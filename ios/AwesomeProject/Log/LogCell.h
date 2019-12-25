//
//  LogCell.h
//  FishHookDemo
//
//  Created by 张延深 on 2019/12/24.
//  Copyright © 2019 张延深. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class LogCell;

@protocol LogCellDelegate <NSObject>

@optional
- (void)logCell:(LogCell *)cell longPress:(NSString *)text;

@end

@interface LogCell : UITableViewCell

@property (nonatomic, weak) id<LogCellDelegate> delegate;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, strong) UIColor *titleColor;

@end

NS_ASSUME_NONNULL_END
