//
//  DTButton.h
//  LeTu
//
//  Created by DT on 14-5-21.
//
//

#import <UIKit/UIKit.h>

/**
 *  自定义Button
 *  用于点击按钮在普通和高亮图片之间切换
 */
@interface DTButton : UIButton

/** 默认图片 */
@property(nonatomic,strong)UIImage *normalImage;
/** 选中图片 */
@property(nonatomic,strong)UIImage *pressImage;
/** 图片状态 NO:默认图片 YES:选中图片 */
@property(nonatomic,assign)BOOL isSelect;

@end
