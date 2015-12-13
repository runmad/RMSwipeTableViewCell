//
//  RMSwipeTableViewController.h
//  RMSwipeTableView
//
//  Created by Rune Madsen on 2012-11-24.
//  Copyright (c) 2015 The App Boutique. All rights reserved.
//

@import UIKit;
#import "RMPersonTableViewCell.h"

@interface RMSwipeTableViewController : UITableViewController <RMSwipeTableViewCellDelegate>

@property (nonatomic, strong) NSMutableArray *array;

@end
