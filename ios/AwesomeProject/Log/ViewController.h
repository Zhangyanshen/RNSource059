//
//  ViewController.h
//  FishHookDemo
//
//  Created by 张延深 on 2019/12/24.
//  Copyright © 2019 张延深. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (nonatomic, copy) void(^callback)(void);

- (void)addLog:(NSString *)log;

@end

