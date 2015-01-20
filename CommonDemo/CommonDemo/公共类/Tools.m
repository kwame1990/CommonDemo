//
//  Tools.m
//  PageDemo
//
//  Created by xiongjw on 14-7-4.
//  Copyright (c) 2014年 xiongjw. All rights reserved.
//

#import "Tools.h"

#import "Constans.h"

@implementation Tools

+(UITableView *)createTable:(id)delegate frame:(CGRect)frame {
    UITableView *table = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    table.backgroundColor = [UIColor clearColor];
    table.backgroundView = nil;
    table.dataSource = delegate;
    table.delegate = delegate;
    table.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    return table;
}

//创建button
+ (UIButton *)createBtn:(id)delegate
                  frame:(CGRect)frame
                  title:(NSString *)title
                bgColor:(UIColor *)color
                isRound:(BOOL)round
            clickAction:(SEL)clickAction{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    [btn setTitle:title forState:UIControlStateNormal];
    btn.backgroundColor = color;
    [btn addTarget:delegate action:clickAction forControlEvents:UIControlEventTouchUpInside];
    //是否要圆形
    if (round) {
        btn.layer.cornerRadius = btn.frame.size.height/2;
        [btn.layer setMasksToBounds:YES];
    }
    return btn;
}

+(UIButton *)getTypeBtn:(int)type {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    if (type == 1) {
        btn.frame = CGRectMake(0, 0, 32, 32);
        [btn setBackgroundImage:[UIImage imageNamed:@"back_normal.png"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"back_press.png"] forState:UIControlStateHighlighted];
    }
    else if (type == 2) {
        btn.frame = CGRectMake(0, 0, 32, 32);
        [btn setBackgroundImage:[UIImage imageNamed:@"ok_normal.png"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"ok_press.png"] forState:UIControlStateHighlighted];
    }
    return btn;
}

//创建导航上的按钮
+(UIBarButtonItem *)getNavBarItem:(id)delegate
                             type:(int)type
                      clickAction:(SEL)clickAction {
    
    UIButton *btn = [self getTypeBtn:type];
    [btn addTarget:delegate action:clickAction forControlEvents:UIControlEventTouchUpInside];
    UIView *view = [[UIView alloc] initWithFrame:btn.frame];
    [view addSubview:btn];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:view];
    return barButtonItem;
}

+(UILabel *)createLable:(id)delegate
                  frame:(CGRect)frame
                  title:(NSString *)title
                bgColor:(UIColor *)color
                   font:(UIFont *)font{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    if (color)
        label.backgroundColor = color;
    else
        label.backgroundColor = [UIColor clearColor];
    if (title) 
        label.text = title;
    if (font)
        label.font = font;
    
    return label;
}

+ (UISwitch *) makeUISwitch:(id) delegate
                     andTag:(int) tag
                     action:(SEL) action {
    
    UISwitch *switchCtl = [[UISwitch alloc] initWithFrame:CGRectZero];
    [switchCtl addTarget:delegate action:action forControlEvents:UIControlEventValueChanged];
    // in case the parent view draws with a custom color or gradient, use a transparent color
    switchCtl.backgroundColor = [UIColor clearColor];
    [switchCtl setAccessibilityLabel:@"Switch"];
    switchCtl.tag = tag;	// tag this view for later so we can remove it from recycled table cells
    switchCtl.on = NO;
    return switchCtl;
}

+ (UITextField *) makeTextField:(id) delegate
                      withFrame:(CGRect) frame
                         andTag:(int) tag
                 andPlaceholder:(NSString *)holder {
    
    UITextField *textField = [[UITextField alloc] initWithFrame:frame];
    
    textField.textColor = [UIColor blackColor];
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;  //垂直居中
    textField.font = [UIFont systemFontOfSize:14.0];
    textField.placeholder = holder;
    textField.backgroundColor = [UIColor clearColor];
    textField.autocorrectionType = UITextAutocorrectionTypeNo;	// no auto correction support
    textField.keyboardType = UIKeyboardTypeDefault;
    
    textField.returnKeyType = UIReturnKeyDone;
    
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;	// has a clear 'x' button to the right
    
    textField.tag = tag;		// tag this control so we can remove it later for recycled cells
    
    // Add an accessibility label that describes what the text field is for.
    [textField setAccessibilityLabel:@"TextField"];
    
    textField.text = @"";
    textField.delegate = delegate;	// let us be the delegate so we know when the keyboard's "Done" button is pressed
	return textField;
}

