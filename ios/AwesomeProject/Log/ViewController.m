//
//  ViewController.m
//  FishHookDemo
//
//  Created by 张延深 on 2019/12/24.
//  Copyright © 2019 张延深. All rights reserved.
//

#import "ViewController.h"
#import "fishhook.h"
#import "LogCell.h"

static id obj;

int (*origi_fprintf)(FILE * __restrict file, const char * __restrict str, ...);

int my_fprintf(FILE * __restrict file, const char * __restrict str, ...) {
    NSString *oc_str = [NSString stringWithCString:str encoding:NSUTF8StringEncoding];
    [obj addLog:oc_str];
    // 调用原来的方法
//    origi_fprintf(file, str);
    return 0;
}

NSString* (*original_RCTFormatLog)(
  NSDate *timestamp,
  NSInteger level,
  NSString *fileName,
  NSNumber *lineNumber,
  NSString *message
                                );

NSString *my_RCTFormatLog(
  NSDate *timestamp,
  NSInteger level,
  NSString *fileName,
  NSNumber *lineNumber,
  NSString *message
)
{
  [obj addLog:message];
  return message;
//  return original_RCTFormatLog(timestamp, level, fileName, lineNumber, message);
}

@interface ViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, LogCellDelegate>
{
    BOOL _enableFilter;
    dispatch_queue_t _logQueue;
    NSString *_willCopyText; // 即将要copy的文本
    NSInteger _maxLogCount; // 最多显示多少条log
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (nonatomic, copy) NSString *filterText;
@property (nonatomic, strong) NSMutableArray *logArr; // 所有的log数组
@property (nonatomic, strong) NSMutableArray *filterLogArr; // 实际显示的log数组
@property (nonatomic, strong) NSArray *testLogArr;
@property (nonatomic, assign) BOOL logScroll; // log是否滚动到底部

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    obj = self;
    _maxLogCount = 500;
    _logScroll = YES;
    _logQueue = dispatch_queue_create("cn.newbanker.log_queue", NULL);
    self.testLogArr = @[
        @{
            @"key1": @"cacacacac",
            @"key2": @[@"1", @2],
            @"key3": @{
                @"1": @"我擦来🐶",
                @"2": [NSNull null]
            },
            @"key4": [NSNull null],
            @"key5": @2222
        },
        @[@"你来", @"1", @3, @[@"abd"], [NSNull null]],
        @"[error]弄死你",
        [NSObject new],
        @"[warn]弄死你",
        @123,
        
    ];
    [self setupUI];
    struct rebinding rebd;
    rebd.name = "fprintf";
    rebd.replaced = (void *)&origi_fprintf;
    rebd.replacement = my_fprintf;
    
    struct rebinding rebds[] = {rebd};
    rebind_symbols(rebds, 1);
    
//    [self generateRandomLogMessage];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.filterLogArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cell";
    LogCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    NSString *logStr = [self.filterLogArr[indexPath.row] description];
    cell.text = logStr;
    cell.delegate = self;
    if ([logStr containsString:@"[warn]"]) {
        cell.titleColor = [UIColor systemYellowColor];
    } else if ([logStr containsString:@"[error]"]) {
        cell.titleColor = [UIColor redColor];
    } else {
        cell.titleColor = [UIColor blackColor];
    }
    return cell;
}

#pragma mark - UISearchBarDelegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    self.filterText = searchText;
    [self filterLogArray:searchText];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}

#pragma mark - LogCellDelegate

- (void)logCell:(LogCell *)cell longPress:(NSString *)text {
    _willCopyText = text;
    UIMenuController *menu = [UIMenuController sharedMenuController];
    UIMenuItem *item = [[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(copyText:)];
    menu.menuItems = @[item];
    [menu setTargetRect:cell.bounds inView:cell];
    [menu setMenuVisible:YES animated:YES];
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

#pragma mark - Event response

- (IBAction)clearLog:(UIBarButtonItem *)sender {
    [self.logArr removeAllObjects];
    [self.filterLogArr removeAllObjects];
    [self.tableView reloadData];
}

- (void)copyText:(id)sender {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = _willCopyText;
    NSLog(@"%@", _willCopyText);
}

- (IBAction)hideLog:(UIBarButtonItem *)sender {
    if (self.callback) {
        self.callback();
    }
}

#pragma mark - Setters/Getters

- (NSMutableArray *)logArr {
    if (!_logArr) {
        _logArr = [NSMutableArray array];
    }
    return _logArr;
}

- (NSMutableArray *)filterLogArr {
    if (!_filterLogArr) {
        _filterLogArr = [NSMutableArray array];
    }
    return _filterLogArr;
}

- (void)setLogScroll:(BOOL)logScroll {
    _logScroll = logScroll;
}

#pragma mark - Private methods

- (void)setupUI {
    self.title = @"日志";
    self.tableView.tableFooterView = [UIView new];
    [self.tableView registerNib:[UINib nibWithNibName:@"LogCell" bundle:nil] forCellReuseIdentifier:@"cell"];
}

- (void)filterLogArray:(NSString *)filterText {
    __weak typeof(self) wself = self;
    dispatch_async(_logQueue, ^{
        __strong typeof(wself) sself = wself;
        NSMutableArray *allLogTmp = self.logArr;
        if (allLogTmp.count > sself->_maxLogCount) {
            [allLogTmp removeObjectsInRange:NSMakeRange(sself->_maxLogCount, allLogTmp.count - sself->_maxLogCount)];
        }
        self.logArr = allLogTmp;
        
        NSMutableArray *tmp = [NSMutableArray array];
        if (filterText && filterText.length > 0) {
            [self.logArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([[obj description] rangeOfString:filterText options:NSCaseInsensitiveSearch | NSDiacriticInsensitiveSearch | NSWidthInsensitiveSearch].location != NSNotFound) {
                    [tmp addObject:obj];
                }
            }];
        } else {
            [tmp addObjectsFromArray:self.logArr];
        }
        dispatch_sync(dispatch_get_main_queue(), ^{
            self.filterLogArr = [NSMutableArray arrayWithArray:tmp];
            [self.tableView reloadData];
        });
    });
}

- (void)addLog:(NSString *)log {
    [self.logArr insertObject:log atIndex:0];
    [self filterLogArray:self.filterText];
}

- (void)generateRandomLogMessage {
    static NSInteger index = 0;
    for (NSObject *obj in self.testLogArr) {
        index++;
        char *log = my_fprintf(stderr, obj.description.UTF8String);
        fflush(stderr);
        NSString *logStr = [NSString stringWithCString:log encoding:NSUTF8StringEncoding];
//        [self.logArr addObject:logStr];
//        logStr = [NSString stringWithFormat:@"%ld: %@", index, logStr];
        [self.logArr insertObject:logStr atIndex:0];
    }
    [self filterLogArray:self.filterText];
    // Schedule next message
    double delayInSeconds = arc4random() % 5;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self generateRandomLogMessage];
    });
}

@end
