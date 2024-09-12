//
//  ViewController.m
//  YoNexusSlotsXtremeNo
//
//  Created by adin on 2024/9/12.
//

#import "YoSeptemBerthHVCViewController.h"
#import "YoSeptemBerthNavigationController.h"
#import "BerthAppDelegate.h"
#import "RootViewController.h"

@interface YoSeptemBerthHVCViewController ()

@end

@implementation YoSeptemBerthHVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

+ (void)SeptemBerthStart
{
    YoSeptemBerthNavigationController *nav = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateInitialViewController];
    nav.modalPresentationStyle = UIModalPresentationFullScreen;
    RootViewController *rootVC = [(BerthAppDelegate *)UIApplication.sharedApplication.delegate rootVC];
    [rootVC presentViewController:nav animated:NO completion:nil];
}

@end
