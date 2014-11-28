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
    [self createLabels];
}

-(void)createLabels
{
    DTLabel *lable;
    lable = [[DTLabel alloc] initWithFrame:CGRectMake(5, 5, 300, 20) block:^{
        [[[UIAlertView alloc] initWithTitle:@"" message:@"点击了文本" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
    }];
    lable.backgroundColor = [UIColor blackColor];
    lable.textColor = [UIColor whiteColor];
    lable.highlightedTextColor = [UIColor redColor];
    lable.text = @"DTLabelController";
    [self.view addSubview:lable];
    
    lable = [[DTLabel alloc] initWithFrame:CGRectMake(5, 40, 300, 20) block:^{
        [[[UIAlertView alloc] initWithTitle:@"" message:@"点击了文本" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
    }];
    lable.backgroundColor = [UIColor blackColor];
    lable.textColor = [UIColor whiteColor];
    lable.highlightedTextColor = [UIColor redColor];
    lable.strikeThroughEnabled = YES;
    lable.strikeThroughColor = [UIColor greenColor];
    lable.text = @"DTLabelController";
    [self.view addSubview:lable];
    
    lable = [[DTLabel alloc] initWithFrame:CGRectMake(5, 70, 300, 20) block:^{
        [[[UIAlertView alloc] initWithTitle:@"" message:@"点击了文本" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
    }];
    lable.backgroundColor = [UIColor blackColor];
    lable.textAlignment = NSTextAlignmentCenter;
    lable.textColor = [UIColor whiteColor];
    lable.highlightedTextColor = [UIColor redColor];
    lable.strikeThroughEnabled = YES;
    lable.strikeThroughHighlightedEnabled = YES;
    lable.strikeThroughColor = [UIColor blueColor];
    lable.strikeThroughHeight = 2;
    lable.text = @"DTLabelController";
    [self.view addSubview:lable];
    
    lable = [[DTLabel alloc] initWithFrame:CGRectMake(5, 100, 300, 20) block:^{
        [[[UIAlertView alloc] initWithTitle:@"" message:@"点击了文本" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
    }];
    lable.backgroundColor = [UIColor blackColor];
    lable.textAlignment = NSTextAlignmentRight;
    lable.textColor = [UIColor whiteColor];
    lable.highlightedTextColor = [UIColor redColor];
    lable.strikeThroughEnabled = YES;
    lable.strikeThroughColor = [UIColor blueColor];
    lable.strikeThroughHeight = 2;
    lable.text = @"DTLabelController";
    [self.view addSubview:lable];
    
    lable = [[DTLabel alloc] initWithFrame:CGRectMake(5, 130, 300, 30) block:^{
        [[[UIAlertView alloc] initWithTitle:@"" message:@"点击了文本" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
    }];
    lable.backgroundColor = [UIColor blackColor];
    lable.textAlignment = NSTextAlignmentCenter;
    lable.textColor = [UIColor whiteColor];
    lable.highlightedTextColor = [UIColor redColor];
    lable.underLineEnabled = YES;
    lable.underLineColor = [UIColor orangeColor];
    lable.underLineHeight = 5;
    lable.text = @"DTLabelController";
    [self.view addSubview:lable];
    
    
    lable = [[DTLabel alloc] initWithFrame:CGRectMake(5, 170, 300, 30) block:^{
        [[[UIAlertView alloc] initWithTitle:@"" message:@"点击了文本" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
    }];
    lable.backgroundColor = [UIColor blackColor];
    lable.textAlignment = NSTextAlignmentCenter;
    lable.textColor = [UIColor whiteColor];
    lable.highlightedTextColor = [UIColor redColor];
    lable.underLineEnabled = YES;
    lable.underLineHighlightedEnabled = YES;
    lable.underLineColor = [UIColor purpleColor];
    lable.underLineHeight = 5;
    lable.text = @"DTLabelController";
    [self.view addSubview:lable];
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"Using NSAttributed String"];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(0,5)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(6,12)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:NSMakeRange(19,6)];
    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Arial-BoldItalicMT" size:10.0] range:NSMakeRange(0, 5)];
    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Bold" size:15.0] range:NSMakeRange(6, 12)];
    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Courier-BoldOblique" size:12.0] range:NSMakeRange(19, 6)];
    lable = [[DTLabel alloc] initWithFrame:CGRectMake(5, 210, 300, 30) block:^{
        
    }];
    lable.backgroundColor = [UIColor blackColor];
    lable.textAlignment = NSTextAlignmentCenter;
    lable.textColor = [UIColor whiteColor];
    lable.attributedText = str;
    [self.view addSubview:lable];
}

@end
