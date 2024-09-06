//
//  AppDelegate.h
//  MegaLuckSlotBliss
//
//  Created by adin on 2024/9/6.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) UIWindow * window;
@property (nonatomic, strong) NSPersistentContainer *persistentContainer;
@end

