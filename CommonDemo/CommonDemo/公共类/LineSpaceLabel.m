//
//  LineSpaceLabel.m
//  TestDemo
//
//  Created by Xiong JiWei on 14-1-16.
//  Copyright (c) 2014年 Xiong JiWei. All rights reserved.
//

#import "LineSpaceLabel.h"

#import <CoreText/CoreText.h>
#import <Foundation/Foundation.h>

@interface LineSpaceLabel ()

@end

@implementation LineSpaceLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //如果不设置，默认这样
        _lineSpace = 5.0;
        _charSpace = 2.0;
    }
    return self;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    _lineSpace = 5.0;
    _charSpace = 2.0;
}

-(void)setCharSpace:(CGFloat)charSpace{
    _charSpace = charSpace;
    [self setNeedsDisplay];
}
-(void)setLineSpace:(CGFloat)lineSpace{
    _lineSpace = lineSpace;
    [self setNeedsDisplay];
}

-(void) drawTextInRect:(CGRect)requestedRect

{
    
    //创建AttributeString
    if (self.text == nil) {
        self.text = @"";
    }
    NSMutableAttributedString *string =[[NSMutableAttributedString alloc] initWithString:self.text];
    //设置字体及大小
    CTFontRef helveticaBold = CTFontCreateWithName((CFStringRef)self.font.fontName,self.font.pointSize,NULL);
    [string addAttribute:(id)kCTFontAttributeName value:(__bridge id)helveticaBold range:NSMakeRange(0,[string length])];
    
    //设置字间距
    if(_charSpace)
    {
        long number = self.charSpace;
        CFNumberRef num = CFNumberCreate(kCFAllocatorDefault,kCFNumberSInt8Type,&number);
        [string addAttribute:(id)kCTKernAttributeName value:(__bridge id)num range:NSMakeRange(0,[string length])];
        CFRelease(num);
    }
    
    //设置字体颜色
    [string addAttribute:(id)kCTForegroundColorAttributeName value:(id)(self.textColor.CGColor) range:NSMakeRange(0,[string length])];
    
    //创建文本对齐方式
    CTTextAlignment alignment = kCTLeftTextAlignment;
    if(self.textAlignment == NSTextAlignmentCenter) {
        alignment = kCTCenterTextAlignment;
        
    }
    if(self.textAlignment == NSTextAlignmentRight) {
        alignment = kCTRightTextAlignment;
    }
    
    CTParagraphStyleSetting alignmentStyle;
    alignmentStyle.spec = kCTParagraphStyleSpecifierAlignment;
    alignmentStyle.valueSize = sizeof(alignment);
    alignmentStyle.value = &alignment;
    
    //设置文本行间距
    CGFloat lineSpace = self.lineSpace;
    CTParagraphStyleSetting lineSpaceStyle;
    lineSpaceStyle.spec = kCTParagraphStyleSpecifierLineSpacingAdjustment;
    lineSpaceStyle.valueSize = sizeof(lineSpace);
    lineSpaceStyle.value =&lineSpace;
    
    //设置文本段间距
    CGFloat paragraphSpacing = 5.0;
    CTParagraphStyleSetting paragraphSpaceStyle;
    paragraphSpaceStyle.spec = kCTParagraphStyleSpecifierParagraphSpacing;
    paragraphSpaceStyle.valueSize = sizeof(CGFloat);
    paragraphSpaceStyle.value = &paragraphSpacing;
    
    //创建设置数组
    CTParagraphStyleSetting settings[ ] ={alignmentStyle,lineSpaceStyle,paragraphSpaceStyle};
    CTParagraphStyleRef style = CTParagraphStyleCreate(settings ,3);
    
    //给文本添加设置
    [string addAttribute:(id)kCTParagraphStyleAttributeName value:(__bridge id)style range:NSMakeRange(0 , [string length])];
    
    //排版
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)string);
    CGMutablePathRef leftColumnPath = CGPathCreateMutable();
    CGPathAddRect(leftColumnPath, NULL ,CGRectMake(0 , 0 ,self.bounds.size.width , self.bounds.size.height));
    CTFrameRef leftFrame = CTFramesetterCreateFrame(framesetter,CFRangeMake(0, 0), leftColumnPath , NULL);
    
    //翻转坐标系统（文本原来是倒的要翻转下）
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetTextMatrix(context , CGAffineTransformIdentity);
    CGContextTranslateCTM(context , 0 ,self.bounds.size.height);
    CGContextScaleCTM(context, 1.0 ,-1.0);
    
    //画出文本
    CTFrameDraw(leftFrame,context);
    //释放
    CGPathRelease(leftColumnPath);
    CFRelease(framesetter);
    CFRelease(helveticaBold);
    
    UIGraphicsPushContext(context);
}

@end
