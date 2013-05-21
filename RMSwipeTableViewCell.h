//
//  RMSwipeTableViewCell.h
//  RMSwipeTableView
//
//  Created by Rune Madsen on 2012-11-24.
//  Copyright (c) 2012 The App Boutique. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, RMSwipeTableViewCellRevealDirection) {
    RMSwipeTableViewCellRevealDirectionBoth = 0,
    RMSwipeTableViewCellRevealDirectionRight = 1,
    RMSwipeTableViewCellRevealDirectionLeft = 2,
};

typedef NS_ENUM(NSUInteger, RMSwipeTableViewCellAnimationType) {
    RMSwipeTableViewCellAnimationTypeBounce = 0,
    RMSwipeTableViewCellAnimationTypeEaseIn,
    RMSwipeTableViewCellAnimationTypeEaseOut,
    RMSwipeTableViewCellAnimationTypeEaseInOut,
};

@protocol RMSwipeTableViewCellDelegate;

@interface RMSwipeTableViewCell : UITableViewCell <UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIView *backView;
@property (nonatomic, readwrite) RMSwipeTableViewCellRevealDirection revealDirection; // default is RMSwipeTableViewCellRevealDirectionBoth
@property (nonatomic, readwrite) RMSwipeTableViewCellAnimationType animationType; // default is RMSwipeTableViewCellAnimationTypeBounce
@property (nonatomic, readwrite) float animationDuration; // default is 0.2
@property (nonatomic, readwrite) BOOL revealsBackground; // default is NO
@property (nonatomic, readwrite) BOOL shouldAnimateCellReset; // this can be overriden at any point (useful in the swipeTableViewCellWillResetState:fromLocation: delegate method). default is YES - note: it will reset to YES in prepareForReuse
@property (nonatomic, readwrite) BOOL panElasticity; // When panning/swiping the cell's location is set to exponentially decay. The elsticity/stickiness closely matches that of a UIScrollView/UITableView. default is YES
@property (nonatomic, strong) UIColor *backViewbackgroundColor; // default is [UIColor colorWithWhite:0.92 alpha:1]
@property (nonatomic, assign) id <RMSwipeTableViewCellDelegate> delegate;

// exposed class methods for easy subclassing
-(void)handlePanGesture:(UIPanGestureRecognizer *)panGestureRecognizer;
-(BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)panGestureRecognizer;
-(void)animateContentViewForPoint:(CGPoint)translation velocity:(CGPoint)velocity;
-(void)resetCellFromPoint:(CGPoint)translation velocity:(CGPoint)velocity;
-(UIView*)backView;
-(void)cleanupBackView;

@end

@protocol RMSwipeTableViewCellDelegate <NSObject>
@optional
-(void)swipeTableViewCellDidStartSwiping:(RMSwipeTableViewCell*)swipeTableViewCell;
-(void)swipeTableViewCell:(RMSwipeTableViewCell*)swipeTableViewCell swipedToLocation:(CGPoint)translation velocity:(CGPoint)velocity;
-(void)swipeTableViewCellWillResetState:(RMSwipeTableViewCell*)swipeTableViewCell fromLocation:(CGPoint)translation animation:(RMSwipeTableViewCellAnimationType)animation velocity:(CGPoint)velocity;
-(void)swipeTableViewCellDidResetState:(RMSwipeTableViewCell*)swipeTableViewCell fromLocation:(CGPoint)translation animation:(RMSwipeTableViewCellAnimationType)animation velocity:(CGPoint)velocity;
@end
