//
//  UITableViewCell+FlatUI.m
//  FlatUIKitExample
//
//  Created by Maciej Swic on 2013-05-31.
//
//

#import "UITableViewCell+FlatUI.h"
#import "YoSeptemBerthCellBackgroundView.h"
#import <objc/runtime.h>

@implementation UITableViewCell (FlatUI)

@dynamic cornerRadius, separatorHeight;

- (void) YoSeptemBerth_configureFlatCellWithColor:(UIColor *)color
                      selectedColor:(UIColor *)selectedColor {
    [self YoSeptemBerth_configureFlatCellWithColor:color
                       selectedColor:selectedColor
                     roundingCorners:0];
}

- (void) YoSeptemBerth_configureFlatCellWithColor:(UIColor *)color
                      selectedColor:(UIColor *)selectedColor
                    roundingCorners:(UIRectCorner)corners {
    YoSeptemBerthCellBackgroundView* backgroundView = [YoSeptemBerthCellBackgroundView new];
    backgroundView.backgroundColor = color;
    backgroundView.roundedCorners = corners;
    self.backgroundView = backgroundView;
    
    YoSeptemBerthCellBackgroundView* selectedBackgroundView = [YoSeptemBerthCellBackgroundView new];
    selectedBackgroundView.roundedCorners = corners;
    selectedBackgroundView.backgroundColor = selectedColor;
    self.selectedBackgroundView = selectedBackgroundView;
    
    //The labels need a clear background color or they will look very funky
    self.textLabel.backgroundColor = [UIColor clearColor];
    if ([self respondsToSelector:@selector(detailTextLabel)])
        self.detailTextLabel.backgroundColor = [UIColor clearColor];
    
    //Guess some good text colors
    self.textLabel.textColor = selectedColor;
    self.textLabel.highlightedTextColor = color;
    if ([self respondsToSelector:@selector(detailTextLabel)]) {
        self.detailTextLabel.textColor = selectedColor;
        self.detailTextLabel.highlightedTextColor = color;
    }
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    [(YoSeptemBerthCellBackgroundView*)self.backgroundView setCornerRadius:cornerRadius];
    [(YoSeptemBerthCellBackgroundView*)self.selectedBackgroundView setCornerRadius:cornerRadius];
}

- (void)setSeparatorHeight:(CGFloat)separatorHeight {
    [(YoSeptemBerthCellBackgroundView*)self.backgroundView setSeparatorHeight:separatorHeight];
    [(YoSeptemBerthCellBackgroundView*)self.selectedBackgroundView setSeparatorHeight:separatorHeight];
}

@end
