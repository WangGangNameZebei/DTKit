//
//  DTClickImageView.h
//  DTKitDemo
//
//  Created by DT on 14-11-27.
//  Copyright (c) 2014年 DT. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^CallBack) ();

/**
 *  @Author DT, 14-11-27 13:11:43
 *
 *  @brief 封装UIImageView,支持点击高亮效果,支持block形式的点击事件
 */
@interface DTClickImageView : UIImageView
{
    CallBack callBack;
}

/**
 *  @Author DT, 14-11-27 15:11:17
 *
 *  @brief 高亮图层
 */
@property(nonatomic,strong)CALayer *highlightLayer;

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

@end
