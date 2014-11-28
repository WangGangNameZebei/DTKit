//
//  DTGridTableViewController.m
//  DTKitDemo
//
//  Created by DT on 14-11-25.
//  Copyright (c) 2014年 DT. All rights reserved.
//

#import "DTGridTableViewController.h"
#import "MJRefresh.h"
#import "DTGridTableView.h"
#import "DTGridTableCellView.h"

// block self
#define WEAKSELF typeof(self) __weak weakSelf = self;

@interface DTGridTableViewController()<DTGridTableViewDatasource,DTGridTableViewDelegate>

@property(nonatomic,strong)DTGridTableView *tableView;
@property(nonatomic,strong)NSMutableArray *itemsArray;

@end

@implementation DTGridTableViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    if ([[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.title = @"DTGridTableViewController";
    
    [self addData];
    [self initGridTableView];
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
    if (!self.itemsArray) {
        self.itemsArray = [[NSMutableArray alloc] init];
    }
    for (int i=0; i<15; i++) {
        if (self.itemsArray.count >=50) {
            return;
        }
        [self.itemsArray addObject:[self randomColor]];
    }
}

-(void)initGridTableView
{
    self.tableView = [[DTGridTableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height -64)];
    self.tableView.datasource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    
    WEAKSELF
    [self.tableView.tableView addHeaderWithCallback:^{
        [weakSelf.itemsArray removeAllObjects];
        [weakSelf addData];
        [weakSelf.tableView.tableView headerEndRefreshing];
        [weakSelf.tableView reloadData];
    }];
    [self.tableView.tableView addFooterWithCallback:^{
        [weakSelf addData];
        [weakSelf.tableView.tableView footerEndRefreshing];
        [weakSelf.tableView reloadData];
    }];
}

#pragma mark DTGridTableViewDatasource
- (NSInteger)numberOfGridsInRow
{
    return 3;
}

- (NSInteger)numberOfGrids
{
    return self.itemsArray.count;
}

- (UIView*)viewAtIndex:(NSInteger)index size:(CGSize)size
{
    DTGridTableCellView *view = [[DTGridTableCellView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    return view;
}

#pragma mark DTGridTableViewDelegate
- (void)gridView:(UIView*)gridView gridViewForRowAtIndexPath:(int)index
{
    DTGridTableCellView *view = (DTGridTableCellView*)gridView;
    view.backgroundColor = [self.itemsArray objectAtIndex:index];
    view.label.text = [NSString stringWithFormat:@"%i",index];
}
@end
