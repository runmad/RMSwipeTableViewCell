//
//  menuController.m
//  Triggerfox
//
//  Created by Rune Madsen on 2012-12-27.
//  Copyright (c) 2012 Triggerfox Corporation. All rights reserved.
//

#import "RMMenuController.h"
#import "RMMenuBarSliderView.h"
#import <QuartzCore/QuartzCore.h>
#import "FTWButton.h"

@interface RMMenuController () {
	UIView *tabButtonsContainerView;
	UIView *contentContainerView;
	RMMenuBarSliderView *menuBarSliderView;
	BOOL menuVisible;
	BOOL sliderHidden;
}

@end

static const NSInteger TagOffset = 1000;
static const NSInteger kExtraDragViewTag = 534;
static const NSInteger ViewControllerOffset = 100;

@implementation RMMenuController

- (void)viewDidLoad {
	[super viewDidLoad];
	self.view.backgroundColor = [UIColor colorWithWhite:0.1 alpha:1];
	self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	
	menuVisible = NO;
	
	tabButtonsContainerView = [[UIView alloc] initWithFrame:CGRectMake(self.view.bounds.origin.x + 25,
																	   self.view.bounds.origin.y + 25,
																	   self.view.bounds.size.width - 50,
																	   self.view.bounds.size.height - 50)];
	tabButtonsContainerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
//	tabButtonsContainerView.layer.borderColor = [UIColor blueColor].CGColor;
//	tabButtonsContainerView.layer.borderWidth = 1;
	[self.view addSubview:tabButtonsContainerView];
	
	contentContainerView = [[UIView alloc] initWithFrame:self.view.bounds];
	contentContainerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	[self.view addSubview:contentContainerView];
	
	UIImageView *sliderBarImageView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"sliderBar"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)]];
	[sliderBarImageView setFrame:CGRectMake(0, CGRectGetMaxY(contentContainerView.frame), CGRectGetWidth(contentContainerView.frame), 9)];
	[sliderBarImageView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
	[contentContainerView addSubview:sliderBarImageView];
	
	CGFloat menuBarSliderViewHeight = 50;
	menuBarSliderView = [[RMMenuBarSliderView alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.view.frame) / 2) - 50, CGRectGetMaxY(contentContainerView.frame) - (menuBarSliderViewHeight / 2), 100, menuBarSliderViewHeight)];
	[menuBarSliderView setAutoresizingMask:UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin];
	[self.view addSubview:menuBarSliderView];
	
	UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
	[menuBarSliderView addGestureRecognizer:tapGesture];
	UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
	[panGesture setMinimumNumberOfTouches:1];
	[panGesture setMaximumNumberOfTouches:1];
	[menuBarSliderView addGestureRecognizer:panGesture];
	
	[self reloadTabButtons];
}

