//
//  DTInstalledAppsDetailController.m
//  DTKitDemo
//
//  Created by DT on 14-12-11.
//  Copyright (c) 2014年 DT. All rights reserved.
//

#import "DTInstalledAppsDetailController.h"

@interface DTInstalledAppsDetailController()<UITableViewDataSource,UITableViewDelegate>
{
    BOOL _hasCFBundleURLTypes;
}
@property(nonatomic,strong)UIView *tableHeaderView;
@property(nonatomic,strong)UITableView *tableView;

@end

@implementation DTInstalledAppsDetailController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    if ([[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.title = @"DTInstalledAppsDetailController";
    _hasCFBundleURLTypes = self.model.CFBundleURLTypes==nil?NO:YES;
    [self.tableView reloadData];
}

-(UIView*)tableHeaderView
{
    if (!_tableHeaderView) {
        _tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
        _tableHeaderView.backgroundColor = [UIColor whiteColor];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 70, 70)];
        imageView.image = [self.model imageWithIcon];
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 15, self.view.frame.size.width -100, 25)];
        titleLabel.font = [UIFont systemFontOfSize:16.0f];
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.text = self.model.CFBundleDisplayName;
        UILabel *detailTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 40, self.view.frame.size.width -100, 20)];
        detailTextLabel.font = [UIFont systemFontOfSize:14.0f];
        detailTextLabel.textColor = [UIColor grayColor];
        detailTextLabel.text = self.model.CFBundleShortVersionString;
        UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 60, self.view.frame.size.width -100, 20)];
        detailLabel.font = [UIFont systemFontOfSize:14.0f];
        detailLabel.textColor = [UIColor grayColor];
        detailLabel.text = [NSString stringWithFormat:@"包大小:%.0fM",self.model.appSize];
        [_tableHeaderView addSubview:imageView];
        [_tableHeaderView addSubview:titleLabel];
        [_tableHeaderView addSubview:detailTextLabel];
        [_tableHeaderView addSubview:detailLabel];
    }
    return _tableHeaderView;
}

-(UITableView*)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.tableHeaderView = self.tableHeaderView;
        [self.view addSubview:_tableView];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==1) {
        return self.model.CFBundleURLTypes.count;
    }
    return 4;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_hasCFBundleURLTypes) {
        return 2;
    }
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section ==0) {
        return @"基本信息";
    }else if (section ==1){
        return @"url schemes地址";
    }
    return @"";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (! cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = [UIFont systemFontOfSize:15.0f];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14.0f];
    }
    if (indexPath.section ==0) {
        switch (indexPath.row) {
            case 0:{
                cell.textLabel.text = @"运行语言";
                cell.detailTextLabel.text = self.model.CFBundleDevelopmentRegion;
                break;
            }
            case 1:{
                cell.textLabel.text = @"Bundle Identifier";
                cell.detailTextLabel.text = self.model.CFBundleIdentifier;
                break;
            }
            case 2:{
                cell.textLabel.text = @"支持系统";
                cell.detailTextLabel.text = [self.model.CFBundleSupportedPlatforms componentsJoinedByString:@","];
                break;
            }
            case 3:{
                cell.textLabel.text = @"最低支持手机系统版本";
                cell.detailTextLabel.text = self.model.MinimumOSVersion;
                break;
            }
            default:
                break;
        }
    }else if (indexPath.section ==1){
        NSDictionary *dict = self.model.CFBundleURLTypes[indexPath.row];
        cell.textLabel.text = [[dict objectForKey:@"CFBundleURLName"] isEqualToString:@""]?@"CFBundleURLName":[dict objectForKey:@"CFBundleURLName"];
        cell.detailTextLabel.text = [[dict objectForKey:@"CFBundleURLSchemes"] componentsJoinedByString:@","];
    }
    return cell;
}


@end
