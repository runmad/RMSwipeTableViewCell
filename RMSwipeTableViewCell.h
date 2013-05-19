//
//  RMSwipeTableViewCell.h
//  RMSwipeTableView
//
//  Created by Rune Madsen on 2012-11-24.
//  Copyright (c) 2012 The App Boutique. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, RMSwipeTableViewCellRevealDirection) {
    RMSwipeTableViewCellRevealDirectionRight = 0,
    RMSwipeTableViewCellRevealDirectionLeft = 1,
    RMSwipeTableViewCellRevealDirectionBoth = 2,
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
@property (nonatomic, readwrite) RMSwipeTableViewCellRevealDirection revealDirection; // default is RMSwipeTableViewCellRevealDirectionRight
@property (nonatomic, readwrite) RMSwipeTableViewCellAnimationType animationType; // default is RMSwipeTableViewCellAnimationTypeBounce.
@property (nonatomic, readwrite) float animationDuration; // default is 0.2
@property (nonatomic, readwrite) BOOL revealsBackground; // default is NO
@property (nonatomic, readwrite) BOOL shouldAnimateCellReset; // default is YES
@property (nonatomic, strong) UIColor *backViewbackgroundColor; // default is [UIColor colorWithWhite:0.92 alpha:1]
@property (nonatomic, assign) id <RMSwipeTableViewCellDelegate> delegate;

// exposed class methods for easy subclassing
-(void)handlePanGesture:(UIPanGestureRecognizer *)panGestureRecognizer;
-(BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)panGestureRecognizer;
-(void)animateContentViewForPoint:(CGPoint)translation;
-(void)resetCellFromPoint:(CGPoint)translation;
-(UIView*)backView;
-(void)cleanup;

@end

@protocol RMSwipeTableViewCellDelegate <NSObject>
@optional
-(void)swipeTableViewCellDidStartSwiping:(RMSwipeTableViewCell*)swipeTableViewCell fromTouchLocation:(CGPoint)translation;
-(void)swipeTableViewCell:(RMSwipeTableViewCell*)swipeTableViewCell swipedToLocation:(CGPoint)translation;
-(void)swipeTableViewCellWillResetState:(RMSwipeTableViewCell*)swipeTableViewCell fromLocation:(CGPoint)translation withAnimation:(RMSwipeTableViewCellAnimationType)animation;
-(BOOL)swipeTableViewCell:(RMSwipeTableViewCell*)swipeTableViewCell shouldAnimateFromLocation:(CGPoint)translation;
-(void)swipeTableViewCellDidResetState:(RMSwipeTableViewCell*)swipeTableViewCell fromLocation:(CGPoint)translation withAnimation:(RMSwipeTableViewCellAnimationType)animation;
@end
