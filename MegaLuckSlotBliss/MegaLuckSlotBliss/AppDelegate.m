//
//  AppDelegate.m
//  MegaLuckSlotBliss
//
//  Created by adin on 2024/9/6.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}


- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    if ([context hasChanges]) {
        @try {
            NSError *error = nil;
            if (![context save:&error]) {
                // 处理错误
                NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                abort();
            }
        }
        @catch (NSException *exception) {
            NSLog(@"Exception occurred: %@, %@", exception, [exception userInfo]);
            abort();
        }
    }
}

// 懒加载 NSPersistentContainer
- (NSPersistentContainer *)persistentContainer {
    if (_persistentContainer == nil) {
        _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"Mega_Luck_Slot_Bliss"];
        
        [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
            if (error != nil) {
                NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                abort();
            }
        }];
    }
    return _persistentContainer;
}

@end
