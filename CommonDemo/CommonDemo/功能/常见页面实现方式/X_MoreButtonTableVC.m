//
//  X_MoreButtonTableVC.m
//  CommonDemo
//
//  Created by xiongjw on 14-7-15.
//  Copyright (c) 2014年 xiongjw. All rights reserved.
//

#import "X_MoreButtonTableVC.h"

#import "Constans.h"
#import "X_TableCell.h"

@interface X_MoreButtonTableVC () {
     NSArray *_infoList;
}

@end

@implementation X_MoreButtonTableVC

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)callBtnClickBack:(NSNotification *)note {
    NSInteger tag = [[note object] integerValue];
    NSLog(@"点击第%d行第%d个",tag/3,tag%3);
}

- (void)loadInitVariable {
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.title = @"1行3个button";
    self.view.backgroundColor = CYBackgroundColor;
    
    _infoList = @[@"000.jpg",@"111.jpg",@"222.jpg",@"333.jpg",@"444.jpg",@"555.jpg",@"666.jpg",@"777.jpg",@"888.jpg",@"999.jpg"];
    //创建消息通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(callBtnClickBack:)
                                                 name:@"callBtnClickBack"
                                               object:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadInitVariable];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"callBtnClickBack" object:nil];
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
    return _infoList.count%3 == 0 ? _infoList.count/3 : _infoList.count/3 + 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 110.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *fier1 = @"X_MoreButtonTableVC";
    
    X_TableCell *cell = (X_TableCell *)[tableView dequeueReusableCellWithIdentifier:fier1];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"X_TableCell" owner:self options:nil] objectAtIndex:0];
    }
    [cell layoutCell:_infoList row:indexPath.row];
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    return;
}

@end
