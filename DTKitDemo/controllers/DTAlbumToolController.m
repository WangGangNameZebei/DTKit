//
//  DTAlbumToolController.m
//  DTKitDemo
//
//  Created by DT on 14-12-3.
//  Copyright (c) 2014年 DT. All rights reserved.
//

#import "DTAlbumToolController.h"
#import "DTTableView.h"
#import "DTAlbumTool.h"
#import "DTAlbumDetailsController.h"

@interface DTAlbumToolController()<UITableViewDelegate>

@property(nonatomic,strong)DTTableView *tableView;

@end

@implementation DTAlbumToolController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    if ([[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"DTAlbumToolController";
    
    [self initTableView];
    [self createData];
}

-(void)initTableView
{
    self.tableView = [[DTTableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64) style:UITableViewStylePlain];
//    self.tableView.rowHeight = 90;
    //必写,不然程序会报错
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    
    [self.tableView initWithCellIdentifier:@"cell" configureCellBlock:^(UITableViewCell *cell, NSString *identifier, NSIndexPath *indexPath, id data) {
        cell.textLabel.font = [UIFont systemFontOfSize:15.0f];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = [data objectAtIndex:0];
    }];
}

- (void)createData
{
    NSMutableArray *tableArray = [NSMutableArray arrayWithObjects:
                                  [NSArray arrayWithObjects:@"获取系统相薄信息",@"1", nil],
                                  [NSArray arrayWithObjects:@"获取全部相薄信息",@"2", nil],
                                  [NSArray arrayWithObjects:@"获取系统相薄第一张图片信息",@"3", nil],
                                  [NSArray arrayWithObjects:@"获取系统相薄最新一张图片信息",@"4", nil],
                                  [NSArray arrayWithObjects:@"获取系统相薄图片信息",@"5", nil],
                                  [NSArray arrayWithObjects:@"获取系统相薄视频信息",@"6", nil],
                                  [NSArray arrayWithObjects:@"获取系统相薄全部信息",@"7", nil],
                                  [NSArray arrayWithObjects:@"获取全部相薄图片信息",@"8", nil],
                                  [NSArray arrayWithObjects:@"获取全部相薄视频信息",@"9", nil],
                                  [NSArray arrayWithObjects:@"获取全部相薄全部信息",@"10", nil],
                                  [NSArray arrayWithObjects:@"创建一个test相册",@"11", nil],
                                  [NSArray arrayWithObjects:@"保存一张图片到系统相薄里面",@"12", nil],
                                  [NSArray arrayWithObjects:@"保存一张图片到test相薄里面",@"13", nil],nil];
    
    [self.tableView addFirstArray:tableArray];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSArray *array = [self.tableView.tableArray objectAtIndex:indexPath.row];
    
    DTAlbumDetailsController *detailsVC = [[DTAlbumDetailsController alloc] init];
    detailsVC.type = [array objectAtIndex:1];
    [self.navigationController pushViewController:detailsVC animated:YES];
}

@end
