//
//  DTTableView.h
//  tableViewDemo
//
//  Created by DT on 14-6-6.
//  Copyright (c) 2014年 DT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIScrollView+MJRefresh.h"
#import "DTTableViewCell.h"

/** 回调函数,用于填充UITableViewCell数据 */
typedef void (^TableViewCellConfigureBlock)(UITableViewCell *cell, NSString *identifier, NSIndexPath *indexPath, id data);
/** 回调函数,用于填充section头(尾)数据 */
typedef NSString* (^TableViewTitleConfigureBlock)(NSInteger section);

/** 枚举 */
typedef enum {
    UITableViewDefault,
    UITableViewSection,
}tableViewSectionType;

/**
 *  @Author DT, 14-11-25 17:11:12
 *
 *  封装UITableView,可以不用实现dataSource代理
 */
@interface DTTableView : UITableView

/**
 *  总数
 */
@property(nonatomic,assign)int total;

/**
 *  页码
 */
@property(nonatomic,assign)int pageNumber;

/**
 *  页数
 */
@property(nonatomic,assign)int pages;

/**
 *  数组集合
 */
@property(nonatomic,strong,readonly)NSMutableArray *tableArray;

/**
 *  枚举类型,默认是UITableViewDefault
 */
@property (nonatomic, assign) tableViewSectionType sectionType;

/**
 *  第一次添加数据
 *
 *  @param array 数据源
 */
-(void)addFirstArray:(NSMutableArray*)array;

/**
 *  加载更多数据
 *
 *  @param array 数据源
 */
-(void)addMoreArray:(NSMutableArray*)array;

/**
 *  初始化datasource,针对一个cell
 *
 *  @param cellIdentifier     cell的标识符
 *  @param configureCellBlock 回调函数，参数有cell、indexPath和data
 */
- (void)initWithCellIdentifier:(NSString *)cellIdentifier
            configureCellBlock:(TableViewCellConfigureBlock)configureCellBlock;
/**
 *  初始化datasource,针对多个cell
 *
 *  @param cellIdentifiers    cell的标识符字典(key:identifier,value:NSIndexPath集合,也可以是NSNull)
 *  @param configureCellBlock 回调函数，参数有cell、indexPath和data
 */
- (void)initWithCellIdentifiers:(NSDictionary *)cellIdentifiers
           configureCellBlock:(TableViewCellConfigureBlock)configureCellBlock;
/**
 *  返回数据
 *
 *  @param indexPath indexPath
 *
 *  @return 数据源
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
