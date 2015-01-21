//
//  DTNetworkRequestUtilController.m
//  DTKitDemo
//
//  Created by DT on 15-1-21.
//  Copyright (c) 2015年 DT. All rights reserved.
//

#import "DTNetworkRequestUtilController.h"
#import "DTTableView.h"
#import "DTNetworkCache.h"
#import "DTNetworkRequestUtil.h"

@interface DTNetworkRequestUtilController ()<UITableViewDelegate>

@property(nonatomic,strong)DTTableView *tableView;

@end

@implementation DTNetworkRequestUtilController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    if ([[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.title = @"DTNetworkRequestUtilController";
    
    [self initTableView];
    
    NSMutableArray *tableArray = [[NSMutableArray alloc] initWithObjects:@"开启缓存",@"缓存类型 - CachePolicyNormal ",@"缓存类型 - CachePolicyOnlyCache",@"缓存类型 - CachePolicyCacheElseWeb",@"缓存类型 - CachePolicyCacheAndRefresh",@"缓存类型 - CachePolicyCacheAndWeb",@"第一次加载数据",@"加载更多数据",@"清除缓存",nil];
    [self.tableView addFirstArray:tableArray];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)initTableView
{
    self.tableView = [[DTTableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64) style:UITableViewStylePlain];
    //必写,不然程序会报错
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    
    [self.tableView initWithCellIdentifier:@"cell" configureCellBlock:^(UITableViewCell *cell, NSString *identifier, NSIndexPath *indexPath, id data) {
        cell.textLabel.font = [UIFont systemFontOfSize:15.0f];
        cell.textLabel.text = data;
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:{
            [[DTNetworkCache shareInstance] createSharedCache];
            break;
        }case 1:{
            [DTNetworkRequestUtil shareInstance].cachePolicy = CachePolicyNormal;
            break;
        }case 2:{
            [DTNetworkRequestUtil shareInstance].cachePolicy = CachePolicyOnlyCache;
            break;
        }case 3:{
            [DTNetworkRequestUtil shareInstance].cachePolicy = CachePolicyCacheElseWeb;
            break;
        }case 4:{
            [DTNetworkRequestUtil shareInstance].cachePolicy = CachePolicyCacheAndRefresh;
            break;
        }case 5:{
            [DTNetworkRequestUtil shareInstance].cachePolicy = CachePolicyCacheAndWeb;
            break;
        }case 6:{
            NSDictionary *parameters = @{@"dyId":@"123467",@"isHot":@"0",@"platform":@"ios",@"startPage":@"0",@"totalEachPage":@"2"};
            [[DTNetworkRequestUtil shareInstance] requestWithPath:@"http://192.168.16.194:9088/anjubaoGame/game_center/game_list" parameters:parameters method:GET success:^(DTNetworkResultResponse *response) {
                NSLog(@"%@",response.dictionary);
            } failure:^(DTNetworkResultResponse *response) {
                NSLog(@"response...");
            }];
            break;
        }case 7:{
            NSDictionary *parameters = @{@"dyId":@"123467",@"isHot":@"0",@"platform":@"ios",@"startPage":@"1",@"totalEachPage":@"2"};
            [[DTNetworkRequestUtil shareInstance] requestWithPath:@"http://192.168.16.194:9088/anjubaoGame/game_center/game_list" parameters:parameters method:GET success:^(DTNetworkResultResponse *response) {
                NSLog(@"%@",response.dictionary);
            } failure:^(DTNetworkResultResponse *response) {
                NSLog(@"response...");
            }];
            break;
        }case 8:{
            [[DTNetworkCache shareInstance] deleteSharedCache];
            break;
        }
        default:
            break;
    }
    
}

@end
