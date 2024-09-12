//
//  AppDelegate.h
//  YoNexusSlotsXtremeNo
//
//  Created by adin on 2024/9/12.
//

#import <UIKit/UIKit.h>
#import <IQKeyboardManager/IQKeyboardManager.h>

@class RootViewController;

@interface BerthAppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) UIWindow * window;
@property(nonatomic, readonly) RootViewController* rootVC;

@end

