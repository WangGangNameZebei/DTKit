//
//  DTAddressBookDetailController.m
//  DTKitDemo
//
//  Created by DT on 14-12-10.
//  Copyright (c) 2014年 DT. All rights reserved.
//

#import "DTAddressBookDetailController.h"
#import "DTTableView.h"
#import "DTAddressBookTool.h"
#import "DTAddressBookModel.h"

@interface DTAddressBookDetailController()<UITableViewDataSource>

@property(nonatomic,strong)DTTableView *tableView;
@property (nonatomic,strong) NSArray *itemsArray;

@end

@implementation DTAddressBookDetailController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    if ([[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.title = @"DTAddressBookDetailController";
    
    [self initTableView];
    if (self.type ==1) {
        [self getAddressBooks];
    }else if (self.type ==2){
        [self getAddressBookWithTest];
    }
}

-(void)getAddressBooks
{
    [DTAddressBookTool getAddressBooks:^(NSArray *addressBookArray) {
        self.itemsArray = [NSArray arrayWithArray:addressBookArray];
        [self.tableView reloadData];
    }];
}


-(void)getAddressBookWithTest
{
    [DTAddressBookTool getAddressBooksWithName:@"test" block:^(NSArray *addressBookArray) {
        self.itemsArray = [NSArray arrayWithArray:addressBookArray];
        [self.tableView reloadData];
    }];
}

-(void)initTableView
{
    self.tableView = [[DTTableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.dataSource = self;
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
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = [UIFont systemFontOfSize:14.0f];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14.0f];
    }
    DTAddressBookModel *model = [self.itemsArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@%@",model.lastName==nil?@"":model.lastName,model.personName==nil?@"":model.personName];
    NSString *phones = @"";
    for (NSDictionary *phone in model.phoneArray) {
        phones = [NSString stringWithFormat:@"%@%@,",phones,[phone objectForKey:@"phone"]];
    }
    phones = [phones substringToIndex:phones.length-1];
    phones = [phones stringByReplacingOccurrencesOfString:@"-" withString:@""];
    phones = [phones stringByReplacingOccurrencesOfString:@"+86" withString:@""];
    cell.detailTextLabel.text = phones;
    return cell;
}

@end
