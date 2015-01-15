//
//  DTPrivateToolInstalledAppsController.m
//  DTKitDemo
//
//  Created by DT on 14-12-11.
//  Copyright (c) 2014年 DT. All rights reserved.
//

#import "DTPrivateToolInstalledAppsController.h"
#import "DTTableView.h"
#import "DTPrivateTool.h"
#import "DTInstalledAppModel.h"
#import "DTInstalledAppsDetailController.h"

@interface DTPrivateToolInstalledAppsController()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSArray *itemsArray;

@end

@implementation DTPrivateToolInstalledAppsController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    if ([[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.title = @"DTPrivateToolController";
    
    [self initTableView];
    [self getInstalledApps];
}

-(void)getInstalledApps
{
    self.itemsArray = [DTPrivateTool getInstalledApps];
    [self.tableView reloadData];
}

-(void)initTableView
{
    self.tableView = [[DTTableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64) style:UITableViewStylePlain];
    self.tableView.rowHeight = 70;
    [self.view addSubview:self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.tableView.autoresizesSubviews = YES;
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
    
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
        cell.textLabel.font = [UIFont systemFontOfSize:15.0f];
    }
    DTInstalledAppModel *model = [self.itemsArray objectAtIndex:indexPath.row];
    cell.textLabel.text = model.CFBundleDisplayName;
    cell.detailTextLabel.text = model.CFBundleShortVersionString;
    cell.imageView.image = model.imageWithIcon;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    DTInstalledAppsDetailController *vc = [[DTInstalledAppsDetailController alloc] init];
    vc.model = [self.itemsArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
