//
//  X_PassValueStyleVC.m
//  CommonDemo
//
//  Created by xiongjw on 14-7-6.
//  Copyright (c) 2014年 xiongjw. All rights reserved.
//

#import "X_PassValueStyleVC.h"

#import "Tools.h"
#import "Constans.h"

#import "X_PassValue_DelegateVC.h"
#import "X_PassValue_NotifyVC.h"
#import "X_PassValue_BlockVC.h"

@interface X_PassValueStyleVC ()
{
    NSDictionary *dic;
}

@property (nonatomic, strong) NSString *str;
@property (nonatomic, strong) NSArray *arr;


@end

@implementation X_PassValueStyleVC

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
        
        _arr = @[@"w卧槽",@"w卧槽",@"w卧槽",@"w卧槽",];
        _str = @"尼玛";
        NSLog(@"%@",_arr);
        
        
        X_PassValue_DelegateVC *vc = [[X_PassValue_DelegateVC alloc] init];
        vc.title = btn.titleLabel.text;
        pushVC = vc;
    }
    else if (btn.tag == 2) {
        X_PassValue_NotifyVC *vc = [[X_PassValue_NotifyVC alloc] init];
        vc.title = btn.titleLabel.text;
        pushVC = vc;
    }
    else {
        X_PassValue_BlockVC *vc = [[X_PassValue_BlockVC alloc] init];
        vc.title = btn.titleLabel.text;
        pushVC = vc;
    }
    [self.navigationController pushViewController:pushVC animated:YES];
}

- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)loadInitVariable {
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.title = @"传值方式";
    self.view.backgroundColor = CYBackgroundColor;
    
    
    
    self.navigationItem.leftBarButtonItem = [Tools getNavBarItem:self type:1 clickAction:@selector(backAction)];
    UIButton *btn;
    btn = [Tools createBtn:self
                               frame:CGRectMake(110, 10, 100, 100)
                               title:@"代理传值"
                             bgColor:[UIColor purpleColor]
                             isRound:YES
                         clickAction:@selector(clickBtnAction:)];
    btn.tag = 1;
    [self.view addSubview:btn];
    
    btn = [Tools createBtn:self
                     frame:CGRectMake(110, 120, 100, 100)
                     title:@"通知传值"
                   bgColor:[UIColor purpleColor]
                   isRound:YES
               clickAction:@selector(clickBtnAction:)];
    btn.tag = 2;
    [self.view addSubview:btn];
    
    btn = [Tools createBtn:self
                     frame:CGRectMake(110, 230, 100, 100)
                     title:@"block传值"
                   bgColor:[UIColor purpleColor]
                   isRound:YES
               clickAction:@selector(clickBtnAction:)];
    btn.tag = 3;
    [self.view addSubview:btn];
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
