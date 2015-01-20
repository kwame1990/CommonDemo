//
//  X_CommonPageVC.m
//  CommonDemo
//
//  Created by xiongjw on 14-7-10.
//  Copyright (c) 2014年 xiongjw. All rights reserved.
//

#import "X_CommonPageVC.h"

#import "Constans.h"

#import "X_TabChangeVC.h"
#import "X_PathButtonVC.h"
#import "X_WebViewLocalVC.h"
#import "X_ShowMoreDataVC.h"
#import "X_MoreButtonTableVC.h"
#import "X_SearchTableVC.h"
#import "X_NextTextFieldVC.h"

#import "X_UserListVC.h"
#import "AwardVC.h"
#import "Table1VC.h"

@interface X_CommonPageVC () {
    NSArray *_infoList;
}

@end

@implementation X_CommonPageVC

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    }
    return self;
}

- (void)loadInitVariable {
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.title = @"常见页面";
    self.view.backgroundColor = CYBackgroundColor;
    
    _infoList = @[@"tab切换",@"path按钮效果",@"本地js",@"大数据展现",@"1行3个button",@"搜索匹配",@"textField",@"数据库",@"旋转抽奖",@"下拉放大"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
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
    if (row == 0) {
        pushVC = [[X_TabChangeVC alloc] init];
    }
    else if (row == 1) {
        pushVC = [[X_PathButtonVC alloc] init];
    }
    else if (row == 2) {
        pushVC = [[X_WebViewLocalVC alloc] init];
    }
    else if (row == 3) {
        pushVC = [[X_ShowMoreDataVC alloc] init];
    }
    else if (row == 4) {
        pushVC = [[X_MoreButtonTableVC alloc] init];
    }
    else if (row == 5) {
        pushVC = [[X_SearchTableVC alloc] init];
    }
    else if (row == 6) {
        pushVC = [[X_NextTextFieldVC alloc] init];
    }
    else if (row == 7) {
        pushVC = [[X_UserListVC alloc] initWithStyle:UITableViewStylePlain];
    }
    else if (row == 8) {
        pushVC = [[AwardVC alloc] init];
    }
    else if (row == 9) {
        pushVC = [[Table1VC alloc] initWithStyle:UITableViewStylePlain];
    }
    [self.navigationController pushViewController:pushVC animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
