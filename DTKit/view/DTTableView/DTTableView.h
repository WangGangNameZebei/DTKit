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
 *  @brief 封装UITableView,可以不用实现dataSource代理
 */
@interface DTTableView : UITableView

/**
 *  @Author DT, 14-11-28 17:11:25
 *
 *  @brief 是否隐藏多余分割线,默认是YES
 */
@property(nonatomic,assign)BOOL surplusSeparatorEnabled;

/**
 *  @Author DT, 14-11-28 17:11:09
 *
 *  @brief 分割线是否从0开始,默认为NO
 *  @brief 在ios8系统下要是用户自己实现dataSource代理方法的话,这个属性会不起作用的
 */
@property(nonatomic,assign)BOOL separatorZeroEnabled;

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
 *  去掉section黏性,一般写在scrollViewDidScroll代理方法里面的
 *
 *  @param scrollView scrollView
 */
-(void)removeSectionStickiness:(UIScrollView*)scrollView;

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
