//
//  DTTableViewStyle2Controller.m
//  DTKitDemo
//
//  Created by DT on 14-11-26.
//  Copyright (c) 2014年 DT. All rights reserved.
//

#import "DTTableViewStyle2Controller.h"
#import "DTTableView.h"
#import "DTTableViewStyleCell1.h"
#import "DTTableViewStyleCell2.h"

#define IDENTIFIER_CELL1 @"cell1"
#define IDENTIFIER_CELL2 @"cell2"

// block self
#define WEAKSELF typeof(self) __weak weakSelf = self;

@interface DTTableViewStyle2Controller()

@property(nonatomic,strong)DTTableView *tableView;

@end

@implementation DTTableViewStyle2Controller

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    if ([[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.title = @"样式二";
    [self initTableView];
    [self addData];
}

-(void)addData
{
    NSMutableArray *itemArray = [[NSMutableArray alloc] init];
    [itemArray addObject:@"广州塔位于广州市中心，城市新中轴线与珠江景观轴交汇处."];
    [itemArray addObject:@"海心沙岛和广州市21世纪CBD区珠江新城隔江相望，是中国第一高塔，世界第三高塔。"];
    [itemArray addObject:@"广州塔又称广州新电视塔，昵称小蛮腰"],
    [itemArray addObject:@"广州塔塔身主体450米（塔顶观光平台最高处454米），天线桅杆150米，总高度600米."];
    [itemArray addObject:@"广州塔有5个功能区和多种游乐设施"];
    [itemArray addObject:@"包括488m的世界最高的世界户外观景平台、高空横向摩天轮，极速云霄极限游乐项目，"];
    [itemArray addObject:@"有2个观光大厅，有悬空走廊，天梯，4D和3D动感影院，中西美食，会展设施，购物商场及科普展示厅"];
    [itemArray addObject:@"2005年11月25日，广州塔正式动工兴建。"];
    [self.tableView addMoreArray:itemArray];
}

-(void)initTableView
{
    self.tableView = [[DTTableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64) style:UITableViewStylePlain];
    self.tableView.rowHeight = 70;
    self.tableView.separatorColor = [UIColor blackColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    //必写,不然程序会报错
    [self.tableView registerClass:[DTTableViewStyleCell1 class] forCellReuseIdentifier:IDENTIFIER_CELL1];
    [self.tableView registerClass:[DTTableViewStyleCell2 class] forCellReuseIdentifier:IDENTIFIER_CELL2];
    [self.view addSubview:self.tableView];
    
    NSDictionary *identifiers = [NSDictionary dictionaryWithObjectsAndKeys:
                                 [[NSArray alloc] initWithObjects:
                                  [NSIndexPath indexPathForRow:0 inSection:0],
                                  [NSIndexPath indexPathForRow:3 inSection:0],
                                  [NSIndexPath indexPathForRow:7 inSection:0],  nil], IDENTIFIER_CELL1,
                                 [NSNull null], IDENTIFIER_CELL2, nil];

    [self.tableView initWithCellIdentifiers:identifiers configureCellBlock:^(UITableViewCell *cell, NSString *identifier, NSIndexPath *indexPath, id data) {
        if ([identifier isEqualToString:IDENTIFIER_CELL1]) {
            DTTableViewStyleCell1 *cell1 = (DTTableViewStyleCell1*)cell;
            [cell1 configureForData:data];
        }else if ([identifier isEqualToString:IDENTIFIER_CELL2]){
            DTTableViewStyleCell2 *cell1 = (DTTableViewStyleCell2*)cell;
            [cell1 configureForData:data];
        }
    }];
    
    WEAKSELF
    [self.tableView addFooterWithCallback:^{
        [weakSelf addData];
        [weakSelf.tableView footerEndRefreshing];
    }];
}

@end
