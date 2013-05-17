//
//  TFXMenuController.h
//  Triggerfox
//
//  Created by Rune Madsen on 2012-12-27.
//  Copyright (c) 2012 Triggerfox Corporation. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RMMenuControllerDelegate;

@interface RMMenuController : UIViewController

@property (nonatomic, copy) NSArray *viewControllers;
@property (nonatomic, weak) UIViewController *selectedViewController;
@property (nonatomic, assign) NSUInteger selectedIndex;
@property (nonatomic, weak) id <RMMenuControllerDelegate> delegate;

- (void)setSelectedIndex:(NSUInteger)index animated:(BOOL)animated;
- (void)setSelectedViewController:(UIViewController *)viewController animated:(BOOL)animated;
- (void)setHidden:(BOOL)hidden animated:(BOOL)animated;

@end

/*
 * The delegate protocol for MHTabBarController.
 */
@protocol RMMenuControllerDelegate <NSObject>
@optional
- (BOOL)menuController:(RMMenuController *)menuController shouldSelectViewController:(UIViewController *)viewController atIndex:(NSUInteger)index;
- (void)menuController:(RMMenuController *)menuController didSelectViewController:(UIViewController *)viewController atIndex:(NSUInteger)index;
@end