//
//  DTTableViewSectionDataSource.m
//  UITableViewDemo
//
//  Created by DT on 14-9-2.
//  Copyright (c) 2014年 DT. All rights reserved.
//

#import "DTTableViewSectionDataSource.h"

@implementation DTTableViewSectionDataSource

- (id)itemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.items[indexPath.section][indexPath.row];
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.items[section] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.items count];
}

@end
