//
//  RMPersonTableViewCell.m
//  RMSwipeTableView
//
//  Created by Rune Madsen on 2013-05-13.
//  Copyright (c) 2013 The App Boutique. All rights reserved.
//

#import "RMPersonTableViewCell.h"
#import <QuartzCore/QuartzCore.h>

@interface RMPersonTableViewCell () {
}

@end

@implementation RMPersonTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    if (self) {
        self.textLabel.font = [UIFont fontWithName:@"Avenir-Heavy" size:16];
        self.textLabel.backgroundColor = self.contentView.backgroundColor;
		self.detailTextLabel.font = [UIFont fontWithName:@"Avenir-Book" size:14];
        self.detailTextLabel.backgroundColor = self.contentView.backgroundColor;
        
		self.self.profileImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 54, 54)];
		[self.profileImageView setBackgroundColor:[UIColor whiteColor]];
		[self.profileImageView setClipsToBounds:YES];
		[self.profileImageView setContentMode:UIViewContentModeScaleAspectFill];
		[self.profileImageView.layer setBorderColor:[UIColor colorWithWhite:0 alpha:0.3].CGColor];
		[self.profileImageView.layer setBorderWidth:1];
        [self.profileImageView.layer setCornerRadius:2];
        [self.contentView addSubview:self.profileImageView];
    }
    return self;
}

-(void)prepareForReuse {
	[super prepareForReuse];
	self.textLabel.textColor = [UIColor blackColor];
	self.detailTextLabel.text = nil;
	self.detailTextLabel.textColor = [UIColor grayColor];
	[self setUserInteractionEnabled:YES];
	self.imageView.alpha = 1;
	self.accessoryView = nil;
	self.accessoryType = UITableViewCellAccessoryNone;
    [self.contentView setHidden:NO];
}

-(void)layoutSubviews {
    [super layoutSubviews];
    self.textLabel.frame = CGRectMake(CGRectGetMaxX(self.profileImageView.frame) + 10, CGRectGetMinY(self.textLabel.frame), CGRectGetWidth(self.textLabel.frame), CGRectGetHeight(self.textLabel.frame));
    self.detailTextLabel.frame = CGRectMake(CGRectGetMaxX(self.profileImageView.frame) + 10, CGRectGetMinY(self.detailTextLabel.frame), CGRectGetWidth(self.detailTextLabel.frame), CGRectGetHeight(self.detailTextLabel.frame));
}

-(void)setThumbnail:(UIImage*)image {
	[self.profileImageView setImage:image];
	[self.imageView setImage:[UIImage imageNamed:@"page_white"]];
}

- (void)disableCell {
	self.textLabel.textColor = [UIColor lightGrayColor];
	self.detailTextLabel.textColor = [UIColor lightGrayColor];
	[self setUserInteractionEnabled:NO];
	self.imageView.alpha = 0.5;
}

-(void)setFavourite:(BOOL)favourite animated:(BOOL)animated {
    self.isFavourite = favourite;
    if (animated) {
        if (favourite) {
            CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"borderColor"];
            animation.toValue = (id)[UIColor colorWithRed:1.000 green:0.000 blue:0.000 alpha:0.500].CGColor;
            animation.fromValue = (id)[UIColor colorWithWhite:0 alpha:0.3].CGColor;
            animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            animation.duration = 0.5;
            [self.profileImageView.layer addAnimation:animation forKey:@"animateBorderColor"];
            [self.profileImageView.layer setBorderColor:[UIColor colorWithRed:1.000 green:0.000 blue:0.000 alpha:0.500].CGColor];
        } else {
            CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"borderColor"];
            animation.toValue = (id)[UIColor colorWithWhite:0 alpha:0.3].CGColor;
            animation.fromValue = (id)[UIColor colorWithRed:1.000 green:0.000 blue:0.000 alpha:0.500].CGColor;
            animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            animation.duration = 0.5;
            [self.profileImageView.layer addAnimation:animation forKey:@"animateBorderColor"];
            [self.profileImageView.layer setBorderColor:[UIColor colorWithWhite:0 alpha:0.3].CGColor];
        }
    } else {
        if (favourite) {
            [self.profileImageView.layer setBorderColor:[UIColor colorWithRed:1.000 green:0.000 blue:0.000 alpha:0.500].CGColor];
        } else {
            [self.profileImageView.layer setBorderColor:[UIColor colorWithWhite:0 alpha:0.3].CGColor];
        }
    }
}

-(void)animateContentViewForPoint:(CGPoint)translation {
    [super animateContentViewForPoint:translation];
    NSLog(@"%@", NSStringFromCGPoint(translation));
    if (translation.x > 0) {
        
    }
}

-(void)resetCellFromPoint:(CGPoint)translation {
    [super resetCellFromPoint:translation];
}

@end
