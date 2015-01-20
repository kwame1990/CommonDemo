//
//  X_NextTextFieldVC.m
//  CommonDemo
//
//  Created by xiongjw on 14-7-15.
//  Copyright (c) 2014年 xiongjw. All rights reserved.
//

#import "X_NextTextFieldVC.h"

#import "Constans.h"

@interface X_NextTextFieldVC () <UITextFieldDelegate> {
    UITextField *myField1;
    UITextField *myField2;
    UITextField *myField3;
    UITextField *myField4;
}

@end

@implementation X_NextTextFieldVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)fieldShouldReturn:(id)sender {
    if (sender == myField1) {
        [myField2 becomeFirstResponder];
    }
    else if (sender == myField2) {
        [myField3 becomeFirstResponder];
    }
    else if (sender == myField3) {
        [myField4 becomeFirstResponder];
    }
    else {
        [myField4 resignFirstResponder];
    }
}

- (UITextField *)createField:(CGRect)frame {
    UITextField *_myField = [[UITextField alloc] initWithFrame:frame];
    _myField.borderStyle = UITextBorderStyleRoundedRect;
    _myField.returnKeyType = UIReturnKeyNext;
    _myField.keyboardType = UIKeyboardTypeDefault;
    
    return _myField;
}

- (void)loadInitVariable {
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.title = @"TextField";
    self.view.backgroundColor = CYBackgroundColor;
    
    myField1 = [self createField:CGRectMake(0, 5, CGRectGetWidth(self.view.bounds), 30)];
    [self.view addSubview:myField1];
    
    myField2 = [self createField:CGRectMake(0, 40, CGRectGetWidth(self.view.bounds), 30)];
    [self.view addSubview:myField2];
    
    myField3 = [self createField:CGRectMake(0, 75, CGRectGetWidth(self.view.bounds), 30)];
    [self.view addSubview:myField3];
    
    myField4 = [self createField:CGRectMake(0, 110, CGRectGetWidth(self.view.bounds), 30)];
    myField4.returnKeyType = UIReturnKeyDone;
    [self.view addSubview:myField4];
 
    [myField1 addTarget:self action:@selector(fieldShouldReturn:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [myField2 addTarget:self action:@selector(fieldShouldReturn:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [myField3 addTarget:self action:@selector(fieldShouldReturn:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [myField4 addTarget:self action:@selector(fieldShouldReturn:) forControlEvents:UIControlEventEditingDidEndOnExit];
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


@end
