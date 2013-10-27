//
//  RMSwipeTableViewCell.h
//  RMSwipeTableView
//
//  Created by Rune Madsen on 2012-11-24.
//  Copyright (c) 2012 The App Boutique. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, RMSwipeTableViewCellRevealDirection) {
    RMSwipeTableViewCellRevealDirectionNone = -1, // disables panning
    RMSwipeTableViewCellRevealDirectionBoth = 0,
    RMSwipeTableViewCellRevealDirectionRight = 1,
    RMSwipeTableViewCellRevealDirectionLeft = 2,
};

typedef NS_ENUM(NSUInteger, RMSwipeTableViewCellAnimationType) {
    RMSwipeTableViewCellAnimationTypeEaseInOut            = 0 << 16,
    RMSwipeTableViewCellAnimationTypeEaseIn               = 1 << 16,
    RMSwipeTableViewCellAnimationTypeEaseOut              = 2 << 16,
    RMSwipeTableViewCellAnimationTypeEaseLinear           = 3 << 16,
    RMSwipeTableViewCellAnimationTypeBounce               = 4 << 16, // default
};

@protocol RMSwipeTableViewCellDelegate;

@interface RMSwipeTableViewCell : UITableViewCell <UIGestureRecognizerDelegate>

/**
 
 Customizable subview that is revealed when the user pans
 
 */

@property (nonatomic, strong) UIView *backView;

/**
 Determines the direction that swiping is enabled for. 
 
 Default is RMSwipeTableViewCellRevealDirectionBoth
 */
@property (nonatomic, readwrite) RMSwipeTableViewCellRevealDirection revealDirection;

/**
 Determines the animation that occurs when panning ends. 
 
 Default is RMSwipeTableViewCellAnimationTypeBounce.
 */
@property (nonatomic, readwrite) RMSwipeTableViewCellAnimationType animationType;

/**
 Determines the animation duration when the cell's contentView animates back. 
 
 Default is 0.2f
 */
@property (nonatomic, readwrite) CGFloat animationDuration;

/**
 Override this property at any point to stop the cell contentView from animation back into place on touch ended. Default is YES.
 
 This is useful in the swipeTableViewCellWillResetState:fromLocation: delegate method.
 
 Note: it will reset to YES in prepareForReuse
 */
@property (nonatomic, readwrite) BOOL shouldAnimateCellReset;

/**
 When panning/swiping the cell's location is set to exponentially decay. The elasticity (also know as rubber banding) matches that of a UIScrollView/UITableView. 
 
 Default is YES
 */
@property (nonatomic, readwrite) BOOL panElasticity;

/**
 This determines the exponential decay of the pan. By default it matches that of UIScrollView.
 
 Default is 0.55f
 */
@property (nonatomic, readwrite) CGFloat panElasticityFactor;

/**
 When using panElasticity this property allows you to control at which point elasticitykicks in.
 
 Default is 0.0f
 */
@property (nonatomic, readwrite) CGFloat panElasticityStartingPoint;

/**
 Default is [UIColor colorWithWhite:0.92 alpha:1]
 */
@property (nonatomic, strong) UIColor *backViewbackgroundColor;

@property (nonatomic, assign) id <RMSwipeTableViewCellDelegate> delegate;

// exposed class methods for easy subclassing
-(void)handlePanGesture:(UIPanGestureRecognizer *)panGestureRecognizer;
-(void)didStartSwiping;
-(BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)panGestureRecognizer;
-(void)animateContentViewForPoint:(CGPoint)point velocity:(CGPoint)velocity;
-(void)resetCellFromPoint:(CGPoint)point velocity:(CGPoint)velocity;
-(UIView*)backView;
-(void)cleanupBackView;

@end

@protocol RMSwipeTableViewCellDelegate <NSObject>
@optional
-(void)swipeTableViewCellDidStartSwiping:(RMSwipeTableViewCell*)swipeTableViewCell;
-(void)swipeTableViewCell:(RMSwipeTableViewCell*)swipeTableViewCell didSwipeToPoint:(CGPoint)point velocity:(CGPoint)velocity;
-(void)swipeTableViewCellWillResetState:(RMSwipeTableViewCell*)swipeTableViewCell fromPoint:(CGPoint)point animation:(RMSwipeTableViewCellAnimationType)animation velocity:(CGPoint)velocity;
-(void)swipeTableViewCellDidResetState:(RMSwipeTableViewCell*)swipeTableViewCell fromPoint:(CGPoint)point animation:(RMSwipeTableViewCellAnimationType)animation velocity:(CGPoint)velocity;

/**
 Defaults to YES (the backView is recreated everytime the state is about to reset)
 */
-(BOOL)swipeTableViewCellShouldCleanupBackView:(RMSwipeTableViewCell*)swipeTableViewCell;

/*
//  DEPRECATED DELEGATE METHODS:
//  These have been deprecated in favour of delegate methods that take the panOffset into account
*/
-(void)swipeTableViewCell:(RMSwipeTableViewCell*)swipeTableViewCell swipedToLocation:(CGPoint)translation velocity:(CGPoint)velocity __attribute__((deprecated("Use swipeTableViewCell:didSwipeToPoint:velocity:")));
-(void)swipeTableViewCellWillResetState:(RMSwipeTableViewCell*)swipeTableViewCell fromLocation:(CGPoint)translation animation:(RMSwipeTableViewCellAnimationType)animation velocity:(CGPoint)velocity __attribute__((deprecated("Use swipeTableViewCellWillResetState:fromPoint:animation:velocity:")));
-(void)swipeTableViewCellDidResetState:(RMSwipeTableViewCell*)swipeTableViewCell fromLocation:(CGPoint)translation animation:(RMSwipeTableViewCellAnimationType)animation velocity:(CGPoint)velocity __attribute__((deprecated("swipeTableViewCellDidResetState:fromPoint:animation:velocity:")));

@end
