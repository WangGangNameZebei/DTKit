//
//  DTTableViewDataSource.h
//  UITableViewDemo
//
//  Created by DT on 14-9-1.
//  Copyright (c) 2014年 DT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/** 回调函数 */
typedef void (^TableViewCellConfigureBlock)(UITableViewCell *cell, NSString *identifier, NSIndexPath *indexPath, id data);

typedef NSString* (^TableViewTitleConfigureBlock)(NSInteger section);

/**
 *  抽取UITableViewDataSource,不支持section分段
 */
@interface DTTableViewDataSource : NSObject<UITableViewDataSource>

/**
 *  数据集合
 */
@property (nonatomic, strong) NSMutableArray *items;

/**
 *  初始化方法
 *
 *  @param cellIdentifier     cell标识码
 *  @param configureCellBlock 回调函数
 *
 *  @return 当前对象
 */
- (id)initWithIdentifier:(NSString *)cellIdentifier
      configureCellBlock:(TableViewCellConfigureBlock)configureCellBlock;

/**
 *  初始化datasource(必须实现的,针对多个cell)
 *
 *  @param cellIdentifiers    cell的标识符字典
 *  @param configureCellBlock 回调函数
 *
 *  @return 当前对象
 */
- (id)initWithCellIdentifiers:(NSDictionary *)cellIdentifiers
           configureCellBlock:(TableViewCellConfigureBlock)configureCellBlock;
/**
 *  根据indexPath返回数据
 *
 *  @param indexPath indexPath
 *
 *  @return 数据
 */
- (id)itemAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  设置UITableView头标题
 *
 *  @param configureTitleBlock 回调函数,根据section返回String
 */
- (void)titleForHeaderWithBolock:(TableViewTitleConfigureBlock)configureTitleBlock;

/**
 *  设置UITableView页脚标题
 *
 *  @param configureTitleBlock 回调函数,根据section返回String
 */
- (void)titleForFooterWithBolock:(TableViewTitleConfigureBlock)configureTitleBlock;

@end
