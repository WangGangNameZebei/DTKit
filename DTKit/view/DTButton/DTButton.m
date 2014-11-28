//
//  DTButton.m
//  LeTu
//
//  Created by DT on 14-5-21.
//
//

#import "DTButton.h"

@implementation DTButton

-(void)setNormalImage:(UIImage *)normalImage
{
    _normalImage = normalImage;
}
-(void)setPressImage:(UIImage *)pressImage
{
    _pressImage = pressImage;
}
- (void)setIsSelect:(BOOL)isSelect
{
    _isSelect = isSelect;
    if (_isSelect) {
        [self setImage:self.pressImage forState:UIControlStateNormal];
        [self setImage:self.pressImage forState:UIControlStateHighlighted];
    }else{
        [self setImage:self.normalImage forState:UIControlStateNormal];
        [self setImage:self.normalImage forState:UIControlStateHighlighted];
    }
}
@end
