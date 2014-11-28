//
//  DTButtonController.m
//  DTKitDemo
//
//  Created by DT on 14-11-25.
//  Copyright (c) 2014年 DT. All rights reserved.
//

#import "DTButtonController.h"
#import "DTButton.h"
#import "DTImageTopButton.h"

@implementation DTButtonController

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    if ([[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.title = @"DTButtonController";
    [self createButtons];
}

-(void)createButtons
{
    UILabel *label;
    label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.view.frame.size.width, 20)];
    label.font = [UIFont systemFontOfSize:14.0f];
    label.text = @"点击按钮可以在两张图片之间进行切换";
    [self.view addSubview:label];
    
    DTButton *button1 = [[DTButton alloc] initWithFrame:CGRectMake(10, 30, 25, 25)];
    button1.normalImage = [UIImage imageNamed:@"proserver_loan_check_btn"];
    button1.pressImage = [UIImage imageNamed:@"proserver_loan_check_act_btn"];
    button1.isSelect = NO;
    [button1 addTarget:self action:@selector(imageSwitch:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(10, 65, self.view.frame.size.width, 20)];
    label.font = [UIFont systemFontOfSize:14.0f];
    label.text = @"图片和文字的二种位置状态";
    [self.view addSubview:label];
    
    UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake(10, 95, 70, 25)];
    button2.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    button2.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button2 setTitle:@"默认" forState:UIControlStateNormal];
    [button2 setImage:[UIImage imageNamed:@"proserver_loan_check_btn"] forState:UIControlStateNormal];
    [button2 setImage:[UIImage imageNamed:@"proserver_loan_check_act_btn"] forState:UIControlStateHighlighted];
    [self.view addSubview:button2];
    
    DTImageTopButton *button3 = [[DTImageTopButton alloc] initWithFrame:CGRectMake(90, 95, 50, 55)];
    button3.backgroundColor = [UIColor clearColor];
    [button3 setImageEdgeInsets:UIEdgeInsetsMake(3, 12, 20, 3)];
    button3.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [button3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button3 setTitle:@"文字下" forState:UIControlStateNormal];
    [button3 setImage:[UIImage imageNamed:@"proserver_loan_check_btn"] forState:UIControlStateNormal];
    [button3 setImage:[UIImage imageNamed:@"proserver_loan_check_act_btn"] forState:UIControlStateHighlighted];
    [self.view addSubview:button3];
}

-(void)imageSwitch:(DTButton*)button
{
    button.isSelect = !button.isSelect;
}

@end
