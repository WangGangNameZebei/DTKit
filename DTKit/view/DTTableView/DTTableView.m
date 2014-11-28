//
//  DTTableView.m
//  tableViewDemo
//
//  Created by DT on 14-6-6.
//  Copyright (c) 2014年 DT. All rights reserved.
//

#import "DTTableView.h"
#import "DTTableViewDataSource.h"
#import "DTTableViewSectionDataSource.h"

@interface DTTableView()
{
    NSMutableArray *_tableArray;
}
@property(nonatomic,strong)DTTableViewDataSource *tableViewDataSource;
@end

@implementation DTTableView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.pageNumber = 0;
        self.pages = 10;
        _tableArray = [[NSMutableArray alloc] init];
        self.backgroundView = nil;
        self.backgroundColor = [UIColor clearColor];
        self.sectionType = UITableViewDefault;
        self.surplusSeparatorEnabled = YES;
        self.separatorZeroEnabled = NO;
    }
    return self;
}
-(id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.pageNumber = 0;
        self.pages = 10;
        _tableArray = [[NSMutableArray alloc] init];
        self.backgroundView = nil;
        self.backgroundColor = [UIColor clearColor];
        self.sectionType = UITableViewDefault;
        self.surplusSeparatorEnabled = YES;
        self.separatorZeroEnabled = NO;
    }
    return self;
}

-(void)setSurplusSeparatorEnabled:(BOOL)surplusSeparatorEnabled
{
    if (surplusSeparatorEnabled) {
        self.tableFooterView = [UIView new];
    }
}

-(void)setSeparatorZeroEnabled:(BOOL)separatorZeroEnabled
{
    if (!separatorZeroEnabled) {
        if ([[UIDevice currentDevice].systemVersion floatValue]>=7.0) {
            if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
                [self setSeparatorInset:UIEdgeInsetsZero];
            }
        }
    }
}

-(void)addFirstArray:(NSMutableArray *)array
{
    [_tableArray removeAllObjects];
    _tableArray = array;
    self.tableViewDataSource.items = _tableArray;
    [self reloadData];
}

-(void)addMoreArray:(NSMutableArray *)array
{
    NSArray *indexPaths = [[NSArray alloc] initWithObjects:[NSIndexPath indexPathForRow:[self.tableArray count]-1 inSection:0], nil];
    
    int index = (int)[_tableArray count];
    NSMutableArray * indexPathArray = [NSMutableArray arrayWithCapacity:[array count]];
    [_tableArray addObjectsFromArray:array];
    self.tableViewDataSource.items = _tableArray;
    for(int i=index ;i<[_tableArray count];i++){
        [indexPathArray addObject:[NSIndexPath indexPathForRow:i inSection:0]];
    }
    [self beginUpdates];
    [self insertRowsAtIndexPaths:indexPathArray withRowAnimation:UITableViewRowAnimationFade];
    [self endUpdates];
    
    [self reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
}

-(NSMutableArray*)tableArray
{
    return _tableArray;
}

- (void)initWithCellIdentifier:(NSString *)cellIdentifier
            configureCellBlock:(TableViewCellConfigureBlock)configureCellBlock
{
    if (self.sectionType == UITableViewDefault) {
        self.tableViewDataSource = [[DTTableViewDataSource alloc] initWithIdentifier:cellIdentifier configureCellBlock:configureCellBlock];
        self.dataSource = self.tableViewDataSource;
    }else{
        self.tableViewDataSource = [[DTTableViewSectionDataSource alloc] initWithIdentifier:cellIdentifier configureCellBlock:configureCellBlock];
        self.dataSource = self.tableViewDataSource;
    }
}

- (void)initWithCellIdentifiers:(NSDictionary *)cellIdentifiers
           configureCellBlock:(TableViewCellConfigureBlock)configureCellBlock
{
    if (self.sectionType == UITableViewDefault) {
        self.tableViewDataSource = [[DTTableViewDataSource alloc] initWithCellIdentifiers:cellIdentifiers configureCellBlock:configureCellBlock];
        self.dataSource = self.tableViewDataSource;
    }else{
        self.tableViewDataSource = [[DTTableViewSectionDataSource alloc] initWithCellIdentifiers:cellIdentifiers configureCellBlock:configureCellBlock];
        self.dataSource = self.tableViewDataSource;
    }
}

- (id)itemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.sectionType == UITableViewDefault) {
        return [self.tableViewDataSource itemAtIndexPath:indexPath];
    }else{
        return [(DTTableViewSectionDataSource*)self.tableViewDataSource itemAtIndexPath:indexPath];
    }
}

- (void)titleForHeaderWithBolock:(TableViewTitleConfigureBlock)configureTitleBlock
{
    [self.tableViewDataSource titleForHeaderWithBolock:configureTitleBlock];
}

- (void)titleForFooterWithBolock:(TableViewTitleConfigureBlock)configureTitleBlock
{
    [self.tableViewDataSource titleForFooterWithBolock:configureTitleBlock];
}
@end
