//
//  main.m
//  YoNexusSlotsXtremeNo
//
//  Created by adin on 2024/9/12.
//

#import <UIKit/UIKit.h>
#import "BerthAppDelegate.h"

int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([BerthAppDelegate class]);
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
