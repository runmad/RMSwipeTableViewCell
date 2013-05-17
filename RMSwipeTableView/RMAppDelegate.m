//
//  RMAppDelegate.m
//  RMSwipeTableView
//
//  Created by Rune Madsen on 2012-11-24.
//  Copyright (c) 2012 The App Boutique. All rights reserved.
//

#import "RMAppDelegate.h"
#import "RMSwipeTableViewController.h"
#import "RMSecondViewController.h"
#import "RMMenuController.h"

@implementation RMAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];
    RMSwipeTableViewController *swipeTableViewController = [[RMSwipeTableViewController alloc] initWithStyle:UITableViewStylePlain];
    swipeTableViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"House Lannister" image:[UIImage imageNamed:@"CheckmarkGrey"] tag:0];
    RMSecondViewController *secondViewController = [[RMSecondViewController alloc] init];
    secondViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Second View" image:[UIImage imageNamed:@"CheckmarkGrey"] tag:1];
    RMMenuController *menuController = [[RMMenuController alloc] init];
    [menuController setViewControllers:@[[[UINavigationController alloc] initWithRootViewController:swipeTableViewController], [[UINavigationController alloc] initWithRootViewController:secondViewController]]];
    self.window.rootViewController = menuController;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];

    //    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"NavigationBar"] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setTintColor:[UIColor colorWithRed:1.000 green:0.136 blue:0.142 alpha:1.000]];
	UIImage *barButton = [[UIImage imageNamed:@"NavBarButton"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 5)];
	[[UIBarButtonItem appearance] setBackgroundImage:barButton forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
	UIImage *barButtonHighlighted = [[UIImage imageNamed:@"NavBarButtonPressed"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 5)];
    [[UIBarButtonItem appearance] setBackgroundImage:barButtonHighlighted forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
    
    [[UINavigationBar appearance] setTitleTextAttributes:[[NSDictionary alloc] initWithObjectsAndKeys:
                                                          [UIFont fontWithName:@"Avenir-Heavy" size:0], UITextAttributeFont,
                                                          [UIColor colorWithWhite:0.0f alpha:0.2f], UITextAttributeTextShadowColor,
                                                          [NSValue valueWithUIOffset:UIOffsetMake(0.0f, -1.0f)], UITextAttributeTextShadowOffset,
                                                          [UIColor whiteColor], UITextAttributeTextColor,
                                                          nil]];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
