//
//  DTPrivateToolController.m
//  DTKitDemo
//
//  Created by DT on 14-12-11.
//  Copyright (c) 2014年 DT. All rights reserved.
//

#import "DTPrivateToolController.h"
#import "DTTableView.h"
#import "DTPrivateToolInstalledAppsController.h"

@interface DTPrivateToolController()<UITableViewDelegate>

@property(nonatomic,strong)DTTableView *tableView;

@end

@implementation DTPrivateToolController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    if ([[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.title = @"DTPrivateToolController";
    
    [self initTableView];
    [self.tableView addFirstArray:[[NSMutableArray alloc] initWithObjects:@"获取手机所用应用列表", nil]];
}

-(void)initTableView
{
    self.tableView = [[DTTableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64) style:UITableViewStylePlain];
    //必写,不然程序会报错
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    
    [self.tableView initWithCellIdentifier:@"cell" configureCellBlock:^(UITableViewCell *cell, NSString *identifier, NSIndexPath *indexPath, id data) {
        cell.textLabel.text = data;
    }];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:{
            DTPrivateToolInstalledAppsController *vc = [[DTPrivateToolInstalledAppsController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        default:
            break;
    }
}

@end
