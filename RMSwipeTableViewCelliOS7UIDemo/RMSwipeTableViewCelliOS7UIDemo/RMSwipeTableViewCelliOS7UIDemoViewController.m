//
//  RMSwipeTableViewCelliOS7UIDemoViewController.m
//  RMSwipeTableViewCelliOS7UIDemo
//
//  Created by Rune Madsen on 2013-06-16.
//  Copyright (c) 2013 The App Boutique. All rights reserved.
//

#import "RMSwipeTableViewCelliOS7UIDemoViewController.h"

@interface RMSwipeTableViewCelliOS7UIDemoViewController ()

@end

@implementation RMSwipeTableViewCelliOS7UIDemoViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerClass:[RMSwipeTableViewCelliOS7UIDemoTableViewCell class] forCellReuseIdentifier:@"Cell"];
    [self.tableView setRowHeight:77];
    
    [self.navigationItem setTitle:NSLocalizedString(@"Messages", nil)];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)resetDemo {
    _messagesArray = nil;
    [self.tableView reloadData];
    [self.navigationItem setRightBarButtonItem:nil animated:YES];
}

-(NSMutableArray*)messagesArray {
    if (!_messagesArray) {
        _messagesArray = [@[] mutableCopy];
        [_messagesArray addObject:@{ @"sender" : @"Jonathan Ive", @"message" : @"I can't believe what people are saying about those iOS 7 icons! Are they missing aluminium or something?" }];
        [_messagesArray addObject:@{ @"sender" : @"Phil Schiller", @"message" : @"Thanks! I am letting my hair grow a bit longer this summer." }];
        [_messagesArray addObject:@{ @"sender" : @"Tim Cook", @"message" : @"Haha, yeah. I just love mocking the competition with those numbers! 😁" }];
        [_messagesArray addObject:@{ @"sender" : @"Craig Federighi", @"message" : @"I know, I am using 5 screens on my Mac now, I love that feature!" }];
        [_messagesArray addObject:@{ @"sender" : @"Peter Openheimer", @"message" : @"Honestly, I am not worried, the stock will bounce back..." }];
        [_messagesArray addObject:@{ @"sender" : @"Scott Forstall", @"message" : @"Hey, why are you not responding to my messages???" }];
//        [_messagesArray addObject:@{ @"sender" : @"", @"message" : @"" }];
    }
    return _messagesArray;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    return [self.messagesArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    RMSwipeTableViewCelliOS7UIDemoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = [self.messagesArray objectAtIndex:indexPath.row][@"sender"];
    cell.detailTextLabel.text = [self.messagesArray objectAtIndex:indexPath.row][@"message"];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    cell.delegate = self;
    cell.demoDelegate = self;
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.selectedIndexPath.row != indexPath.row) {
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
        [self resetSelectedCell];
    }
    if (self.selectedIndexPath.row == indexPath.row) {
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
        [self resetSelectedCell];
    }
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (self.selectedIndexPath) {
        [self resetSelectedCell];
    }
}

#pragma mark - RMSwipeTableViewCelliOS7UIDemoTableViewCell delegate method

-(void)swipeTableViewCellDidDelete:(RMSwipeTableViewCelliOS7UIDemoTableViewCell *)swipeTableViewCell {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:swipeTableViewCell];
    [self.messagesArray removeObjectAtIndex:indexPath.row];
    [swipeTableViewCell resetContentView];
    [self.tableView beginUpdates];
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableView endUpdates];
    if ([self.messagesArray count]) {
        UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Reset", nil) style:UIBarButtonItemStylePlain target:self action:@selector(resetDemo)];
        [self.navigationItem setRightBarButtonItem:barButtonItem animated:YES];
    }
}

#pragma mark - RMSwipeTableViewCell delegate methods

-(void)swipeTableViewCellDidStartSwiping:(RMSwipeTableViewCell *)swipeTableViewCell {
    NSIndexPath *indexPathForCell = [self.tableView indexPathForCell:swipeTableViewCell];
    if (self.selectedIndexPath.row != indexPathForCell.row) {
        [self resetSelectedCell];
    }
}

-(void)resetSelectedCell {
    RMSwipeTableViewCelliOS7UIDemoTableViewCell *cell = (RMSwipeTableViewCelliOS7UIDemoTableViewCell*)[self.tableView cellForRowAtIndexPath:self.selectedIndexPath];
    [cell resetContentView];
    self.selectedIndexPath = nil;
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
}

-(void)swipeTableViewCellWillResetState:(RMSwipeTableViewCell *)swipeTableViewCell fromPoint:(CGPoint)point animation:(RMSwipeTableViewCellAnimationType)animation velocity:(CGPoint)velocity {
    if (velocity.x <= fabsf(400) && point.x < -80) {
        self.selectedIndexPath = [self.tableView indexPathForCell:swipeTableViewCell];
        swipeTableViewCell.shouldAnimateCellReset = NO;
        swipeTableViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSTimeInterval duration = MIN(fabsf(point.x) / fabsf(velocity.x), 0.10f);
        [UIView animateWithDuration:duration
                              delay:0
                            options:UIViewAnimationOptionCurveLinear
                         animations:^{
                             swipeTableViewCell.contentView.frame = CGRectOffset(swipeTableViewCell.contentView.bounds, point.x - (ABS(velocity.x) / 150), 0);
                         }
                         completion:^(BOOL finished) {
                             [UIView animateWithDuration:duration
                                                   delay:0
                                                 options:UIViewAnimationOptionCurveEaseOut
                                              animations:^{
                                                  swipeTableViewCell.contentView.frame = CGRectOffset(swipeTableViewCell.contentView.bounds, -80, 0);
                                              }
                                              completion:^(BOOL finished) {
                                              }];
                         }];
    }
    // The below behaviour is not normal as of iOS 7 beta seed 1
    // for Messages.app, but it is for Mail.app.
    // The user has to pan/swipe with a certain amount of velocity
    // before the cell goes to delete-state. If the user just pans
    // above the threshold for the button but without enough velocity,
    // the cell will reset.
    // Mail.app will, however allow for the cell to reveal the button
    // even if the velocity isn't high, but the pan translation is
    // above the threshold. I am assuming it'll get more consistent
    // in later seed of the iOS 7 beta
    /*
    else if (velocity.x > -500 && point.x < -80) {
        self.selectedIndexPath = [self.tableView indexPathForCell:swipeTableViewCell];
        swipeTableViewCell.shouldAnimateCellReset = NO;
        swipeTableViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSTimeInterval duration = MIN(-point.x / ABS(velocity.x), 0.15f);
        [UIView animateWithDuration:duration
                         animations:^{
                             swipeTableViewCell.contentView.frame = CGRectOffset(swipeTableViewCell.contentView.bounds, -80, 0);
                         }];
    }
     */
}

@end
