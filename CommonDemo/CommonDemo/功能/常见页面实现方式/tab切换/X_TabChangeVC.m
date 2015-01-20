//
//  X_TabChangeVC.m
//  CommonDemo
//
//  Created by xiongjw on 14-7-10.
//  Copyright (c) 2014年 xiongjw. All rights reserved.
//

#import "X_TabChangeVC.h"

#import "Constans.h"
#import "Tools.h"

@interface X_TabChangeVC () {
    UIView *_tabView1;
    UIView *_tabView2;
    UIView *_tabView3;
}

@end

@implementation X_TabChangeVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)segmentAction1:(id)sender {
    
    UIButton *button = (UIButton *)sender;
    for (UIView *sub in _tabView1.subviews) {
        if ([sub isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)sub;
            btn.selected = NO;
        }
    }
    button.selected = YES;
}

- (void)segmentAction2:(id)sender  {
    UIButton *button = (UIButton *)sender;
    for (UIView *sub in _tabView2.subviews) {
        if ([sub isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)sub;
            btn.selected = NO;
        }
    }
    button.selected = YES;
}

- (void)segmentAction3:(id)sender  {
    UIButton *button = (UIButton *)sender;
    for (UIView *sub in _tabView3.subviews) {
        if ([sub isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)sub;
            btn.selected = NO;
        }
    }
    button.selected = YES;
}

- (void)loadInitVariable {
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.title = @"tab切换";
    self.view.backgroundColor = CYBackgroundColor;
    
    NSArray *titles = [NSArray arrayWithObjects:@"A",@"B",@"C",@"D", nil];
    
    _tabView1 = [Tools getTabChangeView:2 titleArray:titles delegate:self action:@selector(segmentAction1:)];
    [self.view addSubview:_tabView1];
    
    _tabView2 = [Tools getTabChangeView:3 titleArray:titles delegate:self action:@selector(segmentAction2:)];
    _tabView2.frame = CGRectMake(_tabView2.frame.origin.x, 46, _tabView2.frame.size.width, _tabView2.frame.size.height);
    [self.view addSubview:_tabView2];
    
    _tabView3 = [Tools getTabChangeView:4 titleArray:titles delegate:self action:@selector(segmentAction3:)];
    _tabView3.frame = CGRectMake(_tabView3.frame.origin.x, 92, _tabView3.frame.size.width, _tabView3.frame.size.height);
    [self.view addSubview:_tabView3];
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
