//
//  RMSwipeTableViewCell.h
//  RMSwipeTableView
//
//  Created by Rune Madsen on 2012-11-24.
//  Copyright (c) 2012 The App Boutique. All rights reserved.
//

#import <UIKit/UIKit.h>

enum {
    RMSwipeTableViewCellRevealDirectionRight = 0,
    RMSwipeTableViewCellRevealDirectionLeft,
    RMSwipeTableViewCellRevealDirectionBoth,
};
typedef NSUInteger RMSwipeTableViewCellRevealDirection;

enum {
    RMSwipeTableViewCellAnimationTypeBounce = 0,
    RMSwipeTableViewCellAnimationTypeEaseIn,
    RMSwipeTableViewCellAnimationTypeEaseOut,
    RMSwipeTableViewCellAnimationTypeEaseInOut,
};
typedef NSUInteger RMSwipeTableViewCellAnimationType;

@protocol RMSwipeTableViewCellDelegate;

@interface RMSwipeTableViewCell : UITableViewCell <UIGestureRecognizerDelegate>

@property (nonatomic, readwrite) RMSwipeTableViewCellRevealDirection *revealDirection; // default is RMSwipeTableViewCellRevealDirectionRight
@property (nonatomic, readwrite) RMSwipeTableViewCellAnimationType *animationType; // default is RMSwipeTableViewCellAnimationTypeBounce.
@property (nonatomic, readwrite) BOOL revealsBackground; // default is NO
@property (nonatomic, assign) id <RMSwipeTableViewCellDelegate> delegate;
@property (nonatomic, readwrite) float swipeDrag; // this determines how 'sticky' the cell feels. default is 0.35

@end


@protocol RMSwipeTableViewCellDelegate
@optional
-(void)swipeTableViewCellDidStartSwiping:(RMSwipeTableViewCell*)swipeTableViewCell;
-(void)swipeTableViewCell:(RMSwipeTableViewCell*)swipeTableViewCell didFinishAnimation:(RMSwipeTableViewCellAnimationType)animation;
@end
