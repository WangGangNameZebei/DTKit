//
//  DTImageTopButton.m
//  DTKitDemo
//
//  Created by DT on 14-11-25.
//  Copyright (c) 2014年 DT. All rights reserved.
//

#import "DTImageTopButton.h"

@implementation DTImageTopButton

-(void) layoutSubviews
{
    [super layoutSubviews];
    UILabel *label = [self titleLabel];
    label.textAlignment = NSTextAlignmentCenter;
    CGRect labelFrame = label.frame;
    labelFrame.origin.x = self.bounds.origin.x;
    labelFrame.origin.y = self.bounds.size.height - 20;
    labelFrame.size.width = self.bounds.size.width;
    labelFrame.size.height = 20;
    label.frame = labelFrame;
}


@end
