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
@property (nonatomic, readwrite) RMSwipeTableViewCellAnimationType *animationType; // default is RMSwipeTableViewCellAnimationTypeBounce.
@property (nonatomic, readwrite) BOOL revealsBackground; // default is NO
@property (nonatomic, readwrite) float dragResistance; // the drag resistance determines how "heavy" the cell feels when dragging it. Default is 0.35
@property (nonatomic, assign) id <RMSwipeTableViewCellDelegate> delegate;

@end


@protocol RMSwipeTableViewCellDelegate <NSObject>
@optional
-(void)swipeTableViewCellDidStartSwiping:(RMSwipeTableViewCell*)swipeTableViewCell fromTouchLocation:(CGPoint)translation;
-(void)swipeTableViewCell:(RMSwipeTableViewCell*)swipeTableViewCell swipedToLocation:(CGPoint)translation;
-(void)swipeTableViewCellWillResetState:(RMSwipeTableViewCell*)swipeTableViewCell fromLocation:(CGPoint)translation withAnimation:(RMSwipeTableViewCellAnimationType)animation;
-(void)swipeTableViewCellDidResetState:(RMSwipeTableViewCell*)swipeTableViewCell fromLocation:(CGPoint)translation withAnimation:(RMSwipeTableViewCellAnimationType)animation;
@end
