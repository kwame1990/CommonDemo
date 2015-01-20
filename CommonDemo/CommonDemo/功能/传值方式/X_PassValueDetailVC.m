//
//  X_PassValueDetailVC.m
//  CommonDemo
//
//  Created by xiongjw on 14-7-6.
//  Copyright (c) 2014年 xiongjw. All rights reserved.
//

#import "X_PassValueDetailVC.h"

#import "Constans.h"

@interface X_PassValueDetailVC () <UITableViewDataSource,UITableViewDelegate> {
    NSArray *_infoList;
}



@end

@implementation X_PassValueDetailVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)backAction {
    
    //如果返回，则传空
    if (_type == PassValue_Delegate) {
         [self.delegate dismissX_PassValueDetailVC:@""];
    }
    else if (_type == PassValue_Notify) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"callBack" object:nil];
    }
    else if (_type == PassValue_Block) {
        _successBlock(@"");
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
}

- (void)saveAction {
    //[self.delegate dismissX_PassValueDetailVC:@"AAA"];
}

- (void)loadInitVariable {
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.title = @"Main";
    self.view.backgroundColor = CYBackgroundColor;
    
    self.navigationItem.leftBarButtonItem = [Tools getNavBarItem:self type:1 clickAction:@selector(backAction)];
    //self.navigationItem.rightBarButtonItem = [Tools getNavBarItem:self type:2 clickAction:@selector(saveAction)];
    
    UITableView *table = [Tools createTable:self frame:CGRectMake(0, 0, CGRectGetWidth(ScreenFrame), CGRectGetHeight(ScreenFrame) - 64)];
    
    [self.view addSubview:table];
    
    _infoList = @[@"AAA",@"BBB",@"CCC",@"DDD",@"EEE",@"FFF",@"GGG"];
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _infoList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"X_PassValueDetailVCCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.textLabel.font = [UIFont systemFontOfSize:17];
    }
    cell.textLabel.text = _infoList[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate withTitle: colorType
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //开始传值
    if (_type == PassValue_Delegate) {
        //代理传值
        [self.delegate dismissX_PassValueDetailVC:_infoList[indexPath.row]];
    }
    else if (_type == PassValue_Notify) {
        //提交通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"callBack" object:_infoList[indexPath.row]];
    }
    else if (_type == PassValue_Block) {
        //block传值
        _successBlock(_infoList[indexPath.row]);
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
}

@end
