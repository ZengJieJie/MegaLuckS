//
//  UIPopoverController+FlatUI.m
//  FlatUIKit
//
//  Created by Jack Flintermann on 6/29/13.
//  Copyright (c) 2013 Jack Flintermann. All rights reserved.
//

#import "UIPopoverController+FlatUI.h"
#import "YoSeptemBerthPopoverBackgroundView.h"

@implementation UIPopoverController (FlatUI)

- (void) configureFlatPopoverWithBackgroundColor:(UIColor *)backgroundColor
                                    cornerRadius:(CGFloat)cornerRadius {
    [YoSeptemBerthPopoverBackgroundView setBackgroundColor:backgroundColor];
    [YoSeptemBerthPopoverBackgroundView setCornerRadius:cornerRadius];
    [self setPopoverLayoutMargins:[YoSeptemBerthPopoverBackgroundView contentViewInsets]];
    [self setPopoverBackgroundViewClass:[YoSeptemBerthPopoverBackgroundView class]];
}

@end
