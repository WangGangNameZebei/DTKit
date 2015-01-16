//
//  DTTabBarController.m
//  DTKitDemo
//
//  Created by DT on 14-11-25.
//  Copyright (c) 2014年 DT. All rights reserved.
//

#import "DTTabBarController.h"
#import "DTTabBar.h"

@interface DTTabBarController()<DTTabBarDelegate>
@property(nonatomic,strong)DTTabBar *tabbar;
@property(nonatomic,strong)NSArray *itemsArray;
@property(nonatomic,strong)NSMutableArray *controllersArray;
@property(nonatomic,strong)UIViewController *currentViewController;
@end

@implementation DTTabBarController

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    if ([[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.title = @"DTTabBarController";
    
    [self initTabBar];
}

-(void)initTabBar
{
    self.itemsArray = [NSArray arrayWithObjects:
                       [DTTabBarItem itemWithNormalImageName:@"tab_home1" highlightImageName:@"tab_home2"],
                       [DTTabBarItem itemWithNormalImageName:@"tab_life1" highlightImageName:@"tab_life2"],
                       [DTTabBarItem itemWithNormalImageName:@"tab_property1" highlightImageName:@"tab_property2"],
                       [DTTabBarItem itemWithNormalImageName:@"tab_more1" highlightImageName:@"tab_more2"],nil];
    
    self.tabbar = [[DTTabBar alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 64 -49, self.view.frame.size.width, 49) array:self.itemsArray];
    self.tabbar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tab_bottom_bar_bg"]];
    self.tabbar.delegate = self;
    [self.view addSubview:self.tabbar];
    
    self.controllersArray = [[NSMutableArray alloc] init];
    [self.controllersArray addObject:[[NSClassFromString(@"DTCycleScrollViewController") alloc] init]];
    [self.controllersArray addObject:[[NSClassFromString(@"DTGridTableViewController") alloc] init]];
    [self.controllersArray addObject:[[NSClassFromString(@"DTButtonController") alloc] init]];
    [self.controllersArray addObject:[[NSClassFromString(@"DTTableViewController") alloc] init]];
    for (UIViewController *vc in self.controllersArray) {
        [self addChildViewController:vc];
    }
    UIViewController *firstVC = [self.controllersArray objectAtIndex:0];
    [self.view addSubview:firstVC.view];
    self.currentViewController = firstVC;
    [self.view bringSubviewToFront:self.tabbar];
}

#pragma mark DTTabBarDelegate
-(void)callButtonAction:(NSInteger)index
{
    if (self.tabbar.currentTab==index) {
        return;
    }
    UIViewController *viewController = [self.controllersArray objectAtIndex:index];
    [self transitionFromViewController:self.currentViewController toViewController:viewController duration:0 options:0 animations:^{
    }  completion:^(BOOL finished) {
        [self.view bringSubviewToFront:self.tabbar];
        self.currentViewController=viewController;
    }];
}
@end
