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
	UIImageView *thumbnailImageView;
}

@end

@implementation RMPersonTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    if (self) {
        self.textLabel.font = [UIFont boldSystemFontOfSize:16];
        self.textLabel.backgroundColor = self.contentView.backgroundColor;
		self.detailTextLabel.font = [UIFont systemFontOfSize:14];
        self.detailTextLabel.backgroundColor = self.contentView.backgroundColor;
//		self.selectionStyle = UITableViewCellSelectionStyleNone;
		thumbnailImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 54, 54)];
		[thumbnailImageView setBackgroundColor:[UIColor whiteColor]];
		[thumbnailImageView setClipsToBounds:YES];
		[thumbnailImageView setContentMode:UIViewContentModeScaleAspectFill];
		[thumbnailImageView.layer setBorderColor:[UIColor colorWithWhite:0 alpha:0.3].CGColor];
		[thumbnailImageView.layer setBorderWidth:1];
        [thumbnailImageView.layer setCornerRadius:2];
        [self.contentView addSubview:thumbnailImageView];
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
    self.textLabel.frame = CGRectMake(CGRectGetMaxX(thumbnailImageView.frame) + 10, CGRectGetMinY(self.textLabel.frame), CGRectGetWidth(self.textLabel.frame), CGRectGetHeight(self.textLabel.frame));
    self.detailTextLabel.frame = CGRectMake(CGRectGetMaxX(thumbnailImageView.frame) + 10, CGRectGetMinY(self.detailTextLabel.frame), CGRectGetWidth(self.detailTextLabel.frame), CGRectGetHeight(self.detailTextLabel.frame));
}

-(void)setThumbnail:(UIImage*)image {
	[thumbnailImageView setImage:image];
	[self.imageView setImage:[UIImage imageNamed:@"page_white"]];
}

- (void)disableCell {
	self.textLabel.textColor = [UIColor lightGrayColor];
	self.detailTextLabel.textColor = [UIColor lightGrayColor];
	[self setUserInteractionEnabled:NO];
	self.imageView.alpha = 0.5;
}

-(void)setFavourite:(BOOL)favourite animated:(BOOL)animated {
    if (animated) {
        if (favourite) {
            [UIView animateWithDuration:0.15
                                  delay:0
                                options:UIViewAnimationCurveLinear
                             animations:^{
                                 [thumbnailImageView.layer setBorderColor:[UIColor colorWithRed:1.000 green:0.000 blue:0.000 alpha:0.500].CGColor];
                             }
                             completion:^(BOOL finished) {
                             }
             ];
        } else {
            [UIView animateWithDuration:0.15
                                  delay:0
                                options:UIViewAnimationCurveLinear
                             animations:^{
                                 [thumbnailImageView.layer setBorderColor:[UIColor colorWithWhite:0 alpha:0.3].CGColor];
                             }
                             completion:^(BOOL finished) {
                             }
             ];
        }
    }
}

@end