-(void)handleTap:(UITapGestureRecognizer*)tapGestureRecognizer {
	UIView *view = tapGestureRecognizer.view;
	if (CGRectGetMinY(view.frame) > 100) {
		[UIView animateWithDuration:0.2
							  delay:0
							options:UIViewAnimationOptionCurveEaseOut
						 animations:^{
							 CGRect frame = contentContainerView.frame;
							 frame.origin.y -= 30;
							 contentContainerView.frame = frame;
							 [menuBarSliderView setFrame:CGRectMake(CGRectGetMinX(menuBarSliderView.frame), CGRectGetMaxY(contentContainerView.frame) - (CGRectGetHeight(menuBarSliderView.frame) / 2), CGRectGetWidth(menuBarSliderView.frame), CGRectGetHeight(menuBarSliderView.frame))];
						 }
						 completion:^(BOOL finished) {
							 [UIView animateWithDuration:0.15
												   delay:0.08
												 options:UIViewAnimationOptionCurveLinear
											  animations:^{
												  contentContainerView.frame = self.view.bounds;
												  [menuBarSliderView setFrame:CGRectMake(CGRectGetMinX(menuBarSliderView.frame), CGRectGetMaxY(contentContainerView.frame) - (CGRectGetHeight(menuBarSliderView.frame) / 2), CGRectGetWidth(menuBarSliderView.frame), CGRectGetHeight(menuBarSliderView.frame))];
											  }
											  completion:^(BOOL finished) {
												  [UIView animateWithDuration:0.1
																		delay:0
																	  options:UIViewAnimationOptionCurveLinear
																   animations:^{
																	   CGRect frame = contentContainerView.frame;
																	   frame.origin.y -= 8;
																	   contentContainerView.frame = frame;
																	   [menuBarSliderView setFrame:CGRectMake(CGRectGetMinX(menuBarSliderView.frame), CGRectGetMaxY(contentContainerView.frame) - (CGRectGetHeight(menuBarSliderView.frame) / 2), CGRectGetWidth(menuBarSliderView.frame), CGRectGetHeight(menuBarSliderView.frame))];
																   }
																   completion:^(BOOL finished) {
																	   [UIView animateWithDuration:0.1
																							 delay:0
																						   options:UIViewAnimationOptionCurveLinear
																						animations:^{
																							contentContainerView.frame = self.view.bounds;
																							[menuBarSliderView setFrame:CGRectMake(CGRectGetMinX(menuBarSliderView.frame), CGRectGetMaxY(contentContainerView.frame) - (CGRectGetHeight(menuBarSliderView.frame) / 2), CGRectGetWidth(menuBarSliderView.frame), CGRectGetHeight(menuBarSliderView.frame))];
																						}
																						completion:^(BOOL finished) {
																							menuVisible = NO;
																							for (UIView *view in contentContainerView.subviews) {
																								if (view.tag == kExtraDragViewTag) {
																									[view removeFromSuperview];
																								}
																							}
																						}
																		];
																   }
												   ];
											  }
							  ];
						 }
		 ];
	} else {
		[UIView animateWithDuration:0.2
							  delay:0
							options:UIViewAnimationOptionCurveEaseInOut
						 animations:^{
							 contentContainerView.frame = self.view.bounds;
							 [menuBarSliderView setFrame:CGRectMake(CGRectGetMinX(menuBarSliderView.frame), CGRectGetMaxY(contentContainerView.frame) - (CGRectGetHeight(menuBarSliderView.frame) / 2), CGRectGetWidth(menuBarSliderView.frame), CGRectGetHeight(menuBarSliderView.frame))];
						 }
						 completion:^(BOOL finished) {
							 menuVisible = NO;
							 for (UIView *view in contentContainerView.subviews) {
								 if (view.tag == kExtraDragViewTag) {
									 [view removeFromSuperview];
								 }
							 }
						 }
		 ];
	}
}

-(void)handlePan:(UIPanGestureRecognizer*)panGestureRecognizer {
    if ([panGestureRecognizer state] == UIGestureRecognizerStateBegan || [panGestureRecognizer state] == UIGestureRecognizerStateChanged) {
		UIView *view = panGestureRecognizer.view;
		CGPoint translation = [panGestureRecognizer translationInView:[view superview]];
		[self adjustAnchorPointForGestureRecognizer:panGestureRecognizer];
        [contentContainerView setCenter:CGPointMake([contentContainerView center].x, [contentContainerView center].y + translation.y)];
		[menuBarSliderView setCenter:CGPointMake([menuBarSliderView center].x, [menuBarSliderView center].y + translation.y)];
		if (contentContainerView.frame.origin.y >= 0) {
			[contentContainerView setFrame:CGRectMake(contentContainerView.frame.origin.x, 0, contentContainerView.frame.size.width, contentContainerView.frame.size.height)];
			[menuBarSliderView setFrame:CGRectMake(CGRectGetMinX(menuBarSliderView.frame), CGRectGetMaxY(contentContainerView.frame) - (CGRectGetHeight(menuBarSliderView.frame) / 2), CGRectGetWidth(menuBarSliderView.frame), CGRectGetHeight(menuBarSliderView.frame))];
		}
        [panGestureRecognizer setTranslation:CGPointZero inView:[menuBarSliderView superview]];
    }
	else if ([panGestureRecognizer state] == UIGestureRecognizerStateEnded) {
		CGPoint velocityInView = [panGestureRecognizer velocityInView:self.view];
		CGFloat pointsToAnimate = contentContainerView.frame.origin.y;
		CGFloat velocity = velocityInView.y;
		NSTimeInterval animationDuration = pointsToAnimate / fabsf(velocity);
		CGFloat threshold = CGRectGetHeight(self.view.frame) / 2;
		if (menuVisible) {
			CGFloat contentContainerViewLocation = (CGRectGetHeight(self.view.frame) - ViewControllerOffset) - ABS(pointsToAnimate);
			if (velocity < 0) {
				[self showMenuWithAnimationDuration:animationDuration];
			} else if (ABS(pointsToAnimate) < threshold && ABS(velocity) < 500) {
				NSTimeInterval animationDuration = ((CGRectGetHeight(self.view.frame) - contentContainerView.frame.origin.y) / 500) - 1;
				[self hideMenuWithAnimationDuration:animationDuration];
			} else if (ABS(velocity) > 500 && contentContainerViewLocation > 0) {
				[self hideMenuWithAnimationDuration:animationDuration];
			} else if (ABS(velocity) > 500 && contentContainerViewLocation < 0) {
				[self showMenuWithAnimationDuration:animationDuration];
			} else if (ABS(pointsToAnimate) >= threshold && ABS(velocity) < 500) {
				[self showMenuWithAnimationDuration:0.2];
			}
		} else {
			if (velocity > 0) {
				[self hideMenuWithAnimationDuration:animationDuration];
			} else if (ABS(pointsToAnimate) < threshold && ABS(velocity) < 500) {
				NSTimeInterval animationDuration = ((CGRectGetHeight(self.view.frame) - contentContainerView.frame.origin.y) / 500) - 1;
				[self hideMenuWithAnimationDuration:animationDuration];
			} else if (ABS(velocity) > 500) {
				[self showMenuWithAnimationDuration:animationDuration];
			} else if (ABS(pointsToAnimate) >= threshold && ABS(velocity) < 500) {
				[self showMenuWithAnimationDuration:0.2];
			}
		}
	}
}

