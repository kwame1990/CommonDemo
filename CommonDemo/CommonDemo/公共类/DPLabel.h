//
//  DPLabel.h
//  TestDemo
//
//  Created by Xiong JiWei on 13-12-29.
//  Copyright (c) 2013年 Xiong JiWei. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    VerticalAlignmentTop = 0,
    VerticalAlignmentMidele,
    VerticalAlignmentBottom,
    VerticalAlignmentMax
}VerticalAlignment;

@interface DPLabel : UILabel {
    VerticalAlignment _verticalAlignment;
}

@property (nonatomic, assign) VerticalAlignment verticalAlignment;

@end
