//
//  AppDelegate.h
//  YoNexusSlotsXtremeNo
//
//  Created by adin on 2024/9/12.
//

#import "BerthAppDelegate.h"
#import "cocos2d.h"
#import "AppDelegate.h"
#import "RootViewController.h"
#import "SDKWrapper.h"
#import "platform/ios/CCEAGLView-ios.h"
#import "Adjust.h"
#import <AppTrackingTransparency/AppTrackingTransparency.h>
#import <AdSupport/AdSupport.h>
#import <Bugly/Bugly.h>
using namespace cocos2d;

@implementation BerthAppDelegate

Application* app = nullptr;
@synthesize window;

#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[SDKWrapper getInstance] application:application didFinishLaunchingWithOptions:launchOptions];
    
    NSString *yourAppToken = @"6r1cuza7l5s0";
    NSString *environment = ADJEnvironmentProduction;
    ADJConfig* myAdjustConfig = [ADJConfig configWithAppToken:yourAppToken
                                   environment:environment];
    [myAdjustConfig setLogLevel:ADJLogLevelVerbose];
    [Bugly startWithAppId:@"6r1cuza7l5s0"];
    // Your code here
    [[IQKeyboardManager sharedManager] setEnable:YES];
    
    // Add the view controller's view to the window and display.
    float scale = [[UIScreen mainScreen] scale];
    CGRect bounds = [[UIScreen mainScreen] bounds];
    window = [[UIWindow alloc] initWithFrame: bounds];
    
    // cocos2d application instance
    app = new AppDelegate(bounds.size.width * scale, bounds.size.height * scale);
    app->setMultitouch(true);
    
    // Use RootViewController to manage CCEAGLView
    _rootVC = [[RootViewController alloc]init];
#ifdef NSFoundationVersionNumber_iOS_7_0
    _rootVC.automaticallyAdjustsScrollViewInsets = NO;
    _rootVC.extendedLayoutIncludesOpaqueBars = NO;
    _rootVC.edgesForExtendedLayout = UIRectEdgeAll;
#else
    _viewController.wantsFullScreenLayout = YES;
#endif
    // Set RootViewController to window
    if ( [[UIDevice currentDevice].systemVersion floatValue] < 6.0)
    {
        // warning: addSubView doesn't work on iOS6
        [window addSubview: _rootVC.view];
    }
    else
    {
        // use this method on ios6
        [window setRootViewController:_rootVC];
        
    }
    
    [window makeKeyAndVisible];
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
    //run the cocos2d-x game scene
    app->start();

    
//    [self requestIDFA];

    [Adjust appDidLaunch:myAdjustConfig];
    
    
//    [self trackCustomEvent];
    return YES;
}


- (void)requestIDFA {
  [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
    // Tracking authorization completed. Start loading ads here.
    // [self loadAd];
//      NSLog(@"idfa %@,status %lu",[Adjust idfa], status);
  }];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
    app->onPause();
    [[SDKWrapper getInstance] applicationWillResignActive:application];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
    app->onResume();
    [[SDKWrapper getInstance] applicationDidBecomeActive:application];
    [Adjust requestTrackingAuthorizationWithCompletionHandler:^(NSUInteger status) {
//        NSLog(@"idfa %@,idfv  %@,status %lu",[Adjust idfa], [Adjust idfv] ,status);
       switch (status) {
          case 0:
             // ATTrackingManagerAuthorizationStatusNotDetermined case
             break;
          case 1:
             // ATTrackingManagerAuthorizationStatusRestricted case
             break;
          case 2:
             // ATTrackingManagerAuthorizationStatusDenied case
             break;
          case 3:
             // ATTrackingManagerAuthorizationStatusAuthorized case
             break;
       }
    }];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
    [[SDKWrapper getInstance] applicationDidEnterBackground:application];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
    [[SDKWrapper getInstance] applicationWillEnterForeground:application];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [[SDKWrapper getInstance] applicationWillTerminate:application];
    delete app;
    app = nil;
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}



@end

