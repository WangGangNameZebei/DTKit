//
//  DTTableViewDataSource.m
//  UITableViewDemo
//
//  Created by DT on 14-9-1.
//  Copyright (c) 2014年 DT. All rights reserved.
//

#import "DTTableViewDataSource.h"

@interface DTTableViewDataSource()
{
    BOOL _isMoreIdentifier;
}
@property (nonatomic, copy)   NSString *cellIdentifier;
@property (nonatomic, copy)   TableViewCellConfigureBlock configureCellBlock;
@property (nonatomic, copy)   TableViewTitleConfigureBlock configureHeaderTitleBlock;
@property (nonatomic, copy)   TableViewTitleConfigureBlock configureFooterTitleBlock;

@property (nonatomic, strong) NSDictionary *cellIdentifiers;

@end

@implementation DTTableViewDataSource

- (id)initWithIdentifier:(NSString *)cellIdentifier
      configureCellBlock:(TableViewCellConfigureBlock)configureCellBlock
{
    self = [super init];
    if (self) {
        _isMoreIdentifier = NO;
        self.cellIdentifier = cellIdentifier;
        self.configureCellBlock = [configureCellBlock copy];
    }
    return self;
}

- (id)initWithCellIdentifiers:(NSDictionary *)cellIdentifiers
           configureCellBlock:(TableViewCellConfigureBlock)configureCellBlock
{
    self = [super init];
    if (self) {
        _isMoreIdentifier = YES;
        self.cellIdentifiers = cellIdentifiers;
        self.configureCellBlock = [configureCellBlock copy];
    }
    return self;
}
- (id)itemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.items[indexPath.row];
}

- (void)titleForHeaderWithBolock:(TableViewTitleConfigureBlock)configureTitleBlock
{
    self.configureHeaderTitleBlock = configureTitleBlock;
}

- (void)titleForFooterWithBolock:(TableViewTitleConfigureBlock)configureTitleBlock
{
    self.configureFooterTitleBlock = configureTitleBlock;
}

#pragma mark UITableViewDataSource

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (self.configureHeaderTitleBlock) {
        return self.configureHeaderTitleBlock(section);
    }
    return nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    if (self.configureFooterTitleBlock) {
        return self.configureFooterTitleBlock(section);
    }
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_isMoreIdentifier) {
        for (NSString *key in self.cellIdentifiers) {
            self.cellIdentifier = key;
            if ([self.cellIdentifiers[key] isKindOfClass:[NSArray class]]) {
                NSArray *indexPathArray = self.cellIdentifiers[key];
                for (NSIndexPath *newIndexPath in indexPathArray) {
                    if ([newIndexPath compare:indexPath] == NSOrderedSame ? YES : NO) {
                        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:key];
                        id item = [self itemAtIndexPath:indexPath];
                        self.configureCellBlock(cell, key, indexPath, item);
                        return cell;
                    }
                }
            }
        }
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier];
    id item = [self itemAtIndexPath:indexPath];
    self.configureCellBlock(cell, self.cellIdentifier, indexPath, item);
    
    return cell;
}

@end
