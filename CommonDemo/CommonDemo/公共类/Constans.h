//
//  Constans.h
//  PageDemo
//
//  Created by xiongjw on 14-7-5.
//  Copyright (c) 2014年 xiongjw. All rights reserved.
//



//iphone系列
#define iPhone5         ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define COLOR(r,g,b)    [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

#define ScreenFrame     [[UIScreen mainScreen] bounds]

#define iosVersion      [[[UIDevice currentDevice] systemVersion] floatValue]

#define CYBackgroundColor COLOR(236,236,236)

