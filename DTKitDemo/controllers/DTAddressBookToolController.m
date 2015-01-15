//
//  DTAddressBookToolController.m
//  DTKitDemo
//
//  Created by DT on 14-12-10.
//  Copyright (c) 2014年 DT. All rights reserved.
//

#import "DTAddressBookToolController.h"
#import "DTAddressBookTool.h"
#import "DTAlertView.h"
#import "DTAddressBookDetailController.h"
#import "DTAddressBookModel.h"

@interface DTAddressBookToolController()<UITableViewDataSource,UITableViewDelegate>
{
    NSNumber *_personId;
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *itemsArray;

@end

@implementation DTAddressBookToolController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    if ([[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.title = @"DTAddressBookToolController";
    
    [self initTableView];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (![DTAddressBookTool addressBookAuthorizationEnabled]) {
        DTAlertView *alertView = [[DTAlertView alloc] initWithTitle:@"" message:@"没有通讯录权限" cancelButtonTitle:@"确定" otherButtonTitles:nil,nil];
        [alertView handlerClickedButton:^(DTAlertView *alertView, NSInteger buttonIndex) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
        return;
    }
}

-(void)initTableView
{
    self.itemsArray = [NSArray arrayWithObjects:@"获取手机通讯录列表",@"创建一个名test,电话为13800138000,10086的通讯录",@"修改名为test通讯录电话为4836323",@"查找名为test通讯录的列表信息",@"删除名为test通讯录信息",nil];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64) style:UITableViewStylePlain];
    self.tableView.tableFooterView = [UIView new];
    [self.view addSubview:self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.tableView.autoresizesSubviews = YES;
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth ;
    
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
        cell.textLabel.font = [UIFont systemFontOfSize:14.0f];
    }
    cell.textLabel.text = [self.itemsArray objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:{
            DTAddressBookDetailController *detailVC = [[DTAddressBookDetailController alloc] init];
            detailVC.type = 1;
            [self.navigationController pushViewController:detailVC animated:YES];
            break;
        }
        case 1:{
            BOOL b = [DTAddressBookTool createNewAddressBookWithName:@"test" phone:@"13800138000",@"10086",nil];
            if (b) {
                [DTAddressBookTool getAddressBooksWithName:@"test" block:^(NSArray *addressBookArray) {
                    _personId = ((DTAddressBookModel*)[addressBookArray lastObject]).personId;
                }];
                DTAlertView *alertView = [[DTAlertView alloc] initWithTitle:@"" message:@"创建成功" cancelButtonTitle:@"确定" otherButtonTitles:nil,nil];
                NSLog(@"%@",alertView);
            }else{
                DTAlertView *alertView = [[DTAlertView alloc] initWithTitle:@"" message:@"创建失败" cancelButtonTitle:@"确定" otherButtonTitles:nil,nil];
                NSLog(@"%@",alertView);
            }
            break;
        }
        case 2:{
            BOOL b = [DTAddressBookTool editAddressBookWithId:_personId phone:@"4836323",nil];
            if (b) {
                DTAlertView *alertView = [[DTAlertView alloc] initWithTitle:@"" message:@"修改成功" cancelButtonTitle:@"确定" otherButtonTitles:nil,nil];
                NSLog(@"%@",alertView);
            }else{
                DTAlertView *alertView = [[DTAlertView alloc] initWithTitle:@"" message:@"修改失败" cancelButtonTitle:@"确定" otherButtonTitles:nil,nil];
                NSLog(@"%@",alertView);
            }
            break;
        }
        case 3:{
            DTAddressBookDetailController *detailVC = [[DTAddressBookDetailController alloc] init];
            detailVC.type = 2;
            [self.navigationController pushViewController:detailVC animated:YES];
            break;
        }
        case 4:{
            [DTAddressBookTool getAddressBooksWithName:@"test" block:^(NSArray *addressBookArray) {
                for (DTAddressBookModel *model in addressBookArray) {
                    [DTAddressBookTool deleteAddressBookWithId:model.personId];
                }
                DTAlertView *alertView = [[DTAlertView alloc] initWithTitle:@"" message:@"删除成功" cancelButtonTitle:@"确定" otherButtonTitles:nil,nil];
                NSLog(@"%@",alertView);
            }];
            break;
        }
        default:
            break;
    }
}

@end
