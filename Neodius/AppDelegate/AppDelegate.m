//
//  AppDelegate.m
//  Neodius
//
//  Created by Benjamin de Bos on 16-09-17.
//  Copyright © 2017 ITS-VIsion. All rights reserved.
//
#import "AppDelegate.h"
#import "menuTableViewController.h"
#import "walletViewTableViewController.h"
#import "NeodiusDataSource.h"
#import "gasCalculationTableViewController.h"

@implementation AppDelegate
@synthesize window = _window;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [UINavigationBar appearance].barTintColor = [UIColor colorWithRed:0.35 green:0.75 blue:0.00 alpha:1.0];
    [UINavigationBar appearance].tintColor = [UIColor whiteColor];
    [UINavigationBar appearance].titleTextAttributes = @{
                                                           NSForegroundColorAttributeName: [UIColor whiteColor],
                                                           NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Light" size:22]
                                                           };
    
    
    
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil] setTintColor:[UIColor whiteColor]];
    
    UIViewController *centerController = [[walletViewTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    UIViewController *menuController = [[menuTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    
    //create navigation controller for center
    centerController = [[UINavigationController alloc] initWithRootViewController:centerController];
    
    //create viewdeck controller
    deckController = [[IIViewDeckController alloc] initWithCenterViewController:centerController leftViewController:menuController];

    self.window.rootViewController = deckController;
    
    [_window makeKeyAndVisible];

    [LTHPasscodeViewController useKeychain:YES];
    [LTHPasscodeViewController sharedUser].touchIDString = NSLocalizedString(@"Use TouchID to unlock Neodius", nil);
    [LTHPasscodeViewController sharedUser].backgroundColor = [UIColor whiteColor];
    [LTHPasscodeViewController sharedUser].backgroundImage = [UIImage imageNamed:@"menuLogo"];
    [LTHPasscodeViewController sharedUser].labelTextColor = neoGreenColor;
    [LTHPasscodeViewController sharedUser].labelFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:20];
    
    if ([LTHPasscodeViewController doesPasscodeExist]) {
        if ([LTHPasscodeViewController didPasscodeTimerEnd]) {
            [[LTHPasscodeViewController sharedUser] showLockScreenWithAnimation:NO
                                                                     withLogout:NO
                                                                 andLogoutTitle:nil];
        }
    }
    
    
    
    return YES;
}




-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}


@end

