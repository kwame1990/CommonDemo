//
//  X_SearchTableVC.m
//  CommonDemo
//
//  Created by xiongjw on 14-7-15.
//  Copyright (c) 2014年 xiongjw. All rights reserved.
//

#import "X_SearchTableVC.h"

#import "Constans.h"

@interface X_SearchTableVC () <UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate> {
    UITableView *_myTable;
    UITextField *_myField;
    
    NSArray *_allList;
    NSMutableArray *_infoList;
}

@end

@implementation X_SearchTableVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (NSMutableArray *)getNewArray :(NSString *)str {
    NSMutableArray *mutArray = [NSMutableArray arrayWithCapacity:0];
    for (NSString *item in _allList) {
        if ([item hasPrefix:str]) {
            [mutArray addObject:item];
        }
    }
    return mutArray;
}

- (void)loadInitVariable {
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.title = @"常见页面";
    self.view.backgroundColor = CYBackgroundColor;
    
    _myField = [[UITextField alloc] initWithFrame:CGRectMake(0, 5, CGRectGetWidth(self.view.bounds), 35)];
    _myField.placeholder = @"🔍以字母i开头搜索";
    _myField.delegate = self;
    _myField.borderStyle = UITextBorderStyleRoundedRect;
    _myField.returnKeyType = UIReturnKeyDone;
    _myField.keyboardType = UIKeyboardTypeDefault;
    [self.view addSubview:_myField];
    
    _myTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, CGRectGetWidth(self.view.bounds), CGRectGetHeight([[UIScreen mainScreen] bounds]) -64-40) style:UITableViewStylePlain];
    _myTable.delegate = self;
    _myTable.dataSource = self;
    _myTable.backgroundColor = CYBackgroundColor;
    [_myTable setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    [self.view addSubview:_myTable];
    
    _allList = @[@"i love you",@"i miss you",@"ios7.0.6",@"ios7",
                 @"ios7.0.4完美越狱",@"ios7.1",@"ios7越狱",
                 @"ios7.0.5",@"ios7完美越狱",@"ios7.06",
                 @"ios7.0.6完美越狱",@"ios7.0.4"];
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
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return _infoList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = _infoList[indexPath.row];
    return cell;
}

#pragma mark - UITextField delegate

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    NSString *candidateString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    _infoList = [self getNewArray:[candidateString lowercaseString]];
    [_myTable reloadData];
    return YES;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [_myField resignFirstResponder];
    return YES;
}

@end
