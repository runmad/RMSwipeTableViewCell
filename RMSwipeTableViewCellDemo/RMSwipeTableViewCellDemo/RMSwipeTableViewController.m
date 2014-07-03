//
//  RMSwipeTableViewController.m
//  RMSwipeTableView
//
//  Created by Rune Madsen on 2012-11-24.
//  Copyright (c) 2012 The App Boutique. All rights reserved.
//

#import "RMSwipeTableViewController.h"

#define LOG_DELEGATE_METHODS 0

@interface RMSwipeTableViewController ()

@end

@implementation RMSwipeTableViewController

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        [self.navigationItem setTitle:@"House Lannister"];
        
        static NSString *CellIdentifier = @"Cell";
        [self.tableView registerClass:[RMPersonTableViewCell class] forCellReuseIdentifier:CellIdentifier];
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
        [self.tableView setRowHeight:64];
        
        UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(resetTableView)];
        [self.navigationItem setRightBarButtonItem:barButtonItem];
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.tableView.frame), 200)];
        [view setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
        [view setBackgroundColor:[UIColor colorWithWhite:0.92 alpha:1]];
        UIImageView *sigilImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"HouseStarkSigil"]];
        [sigilImageView setCenter:view.center];
        [sigilImageView setAlpha:0.3];
        [view addSubview:sigilImageView];
        self.tableView.tableFooterView = view;
        
        [self.tableView setBackgroundColor:view.backgroundColor];
        
        self.tableView.contentInset = self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, - CGRectGetHeight(view.frame), 0);
    }
    return self;
}

-(void)resetTableView {
    [_array removeAllObjects];
    _array = nil;
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSMutableArray*)array {
    if (!_array) {
        _array = [@[
                  [@{@"name" : @"Cersei Lannister", @"title" : @"Queen of the Seven Kingdoms", @"isFavourite" : @NO, @"image" : @"cersei" } mutableCopy],
                  [@{@"name" : @"Jaime Lannister", @"title" : @"Kingslayer", @"isFavourite" : @NO, @"image" : @"jaime" } mutableCopy],
                  [@{@"name" : @"Joffrey Baratheon", @"title" : @"The Illborn", @"isFavourite" : @NO, @"image" : @"joffrey" } mutableCopy],
                  [@{@"name" : @"Tyrion Lannister", @"title" : @"The Halfman", @"isFavourite" : @NO, @"image" : @"tyrion" } mutableCopy],
                  [@{@"name" : @"Tywin Lannister", @"title" : @"Lord of Casterly Rock", @"isFavourite" : @NO, @"image" : @"tywin" } mutableCopy]]
                  mutableCopy];
    }
    return _array;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.array count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    RMPersonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = (self.array)[indexPath.row][@"name"];
    cell.detailTextLabel.text = (self.array)[indexPath.row][@"title"];
    [cell setThumbnail:[UIImage imageNamed:(self.array)[indexPath.row][@"image"]]];
    [cell setFavourite:[(self.array)[indexPath.row][@"isFavourite"] boolValue] animated:NO];
    cell.delegate = self;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Swipe Table View Cell Delegate

-(void)swipeTableViewCellDidStartSwiping:(RMSwipeTableViewCell *)swipeTableViewCell {
#if LOG_DELEGATE_METHODS
    NSLog(@"swipeTableViewCellDidStartSwiping: %@", swipeTableViewCell);
#endif
}

-(void)swipeTableViewCell:(RMPersonTableViewCell *)swipeTableViewCell didSwipeToPoint:(CGPoint)point velocity:(CGPoint)velocity {
#if LOG_DELEGATE_METHODS
    NSLog(@"swipeTableViewCell: %@ didSwipeToPoint: %@ velocity: %@", swipeTableViewCell, NSStringFromCGPoint(point), NSStringFromCGPoint(velocity));
#endif
}

-(void)swipeTableViewCellWillResetState:(RMSwipeTableViewCell *)swipeTableViewCell fromPoint:(CGPoint)point animation:(RMSwipeTableViewCellAnimationType)animation velocity:(CGPoint)velocity {
#if LOG_DELEGATE_METHODS
    NSLog(@"swipeTableViewCellWillResetState: %@ fromPoint: %@ animation: %d, velocity: %@", swipeTableViewCell, NSStringFromCGPoint(point), animation, NSStringFromCGPoint(velocity));
#endif
    if (point.x >= CGRectGetHeight(swipeTableViewCell.frame)) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:swipeTableViewCell];
        if ([(self.array)[indexPath.row][@"isFavourite"] boolValue]) {
            (self.array)[indexPath.row][@"isFavourite"] = @NO;
        } else {
            (self.array)[indexPath.row][@"isFavourite"] = @YES;
        }
        [(RMPersonTableViewCell*)swipeTableViewCell setFavourite:[(self.array)[indexPath.row][@"isFavourite"] boolValue] animated:YES];
    } else if (point.x < 0 && -point.x >= CGRectGetHeight(swipeTableViewCell.frame)) {
        swipeTableViewCell.shouldAnimateCellReset = NO;
        [[(RMPersonTableViewCell*)swipeTableViewCell checkmarkGreyImageView] removeFromSuperview];
        [UIView animateWithDuration:0.25
                              delay:0
                            options:UIViewAnimationCurveLinear
                         animations:^{
                             swipeTableViewCell.contentView.frame = CGRectOffset(swipeTableViewCell.contentView.bounds, swipeTableViewCell.contentView.frame.size.width, 0);
                         }
                         completion:^(BOOL finished) {
                             [swipeTableViewCell.contentView setHidden:YES];
                             NSIndexPath *indexPath = [self.tableView indexPathForCell:swipeTableViewCell];
                             [self.array removeObjectAtIndex:indexPath.row];
                             [self.tableView beginUpdates];
                             [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationMiddle];
                             [self.tableView endUpdates];
                         }
         ];
    }
}

-(void)swipeTableViewCellDidResetState:(RMSwipeTableViewCell *)swipeTableViewCell fromPoint:(CGPoint)point animation:(RMSwipeTableViewCellAnimationType)animation velocity:(CGPoint)velocity {
#if LOG_DELEGATE_METHODS
    NSLog(@"swipeTableViewCellDidResetState: %@ fromPoint: %@ animation: %d, velocity: %@", swipeTableViewCell, NSStringFromCGPoint(point), animation, NSStringFromCGPoint(velocity));
#endif
    if (point.x < 0 && -point.x > CGRectGetHeight(swipeTableViewCell.frame)) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:swipeTableViewCell];
        [self.array removeObjectAtIndex:indexPath.row];
        [self.tableView beginUpdates];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.tableView endUpdates];
    }
}

@end
