//
//  DTLabelController.m
//  DTKitDemo
//
//  Created by DT on 14-11-28.
//  Copyright (c) 2014年 DT. All rights reserved.
//

#import "DTLabelController.h"
#import "DTLabel.h"

@implementation DTLabelController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    if ([[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.title = @"DTLabelController";
}

-(void)createLabels
{
    
}

@end