+ (void)setTopView:(id)delegate textView:(UITextView *)textView action:(SEL)action {
    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
    UIToolbar * topView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    if (version > 6.9) {
        topView.backgroundColor = [UIColor whiteColor];
    }
    else {
        [topView setBarStyle:UIBarStyleBlackTranslucent];
    }
    UIBarButtonItem * btnSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc]initWithTitle:@"关闭" style:UIBarButtonItemStyleDone target:delegate action:action];
    NSArray * buttonsArray = [NSArray arrayWithObjects:btnSpace,doneButton,nil];
    [topView setItems:buttonsArray];
    [textView setInputAccessoryView:topView];
}

+ (void)modifyNav:(UINavigationController *)nav {
    
    [nav.navigationBar setBackgroundColor:[UIColor blackColor]];
    nav.navigationBar.tintColor = [UIColor whiteColor];
    [nav.navigationBar setTranslucent:NO];
    nav.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                             [UIColor whiteColor],UITextAttributeTextColor,
                                             [UIFont boldSystemFontOfSize:18],UITextAttributeFont, nil];
    
    UIImage *image = [UIImage imageNamed:@"nav_bg.png"];
    UIImage *navBack = [image stretchableImageWithLeftCapWidth:image.size.width/2 topCapHeight:image.size.height/2];
    if (iosVersion > 4.9) {
        //设置背景图片
        [nav.navigationBar setBackgroundImage:navBack forBarMetrics:0];
    }
    else {
        [nav.navigationBar insertSubview:[[UIImageView alloc] initWithImage:navBack] atIndex:1];
    }
}

+ (UIButton *)getBtn:(CGRect)frame
          nomalImage:(UIImage *)nImage
         selectedImg:(UIImage *)sImage
               title:(NSString *)title
                 num:(int)num
                 tag:(int)tag
            delegate:(id)delegate
              action:(SEL)clickAction {
    UIButton *button = [[UIButton alloc] initWithFrame:frame];
    [button setTitle:title forState:UIControlStateNormal];
    button.tag = tag;
    if (num == 2) {
        button.titleLabel.font = [UIFont boldSystemFontOfSize:17.0];
    }
    else if (num == 3) {
        button.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
    }
    else {
        button.titleLabel.font = [UIFont boldSystemFontOfSize:14.0];
    }
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setBackgroundImage:nImage forState:UIControlStateNormal];
    [button setBackgroundImage:sImage forState:UIControlStateSelected];
    [button addTarget:delegate action:clickAction forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

+ (UIView *)getTabChangeView:(int)num
                  titleArray:(NSArray *)titleArray
                    delegate:(id)delegate
                      action:(SEL)clickAction {
    
    UIView *head = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 45)];
    head.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tabbled_button_bg_1px.png"]];
    
    CGRect frame1 = num == 2 ? CGRectMake(30, 4, 131, 37) : num == 3 ? CGRectMake(37, 4, 82, 37) : CGRectMake(10, 4, 75, 37);
    CGRect frame2 = num == 2 ? CGRectMake(161, 4, 131, 37) : num == 3 ? CGRectMake(119, 4, 82, 37) : CGRectMake(85, 4, 75, 37);
    CGRect frame3;
    CGRect frame4;
    if (num > 2) {
        frame3 = num == 3 ? CGRectMake(201, 4, 82, 37) : CGRectMake(160, 4, 75, 37);
        if (num > 3) {
            frame4 = CGRectMake(235, 4, 75, 37);
        }
    }
    
    UIImage *nomalImage1 = num == 2 ? [UIImage imageNamed:@"left_tabbled_button.png"] : [UIImage imageNamed:@"group_tabbled_left_button.png"];
    UIImage *selectedImage1 = num == 2 ? [UIImage imageNamed:@"left_tabbled_button_down.png"] : [UIImage imageNamed:@"group_tabbled_left_button_down.png"];
    UIImage *nomalImage2 = num == 2 ? [UIImage imageNamed:@"right_tabbled_button.png"] : [UIImage imageNamed:@"group_tabbled_mid_button.png"];
    UIImage *selectedImage2 = num == 2 ? [UIImage imageNamed:@"right_tabbled_button_down.png"] : [UIImage imageNamed:@"group_tabbled_mid_button_down.png"];
    UIImage *nomalImage3 = nil;
    UIImage *selectedImage3 = nil;
    UIImage *nomalImage4 = nil;
    UIImage *selectedImage4 = nil;
    if (num > 2) {
        nomalImage3 = num == 3 ? [UIImage imageNamed:@"group_tabbled_right_button.png"] : [UIImage imageNamed:@"group_tabbled_mid_button.png"];
        selectedImage3 = num == 3 ? [UIImage imageNamed:@"group_tabbled_right_button_down.png"] : [UIImage imageNamed:@"group_tabbled_mid_button_down.png"];
        if (num > 3) {
            nomalImage4 = [UIImage imageNamed:@"group_tabbled_right_button.png"];
            selectedImage4 = [UIImage imageNamed:@"group_tabbled_right_button_down.png"];
        }
    }
    
    UIButton *pubButton = [self getBtn:frame1
                            nomalImage:nomalImage1
                           selectedImg:selectedImage1
                                 title:[titleArray objectAtIndex:0]
                                   num:num
                                   tag:1
                              delegate:delegate
                                action:clickAction];
    pubButton.selected = YES;
    [head addSubview:pubButton];
    
    pubButton = [self getBtn:frame2
                  nomalImage:nomalImage2
                 selectedImg:selectedImage2
                       title:[titleArray objectAtIndex:1]
                         num:num
                         tag:2
                    delegate:delegate
                      action:clickAction];
    [head addSubview:pubButton];
    
    if (num > 2) {
        pubButton = [self getBtn:frame3
                      nomalImage:nomalImage3
                     selectedImg:selectedImage3
                           title:[titleArray objectAtIndex:2]
                             num:num
                             tag:3
                        delegate:delegate
                          action:clickAction];
        [head addSubview:pubButton];
        if (num > 3) {
            pubButton = [self getBtn:frame4
                          nomalImage:nomalImage4
                         selectedImg:selectedImage4
                               title:[titleArray objectAtIndex:3]
                                 num:num
                                 tag:4
                            delegate:delegate
                              action:clickAction];
            [head addSubview:pubButton];
        }
    }
    return head;
    
}

