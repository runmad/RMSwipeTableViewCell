//
//  RMSwipeTableViewCelliOS7UIDemoTableViewCell.m
//  RMSwipeTableViewCelliOS7UIDemo
//
//  Created by Rune Madsen on 2013-06-16.
//  Copyright (c) 2013 The App Boutique. All rights reserved.
//

#import "RMSwipeTableViewCelliOS7UIDemoTableViewCell.h"

#define BUTTON_THRESHOLD 80

@implementation RMSwipeTableViewCelliOS7UIDemoTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backViewbackgroundColor = [UIColor whiteColor];
        self.detailTextLabel.numberOfLines = 2;
        self.revealDirection = RMSwipeTableViewCellRevealDirectionRight;
        self.animationType = RMSwipeTableViewCellAnimationTypeEaseOut;
        self.panElasticityStartingPoint = BUTTON_THRESHOLD;
    }
    return self;
}

-(UIButton*)deleteButton {
    if (!_deleteButton) {
        _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteButton setBackgroundImage:[UIImage imageNamed:@"DeleteButtonBackground"] forState:UIControlStateNormal];
        [_deleteButton setBackgroundImage:[UIImage imageNamed:@"DeleteButtonBackground"] forState:UIControlStateHighlighted];
        [_deleteButton.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:18]];
        [_deleteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_deleteButton setTitle:NSLocalizedString(@"Delete", nil) forState:UIControlStateNormal];
        [_deleteButton setFrame:CGRectMake(CGRectGetMaxX(self.frame) - BUTTON_THRESHOLD, 0, BUTTON_THRESHOLD, CGRectGetHeight(self.contentView.frame))];
        [_deleteButton addTarget:self action:@selector(deleteAction) forControlEvents:UIControlEventTouchUpInside];
        [_deleteButton setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
    }
    return _deleteButton;
}

-(void)didStartSwiping {
    [super didStartSwiping];
    [self.backView addSubview:self.deleteButton];
}

-(void)deleteAction {
    if ([self.demoDelegate respondsToSelector:@selector(swipeTableViewCellDidDelete:)]) {
        [self.demoDelegate swipeTableViewCellDidDelete:self];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

-(void)resetContentView {
    [UIView animateWithDuration:0.15f
                     animations:^{
                         self.contentView.frame = CGRectOffset(self.contentView.bounds, 0, 0);
                     }
                     completion:^(BOOL finished) {
                         self.shouldAnimateCellReset = YES;
                         [self cleanupBackView];
                     }];
}

-(void)cleanupBackView {
    [super cleanupBackView];
    [_deleteButton removeFromSuperview];
    _deleteButton = nil;
}

@end
