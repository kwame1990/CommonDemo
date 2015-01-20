//
//  X_ZbarMoveLineVC.m
//  CommonDemo
//
//  Created by xiongjw on 14-7-9.
//  Copyright (c) 2014年 xiongjw. All rights reserved.
//

#import "X_ZbarMoveLineVC.h"

#import "Constans.h"

@interface X_ZbarMoveLineVC () {
    UIImageView *_moveline;
    float _originY;
}

@end

@implementation X_ZbarMoveLineVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) timer {
    _originY ++;
    _moveline.frame = CGRectMake(17, _originY, 280, 10);
    //_moveline.hidden = NO;
    if (_originY == 40 + 280) _originY = 40;
}

- (void)loadInitVariable {
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.title = @"二维码扫描";
    self.view.backgroundColor = CYBackgroundColor;
    
    UIImage *img1 = [UIImage imageNamed:@"zxing_border.png"];
    UIImage *img2 = [UIImage imageNamed:@"zxing_line.png"];
    
    UIImageView *border = [[UIImageView alloc] initWithFrame:CGRectMake(17, 40, 285, 285)];
    border.image = img1;
    [self.view addSubview:border];
    
    _moveline = [[UIImageView alloc] initWithFrame:CGRectMake(17, 40, 280, 10)];
    _moveline.image = img2;
    //_moveline.hidden = YES;
    [self.view addSubview:_moveline];
    
    [NSTimer scheduledTimerWithTimeInterval:0.01f
                                     target:self
                                   selector:@selector(timer)
                                   userInfo:nil
                                    repeats:YES];
    
    _originY = 38;
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
