//
//  ViewController.m
//  DTKitDemo
//
//  Created by DT on 14-11-24.
//  Copyright (c) 2014年 DT. All rights reserved.
//

#import "ViewController.h"
#import "DTSystemCommon.h"
#import "DTAddressBookTool.h"
#import "DTAddressBookModel.h"
#import "DTPrivateTool.h"
#import "DTNetworkRequestUtil.h"
#import "DTNetworkCache.h"

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
                       [NSArray arrayWithObjects:@"DTTabBar",@"实现DTTabBar效果",@"DTTabBarController", nil],
                       [NSArray arrayWithObjects:@"DTTableView",@"封装UITableView,增加多个属性,增加加载更多数据动画显示,抽取dataScoure代理",@"DTTableViewController",nil],
                       [NSArray arrayWithObjects:@"DTAlbumTool",@"DTAlbumTool是一个相册工具类,提供获取相薄、图片、保存等多种方法",@"DTAlbumToolController",nil],
                       [NSArray arrayWithObjects:@"DTAddressBookTool",@"DTAddressBookTool是一个通讯录工具类,提供获取通讯录信息、创建修改删除通讯录等多种方法",@"DTAddressBookToolController",nil],
                       [NSArray arrayWithObjects:@"DTPrivateTool",@"DTPrivateTool是一个私有方法工具类,使用的话是上架不了APP Store",@"DTPrivateToolController",nil],
                       [NSArray arrayWithObjects:@"DTAlertView",@"封装UIAlertView,使用block替代delegate",@"DTAlertViewController",nil],
                       [NSArray arrayWithObjects:@"DTButton",@"自定义Button,支持点击切换默认和高亮图标",@"DTButtonController",nil],
                       [NSArray arrayWithObjects:@"DTLabel",@"封装UILabel,支持点击事件,支持高亮颜色,支持下划线,支持删除线",@"DTLabelController",nil],
                       [NSArray arrayWithObjects:@"DTClickImageView",@"封装UIImageView,支持block形式的点击事件,支持点击高亮显示",@"DTImageViewController",nil],
                       [NSArray arrayWithObjects:@"DTUserDefaults",@"封装NSUserDefaults,写法更加快速简便",@"DTUserDefaultsController",nil],
                       [NSArray arrayWithObjects:@"DTNetworkRequestUtil",@"封装AFNetwrking网络框架,写法更加快速简便,增加把本地缓存功能",@"DTNetworkRequestUtilController",nil],nil];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [[DTNetworkCache shareInstance] createSharedCache];
    NSDictionary *dictionary = @{@"isApp":@"1",@"number":@"2",@"uid":@"0"};
    [DTNetworkRequestUtil shareInstance].cachePolicy = CachePolicyCacheElseWeb;
    [[DTNetworkRequestUtil shareInstance] requestWithPath:@"http://www.drinknlink.com/dailyRecommend/getRecommendForApp" parameters:dictionary success:^(DTNetworkResultResponse *response) {
        
    } failure:^(DTNetworkResultResponse *response) {
        
    }];
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
