//
//  X_PassValue_NotifyVC.m
//  CommonDemo
//
//  Created by xiongjw on 14-7-6.
//  Copyright (c) 2014年 xiongjw. All rights reserved.
//

#import "X_PassValue_NotifyVC.h"

#import "Tools.h"
#import "Constans.h"
#import "X_PassValueDetailVC.h"

@interface X_PassValue_NotifyVC () {
    UITextField *_nameField;
}

@end

@implementation X_PassValue_NotifyVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
//接收到通知了
- (void)callBack:(NSNotification *)note {
    [self dismissViewControllerAnimated:YES completion:NULL];
    NSString *str = [note object];
    if (str) {
        _nameField.text = str;
    }
}

- (void)createNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(callBack:)
                                                 name:@"callBack"
                                               object:nil];
}
- (void)removeNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"callBack" object:nil];
}

- (void)addAction {
    X_PassValueDetailVC *pushVC = [[X_PassValueDetailVC alloc] init];
    pushVC.type = PassValue_Notify;
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
    //创建消息通知
    [self createNotification];
    
    //1.接收方创建消息通知
    //2.传值方提交消息通知
    //3.接收方接收消息
    //4.接收方移除消息通知
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadInitVariable];
}

- (void)dealloc {
    //[super dealloc];
    //移除通知
    [self removeNotification];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
