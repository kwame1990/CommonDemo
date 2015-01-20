//
//  ViewController.m
//  CommonDemo
//
//  Created by xiongjw on 14-7-6.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import "ViewController.h"

#import "Tools.h"
#import "Constans.h"

#import "X_PassValueStyleVC.h"
#import "X_GestureViewVC.h"
#import "X_CommonPageVC.h"

@interface ViewController () <UITableViewDataSource,UITableViewDelegate> {
    NSArray *_infoList;
}

@end

@implementation ViewController

- (void)loadInitVariable {
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.title = @"Main";
    self.view.backgroundColor = CYBackgroundColor;
    
    UITableView *table = [Tools createTable:self frame:CGRectMake(0, 0, CGRectGetWidth(ScreenFrame), CGRectGetHeight(ScreenFrame) - 64)];
    
    [self.view addSubview:table];
    
    _infoList = @[@"关于传值的几种方式",@"一些基本手势和动画",@"常见页面实现"];
    
    /*
     //从bundle中取图片
     UIImageView *imageView = (UIImageView *)[self.view viewWithTag:101];
     
     NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"test.bundle/images/1.jpg"];
     imageView.image = [UIImage imageWithContentsOfFile:path];
     
     NSString *bundlePath = [[NSBundle mainBundle].resourcePath stringByAppendingPathComponent:@"test.bundle/images"];
     NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
     NSString *path = [bundle pathForResource:@"1" ofType:@"jpg"];
     imageView.image = [UIImage imageWithContentsOfFile:path];
     */
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
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
    static NSString *CellIdentifier = @"ViewControllerCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:17];
    }
    cell.textLabel.text = _infoList[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate withTitle: colorType
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    UIViewController *pushVC = nil;
    if (row == 0)
        pushVC = [[X_PassValueStyleVC alloc] init];
    else if (row == 1)
        pushVC = [[X_GestureViewVC alloc] init];
    else if (row == 2)
        pushVC = [[X_CommonPageVC alloc] init];
    
    if (pushVC) {
        [self.navigationController pushViewController:pushVC animated:YES];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
