//
//  RMSwipeTableViewCell.m
//  RMSwipeTableView
//
//  Created by Rune Madsen on 2012-11-24.
//  Copyright (c) 2012 The App Boutique. All rights reserved.
//

#import "RMSwipeTableViewCell.h"

@interface RMSwipeTableViewCell ()
@property (nonatomic, strong) UIView *backView;
@end

@implementation RMSwipeTableViewCell

@synthesize backView;
@synthesize delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // We need to set the contentView's background colour, otherwise the sides are clear on the swipe and animations
        [self.contentView setBackgroundColor:[UIColor greenColor]];
        
        UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
        [panGestureRecognizer setDelegate:self];
        [self addGestureRecognizer:panGestureRecognizer];

        self.revealDirection = RMSwipeTableViewCellRevealDirectionRight;
        self.animationType = RMSwipeTableViewCellAnimationTypeBounce;
        self.swipeDrag = 0.35;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)handlePanGesture:(UIPanGestureRecognizer *)panGestureRecognizer {
    CGPoint translation = [panGestureRecognizer translationInView:self.superview];
    if (panGestureRecognizer.state == UIGestureRecognizerStateBegan && [panGestureRecognizer numberOfTouches] > 0) {
        [delegate swipeTableViewCellDidStartSwiping:self];
        [self animateContentViewForPoint:translation];
    } else if ( panGestureRecognizer.state == UIGestureRecognizerStateChanged && [panGestureRecognizer numberOfTouches] > 0) {
        [self animateContentViewForPoint:translation];
	} else if (panGestureRecognizer.state == UIGestureRecognizerStateEnded) {
		[self resetBackViewFromPoint:translation];
	}
}

#pragma mark - Gesture recognizer delegate
- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)panGestureRecognizer {
    CGPoint translation = [panGestureRecognizer translationInView:[self superview]];
    return (fabs(translation.x) / fabs(translation.y) > 1) ? YES : NO;
}

#pragma mark - Gesture animations 

-(void)animateContentViewForPoint:(CGPoint)translation {
    if (translation.x > 0 && (self.revealDirection == RMSwipeTableViewCellRevealDirectionRight || self.revealDirection == RMSwipeTableViewCellRevealDirectionBoth)) {
        if (backView == nil) {
            UIView *backgroundView = [[UIView alloc] initWithFrame:self.contentView.frame];
            backgroundView.backgroundColor = [UIColor whiteColor];
            self.backgroundView = backgroundView;
            backView = [[UIView alloc] initWithFrame:self.contentView.frame];
            backView.backgroundColor = [UIColor redColor];
        }
        [self.backgroundView addSubview:backView];
        self.contentView.frame = CGRectOffset(self.contentView.bounds, translation.x * self.swipeDrag, 0);
    } else if (translation.x < 0 && (self.revealDirection == RMSwipeTableViewCellRevealDirectionLeft || self.revealDirection == RMSwipeTableViewCellRevealDirectionBoth)) {
        
    }
}

-(void)resetBackViewFromPoint:(CGPoint)translation {
    if (self.animationType == RMSwipeTableViewCellAnimationTypeBounce) {
        [self animateVelocityBounce:translation];
    }
}

-(void)animateVelocityBounce:(CGPoint)translation {
    [UIView animateWithDuration:0.15
                          delay:0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         self.contentView.frame = CGRectOffset(self.contentView.bounds, 0 - (translation.x * 0.03), 0);
                     }
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.1
                                               delay:0
                                             options:UIViewAnimationOptionCurveEaseInOut
                                          animations:^{
                                              self.contentView.frame = CGRectOffset(self.contentView.bounds, 0 + (translation.x * 0.02), 0);
                                          }
                                          completion:^(BOOL finished) {
                                              [UIView animateWithDuration:0.1
                                                                    delay:0
                                                                  options:UIViewAnimationOptionCurveEaseOut
                                                               animations:^{
                                                                   self.contentView.frame = self.contentView.bounds;
                                                               }
                                                               completion:^(BOOL finished) {
                                                                   [backView removeFromSuperview];
                                                                   backView = nil;
                                                               }
                                               ];
                                          }
                          ];
                     }
     ];
}

@end
