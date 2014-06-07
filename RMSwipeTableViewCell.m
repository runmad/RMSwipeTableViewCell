//
//  RMSwipeTableViewCell.m
//  RMSwipeTableView
//
//  Created by Rune Madsen on 2012-11-24.
//  Copyright (c) 2012 The App Boutique. All rights reserved.
//

#import "RMSwipeTableViewCell.h"

@interface RMSwipeTableViewCell ()

@end

@implementation RMSwipeTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initialize];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize
{
    // We need to set the contentView's background colour, otherwise the sides are clear on the swipe and animations
    [self.contentView setBackgroundColor:[UIColor whiteColor]];
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    [panGestureRecognizer setDelegate:self];
    [self addGestureRecognizer:panGestureRecognizer];
    
    self.revealDirection = RMSwipeTableViewCellRevealDirectionBoth;
    self.animationType = RMSwipeTableViewCellAnimationTypeBounce;
    self.animationDuration = 0.2f;
    self.shouldAnimateCellReset = YES;
    self.backViewbackgroundColor = [UIColor colorWithWhite:0.92 alpha:1];
    self.panElasticity = YES;
    self.panElasticityFactor = 0.55f;
    self.panElasticityStartingPoint = 0.0f;
    
    UIView *backgroundView = [[UIView alloc] initWithFrame:self.frame];
    backgroundView.backgroundColor = [UIColor whiteColor];
    self.backgroundView = backgroundView;
}

-(void)prepareForReuse {
    [super prepareForReuse];
    self.shouldAnimateCellReset = YES;
}

-(void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

#pragma mark - Gesture recognizer delegate

-(BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)panGestureRecognizer {
    // We only want to deal with the gesture of it's a pan gesture
    if ([panGestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]] && self.revealDirection != RMSwipeTableViewCellRevealDirectionNone) {
        CGPoint translation = [panGestureRecognizer translationInView:[self superview]];
        return (fabs(translation.x) / fabs(translation.y) > 1) ? YES : NO;
    } else {
        return NO;
    }
}

-(void)handlePanGesture:(UIPanGestureRecognizer *)panGestureRecognizer {
    CGPoint translation = [panGestureRecognizer translationInView:panGestureRecognizer.view];
    CGPoint velocity = [panGestureRecognizer velocityInView:panGestureRecognizer.view];
    CGFloat panOffset = translation.x;
    if (self.panElasticity) {
        if (ABS(translation.x) > self.panElasticityStartingPoint) {
            CGFloat width = CGRectGetWidth(self.frame);
            CGFloat offset = abs(translation.x);
            panOffset = (offset * self.panElasticityFactor * width) / (offset * self.panElasticityFactor + width);
            panOffset *= translation.x < 0 ? -1.0f : 1.0f;
            if (self.panElasticityStartingPoint > 0) {
                panOffset = translation.x > 0 ? panOffset + self.panElasticityStartingPoint / 2 : panOffset - self.panElasticityStartingPoint / 2;
            }
        }
    }
    CGPoint actualTranslation = CGPointMake(panOffset, translation.y);
    if (panGestureRecognizer.state == UIGestureRecognizerStateBegan && [panGestureRecognizer numberOfTouches] > 0) {
        [self didStartSwiping];
        [self animateContentViewForPoint:actualTranslation velocity:velocity];
    } else if (panGestureRecognizer.state == UIGestureRecognizerStateChanged && [panGestureRecognizer numberOfTouches] > 0) {
        [self animateContentViewForPoint:actualTranslation velocity:velocity];
	} else {
		[self resetCellFromPoint:actualTranslation  velocity:velocity];
	}
}

-(void)didStartSwiping {
    if ([self.delegate respondsToSelector:@selector(swipeTableViewCellDidStartSwiping:)]) {
        [self.delegate swipeTableViewCellDidStartSwiping:self];
    }
    [self.backgroundView addSubview:self.backView];
    [self.backView setAutoresizingMask:UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth];
}

#pragma mark - Gesture animations

-(void)animateContentViewForPoint:(CGPoint)point velocity:(CGPoint)velocity {
    if ((point.x > 0 && self.revealDirection == RMSwipeTableViewCellRevealDirectionLeft) || (point.x < 0 && self.revealDirection == RMSwipeTableViewCellRevealDirectionRight) || self.revealDirection == RMSwipeTableViewCellRevealDirectionBoth) {
        self.contentView.frame = CGRectOffset(self.contentView.bounds, point.x, 0);
        if ([self.delegate respondsToSelector:@selector(swipeTableViewCell:didSwipeToPoint:velocity:)]) {
            [self.delegate swipeTableViewCell:self didSwipeToPoint:point velocity:velocity];
        }
    } else if ((point.x > 0 && self.revealDirection == RMSwipeTableViewCellRevealDirectionRight) || (point.x < 0 && self.revealDirection == RMSwipeTableViewCellRevealDirectionLeft)) {
        self.contentView.frame = CGRectOffset(self.contentView.bounds, 0, 0);
    }
}

