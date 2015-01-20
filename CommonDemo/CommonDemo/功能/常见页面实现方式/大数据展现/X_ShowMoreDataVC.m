//
//  X_ShowMoreDataVC.m
//  CommonDemo
//
//  Created by xiongjw on 14-7-10.
//  Copyright (c) 2014年 xiongjw. All rights reserved.
//

#import "X_ShowMoreDataVC.h"

#import "Constans.h"

@interface X_ShowMoreDataVC () {
    NSMutableArray *_showInfoList;
    NSArray *_headViewList;
    
    NSInteger _selectedIndex;
}

@end

@implementation X_ShowMoreDataVC

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)clickAction {
    if (_selectedIndex == [_showInfoList count]) {
        return;
    }
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:_selectedIndex]
                          atScrollPosition:UITableViewScrollPositionTop
                                  animated:NO];
    _selectedIndex ++;
}

- (void)loadInitVariable {
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.title = @"大数据";
    self.view.backgroundColor = CYBackgroundColor;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"click" style:UIBarButtonItemStyleDone target:self action:@selector(clickAction)];
    
    _headViewList = [NSArray arrayWithObjects:
                     @"A",@"B",@"C",@"D",@"E",@"F",@"G",
                     @"H",@"I",@"J",@"K",@"L",@"M",@"N",
                     @"O",@"P",@"Q",@"R",@"S",@"T",
                     @"U",@"V",@"W",@"X",@"Y",@"Z",
                     nil];
    _showInfoList = [[NSMutableArray alloc] init];
    for (int i = 0; i < 26; i++) {
        NSMutableArray *temp = [[NSMutableArray alloc] init];
        for (int j = 0; j < 200; j++) {
            [temp addObject:[NSString stringWithFormat:@"%@%d",[_headViewList[i] lowercaseString],j]];
        }
        [_showInfoList addObject:temp];
    }
    
    _selectedIndex = 0;
    [self performSelector:@selector(clickAction) withObject:nil afterDelay:0];
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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return _showInfoList.count;
}

- (NSString *)tableView:(UITableView *)tableView  titleForHeaderInSection:(NSInteger)section
{
    NSString *k = _headViewList[section];
    if (k == UITableViewIndexSearch)
        return nil;
    return k;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSArray *arr = _showInfoList[section];
    return arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = _showInfoList[indexPath.section][indexPath.row];
    return cell;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return _headViewList;
}

- (NSInteger)tableView:(UITableView *)tableView  sectionForSectionIndexTitle:(NSString *)title
               atIndex:(NSInteger)index
{
    NSString *k = _headViewList[index];
    if (k == UITableViewIndexSearch)
    {
        [tableView setContentOffset:CGPointZero animated:NO];
        return NSNotFound;
    }
    else return index;
    
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    return;
}

@end
