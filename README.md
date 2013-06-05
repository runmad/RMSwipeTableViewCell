#RMSwipeTableViewCell

`RMSwipeTableViewCell` is a drop-in `UITableViewCell` subclass that supports pan gestures as seen in apps such as Clear, Mailbox, Sparrow and many more.

`RMSwipeTableViewCell` allows for easy subclassing to customize the cell to match your needs. The class exposes useful class methods and uses delegate callbacks to handle actions in your `UITableViewController`. `RMSwipeTableViewCell` is compatible with iOS 5 and higher!

`RMSwipeTableViewCell` works great out of the box, but has many properties to customize how the user interacts with the cell.

![RMSwipeTableViewCellDemo Screenshot](http://www.runmad.com/development/RMSwipeTableViewCellDemoScreenshot.png)

[Video example]

##Installing `RMSwipeTableViewCell`

The example below and demo assumes you're compiling for iOS 6+. If you're supporting an older version of iOS use the appropriate methods for initializing and dequeuing the cells. `RMSwipeTableViewCell` is 100% compatible with iOS 5 and above.

###Using CocoaPods

Add the following to your Podfile.

```ruby
pod 'RMSwipeTableViewCell'
```

###Manually

Clone the repository to your machine or add `RMSwipeTableViewCell` as a submodule to your project.

Add `RMSwipeTableViewCell.h` and `RMSwipeTableViewCell.m` to your project. Import the class header and register the cell class in your `UITableView`.

```Objective-C
#import "RMSwipeTableViewCell.h"
// add <RMSwipeTableViewCellDelegate> in your header file if you want to receive delegate callbacks on cell interactions

-(void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[RMSwipeTableViewCell class] forCellReuseIdentifier:CellIdentifier];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    RMSwipeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.delegate = self; // optional
    return cell;
}
```

##Using `RMSwipeTableViewCell`

`RMSwipeTableViewCell` can be used as-is, but you are required to customize the `backView` with subviews, etc. to suit your needs (see Subclassing `RMSwipeTableViewCell`).

The `RMSwipeTableViewCellDemo` project provides an example of subclassing and customizing the cell with custom views and actions.

###Properties

`RMSwipeTableViewCell` lets you customize and control animations and panning gestures. The demo uses all default states.

```Objective-C
UIView *backView;
RMSwipeTableViewCellRevealDirection revealDirection; // default is RMSwipeTableViewCellRevealDirectionBoth
RMSwipeTableViewCellAnimationType animationType; // default is RMSwipeTableViewCellAnimationTypeBounce
float animationDuration; // default is 0.2
BOOL revealsBackground; // default is NO
BOOL shouldAnimateCellReset; // this can be overridden at any point (useful in the swipeTableViewCellWillResetState:fromLocation: delegate method). default is YES - note: it will reset to YES in prepareForReuse
BOOL panElasticity; // When panning/swiping the cell's location is set to exponentially decay. The rubber banding matches that of a UIScrollView/UITableView. default is YES
UIColor *backViewbackgroundColor; // default is [UIColor colorWithWhite:0.92 alpha:1]
```

##Subclassing `RMSwipeTableViewCell`

Subclassing `RMSwipeTableViewCell` is the best way to customize the cell beyond the default properties and any delegate callbacks. Subclassing allows you to create subviews for the `backView`, extend properties if needed and override class methods.

See the demo for an example of subclassing usage.

##`RMSwipeTableViewCell` Delegate Methods

`RMSwipeTableViewCell` has a number of (optional) delegate methods that provide an extensive. The delegate methods are fairly verbose and the demo project shows a few examples of usage.

```Objective-C
// notifies the delegate when the user starts panning
-(void)swipeTableViewCellDidStartSwiping:(RMSwipeTableViewCell*)swipeTableViewCell;

// notifies the delegate when the panning location changes
-(void)swipeTableViewCell:(RMSwipeTableViewCell*)swipeTableViewCell swipedToLocation:(CGPoint)translation velocity:(CGPoint)velocity;

// notifies the delegate when the user lifts their finger from the screen and cell will reset
-(void)swipeTableViewCellWillResetState:(RMSwipeTableViewCell*)swipeTableViewCell fromLocation:(CGPoint)translation animation:(RMSwipeTableViewCellAnimationType)animation velocity:(CGPoint)velocity;

// notifies the delegate when the cell has reset itself back to its starting state. This is useful for doing further animation or updates on the cell after the reset animation has completed
-(void)swipeTableViewCellDidResetState:(RMSwipeTableViewCell*)swipeTableViewCell fromLocation:(CGPoint)translation animation:(RMSwipeTableViewCellAnimationType)animation velocity:(CGPoint)velocity;
```

##Credit

Developed by Rune Madsen ([@runmad] and [runmad.com]).

##Feedback

I appreciate feedback. Create Github issues, pull requests or connect with me on Twitter.

I'd love to see and hear from you if you use it in a project.

##License

`RMSwipeTableViewCell` is available under the MIT license. See the LICENSE file for more info.

[Video example]: http://www.runmad.com/development/RMTableViewSwipeDemoVideo.mp4
[@runmad]: http://www.twitter.com/runmad
[runmad.com]: http://www.runmad.com
