//
//  DTAlertView.m
//  DTKitDemo
//
//  Created by DT on 14-11-26.
//  Copyright (c) 2014年 DT. All rights reserved.
//

#import "DTAlertView.h"

@interface DTAlertView()<UIAlertViewDelegate>
{
    NSInteger _buttonIndex;
}
@end

@implementation DTAlertView

- (id)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...;
{
    //提取不定参数比塞进集合里面
    NSMutableArray* arrays = [NSMutableArray array];
    va_list arguments;
    id eachObject;
    if (otherButtonTitles) {
        [arrays addObject:otherButtonTitles];
        va_start(arguments, otherButtonTitles);
        
        while ((eachObject = va_arg(arguments, id))) {
            [arrays addObject:eachObject];
        }
    }
    va_end(arguments);
    
    self = [super init];
    if (self) {
        self.title = title;
        self.message = message;
        self.delegate = self;
        for (NSString *otherButtonTitle in arrays) {
            if (otherButtonTitle !=nil && ![otherButtonTitle isEqualToString:@""]) {
                [self addButtonWithTitle:otherButtonTitle];
            }
        }
        if (cancelButtonTitle !=nil && ![cancelButtonTitle isEqualToString:@""]) {
            [self addButtonWithTitle:cancelButtonTitle];
        }
        [self show];
    }
    return self;
}

-(void) handlerClickedButton:(CallBack)block
{
    callBack = block;
}

//根据被点击按钮的索引处理点击事件
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    _buttonIndex = buttonIndex;
    if (callBack) {
        callBack(self,buttonIndex);
    }
//    NSLog(@"clickedButtonAtIndex");
}

//AlertView的取消按钮的事件
- (void)alertViewCancel:(UIAlertView *)alertView
{
//    NSLog(@"alertViewCancel");
}

//AlertView即将显示时
- (void)willPresentAlertView:(UIAlertView *)alertView
{
//    NSLog(@"willPresentAlertView");
}

//AlertView已经显示时的事件
- (void)didPresentAlertView:(UIAlertView *)alertView
{
//    NSLog(@"didPresentAlertView");
}

//ALertView即将消失时的事件
- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{
//    NSLog(@"willDismissWithButtonIndex");
}

//AlertView已经消失时执行的事件
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
//    NSLog(@"didDismissWithButtonIndex");
}

@end
