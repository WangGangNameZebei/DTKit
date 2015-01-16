//
//  DTAlertViewController.m
//  DTKitDemo
//
//  Created by DT on 14-11-27.
//  Copyright (c) 2014年 DT. All rights reserved.
//

#import "DTAlertViewController.h"
#import "DTAlertView.h"

@implementation DTAlertViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    if ([[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.title = @"DTAlertViewController";
    [self createButtons];
}

-(void)createButtons
{
    UIButton *button;
    button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(0, 30, self.view.frame.size.width, 30);
    [button setTitle:@"支持一个按钮的AlertView" forState:UIControlStateNormal];
    button.tag = 1;
    [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(0, 80, self.view.frame.size.width, 30);
    [button setTitle:@"支持二个按钮的AlertView" forState:UIControlStateNormal];
    button.tag = 2;
    [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(0, 130, self.view.frame.size.width, 30);
    [button setTitle:@"支持多个按钮的AlertView" forState:UIControlStateNormal];
    button.tag = 3;
    [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

-(void)clickButton:(UIButton*)button
{
    if (button.tag == 1) {
        DTAlertView *alterView = [[DTAlertView alloc] initWithTitle:@"标题" message:@"我是一个按钮的AlertView" cancelButtonTitle:@"确定" otherButtonTitles:nil,nil];
        [alterView handlerClickedButton:^(DTAlertView *alertView, NSInteger buttonIndex) {
            NSLog(@"%li",(long)buttonIndex);
        }];
    }else if (button.tag ==2){
        DTAlertView *alterView = [[DTAlertView alloc] initWithTitle:@"标题" message:@"我是二个按钮的AlertView" cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
        [alterView handlerClickedButton:^(DTAlertView *alertView, NSInteger buttonIndex) {
            NSLog(@"%li",(long)buttonIndex);
        }];
    
    }else if (button.tag ==3){
        DTAlertView *alterView = [[DTAlertView alloc] initWithTitle:@"标题" message:@"我是二个按钮的AlertView" cancelButtonTitle:@"按钮1" otherButtonTitles:@"按钮2",@"按钮3",@"取消",nil];
        [alterView handlerClickedButton:^(DTAlertView *alertView, NSInteger buttonIndex) {
            NSLog(@"%li",(long)buttonIndex);
        }];
    
    }
}

@end
