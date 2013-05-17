//
//  TFXMenuBarSliderView.m
//  Triggerfox
//
//  Created by Rune Madsen on 2012-12-27.
//  Copyright (c) 2012 Triggerfox Corporation. All rights reserved.
//

#import "TFXMenuBarSliderView.h"
#import <QuartzCore/QuartzCore.h>

@implementation TFXMenuBarSliderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
//		self.layer.borderColor = [UIColor blueColor].CGColor;
//		self.layer.borderWidth = 1;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
	[[UIImage imageNamed:@"sliderHandle"] drawInRect:CGRectMake(rect.origin.x, (rect.size.height / 2) - 3, rect.size.width, 12)];
}


@end
