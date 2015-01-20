//
//  AwardVC.m
//  PageDemo
//
//  Created by xiongjw on 14-7-23.
//  Copyright (c) 2014年 xiongjw. All rights reserved.
//

#import "AwardVC.h"

#define COLOR(r,g,b)    [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

@interface AwardVC () {
    UIImageView *imageView;
    float random;
    float orign;
    UIButton *_clickBtn;
}

@end

@implementation AwardVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (float)getNewRandom:(float)ran {
    
    NSString *s = [NSString stringWithFormat:@"%.1f",ran];
    
    if ( [@"0.1" isEqualToString:s] || [@"0.3" isEqualToString:s]
      || [@"0.5" isEqualToString:s] || [@"0.7" isEqualToString:s]
      || [@"0.9" isEqualToString:s] || [@"1.1" isEqualToString:s]
      || [@"1.3" isEqualToString:s] || [@"1.5" isEqualToString:s]
      || [@"1.7" isEqualToString:s] || [@"1.9" isEqualToString:s] )
    {
        float r = [[NSString stringWithFormat:@"%.1f",ran] floatValue];
        r -= 0.1;
        return r;
    }
    else {
        return ran;
    }
    
}

//type = 1则随机奖(不可能是特等奖和再来一次)，type＝2，则是再来一次,type=3,随机，所有奖都有可能
- (void)animationStart:(NSString *)type {
    //不希望重复点击，影响效果
    _clickBtn.enabled = NO;
    
    //产生随机角度
    srand((unsigned)time(0));  //不加这句每次产生的随机数不变
    random = (rand() % 20) / 10.0;
    //使指针处在正中间
    random = [self getNewRandom:random];
    if ([type integerValue] == 1) {
        float s = 10.0 + random + orign;
        s = fmodf(s, 2.0);
        //不让特等奖出现
        if (s >= -0.1  && s <=0.1) {
            orign += 0.2;
        }
        //不出现再来一次
        else if (s >= 1.1 && s <=1.3) {
            orign -= 0.2;
        }
    }
    //每次都是再来一次
    else if ([type integerValue] == 2) {
        random = 1.2 - orign;
    }
    //设置动画
    CABasicAnimation *spin = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    [spin setFromValue:[NSNumber numberWithFloat:M_PI * (0.0 + orign)]];
    [spin setToValue:[NSNumber numberWithFloat:M_PI * (10.0 + random + orign)]];
    [spin setDuration:2.5];
    [spin setDelegate:self];
    //速度控制器
    [spin setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    //添加动画
    [[imageView layer] addAnimation:spin forKey:nil];
    //锁定结束位置
    imageView.transform = CGAffineTransformMakeRotation(M_PI * (10.0+random+orign));
    //锁定fromValue的位置
    orign = 10.0 + random + orign;
    orign = fmodf(orign, 2.0);
}

- (void)choujiang {
    [self animationStart:@"2"];
}

- (void)loadInitVariable {
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]){
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.title = @"抽奖";
    self.view.backgroundColor = COLOR(240.0, 240.0, 245.0);
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, 300, 20)];
    [label setText:@"每天免费抽奖1次,再次抽奖每次消耗0.12元"];
    label.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:label];
    
    imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 60, 280, 280)];
    [imageView setImage:[UIImage imageNamed:@"turntable"]];
    [self.view addSubview:imageView];

    _clickBtn = [[UIButton alloc] initWithFrame:CGRectMake(95,150, 110, 110)];
    [_clickBtn setBackgroundImage:[UIImage imageNamed:@"buttonnormal"] forState:UIControlStateNormal];
    [_clickBtn setBackgroundImage:[UIImage imageNamed:@"buttonselect"] forState:UIControlStateHighlighted];
    [_clickBtn addTarget:self action:@selector(choujiang) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_clickBtn];
    
    [self performSelector:@selector(animationStart:) withObject:@"1"];
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

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    //动画结束，button恢复点击
    _clickBtn.enabled = YES;
    
    //判断抽奖结果，数组顺序(从手机开始，逆时针)
    NSArray *arr = @[@"智能手机一部",@"8分钟",@"2分钟",@"5分钟",@"8分钟",@"20分钟",@"再来一次",@"2分钟",@"10分钟",@"5分钟"];
    
    int row = -1;
    if (orign >= -0.1 && orign < 0.1)       row = 0;
    else if (orign >= 0.1 && orign < 0.3)   row = 1;
    else if (orign >= 0.3 && orign < 0.5)   row = 2;
    else if (orign >= 0.5 && orign < 0.7)   row = 3;
    else if (orign >= 0.7 && orign < 0.9)   row = 4;
    else if (orign >= 0.9 && orign < 1.1)   row = 5;
    else if (orign >= 1.1 && orign < 1.3)   row = 6;
    else if (orign >= 1.3 && orign < 1.5)   row = 7;
    else if (orign >= 1.5 && orign < 1.7)   row = 8;
    else if (orign >= 1.7 && orign < 1.9)   row = 9;
    
    UIAlertView *result = [[UIAlertView alloc] initWithTitle:@"提示"
                                                     message:arr[row]
                                                    delegate:self
                                           cancelButtonTitle:@"确定"
                                           otherButtonTitles: nil];
    [result show];
}
@end