-(void)resetCellFromPoint:(CGPoint)point velocity:(CGPoint)velocity {
    if ([self.delegate respondsToSelector:@selector(swipeTableViewCellWillResetState:fromPoint:animation:velocity:)]) {
        [self.delegate swipeTableViewCellWillResetState:self fromPoint:point animation:self.animationType velocity:velocity];
    }
    if (self.shouldAnimateCellReset == NO) {
        return;
    }
    if ((self.revealDirection == RMSwipeTableViewCellRevealDirectionLeft && point.x < 0) || (self.revealDirection == RMSwipeTableViewCellRevealDirectionRight && point.x > 0)) {
        return;
    }
    if (self.animationType == RMSwipeTableViewCellAnimationTypeBounce) {
        void (^completionBlock)(BOOL) = ^(BOOL finished) {
            BOOL shouldCleanupBackView = YES;
            if ([self.delegate respondsToSelector:@selector(swipeTableViewCellShouldCleanupBackView:)]) {
                shouldCleanupBackView = [self.delegate swipeTableViewCellShouldCleanupBackView:self];
            }
            if (shouldCleanupBackView) {
                [self cleanupBackView];
            }
            
            if ([self.delegate respondsToSelector:@selector(swipeTableViewCellDidResetState:fromPoint:animation:velocity:)]) {
                [self.delegate swipeTableViewCellDidResetState:self fromPoint:point animation:self.animationType velocity:velocity];
            }
        };
        if ([[UIView class] respondsToSelector:@selector(animateWithDuration:delay:usingSpringWithDamping:initialSpringVelocity:options:animations:completion:)]) {
            [UIView animateWithDuration:self.animationDuration
                                  delay:0
                 usingSpringWithDamping:0.6
                  initialSpringVelocity:point.x / 10
                                options:UIViewAnimationOptionAllowUserInteraction
                             animations:^{
                                 self.contentView.frame = self.contentView.bounds;
                             }
                             completion:completionBlock];
        } else {
            [UIView animateWithDuration:self.animationDuration
                                  delay:0
                                options:UIViewAnimationOptionCurveEaseIn
                             animations:^{
                                 self.contentView.frame = CGRectOffset(self.contentView.bounds, 0 - (point.x * 0.03), 0);
                             }
                             completion:^(BOOL finished) {
                                 [UIView animateWithDuration:0.1
                                                       delay:0
                                                     options:UIViewAnimationOptionCurveEaseInOut
                                                  animations:^{
                                                      self.contentView.frame = CGRectOffset(self.contentView.bounds, 0 + (point.x * 0.02), 0);
                                                  }
                                                  completion:^(BOOL finished) {
                                                      [UIView animateWithDuration:0.1
                                                                            delay:0
                                                                          options:UIViewAnimationOptionCurveEaseOut
                                                                       animations:^{
                                                                           self.contentView.frame = self.contentView.bounds;
                                                                       }
                                                                       completion:completionBlock
                                                       ];
                                                  }
                                  ];
                             }
             ];
        }
    } else {
        [UIView animateWithDuration:self.animationDuration
                              delay:0
                            options:(UIViewAnimationOptions)self.animationType
                         animations:^{
                             self.contentView.frame = CGRectOffset(self.contentView.bounds, 0, 0);
                         }
                         completion:^(BOOL finished) {
                             
                             BOOL shouldCleanupBackView = YES;
                             if ([self.delegate respondsToSelector:@selector(swipeTableViewCellShouldCleanupBackView:)]) {
                                 shouldCleanupBackView = [self.delegate swipeTableViewCellShouldCleanupBackView:self];
                             }
                             if (shouldCleanupBackView) {
                                 [self cleanupBackView];
                             }
                             
                             if ([self.delegate respondsToSelector:@selector(swipeTableViewCellDidResetState:fromPoint:animation:velocity:)]) {
                                 [self.delegate swipeTableViewCellDidResetState:self fromPoint:point animation:self.animationType velocity:velocity];
                             }
                         }
         ];
    }
}

-(UIView*)backView {
    if (!_backView) {
        _backView = [[UIView alloc] initWithFrame:self.contentView.bounds];
        _backView.backgroundColor = self.backViewbackgroundColor;
    }
    return _backView;
}

-(void)cleanupBackView {
    [_backView removeFromSuperview];
    _backView = nil;
}

@end
