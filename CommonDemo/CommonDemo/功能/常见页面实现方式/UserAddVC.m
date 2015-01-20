//
//  UserAddVC.m
//  TestDemo
//
//  Created by Xiong JiWei on 14-1-3.
//  Copyright (c) 2014年 Xiong JiWei. All rights reserved.
//

#import "UserAddVC.h"

#import "User.h"

@interface UserAddVC ()

@property (nonatomic,retain) IBOutlet UITextField *nameField;
@property (nonatomic,retain) IBOutlet UITextField *ageField;

@end

@implementation UserAddVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)commit:(id)sender {
    if ([_nameField.text length] == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"请输入您的姓名"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles: nil];
        [alert show];
        return;
    }
    
    if ([_ageField.text length] == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"请输入您的年龄"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles: nil];
        [alert show];
        return;
    }
    
    User *user = [[User alloc] init];
    user.name = _nameField.text;
    user.age = [_ageField.text integerValue];
    
    // 插入到数据库
    if ([user insertToDb]) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"添加用户失败"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles: nil];
        [alert show];
    }
}

- (void)textFieldShouldReturn:(id)sender {
    if (sender == _nameField) {
        [_ageField becomeFirstResponder];
    }
    else {
        [_ageField resignFirstResponder];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [_nameField addTarget:self action:@selector(textFieldShouldReturn:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [_ageField  addTarget:self action:@selector(textFieldShouldReturn:) forControlEvents:UIControlEventEditingDidEndOnExit];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
