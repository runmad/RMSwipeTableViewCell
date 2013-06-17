//
//  RMSwipeTableViewCelliOS7UIDemoTableViewCell.h
//  RMSwipeTableViewCelliOS7UIDemo
//
//  Created by Rune Madsen on 2013-06-16.
//  Copyright (c) 2013 The App Boutique. All rights reserved.
//

#import "RMSwipeTableViewCell.h"

@protocol RMSwipeTableViewCelliOS7UIDemoTableViewCellDelegate;

@interface RMSwipeTableViewCelliOS7UIDemoTableViewCell : RMSwipeTableViewCell

typedef void (^deleteBlock)(RMSwipeTableViewCelliOS7UIDemoTableViewCell *swipeTableViewCell);

@property (nonatomic, strong) UIButton *deleteButton;
@property (nonatomic, strong) deleteBlock deleteBlockHandler;
@property (nonatomic, assign) id <RMSwipeTableViewCelliOS7UIDemoTableViewCellDelegate> demoDelegate;

-(void)resetContentView;

@end

@protocol RMSwipeTableViewCelliOS7UIDemoTableViewCellDelegate <NSObject>
@optional
-(void)swipeTableViewCellDidDelete:(RMSwipeTableViewCelliOS7UIDemoTableViewCell*)swipeTableViewCell;
@end
