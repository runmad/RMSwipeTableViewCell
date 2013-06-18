//
//  RMAppDelegate.m
//  RMSwipeTableViewCelliOS7UIDemo
//
//  Created by Rune Madsen on 2013-06-16.
//  Copyright (c) 2013 The App Boutique. All rights reserved.
//

#import "RMAppDelegate.h"
#import "RMSwipeTableViewCelliOS7UIDemoViewController.h"

@implementation RMAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
#define SHOW_ALERTVIEW 1
#if SHOW_ALERTVIEW
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Developer note"
                                                        message:@"This demo tries to mimick the panning behaviour seen in Messages.app on iOS 7. It's worth noting that Mail.app and Weather.app appear to have other behaviours. As of Beta Seed 1 there appears to be three separate behaviours:\n\nIn Mail.app the user can pan and come to a stop above the threshold and still lock the content view in open position.\n\nIn Weather.app panning locks once it reaches the threshold for button visibility.\n\nMessages.app, which this demo tries to copy its panning behaviour from, requires the user to pan with a flick in order to lock the content view in \"Delete\" mode. Simply panning to above the threshold without enough velocity will not lock the cell in \"Delete\" mode.\n\nI haven't quite nailed the flick algorithm and need to work on re-activating the panning on an already open cell - feel free to submit a pull request if you can assist!"
                                                       delegate:nil
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"OK", nil];
    [alertView show];
#endif
    
    RMSwipeTableViewCelliOS7UIDemoViewController *swipeTableViewCelliOS7UIDemoViewController = [[RMSwipeTableViewCelliOS7UIDemoViewController alloc] initWithStyle:UITableViewStylePlain];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:swipeTableViewCelliOS7UIDemoViewController];
    [navigationController.navigationBar setClipsToBounds:YES];
    self.window.rootViewController = navigationController;
    
    
    [[UIBarButtonItem appearance] setBackgroundImage:[[UIImage alloc] init] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearance] setTitleTextAttributes:[[NSDictionary alloc] initWithObjectsAndKeys:
                                                          [UIFont fontWithName:@"HelveticaNeue-Light" size:17], UITextAttributeFont,
                                                          [UIColor colorWithWhite:0.0f alpha:0.0f], UITextAttributeTextShadowColor,
                                                          [NSValue valueWithUIOffset:UIOffsetMake(0.0f, 0.0f)], UITextAttributeTextShadowOffset,
                                                          [UIColor colorWithRed:0.196 green:0.573 blue:0.984 alpha:1.000], UITextAttributeTextColor,
                                                          nil] forState:UIControlStateNormal];
    [[UIBarButtonItem appearance] setTitleTextAttributes:[[NSDictionary alloc] initWithObjectsAndKeys:
                                                          [UIFont fontWithName:@"HelveticaNeue-Light" size:17], UITextAttributeFont,
                                                          [UIColor colorWithWhite:0.0f alpha:0.0f], UITextAttributeTextShadowColor,
                                                          [NSValue valueWithUIOffset:UIOffsetMake(0.0f, 0.0f)], UITextAttributeTextShadowOffset,
                                                          [UIColor colorWithRed:0.196 green:0.573 blue:0.984 alpha:1.000], UITextAttributeTextColor,
                                                          nil] forState:UIControlStateHighlighted];
    
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:[[NSDictionary alloc] initWithObjectsAndKeys:
                                                          [UIFont fontWithName:@"HelveticaNeue-Medium" size:0], UITextAttributeFont,
                                                          [UIColor colorWithWhite:0.0f alpha:0.0f], UITextAttributeTextShadowColor,
                                                          [NSValue valueWithUIOffset:UIOffsetMake(0.0f, 0.0f)], UITextAttributeTextShadowOffset,
                                                          [UIColor blackColor], UITextAttributeTextColor,
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
