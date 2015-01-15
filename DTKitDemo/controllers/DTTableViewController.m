//
//  DTTableViewController.m
//  DTKitDemo
//
//  Created by DT on 14-11-26.
//  Copyright (c) 2014年 DT. All rights reserved.
//

#import "DTTableViewController.h"
#import "DTTableView.h"
#import "DTTableViewControllerCell.h"

#define IDENTIFIER @"cell"

// block self
#define WEAKSELF typeof(self) __weak weakSelf = self;

@interface DTTableViewController()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)DTTableView *tableView;
@property(nonatomic,strong)NSMutableArray *itemsArray;

@end

@implementation DTTableViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    if ([[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.title = @"DTTableViewController";
    [self initTableView];
    [self addData];
}

-(UIColor *)randomColor
{
    CGFloat hue = ( arc4random() % 256 / 256.0 ); //0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5; // 0.5 to 1.0,away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5; //0.5 to 1.0,away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

-(void)addData
{
    _itemsArray = [[NSMutableArray alloc] init];
    [_itemsArray addObject:[NSArray arrayWithObjects:@"样式一",@"只支持一个类型cell,不支持section样式,支持加载更多cell动画显示",@"DTTableViewStyle1Controller", nil]];
    [_itemsArray addObject:[NSArray arrayWithObjects:@"样式二",@"支持多个类型cell,不支持section样式,支持加载更多cell动画显示",@"DTTableViewStyle2Controller", nil]];
    [_itemsArray addObject:[NSArray arrayWithObjects:@"样式三",@"支持一个类型cell,支持section样式,暂不支持加载更多cell动画显示",@"DTTableViewStyle3Controller", nil]];
    [_itemsArray addObject:[NSArray arrayWithObjects:@"样式四",@"支持多个类型cell,支持section样式,暂不支持加载更多cell动画显示",@"DTTableViewStyle4Controller", nil]];
    [self.tableView addFirstArray:_itemsArray];
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

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableView.tableArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DTTableViewControllerCell *cell = [tableView dequeueReusableCellWithIdentifier:IDENTIFIER];
    if (! cell) {
        cell = [[DTTableViewControllerCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:IDENTIFIER];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    NSArray *array = [self.tableView.tableArray objectAtIndex:indexPath.row];
    [cell configureForData:array];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSArray *array = [self.tableView.tableArray objectAtIndex:indexPath.row];
    
    id vc = [[NSClassFromString([array objectAtIndex:2]) alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}



@end
