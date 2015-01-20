//
//  X_TableCell.m
//  CommonDemo
//
//  Created by xiongjw on 14-7-15.
//  Copyright (c) 2014年 xiongjw. All rights reserved.
//

#import "X_TableCell.h"

#import "Constans.h"

@implementation X_TableCell

- (void)awakeFromNib
{
    // Initialization code
}

- (id)initWithCoder:(NSCoder *)coder
{
	self = [super initWithCoder:coder];
	if (self != nil) {
        self.backgroundColor = [UIColor clearColor];
        UIView *backView = [[UIView alloc] initWithFrame:self.frame];
        backView.backgroundColor = CYBackgroundColor;
        self.backgroundView = backView;
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType  = UITableViewCellAccessoryNone;
	}
    
	return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutCell:(NSArray *)list row:(NSInteger)row {
    
    NSString *temp1 = nil;
    NSString *temp2 = nil;
    NSString *temp3 = nil;
    
    if (list.count%3 == 1 && row == list.count/3) {
        temp1 = list[row*3];
        
        _btn2.hidden = YES;
        _btn3.hidden = YES;
    }
    else if (list.count%3 ==2 && row == list.count/3) {
        temp1 = list[row*3];
        temp2 = list[row*3 + 1];
        
        _btn3.hidden = YES;
    }
    else {
        temp1 = list[row*3];
        temp2 = list[row*3 + 1];
        temp3 = list[row*3 + 2];
    }
    
    _btn1.tag = row*3;
    _btn2.tag = row*3 + 1;
    _btn3.tag = row*3 + 2;
    
    [_btn1 setBackgroundImage:[UIImage imageNamed:temp1] forState:UIControlStateNormal];
    [_btn2 setBackgroundImage:[UIImage imageNamed:temp2] forState:UIControlStateNormal];
    [_btn3 setBackgroundImage:[UIImage imageNamed:temp3] forState:UIControlStateNormal];
    
    [_btn1 addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    [_btn2 addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    [_btn3 addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)clickAction:(UIButton *)btn {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"callBtnClickBack" object:[NSString stringWithFormat:@"%d",btn.tag]];
}

@end
