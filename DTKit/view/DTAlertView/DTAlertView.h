//
//  DTAlertView.h
//  DTKitDemo
//
//  Created by DT on 14-11-26.
//  Copyright (c) 2014年 DT. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DTAlertView;
typedef void (^CallBack) (DTAlertView *alertView, NSInteger buttonIndex);

/**
 *  @Author DT, 14-11-27 11:11:33
 *
 *  @brief 自定义UIAlertView,实现用block代替delegate
 */
@interface DTAlertView : UIAlertView
{
    CallBack callBack;
}

/**
 *  @Author DT, 14-11-27 11:11:51
 *
 *  @brief 初始化方法
 *
 *  @param title             标题
 *  @param message           内容
 *  @param cancelButtonTitle 取消按钮标题
 *  @param otherButtonTitles 其他按钮标题,支持不定参数传值,以nil结束
 *
 *  @return 当前对象
 */
- (id)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...;

/**
 *  @Author DT, 14-11-27 11:11:36
 *
 *  @brief 回调方法
 *
 *  @param block 回调函数,参数是buttonIndex
 */
-(void) handlerClickedButton:(CallBack)block;

@end
