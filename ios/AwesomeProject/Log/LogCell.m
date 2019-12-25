//
//  LogCell.m
//  FishHookDemo
//
//  Created by 张延深 on 2019/12/24.
//  Copyright © 2019 张延深. All rights reserved.
//

#import "LogCell.h"

@interface LogCell ()

@property (weak, nonatomic) IBOutlet UILabel *logLbl;

@end

@implementation LogCell

- (void)awakeFromNib {
    [super awakeFromNib];
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    [self addGestureRecognizer:longPress];
}

#pragma mark - Event response

- (void)handleLongPress:(UILongPressGestureRecognizer *)longPress {
    if (longPress.state == UIGestureRecognizerStateBegan) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(logCell:longPress:)]) {
            [self.delegate logCell:self longPress:self.text];
        }
    }
}

#pragma mark - Setters/Getters

- (void)setText:(NSString *)text {
    _text = text;
    self.logLbl.text = text;
}

- (void)setTitleColor:(UIColor *)titleColor {
    _titleColor = titleColor;
    self.logLbl.textColor = titleColor;
}

@end
