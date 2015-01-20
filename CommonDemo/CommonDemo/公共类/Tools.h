//
//  Tools.h
//  PageDemo
//
//  Created by xiongjw on 14-7-4.
//  Copyright (c) 2014年 xiongjw. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    PassValue_Delegate = 0,
    PassValue_Notify = 1,
    PassValue_Block = 2
} PassValueType;

@interface Tools : NSObject


+ (NSString *)str;
//创建table
+(UITableView *)createTable:(id)delegate frame:(CGRect)frame;
//创建button
+(UIButton *)createBtn:(id)delegate
                 frame:(CGRect)frame
                 title:(NSString *)title
               bgColor:(UIColor *)color
               isRound:(BOOL)round
           clickAction:(SEL)clickAction;
// 创建导航上的按钮
+(UIBarButtonItem *)getNavBarItem:(id)delegate
                             type:(int)type
                      clickAction:(SEL)clickAction;
//创建label
+(UILabel *)createLable:(id)delegate
                  frame:(CGRect)frame
                  title:(NSString *)title
                bgColor:(UIColor *)color
                   font:(UIFont *)font;
//创建开关
+ (UISwitch *) makeUISwitch:(id) delegate
                     andTag:(int) tag
                     action:(SEL) action;
//创建textfield
+ (UITextField *) makeTextField:(id) delegate
                      withFrame:(CGRect) frame
                         andTag:(int) tag
                 andPlaceholder:(NSString *)holder;

//textview上加关闭按钮
+ (void)setTopView:(id)delegate textView:(UITextView *)textView action:(SEL)action;
//修改导航
+ (void)modifyNav:(UINavigationController *)nav;
//tab
+ (UIView *)getTabChangeView:(int)num
                  titleArray:(NSArray *)titleArray
                    delegate:(id)delegate
                      action:(SEL)clickAction;
//倒计时
+ (NSString *)getCountDownTime:(NSInteger)year
                      andMonth:(NSInteger)month
                        andDay:(NSInteger)day
                       andHour:(NSInteger)hour
                     andMinute:(NSInteger)minute
                     andSecond:(NSInteger)second;

+ (void)AlertMsg:(id)delegate msg:(NSString *)msg;

+ (void)isInScope :(NSString *)dateString;

+ (NSUInteger)getWeekDay :(NSString *)str;

@end
