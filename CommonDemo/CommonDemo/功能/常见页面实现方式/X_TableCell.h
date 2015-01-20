//
//  X_TableCell.h
//  CommonDemo
//
//  Created by xiongjw on 14-7-15.
//  Copyright (c) 2014年 xiongjw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface X_TableCell : UITableViewCell

@property(nonatomic, weak) IBOutlet UIButton *btn1;
@property(nonatomic, weak) IBOutlet UIButton *btn2;
@property(nonatomic, weak) IBOutlet UIButton *btn3;

- (void)layoutCell:(NSArray *)list row:(NSInteger)row;

@end
