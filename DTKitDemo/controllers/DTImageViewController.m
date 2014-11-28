//
//  DTImageViewController.m
//  DTKitDemo
//
//  Created by DT on 14-11-27.
//  Copyright (c) 2014年 DT. All rights reserved.
//

#import "DTImageViewController.h"
#import "DTClickImageView.h"

@implementation DTImageViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    if ([[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.title = @"DTImageViewController";
    [self createImageViews];
}

-(void)createImageViews
{
    DTClickImageView *imageView;
    imageView = [[DTClickImageView alloc] initWithFrame:CGRectMake(10, 10, 300, 160) block:^{
        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"" message:@"点击了图片1" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alterView show];
    }];
    imageView.image = [UIImage imageNamed:@"pengyouquan_detail_pic"];
    [self.view addSubview:imageView];
    
    
    imageView = [[DTClickImageView alloc] initWithFrame:CGRectMake(50, 200, 200, 100) block:^{
        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"" message:@"点击了图片2" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alterView show];
    }];
    imageView.image = [UIImage imageNamed:@"friendscircle_others_dialogbox_pic3"];
    imageView.clipsToBounds = YES;
    imageView.contentMode = UIViewContentModeScaleToFill;
    imageView.highlightLayer.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.2].CGColor;
    imageView.highlightLayer.masksToBounds = YES; //没这句话它圆不起来
    imageView.highlightLayer.cornerRadius = 28.0; //设置图片圆角的尺度
    
    [self.view addSubview:imageView];
}

@end
