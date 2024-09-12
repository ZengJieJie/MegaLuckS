
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface PlatformIosApi : NSObject

+ (UIImage*)imageByScalingAndCroppingForSize:(UIImage*)sourceImage size:(CGSize)targetSize;

@end



