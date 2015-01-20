//
//  UserUpdateVC.m
//  TestDemo
//
//  Created by Xiong JiWei on 14-1-3.
//  Copyright (c) 2014年 Xiong JiWei. All rights reserved.
//

#import "UserUpdateVC.h"

@interface UserUpdateVC ()

@property (nonatomic,retain) IBOutlet UITextField *nameField;
@property (nonatomic,retain) IBOutlet UITextField *ageField;

@end

@implementation UserUpdateVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)update:(id)sender {
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
    
    _user.name = _nameField.text;
    _user.age = [_ageField.text integerValue];
    //    UIImage *img = [UIImage imageNamed:@"1"];
    //    NSData *data = UIImageJPEGRepresentation(img, 1.0);
    //    _user.image = data;
    
    // 更新到数据库
    if ([_user updatetoDb]) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"修改信息失败"
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
    
    _nameField.text = _user.name;
    _ageField.text = [NSString stringWithFormat:@"%d", _user.age];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
