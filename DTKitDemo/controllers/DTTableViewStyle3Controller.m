//
//  DTTableViewStyle3Controller.m
//  DTKitDemo
//
//  Created by DT on 14-11-26.
//  Copyright (c) 2014年 DT. All rights reserved.
//

#import "DTTableViewStyle3Controller.h"
#import "DTTableView.h"
#import "DTTableViewStyleCell2.h"

#define IDENTIFIER @"cell"

// block self
#define WEAKSELF typeof(self) __weak weakSelf = self;

@interface DTTableViewStyle3Controller()<UITableViewDelegate>

@property(nonatomic,strong)DTTableView *tableView;
@property(nonatomic,strong)NSMutableArray *itemArray;

@end

@implementation DTTableViewStyle3Controller

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    if ([[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.title = @"样式三";
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

/**
 *  @Author DT, 14-11-26 14:11:50
 *
 *  section类型暂不支持加载更多动画
 */
-(void)initTableView
{
    self.tableView = [[DTTableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height -64) style:UITableViewStylePlain];
    self.tableView.rowHeight = 70;
    self.tableView.sectionType = UITableViewSection;
    [self.tableView registerClass:[DTTableViewStyleCell2 class] forCellReuseIdentifier:@"cell"];
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    
    [self.tableView initWithCellIdentifier:@"cell" configureCellBlock:^(UITableViewCell *cell, NSString *identifier, NSIndexPath *indexPath, id data) {
        DTTableViewStyleCell2 *homeCell = (DTTableViewStyleCell2*)cell;
        [homeCell configureForData:data];
    }];
    
    [self.tableView titleForHeaderWithBolock:^NSString *(NSInteger section) {
        return [NSString stringWithFormat:@"Header:%i",section];
    }];
    
    [self.tableView titleForFooterWithBolock:^NSString *(NSInteger section) {
        return [NSString stringWithFormat:@"Footer:%i",section];
    }];
}

#pragma mark UITableViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.tableView removeSectionStickiness:scrollView];
}

@end