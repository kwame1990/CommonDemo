//
//  DPLabel.m
//  TestDemo
//
//  Created by Xiong JiWei on 13-12-29.
//  Copyright (c) 2013年 Xiong JiWei. All rights reserved.
//

#import "DPLabel.h"

@implementation DPLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _verticalAlignment = VerticalAlignmentTop;
    }
    return self;
}

- (VerticalAlignment)verticalAlignment
{
    return _verticalAlignment;
}

- (void)setVerticalAlignment:(VerticalAlignment)align
{
    _verticalAlignment = align;
    [self setNeedsDisplay];
}

- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines
{
    CGRect rc = [super textRectForBounds:bounds limitedToNumberOfLines:numberOfLines];
    switch (_verticalAlignment) {
        case VerticalAlignmentTop:
            rc.origin.y = bounds.origin.y;
            break;
        case VerticalAlignmentBottom:
            rc.origin.y = bounds.origin.y + bounds.size.height - rc.size.height;
            break;
        case VerticalAlignmentMidele:
        default:
            rc.origin.y = bounds.origin.y + (bounds.size.height - rc.size.height)/2;
            break;
    }
    
    return rc;
}

- (void)drawTextInRect:(CGRect)rect
{
    CGRect rc = [self textRectForBounds:rect limitedToNumberOfLines:self.numberOfLines];
    [super drawTextInRect:rc];
}

@end
