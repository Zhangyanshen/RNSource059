/**
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

#import "AppDelegate.h"

#import <React/RCTBridge.h>
#import <React/RCTBundleURLProvider.h>
#import <React/RCTRootView.h>
#import "ViewController.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define StatusBarHeight [UIApplication sharedApplication].statusBarFrame.size.height

@interface AppDelegate ()

@property (nonatomic, strong) ViewController *vc;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  RCTBridge *bridge = [[RCTBridge alloc] initWithDelegate:self launchOptions:launchOptions];
  RCTRootView *rootView = [[RCTRootView alloc] initWithBridge:bridge
                                                   moduleName:@"AwesomeProject"
                                            initialProperties:nil];

  rootView.backgroundColor = [[UIColor alloc] initWithRed:1.0f green:1.0f blue:1.0f alpha:1];

  self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
  UIViewController *rootViewController = [UIViewController new];
  rootViewController.view = rootView;
  self.window.rootViewController = rootViewController;
  [self.window makeKeyAndVisible];
  
  [self setupUI];
  
  return YES;
}

- (NSURL *)sourceURLForBridge:(RCTBridge *)bridge
{
#if DEBUG
  return [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index" fallbackResource:nil];
#else
  return [[NSBundle mainBundle] URLForResource:@"main" withExtension:@"jsbundle"];
#endif
}

- (void)setupUI {
  ViewController *vc = (ViewController *)[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ViewController"];
  vc.callback = ^{
      [UIView animateWithDuration:0.5 animations:^{
          self.vc.view.transform = CGAffineTransformIdentity;
      } completion:^(BOOL finished) {
          self.vc.view.hidden = YES;
      }];
  };
  vc.view.frame = CGRectMake(0, ScreenHeight, ScreenWidth, ScreenHeight - StatusBarHeight);
  vc.view.hidden = YES;
  [self.window addSubview:vc.view];
  self.vc = vc;
}

- (void)showLogView {
  self.vc.view.hidden = NO;
  [UIView animateWithDuration:0.5 animations:^{
      self.vc.view.transform = CGAffineTransformMakeTranslation(0, -(ScreenHeight - StatusBarHeight));
  }];
}

@end
