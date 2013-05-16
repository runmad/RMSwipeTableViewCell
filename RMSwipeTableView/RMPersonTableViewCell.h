//
//  RMPersonTableViewCell.h
//  RMSwipeTableView
//
//  Created by Rune Madsen on 2013-05-13.
//  Copyright (c) 2013 The App Boutique. All rights reserved.
//

#import "RMSwipeTableViewCell.h"

@interface RMPersonTableViewCell : RMSwipeTableViewCell

-(void)setThumbnail:(UIImage*)image;
-(void)setFavourite:(BOOL)favourite animated:(BOOL)animated;

@end
