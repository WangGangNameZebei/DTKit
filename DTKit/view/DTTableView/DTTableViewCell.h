//
//  DTTableViewCell.h
//  UITableViewDemo
//
//  Created by DT on 14-9-1.
//  Copyright (c) 2014年 DT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DTTableViewCell : UITableViewCell

/**
 *  数据填充方法
 *
 *  @param data 数据源
 */
- (void)configureForData:(id)data;

/**
 *  计算cell高度
 *
 *  @param data 数据源
 *
 *  @return 高度
 */
+ (CGFloat)calculateCellHeightWithAlbum:(id)data;

@end