+ (NSString *)getCountDownTime:(NSInteger)year
                      andMonth:(NSInteger)month
                        andDay:(NSInteger)day
                       andHour:(NSInteger)hour
                     andMinute:(NSInteger)minute
                     andSecond:(NSInteger)second {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setYear:year];
    [components setMonth:month];
    [components setDay:day];
    [components setHour:hour];
    [components setMinute:minute];
    [components setSecond:second];
    
    NSDate *todate = [calendar dateFromComponents:components];
    
    NSDate *today = [NSDate date];
    
    unsigned int unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit |NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *d = [calendar components:unitFlags fromDate:today toDate:todate options:0];
    
    return [NSString stringWithFormat:@"%d年%d月%d天%d小时%d分%d秒", [d year],[d month],[d day],[d hour],[d minute], [d second]];
    /*
    UILabel *label = (UILabel *)[self.view viewWithTag:100];
    NSString *time = [DemoDefine getCountDownTime:2014
                                         andMonth:01
                                           andDay:26
                                          andHour:16
                                        andMinute:11
                                        andSecond:00];
    label.text = [NSString stringWithFormat:@"还剩%@",[time substringFromIndex:4]];
     
     [NSTimer scheduledTimerWithTimeInterval:1.0
     target:self
     selector:@selector(xjwMethod)
     userInfo:nil
     repeats:YES];//使用timer定时，每秒触发一次
     */
}

//封装系统提示
+(void)AlertMsg:(id)delegate msg:(NSString *)msg {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                    message:msg
                                                   delegate:delegate
                                          cancelButtonTitle:nil
                                          otherButtonTitles:@"确定", nil];
    [alert show];
}

+ (int)timeCompare:(NSString *)str1 andStr2:(NSString *)str2 {
    int num = 0;
    
    NSDateFormatter *df=[[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *date1=[df dateFromString:str1];
    NSDate *date2=[df dateFromString:str2];
    
    switch ([date1 compare:date2]) {
        case NSOrderedSame:
            num = 1;
            NSLog(@"相等");
            break;
        case NSOrderedAscending:
            num = 2;
            NSLog(@"date1比date2小");
            break;
        case NSOrderedDescending:
            num = 3;
            NSLog(@"date1比date2大");
            break;
        default:
            num = 4;
            NSLog(@"非法时间");
            break;
    }
    
    return num;
}

+ (void)isInScope :(NSString *)dateString {
    NSString *str1 = @"1997-07-11";
    NSString *str2 = @"2002-09-12";
    int n = [self timeCompare:dateString andStr2:str1];
    int m = [self timeCompare:dateString andStr2:str2];
    if ((n == 1 && m == 2) || (n == 3 && m == 1) || (n == 3 && m == 2)) {
        NSLog(@"在范围之内.");
    }
}

+ (NSUInteger)getWeekDay :(NSString *)str{
    
    //NSString *str = @"2013-12-19";
    //str = [[str componentsSeparatedByString:@" "] objectAtIndex:0];
    NSDateFormatter *datef = [[NSDateFormatter alloc] init];
    [datef setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [datef dateFromString:str];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *week = [calendar components:(NSWeekdayCalendarUnit) fromDate:date];
    
    return [week weekday] - 1;
}

@end
