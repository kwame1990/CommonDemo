//
//  X_PassValue_DelegateVC.m
//  CommonDemo
//
//  Created by xiongjw on 14-7-6.
//  Copyright (c) 2014年 xiongjw. All rights reserved.
//

#import "X_PassValue_DelegateVC.h"

#import "Tools.h"
#import "Constans.h"
#import "X_PassValueDetailVC.h"

@interface X_PassValue_DelegateVC () <X_PassValueDetailVCDelegate> {
    
    
    UITextField *_nameField;
    
    
}

@property (nonatomic, strong) UITableView *tab;

@end

@implementation X_PassValue_DelegateVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)addAction {
    X_PassValueDetailVC *pushVC = [[X_PassValueDetailVC alloc] init];
    pushVC.type = PassValue_Delegate;
    pushVC.delegate = self;//代理必做之事
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:pushVC];
    [Tools modifyNav:nav];
    [self presentViewController:nav animated:YES completion:NULL];
}

- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)loadInitVariable {
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.view.backgroundColor = CYBackgroundColor;
    
    self.navigationItem.leftBarButtonItem = [Tools getNavBarItem:self type:1 clickAction:@selector(backAction)];
    
    _nameField = [Tools makeTextField:self withFrame:CGRectMake(10, 100, 260, 40) andTag:1 andPlaceholder:@""];
    _nameField.enabled = NO;
    _nameField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:_nameField];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    btn.frame = CGRectMake(280, 109, btn.frame.size.width, btn.frame.size.height);
    [btn addTarget:self action:@selector(addAction) forControlEvents:UIControlEventTouchUpInside];
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

-(void)dismissX_PassValueDetailVC:(NSString *)str {
    //页面消失，开始接收值
    [self dismissViewControllerAnimated:YES completion:NULL];
    if (str != nil && str.length > 0) {
        _nameField.text = str;
    }
}

@end
