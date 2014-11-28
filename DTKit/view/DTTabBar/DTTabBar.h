//
//  DTTabBar.h
//  AnimatTabbarSample
//
//  Created by DT on 14-6-7.
//  Copyright (c) 2014年 DT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DTButton.h"
#import "DTTabBarItem.h"

@protocol DTTabBarDelegate<NSObject>

/**
 *  按钮点击事件
 *
 *  @param index 点击的按钮
 */
-(void)callButtonAction:(int)index;

@end

/**
 *  选项卡,用于代替UITabBarController
 */
@interface DTTabBar : UIView

@property(nonatomic,assign)id<DTTabBarDelegate>delegate;

/**
 *  当前阴影效果按钮
 */
@property(nonatomic,strong)DTButton *shadeButton;

/**
 *  当前的tab
 */
@property(nonatomic,assign)int currentTab;

/**
 *  TabBar的tab集合,类型是DTButton
 */
@property(nonatomic,strong,readonly)NSArray *buttonArray;

/**
 *  初始化方法
 *
 *  @param frame 位置
 *  @param array DTTabBarItem类型的集合
 *
 *  @return
 */
- (id)initWithFrame:(CGRect)frame array:(NSArray*)array;

@end
