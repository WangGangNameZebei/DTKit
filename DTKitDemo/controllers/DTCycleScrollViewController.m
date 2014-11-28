//
//  DTCycleScrollViewController.m
//  DTKitDemo
//
//  Created by DT on 14-11-25.
//  Copyright (c) 2014年 DT. All rights reserved.
//

#import "DTCycleScrollViewController.h"
#import "DTCycleScrollView.h"

@interface DTCycleScrollViewController()<DTCycleScrollViewDatasource,DTCycleScrollViewDelegate>

@property(nonatomic,strong)DTCycleScrollView *cycleScrollView;
@property(nonatomic,strong)NSArray *itemsArray;

@end

@implementation DTCycleScrollViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    if ([[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.title = @"DTCycleScrollViewController";
    
    self.itemsArray = [NSArray arrayWithObjects:
                       [NSArray arrayWithObjects:[UIColor yellowColor],@"黄色", nil],
                       [NSArray arrayWithObjects:[UIColor blueColor],@"蓝色", nil],
                       [NSArray arrayWithObjects:[UIColor redColor],@"红色", nil],nil];
    
    [self initCycleScrollView];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    self.cycleScrollView.animationDuration = 0;
}

-(void)initCycleScrollView
{
    self.cycleScrollView = [[DTCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), self.view.frame.size.height -64)];
    self.cycleScrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.cycleScrollView.datasource = self;
    self.cycleScrollView.delegate = self;
    self.cycleScrollView.animationDuration = 2.0f;
    [self.view addSubview:self.cycleScrollView];
}

#pragma mark DTCycleScrollViewDatasource
- (NSInteger)numberOfPages
{
    return self.itemsArray.count;
}

- (UIView *)pageAtIndex:(NSInteger)index size:(CGSize)size
{
    NSArray *array = [self.itemsArray objectAtIndex:index];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, (size.height-30)/2, size.width, 30)];
    label.font = [UIFont systemFontOfSize:20.f];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = [array objectAtIndex:1];
    view.backgroundColor = [array objectAtIndex:0];
    [view addSubview:label];
    
    return view;
}

@end
