//
//  DTTableViewStyle4Controller.m
//  DTKitDemo
//
//  Created by DT on 14-11-26.
//  Copyright (c) 2014年 DT. All rights reserved.
//

#import "DTTableViewStyle4Controller.h"
#import "DTTableView.h"
#import "DTTableViewStyleCell1.h"
#import "DTTableViewStyleCell2.h"

#define IDENTIFIER_CELL1 @"cell1"
#define IDENTIFIER_CELL2 @"cell2"

// block self
#define WEAKSELF typeof(self) __weak weakSelf = self;

@interface DTTableViewStyle4Controller()

@property(nonatomic,strong)DTTableView *tableView;
@property(nonatomic,strong)NSMutableArray *itemArray;

@end

@implementation DTTableViewStyle4Controller

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    if ([[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.title = @"样式四";
    [self initTableView];
    [self addData];
}

-(void)addData
{
    self.itemArray = [[NSMutableArray alloc] init];
    for (int j = 0; j < 3; j++)
    {
        NSMutableArray *array = [NSMutableArray array];
        [array addObject:@"广州塔位于广州市中心，城市新中轴线与珠江景观轴交汇处， 与海心沙岛和广州市21世纪CBD区珠江新城隔江相望，是中国第一高塔，世界第三高塔。"];
        [array addObject:@"海心沙岛和广州市21世纪CBD区珠江新城隔江相望，是中国第一高塔，世界第三高塔。"],
        [array addObject:@"广州塔位于广州市中心，城市新中轴线与珠江景观轴交汇处."];
        [array addObject:@"广州塔位于广州市中心，与海心沙岛和广州市21世纪CBD区珠江新城隔江相望，是中国第一高塔，世界第三高塔。"];
        
        [self.itemArray addObject:array];
    }
    [self.tableView addFirstArray:self.itemArray];
}

-(void)initTableView
{
    self.tableView = [[DTTableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64) style:UITableViewStylePlain];
    self.tableView.rowHeight = 70;
    self.tableView.sectionType = UITableViewSection;
    self.tableView.separatorColor = [UIColor blackColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    //必写,不然程序会报错
    [self.tableView registerClass:[DTTableViewStyleCell1 class] forCellReuseIdentifier:IDENTIFIER_CELL1];
    [self.tableView registerClass:[DTTableViewStyleCell2 class] forCellReuseIdentifier:IDENTIFIER_CELL2];
    [self.view addSubview:self.tableView];
    
    NSDictionary *identifiers = [NSDictionary dictionaryWithObjectsAndKeys:
                                 [[NSArray alloc] initWithObjects:
                                  [NSIndexPath indexPathForRow:0 inSection:0],
                                  [NSIndexPath indexPathForRow:1 inSection:1],
                                  [NSIndexPath indexPathForRow:2 inSection:2],  nil], IDENTIFIER_CELL1,
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
    
    [self.tableView titleForHeaderWithBolock:^NSString *(NSInteger section) {
        return [NSString stringWithFormat:@"%li",(long)section];
    }];
    
}

@end
