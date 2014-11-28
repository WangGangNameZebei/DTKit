//
//  DTTableViewStyle1Controller.m
//  DTKitDemo
//
//  Created by DT on 14-11-26.
//  Copyright (c) 2014年 DT. All rights reserved.
//

#import "DTTableViewStyle1Controller.h"
#import "DTTableView.h"
#import "DTTableViewControllerCell.h"

#define IDENTIFIER @"cell"

// block self
#define WEAKSELF typeof(self) __weak weakSelf = self;

@interface DTTableViewStyle1Controller()

@property(nonatomic,strong)DTTableView *tableView;

@end

@implementation DTTableViewStyle1Controller

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    if ([[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.title = @"样式一";
    [self initTableView];
    [self addData];
}

-(UIColor *)randomColor
{
    CGFloat hue = ( arc4random() % 256 / 256.0 ); //0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5; // 0.5 to 1.0,away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5; //0.5 to 1.0,away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

-(void)addData
{
     NSMutableArray *itemsArray = [[NSMutableArray alloc] init];
     int count = self.tableView.tableArray.count + itemsArray.count;
     for (int i=0; i<15; i++) {
         if (count >=50) {
             [self.tableView addMoreArray:itemsArray];
             return;
     }
     [itemsArray addObject:[self randomColor]];
     count = self.tableView.tableArray.count + itemsArray.count;
     }
     if (self.tableView.tableArray.count ==0) {
         [self.tableView addFirstArray:itemsArray];
     }else{
         [self.tableView addMoreArray:itemsArray];
     }
}

-(void)initTableView
{
    self.tableView = [[DTTableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64) style:UITableViewStylePlain];
    self.tableView.rowHeight = 70;
    self.tableView.separatorColor = [UIColor clearColor];
    //必写,不然程序会报错
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:IDENTIFIER];
    [self.view addSubview:self.tableView];
    
    [self.tableView initWithCellIdentifier:IDENTIFIER configureCellBlock:^(UITableViewCell *cell, NSString *identifier, NSIndexPath *indexPath, id data) {
        cell.backgroundColor = data;
        cell.textLabel.text = [NSString stringWithFormat:@"%i",indexPath.row];
    }];
    
    WEAKSELF
    [self.tableView addFooterWithCallback:^{
        [weakSelf addData];
        [weakSelf.tableView footerEndRefreshing];
    }];
}


@end
