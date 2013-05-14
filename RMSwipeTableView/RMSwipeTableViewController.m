//
//  RMSwipeTableViewController.m
//  RMSwipeTableView
//
//  Created by Rune Madsen on 2012-11-24.
//  Copyright (c) 2012 The App Boutique. All rights reserved.
//

#import "RMSwipeTableViewController.h"

@interface RMSwipeTableViewController ()

@end

@implementation RMSwipeTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        [self.navigationItem setTitle:@"House Lannister"];
        
        static NSString *CellIdentifier = @"Cell";
        [self.tableView registerClass:[RMPersonTableViewCell class] forCellReuseIdentifier:CellIdentifier];
        [self.tableView setRowHeight:54];
    }
    return self;
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
                  [@{@"name" : @"Cersei Lannister", @"title" : @"Queen of the Seven Kingdoms", @"isFavourite" : @NO } mutableCopy],
                  [@{@"name" : @"Jaime Lannister", @"title" : @"Kingslayer", @"isFavourite" : @NO } mutableCopy],
                  [@{@"name" : @"Joanna Lannister", @"title" : @"Late wife of Tywon", @"isFavourite" : @NO } mutableCopy],
                  [@{@"name" : @"Joffrey Baratheon", @"title" : @"the Illborn", @"isFavourite" : @NO } mutableCopy],
                  [@{@"name" : @"Tyrion Lannister", @"title" : @"The Imp or Halfman", @"isFavourite" : @NO } mutableCopy],
                  [@{@"name" : @"Tywon Lannister", @"title" : @"Lord of Casterly Rock", @"isFavourite" : @NO } mutableCopy]]
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
    RMSwipeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@%@", [[[self.array objectAtIndex:indexPath.row] objectForKey:@"isFavourite"] boolValue] ? @"❤ " : @"", [[self.array objectAtIndex:indexPath.row] objectForKey:@"name"]];
    cell.detailTextLabel.text = [[self.array objectAtIndex:indexPath.row] objectForKey:@"title"];
    cell.revealDirection = RMSwipeTableViewCellRevealDirectionLeft;
    cell.delegate = self;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Swipe Table View Cell Delegate

-(void)swipeTableViewCellDidStartSwiping:(RMSwipeTableViewCell *)swipeTableViewCell fromTouchLocation:(CGPoint)translation {
    
}

-(void)swipeTableViewCell:(RMSwipeTableViewCell *)swipeTableViewCell swipedToLocation:(CGPoint)translation {
    
}

-(void)swipeTableViewCellWillResetState:(RMSwipeTableViewCell *)swipeTableViewCell fromLocation:(CGPoint)translation withAnimation:(RMSwipeTableViewCellAnimationType)animation {
}

-(void)swipeTableViewCellDidResetState:(RMSwipeTableViewCell *)swipeTableViewCell fromLocation:(CGPoint)translation withAnimation:(RMSwipeTableViewCellAnimationType)animation {
    if (translation.x > 50) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:swipeTableViewCell];
        if ([[[self.array objectAtIndex:indexPath.row] objectForKey:@"isFavourite"] boolValue]) {
            [[self.array objectAtIndex:indexPath.row] setObject:@NO forKey:@"isFavourite"];
        } else {
            [[self.array objectAtIndex:indexPath.row] setObject:@YES forKey:@"isFavourite"];
        }
        [self.tableView beginUpdates];
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.tableView endUpdates];
    }
}

@end
