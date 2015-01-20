//
//  X_GestureViewVC.m
//  CommonDemo
//
//  Created by xiongjw on 14-7-10.
//  Copyright (c) 2014年 xiongjw. All rights reserved.
//

#import "X_GestureViewVC.h"

#import "Constans.h"
#import "X_ZbarMoveLineVC.h"
#import "X_TestRecognizerVC.h"
#import "X_LabelMoveVC.h"
#import "X_Scroll+ImageVC.h"

@interface X_GestureViewVC ()

@end

@implementation X_GestureViewVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)clickBtnAction:(UIButton *)btn {
    UIViewController *pushVC = nil;
    if (btn.tag == 1) {
        pushVC = [[X_ZbarMoveLineVC alloc] init];
    }
    else if (btn.tag == 2) {
        pushVC = [[X_TestRecognizerVC alloc] init];
    }
    else if (btn.tag == 3) {
        pushVC = [[X_LabelMoveVC alloc] init];
    }
    else if (btn.tag == 4) {
        pushVC = [[X_Scroll_ImageVC alloc] init];
    }
    if (pushVC) {
        [self.navigationController pushViewController:pushVC animated:YES];
    }
}

- (void)loadInitVariable {
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.title = @"手势＋动画";
    self.view.backgroundColor = CYBackgroundColor;
    
    NSArray *_infolist = @[@"二维码线的移动",@"常见手势汇总",@"字的移动",@"放大缩小图片"];
    for (int i = 0; i < _infolist.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(10, 10 + 40*i, 300, 30);
        [btn setTitle:_infolist[i] forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor purpleColor];
        btn.tag = i + 1;
        [btn.layer setCornerRadius:10.f];
        [btn.layer setMasksToBounds:YES];
        [btn addTarget:self action:@selector(clickBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadInitVariable];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
