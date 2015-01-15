//
//  DTLabel.h
//  DTKitDemo
//
//  Created by DT on 14-11-28.
//  Copyright (c) 2014年 DT. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^CallBack) ();

/**
 *  @Author DT, 14-11-28 14:11:20
 *
 *  @brief 封装UILabel,支持点击事件,支持高亮颜色,支持下划线,支持删除线
 */
@interface DTLabel : UILabel
{
    CallBack callBack;
}

/**
 *  @Author DT, 14-11-27 15:11:20
 *
 *  @brief 初始化方法,支持点击方法
 *
 *  @param frame 位置
 *  @param block 回调方法
 *
 *  @return 当前试图
 */
-(id)initWithFrame:(CGRect)frame block:(CallBack)block;

/**
 *  @Author DT, 14-11-27 15:11:46
 *
 *  @brief 初始化方法,支持点击方法
 *
 *  @param block 回调方法
 *
 *  @return 当前试图
 */
-(id)initWithblock:(CallBack)block;

/**
 *  @Author DT, 14-11-28 14:11:58
 *
 *  @brief 是否增加有删除线,默认是NO
 */
@property(nonatomic,assign)BOOL strikeThroughEnabled;

/**
 *  @Author DT, 14-11-28 16:11:00
 *
 *  @brief 删除线高亮显示,默认是NO
 */
@property(nonatomic,assign)BOOL strikeThroughHighlightedEnabled;

/**
 *  @Author DT, 14-11-28 14:11:29
 *
 *  @brief 删除线颜色
 */
@property (strong, nonatomic) UIColor *strikeThroughColor;

/**
 *  @Author DT, 14-11-28 15:11:01
 *
 *  @brief 删除线粗细,默认为1
 */
@property (assign, nonatomic) CGFloat strikeThroughHeight;

/**
 *  @Author DT, 14-11-28 14:11:13
 *
 *  @brief 是否增加下划线,默认是NO
 */
@property(nonatomic,assign)BOOL underLineEnabled;

/**
 *  @Author DT, 14-11-28 16:11:00
 *
 *  @brief 下划线高亮显示,默认是NO
 */
@property(nonatomic,assign)BOOL underLineHighlightedEnabled;

/**
 *  @Author DT, 14-11-28 14:11:45
 *
 *  @brief 下划线颜色
 */
@property (strong, nonatomic) UIColor *underLineColor;

/**
 *  @Author DT, 14-11-28 15:11:27
 *
 *  @brief 下划线粗细,默认为1
 */
@property (assign, nonatomic) CGFloat underLineHeight;

@end
