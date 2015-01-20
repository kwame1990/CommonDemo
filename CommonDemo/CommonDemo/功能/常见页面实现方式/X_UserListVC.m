//
//  X_UserListVC.m
//  CommonDemo
//
//  Created by xiongjw on 14-7-15.
//  Copyright (c) 2014年 xiongjw. All rights reserved.
//

#import "X_UserListVC.h"

#import "Constans.h"

#import "UserAddVC.h"
#import "UserUpdateVC.h"

#import "User.h"
//#import <STDbKit/STDbKit.h>
#import "STDb.h"
#import "NSDate+Exts.h"

@interface X_UserListVC ()

@property (nonatomic , assign) NSInteger selectedRow;
@property (nonatomic , strong) NSMutableArray *userList;

@end

@implementation X_UserListVC

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)AddAction {
    UserAddVC *push = [[UserAddVC alloc] initWithNibName:@"UserAddVC" bundle:nil];
    [self.navigationController pushViewController:push animated:YES];
}

- (void)loadInitVariable {
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.title = @"列表";
    self.view.backgroundColor = CYBackgroundColor;
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(AddAction)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    //self.tableView.editing = YES;
    
    // 导入数据库数据; 如果不需要从外部导入，不做处理
    //    [STDb importDb:@"user.db"];
    
    // 添加默认用户
    if (![User existDbObjectsWhere:@"_id=0"]) {
        // 初始化
        User *user = [[User alloc] init];
        user._id = 0;
        user.name = @"admin";
        user.age = 26;
        user.sex = @(kSexTypeMale);
        
        user.phone = @"10086";
        user.email = @"863629377@qq.com";
        
        UIImage *image = [UIImage imageNamed:@"4"];
        user.image = UIImagePNGRepresentation(image);
        user.birthday = [NSDate dateWithDateString:@"1987-01-01"];
        user.info = @{@"name": @"xuezhang"};
        user.favs = @[@"桌球、羽毛球"];
        // 插入到数据库
        [user insertToDb];
    }
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadInitVariable];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    _userList = [User allDbObjects];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return _userList.count;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _selectedRow = [indexPath row];
    return indexPath;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = [indexPath row];
    return row != 0;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSInteger row = [indexPath row];
        
        // 要删除的数据
        User *user = _userList[row];
        // 从数据库中删除数据
        if ([user removeFromDb]) {
            // 数据库数据删除成功
            
            [tableView beginUpdates];
            
            // 删除数据源中的数据
            [_userList removeObjectAtIndex:row];
            
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            [tableView endUpdates];
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"X_UserListVCCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    NSInteger row = [indexPath row];
    User *user = _userList[row];
    cell.textLabel.text = [NSString stringWithFormat:@"姓名：%@",user.name];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"年龄：%d",user.age];
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserUpdateVC *push = [[UserUpdateVC alloc] initWithNibName:@"UserUpdateVC" bundle:nil];
    push.user = _userList[indexPath.row];
    [self.navigationController pushViewController:push animated:YES];
}

@end
