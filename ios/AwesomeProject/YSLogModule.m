//
//  YSLogModule.m
//  AwesomeProject
//
//  Created by 张延深 on 2019/12/25.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import "YSLogModule.h"
#import "AppDelegate.h"

@implementation YSLogModule

- (dispatch_queue_t)methodQueue {
  return dispatch_get_main_queue();
}

RCT_EXPORT_MODULE(LogModule)

RCT_EXPORT_METHOD(showLogView) {
  AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
  [app showLogView];
}

@end
