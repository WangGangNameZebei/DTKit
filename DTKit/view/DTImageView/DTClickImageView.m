//
//  DTClickImageView.m
//  DTKitDemo
//
//  Created by DT on 14-11-27.
//  Copyright (c) 2014年 DT. All rights reserved.
//

#import "DTClickImageView.h"

@interface DTClickImageView()
{
    BOOL _isClicked;
}
@end

@implementation DTClickImageView

-(id)initWithFrame:(CGRect)frame block:(CallBack)block
{
    self = [super initWithFrame:frame];
    if (self) {
        callBack = block;
        _isClicked = NO;
        self.userInteractionEnabled = YES;
        
        //为当前视图增加一个高亮图层
        CALayer *bgLayer = self.layer;
        self.highlightLayer = [[CALayer alloc] init];
        self.highlightLayer.frame = self.bounds;
        self.highlightLayer.backgroundColor = [[[UIColor blackColor] colorWithAlphaComponent:0.2] CGColor];
        [bgLayer addSublayer:self.highlightLayer];
        self.highlightLayer.hidden = YES;
    }
    return self;
}

-(id)initWithblock:(CallBack)block
{
    self = [super init];
    if (self) {
        callBack = block;
        _isClicked = NO;
        self.userInteractionEnabled = YES;
        
        //为当前视图增加一个高亮图层
        CALayer *bgLayer = self.layer;
        self.highlightLayer = [[CALayer alloc] init];
        self.highlightLayer.frame = self.bounds;
        self.highlightLayer.backgroundColor = [[[UIColor blackColor] colorWithAlphaComponent:0.2] CGColor];
        [bgLayer addSublayer:self.highlightLayer];
        self.highlightLayer.hidden = YES;
    }
    return self;
}

-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    self.highlightLayer.frame = self.bounds;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    self.highlightLayer.hidden = NO;
    _isClicked = YES;
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    self.highlightLayer.hidden = YES;
    _isClicked = NO;
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];
    self.highlightLayer.hidden = YES;
    _isClicked = NO;
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    if (_isClicked) {
        //延迟执行
        [self performSelector:@selector(touchesEnded) withObject:nil afterDelay:0.1f];
    }
}
- (void)touchesEnded
{
    self.highlightLayer.hidden = YES;
    _isClicked = NO;
    if (callBack) {
        callBack();
    }
}


@end
