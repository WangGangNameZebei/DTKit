//
//  DTGridTableCellView.m
//  DTKitDemo
//
//  Created by DT on 14-11-25.
//  Copyright (c) 2014年 DT. All rights reserved.
//

#import "DTGridTableCellView.h"

@implementation DTGridTableCellView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.label = [[UILabel alloc] initWithFrame:self.bounds];
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.font =[UIFont systemFontOfSize:30.f];
        [self addSubview:self.label];
    }
    return self;
}

@end
