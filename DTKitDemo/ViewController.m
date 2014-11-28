//
//  ViewController.m
//  DTKitDemo
//
//  Created by DT on 14-11-24.
//  Copyright (c) 2014年 DT. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSArray *itemsArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    if ([[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    self.itemsArray = [NSArray arrayWithObjects:
                       [NSArray arrayWithObjects:@"DTCycleScrollView",@"循环滚动ScrollView,支持自动滚动或手动滚动",@"DTCycleScrollViewController", nil],
                       [NSArray arrayWithObjects:@"DTGridTableView",@"九宫格视图TableView",@"DTGridTableViewController", nil],
                       [NSArray arrayWithObjects:@"DTTabBar",@"九宫格试图TableView",@"DTTabBarController", nil],
                       [NSArray arrayWithObjects:@"DTTableView",@"封装UITableView,增加多个属性,增加加载更多数据动画显示,抽取dataScoure代理",@"DTTableViewController",nil],
                       [NSArray arrayWithObjects:@"DTAlertView",@"封装UIAlertView,使用block替代delegate",@"DTAlertViewController",nil],
                       [NSArray arrayWithObjects:@"DTButton",@"自定义Button,支持点击切换默认和高亮图标",@"DTButtonController",nil],
                       [NSArray arrayWithObjects:@"DTClickImageView",@"封装UIImageView,支持block形式的点击事件,支持点击高亮显示",@"DTImageViewController",nil], nil];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.itemsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (! cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    NSArray *array = [self.itemsArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [array objectAtIndex:0];
    cell.detailTextLabel.text = [array objectAtIndex:1];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSArray *array = [self.itemsArray objectAtIndex:indexPath.row];
    
    id vc = [[NSClassFromString([array objectAtIndex:2]) alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