- (void)adjustAnchorPointForGestureRecognizer:(UIGestureRecognizer *)panGestureRecognizer {
	if (panGestureRecognizer.state == UIGestureRecognizerStateBegan) {
		UIView *view = panGestureRecognizer.view;
		CGPoint locationInView = [panGestureRecognizer locationInView:view];
		CGPoint locationInSuperview = [panGestureRecognizer locationInView:view.superview];
		
		view.layer.anchorPoint = CGPointMake(locationInView.x / view.bounds.size.width, locationInView.y / view.bounds.size.height);
		view.center = locationInSuperview;
	}
}

-(void)hideMenuWithAnimationDuration:(NSTimeInterval)animationDuration {
	[UIView animateWithDuration:animationDuration
						  delay:0
						options:UIViewAnimationOptionCurveEaseInOut
					 animations:^{
						 contentContainerView.frame = self.view.bounds;
						 [menuBarSliderView setFrame:CGRectMake(CGRectGetMinX(menuBarSliderView.frame), CGRectGetMaxY(contentContainerView.frame) - (CGRectGetHeight(menuBarSliderView.frame) / 2), CGRectGetWidth(menuBarSliderView.frame), CGRectGetHeight(menuBarSliderView.frame))];
					 }
					 completion:^(BOOL finished) {
						 menuVisible = NO;
						 for (UIView *view in contentContainerView.subviews) {
							 if (view.tag == kExtraDragViewTag) {
								 [view removeFromSuperview];
							 }
						 }
					 }
	 ];
}

-(void)showMenuWithAnimationDuration:(NSTimeInterval)animationDuration {
	[UIView animateWithDuration:animationDuration
						  delay:0
						options:UIViewAnimationOptionCurveEaseOut
					 animations:^{
						 CGRect frame = contentContainerView.frame;
						 frame.origin.y = -CGRectGetHeight(self.view.frame) + ViewControllerOffset;
						 contentContainerView.frame = frame;
						 [menuBarSliderView setFrame:CGRectMake(CGRectGetMinX(menuBarSliderView.frame), CGRectGetMaxY(contentContainerView.frame) - (CGRectGetHeight(menuBarSliderView.frame) / 2), CGRectGetWidth(menuBarSliderView.frame), CGRectGetHeight(menuBarSliderView.frame))];
					 }
					 completion:^(BOOL finished) {
						 BOOL hasExtraDragView = NO;
						 for (UIView *view in contentContainerView.subviews) {
							 if (view.tag == kExtraDragViewTag) {
								 hasExtraDragView = YES;
							 }
						 }
						 if (hasExtraDragView == NO) {
							 UIView *extraDragView = [[UIView alloc] initWithFrame:contentContainerView.bounds];
							 [extraDragView setBackgroundColor:[UIColor clearColor]];
							 extraDragView.tag = kExtraDragViewTag;
							 UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
							 [extraDragView addGestureRecognizer:tapGesture];
							 UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
							 [panGesture setMinimumNumberOfTouches:1];
							 [panGesture setMaximumNumberOfTouches:1];
							 [extraDragView addGestureRecognizer:panGesture];
							 [contentContainerView addSubview:extraDragView];
						 }
						 menuVisible = YES;
					 }
	 ];
}

