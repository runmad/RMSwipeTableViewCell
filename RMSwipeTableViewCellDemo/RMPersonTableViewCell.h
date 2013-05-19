//
//  RMPersonTableViewCell.h
//  RMSwipeTableView
//
//  Created by Rune Madsen on 2013-05-13.
//  Copyright (c) 2013 The App Boutique. All rights reserved.
//

#import "RMSwipeTableViewCell.h"

@interface RMPersonTableViewCell : RMSwipeTableViewCell

@property (nonatomic, strong) UIImageView *profileImageView;
@property (nonatomic, strong) UIImageView *checkmarkGreyImageView;
@property (nonatomic, strong) UIImageView *checkmarkGreenImageView;
@property (nonatomic, strong) UIImageView *checkmarkProfileImageView;
@property (nonatomic, strong) UIImageView *deleteGreyImageView;
@property (nonatomic, strong) UIImageView *deleteRedImageView;
@property (nonatomic, assign) BOOL isFavourite;

-(void)setThumbnail:(UIImage*)image;
-(void)setFavourite:(BOOL)favourite animated:(BOOL)animated;

@end
