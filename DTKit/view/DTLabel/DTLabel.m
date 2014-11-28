//
//  DTLabel.m
//  DTKitDemo
//
//  Created by DT on 14-11-28.
//  Copyright (c) 2014年 DT. All rights reserved.
//

#import "DTLabel.h"

@interface DTLabel()
{
    BOOL _isClicked;
    UIColor *_defaultColor;
}
@end

@implementation DTLabel

-(id)initWithFrame:(CGRect)frame block:(CallBack)block
{
    self = [super initWithFrame:frame];
    if (self) {
        callBack = block;
        _defaultColor = self.textColor;
        _isClicked = NO;
        self.userInteractionEnabled = YES;
        
        self.strikeThroughHighlightedEnabled = NO;
        self.strikeThroughEnabled = NO;
        self.strikeThroughHeight = 1;
        
        self.underLineHighlightedEnabled = NO;
        self.underLineEnabled = NO;
        self.underLineHeight = 1;
    }
    return self;
}

-(id)initWithblock:(CallBack)block
{
    self = [super init];
    if (self) {
        callBack = block;
        _defaultColor = self.textColor;
        _isClicked = NO;
        self.userInteractionEnabled = YES;
        
        self.strikeThroughHighlightedEnabled = NO;
        self.strikeThroughEnabled = NO;
        self.strikeThroughHeight = 1;
        
        self.underLineHighlightedEnabled = NO;
        self.underLineEnabled = NO;
        self.underLineHeight = 1;
    }
    return self;
}

-(void)setTextColor:(UIColor *)textColor
{
    [super setTextColor:textColor];
    _defaultColor = textColor;
}

-(void)drawTextInRect:(CGRect)rect
{
    [super drawTextInRect:rect];
    if (self.strikeThroughEnabled) {//表示有删除线
        if ((self.strikeThroughHighlightedEnabled && _isClicked ) || !self.strikeThroughHighlightedEnabled) {
            NSDictionary *attributes = @{NSFontAttributeName: [self font]};
            CGSize textSize = [[self text] sizeWithAttributes:attributes];
            CGFloat strikeWidth = textSize.width;
            CGRect strikeThroughRect;
            if ([self textAlignment] == NSTextAlignmentRight){
                strikeThroughRect = CGRectMake(rect.size.width - strikeWidth, (rect.size.height-self.strikeThroughHeight)/2, strikeWidth, self.strikeThroughHeight);
            }else if ([self textAlignment] == NSTextAlignmentCenter){
                strikeThroughRect = CGRectMake(rect.size.width/2 - strikeWidth/2, (rect.size.height-self.strikeThroughHeight)/2, strikeWidth, self.strikeThroughHeight);
            }else{
                strikeThroughRect = CGRectMake(0, (rect.size.height-self.strikeThroughHeight)/2, strikeWidth, self.strikeThroughHeight);
            }
            if (self.strikeThroughColor == nil) {
                CGContextRef context = UIGraphicsGetCurrentContext();
                CGContextSetFillColorWithColor(context, [self textColor].CGColor);
                CGContextFillRect(context, strikeThroughRect);
            }else{
                CGContextRef context = UIGraphicsGetCurrentContext();
                CGContextSetFillColorWithColor(context, [self strikeThroughColor].CGColor);
                CGContextFillRect(context, strikeThroughRect);
            }
        }
        
    }
    if (self.underLineEnabled) {//表示有下划线
        if ((self.underLineHighlightedEnabled && _isClicked ) || !self.underLineHighlightedEnabled) {
            NSDictionary *attributes = @{NSFontAttributeName: [self font]};
            CGSize textSize = [[self text] sizeWithAttributes:attributes];
            CGFloat strikeWidth = textSize.width;
            CGRect underLineRect;
            if ([self textAlignment] == NSTextAlignmentRight){
                underLineRect = CGRectMake(rect.size.width - strikeWidth, rect.size.height/2 + textSize.height/2, strikeWidth, self.underLineHeight);
            }else if ([self textAlignment] == NSTextAlignmentCenter){
                underLineRect = CGRectMake(rect.size.width/2 - strikeWidth/2, rect.size.height/2 + textSize.height/2, strikeWidth, self.underLineHeight);
            }else{
                underLineRect = CGRectMake(0, rect.size.height/2 + textSize.height/2, strikeWidth, self.underLineHeight);
            }
            if (self.underLineColor == nil) {
                CGContextRef context = UIGraphicsGetCurrentContext();
                CGContextSetFillColorWithColor(context, [self textColor].CGColor);
                CGContextFillRect(context, underLineRect);
            }else{
                CGContextRef context = UIGraphicsGetCurrentContext();
                CGContextSetFillColorWithColor(context, [self underLineColor].CGColor);
                CGContextFillRect(context, underLineRect);
            }
        }
    }
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    _isClicked = YES;
    if (self.highlightedTextColor) {
        [super setTextColor:self.highlightedTextColor];
        if (self.strikeThroughHighlightedEnabled || self.underLineHighlightedEnabled) {
            [self setNeedsDisplay];
        }
    }
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    _isClicked = NO;
    if (self.highlightedTextColor) {
        [super setTextColor:_defaultColor];
    }
    if (self.strikeThroughHighlightedEnabled || self.underLineHighlightedEnabled) {
        [self setNeedsDisplay];
    }
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];
    _isClicked = NO;
    if (self.highlightedTextColor) {
        [super setTextColor:_defaultColor];
    }
    if (self.strikeThroughHighlightedEnabled || self.underLineHighlightedEnabled) {
        [self setNeedsDisplay];
    }
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    if (_isClicked) {
        _isClicked = NO;
        if (self.highlightedTextColor) {
            [super setTextColor:_defaultColor];
        }
        if (self.strikeThroughHighlightedEnabled || self.underLineHighlightedEnabled) {
            [self setNeedsDisplay];
        }
        //延迟执行
        [self performSelector:@selector(touchesEnded) withObject:nil afterDelay:0.1f];
    }
}
- (void)touchesEnded
{
    if (callBack) {
        callBack();
    }
}


@end