- (void)viewWillLayoutSubviews {
	[super viewWillLayoutSubviews];
	[self layoutTabButtons];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Only rotate if all child view controllers agree on the new orientation.
	for (UIViewController *viewController in self.viewControllers) {
		if (![viewController shouldAutorotateToInterfaceOrientation:interfaceOrientation]) {
			return NO;
		}
	}
	return YES;
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	
	if ([self isViewLoaded] && self.view.window == nil) {
		self.view = nil;
		tabButtonsContainerView = nil;
		contentContainerView = nil;
		menuBarSliderView = nil;
	}
}

- (void)reloadTabButtons {
	[self removeTabButtons];
	[self addTabButtons];
	
	// Force redraw of the previously active tab.
	NSUInteger lastIndex = _selectedIndex;
	_selectedIndex = NSNotFound;
	self.selectedIndex = lastIndex;
}

- (void)addTabButtons {
	NSUInteger index = 0;
	for (UIViewController *viewController in self.viewControllers) {
        FTWButton *button = [[FTWButton alloc] init];
		button.tag = TagOffset + index;
        [button setColors:@[[UIColor colorWithRed:1.00f green:0.67f blue:0.36f alpha:1.00f], [UIColor colorWithRed:1.00f green:0.45f blue:0.00f alpha:1.00f]] forControlState:UIControlStateNormal];
        [button setColors:@[[UIColor colorWithRed:1.00f green:0.50f blue:0.20f alpha:1.00f], [UIColor colorWithRed:1.00f green:0.45f blue:0.00f alpha:1.00f]] forControlState:UIControlStateHighlighted];
        [button setBorderColor:[UIColor colorWithRed:0.85f green:0.34f blue:0.00f alpha:1.00f] forControlState:UIControlStateNormal];
        [button setBorderWidth:1 forControlState:UIControlStateNormal];
        [button setCornerRadius:2 forControlState:UIControlStateNormal];
        [button setInnerShadowColor:[UIColor colorWithWhite:1.000 alpha:0.500] forControlState:UIControlStateNormal];
        [button setInnerShadowColor:[UIColor colorWithWhite:0 alpha:0.400] forControlState:UIControlStateHighlighted];
        [button setInnerShadowRadius:1 forControlState:UIControlStateNormal];
        [button setInnerShadowRadius:3 forControlState:UIControlStateHighlighted];
        [button setInnerShadowOffset:CGSizeMake(0, 1) forControlState:UIControlStateNormal];
        [button setShadowColor:[UIColor colorWithWhite:0 alpha:0.3] forControlState:UIControlStateNormal];
        [button setShadowColor:[UIColor colorWithWhite:1.000 alpha:0.1] forControlState:UIControlStateHighlighted];
        [button setShadowOffset:CGSizeMake(0, 1) forControlState:UIControlStateNormal];
        [button setShadowOpacity:1 forControlState:UIControlStateNormal];
        [button setShadowRadius:1 forControlState:UIControlStateNormal];
        [button setShadowRadius:0 forControlState:UIControlStateHighlighted];
        [button setFont:[UIFont fontWithName:@"OpenSans-Bold" size:18]];
        [button setTextColor:[UIColor whiteColor] forControlState:UIControlStateNormal];
        [button setTextShadowColor:[UIColor colorWithWhite:0 alpha:0.2] forControlState:UIControlStateNormal];
        [button setTextShadowOffset:CGSizeMake(0, -1) forControlState:UIControlStateNormal];
        [button setText:viewController.tabBarItem.title forControlState:UIControlStateNormal];
        [button setFont:[UIFont fontWithName:@"Avenir-Heavy" size:18]];
        [button addTarget:self action:@selector(tabButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [button setAutoresizingMask:UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth];
		
		[self deselectTabButton:button];
		[tabButtonsContainerView addSubview:button];
		
		++index;
	}
}

- (void)removeTabButtons {
	while ([tabButtonsContainerView.subviews count] > 0) {
		[[tabButtonsContainerView.subviews lastObject] removeFromSuperview];
	}
}

- (void)layoutTabButtons {
	CGRect rect = CGRectMake(0.0f, CGRectGetHeight(tabButtonsContainerView.bounds), CGRectGetWidth(tabButtonsContainerView.bounds), self.tabBarHeight);
	NSArray *buttons = [tabButtonsContainerView subviews];
	for (FTWButton *button in buttons) {
		rect.origin.y = CGRectGetMaxY(tabButtonsContainerView.bounds) - self.tabBarHeight - ((self.tabBarHeight + 10) * [buttons indexOfObject:button]);
		button.frame = rect;
	}
}

- (void)setViewControllers:(NSArray *)newViewControllers {
	NSAssert([newViewControllers count] >= 2, @"MHTabBarController requires at least two view controllers");
	
	UIViewController *oldSelectedViewController = self.selectedViewController;
	
	// Remove the old child view controllers.
	for (UIViewController *viewController in _viewControllers)
	{
		[viewController willMoveToParentViewController:nil];
		[viewController removeFromParentViewController];
	}
	
	_viewControllers = [newViewControllers copy];
	
	// This follows the same rules as UITabBarController for trying to
	// re-select the previously selected view controller.
	NSUInteger newIndex = [_viewControllers indexOfObject:oldSelectedViewController];
	if (newIndex != NSNotFound)
		_selectedIndex = newIndex;
	else if (newIndex < [_viewControllers count])
		_selectedIndex = newIndex;
	else
		_selectedIndex = 0;
	
	// Add the new child view controllers.
	for (UIViewController *viewController in _viewControllers) {
		[self addChildViewController:viewController];
		[viewController didMoveToParentViewController:self];
	}
	
	if ([self isViewLoaded])
		[self reloadTabButtons];
}

- (void)setSelectedIndex:(NSUInteger)newSelectedIndex {
	[self setSelectedIndex:newSelectedIndex animated:NO];
}

- (void)setSelectedIndex:(NSUInteger)newSelectedIndex animated:(BOOL)animated {
	NSAssert(newSelectedIndex < [self.viewControllers count], @"View controller index out of bounds");
	
	if ([self.delegate respondsToSelector:@selector(menuController:shouldSelectViewController:atIndex:)]) {
		UIViewController *toViewController = (self.viewControllers)[newSelectedIndex];
		if (![self.delegate menuController:self shouldSelectViewController:toViewController atIndex:newSelectedIndex])
			return;
	}
	
	if (![self isViewLoaded]) {
		_selectedIndex = newSelectedIndex;
	} else if (_selectedIndex != newSelectedIndex) {
		UIViewController *fromViewController;
		UIViewController *toViewController;
		
		if (_selectedIndex != NSNotFound) {
			FTWButton *fromButton = (FTWButton *)[tabButtonsContainerView viewWithTag:TagOffset + _selectedIndex];
			[self deselectTabButton:fromButton];
			fromViewController = self.selectedViewController;
		}
		
		NSUInteger oldSelectedIndex = _selectedIndex;
		_selectedIndex = newSelectedIndex;
		
		FTWButton *toButton;
		if (_selectedIndex != NSNotFound) {
			toButton = (FTWButton *)[tabButtonsContainerView viewWithTag:TagOffset + _selectedIndex];
			[self selectTabButton:toButton];
			toViewController = self.selectedViewController;
		}
		
		if (toViewController == nil) { // don't animate
			[fromViewController.view removeFromSuperview];
		} else if (fromViewController == nil) { // don't animate
			toViewController.view.frame = contentContainerView.bounds;
			[contentContainerView addSubview:toViewController.view];
			[contentContainerView bringSubviewToFront:menuBarSliderView];
			
			if ([self.delegate respondsToSelector:@selector(menuController:didSelectViewController:atIndex:)]) {
				[self.delegate menuController:self didSelectViewController:toViewController atIndex:newSelectedIndex];
			}
		} else if (animated) {
			CGRect rect = contentContainerView.bounds;
			if (oldSelectedIndex < newSelectedIndex)
				rect.origin.x = rect.size.width;
			else
				rect.origin.x = -rect.size.width;
			
			toViewController.view.frame = rect;
			tabButtonsContainerView.userInteractionEnabled = NO;
			
			[self transitionFromViewController:fromViewController
							  toViewController:toViewController
									  duration:0.3f
									   options:UIViewAnimationOptionLayoutSubviews | UIViewAnimationOptionCurveEaseOut
									animations:^{
										CGRect rect = fromViewController.view.frame;
										if (oldSelectedIndex < newSelectedIndex)
											rect.origin.x = -rect.size.width;
										else
											rect.origin.x = rect.size.width;
										
										fromViewController.view.frame = rect;
										toViewController.view.frame = contentContainerView.bounds;
									}
									completion:^(BOOL finished)
			 {
				 tabButtonsContainerView.userInteractionEnabled = YES;
				 if ([self.delegate respondsToSelector:@selector(menuController:didSelectViewController:atIndex:)]) {
					 [self.delegate menuController:self didSelectViewController:toViewController atIndex:newSelectedIndex];
				 }
			 }];
		} else { // not animated
			[fromViewController.view removeFromSuperview];
			
			toViewController.view.frame = contentContainerView.bounds;
			[contentContainerView addSubview:toViewController.view];
			[contentContainerView bringSubviewToFront:menuBarSliderView];
			
			if ([self.delegate respondsToSelector:@selector(menuController:didSelectViewController:atIndex:)]) {
				[self.delegate menuController:self didSelectViewController:toViewController atIndex:newSelectedIndex];
			}
		}
		[self hideMenuWithAnimationDuration:0.2];
	}
}

- (UIViewController *)selectedViewController {
	if (self.selectedIndex != NSNotFound) {
		return (self.viewControllers)[self.selectedIndex];
	} else {
		return nil;
	}
}

- (void)setSelectedViewController:(UIViewController *)newSelectedViewController {
	[self setSelectedViewController:newSelectedViewController animated:NO];
}

- (void)setSelectedViewController:(UIViewController *)newSelectedViewController animated:(BOOL)animated {
	NSUInteger index = [self.viewControllers indexOfObject:newSelectedViewController];
	if (index != NSNotFound) {
		[self setSelectedIndex:index animated:animated];
	}
}

- (void)tabButtonPressed:(FTWButton *)sender {
	[self setSelectedIndex:sender.tag - TagOffset animated:NO];
}

- (void)setHidden:(BOOL)hidden animated:(BOOL)animated {
	if (hidden && !sliderHidden) {
		CGRect frame = CGRectMake(CGRectGetMinX(menuBarSliderView.frame), CGRectGetMaxY(self.view.frame), CGRectGetWidth(menuBarSliderView.frame), CGRectGetHeight(menuBarSliderView.frame));
		if (animated) {
			[UIView animateWithDuration:0.3
							 animations:^{
								 [menuBarSliderView setFrame:frame];
							 }
							 completion:^(BOOL finished) {
								 [menuBarSliderView setHidden:YES];
							 }];
		} else {
			[menuBarSliderView setFrame:frame];
			[menuBarSliderView setHidden:YES];
		}
		sliderHidden = YES;
	} else if (!hidden && sliderHidden) {
		[menuBarSliderView setHidden:NO];
		CGRect frame = CGRectMake(CGRectGetMinX(menuBarSliderView.frame), CGRectGetMaxY(contentContainerView.frame) - (CGRectGetHeight(menuBarSliderView.frame) / 2), CGRectGetWidth(menuBarSliderView.frame), CGRectGetHeight(menuBarSliderView.frame));
		if (animated) {
			[UIView animateWithDuration:0.3
							 animations:^{
								 [menuBarSliderView setFrame:frame];
							 }];
		} else {
			[menuBarSliderView setFrame:frame];
		}
		sliderHidden = NO;
	}
}

#pragma mark - Change these methods to customize the look of the buttons

- (void)selectTabButton:(FTWButton *)button {
    [button setSelected:YES animated:NO];
    [button setHighlighted:YES animated:NO];
//	[button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//	[button setBackgroundColor:[UIColor colorWithWhite:0.5 alpha:1]];
//	[button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//	[button setTitleShadowColor:[UIColor colorWithWhite:1 alpha:0.5f] forState:UIControlStateNormal];
//	[button.titleLabel setShadowOffset:CGSizeMake(0, 1)];
}

- (void)deselectTabButton:(FTWButton *)button {
    [button setSelected:NO animated:NO];
    [button setHighlighted:NO animated:NO];
//	[button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//	[button setBackgroundColor:[UIColor colorWithWhite:1 alpha:1]];
//	[button setTitleColor:[UIColor colorWithRed:1.000 green:0.502 blue:0.000 alpha:1.000] forState:UIControlStateNormal];
//	[button setTitleShadowColor:[UIColor colorWithWhite:0.3 alpha:1] forState:UIControlStateNormal];
//	[button.titleLabel setShadowOffset:CGSizeMake(0, -1)];
}

- (CGFloat)tabBarHeight {
	return 44.0f;
}

@end

