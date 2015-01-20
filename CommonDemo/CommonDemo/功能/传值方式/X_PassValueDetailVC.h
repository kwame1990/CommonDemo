//
//  X_PassValueDetailVC.h
//  CommonDemo
//
//  Created by xiongjw on 14-7-6.
//  Copyright (c) 2014年 xiongjw. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Tools.h"

typedef void (^completionBlock)(NSString *str);
//begin
@class X_PassValueDetailVC;

@protocol X_PassValueDetailVCDelegate
    -(void)dismissX_PassValueDetailVC:(NSString *)str;
@end
//end
@interface X_PassValueDetailVC : UIViewController
//代理
@property (nonatomic, assign) id<X_PassValueDetailVCDelegate> delegate;
//类型
@property (assign) PassValueType type;
//block
@property (nonatomic,   copy) completionBlock successBlock;

@end
