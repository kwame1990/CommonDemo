//
//  X_LabelMoveVC.m
//  CommonDemo
//
//  Created by xiongjw on 14-7-15.
//  Copyright (c) 2014年 xiongjw. All rights reserved.
//

#import "X_LabelMoveVC.h"

#import "Constans.h"

@interface X_LabelMoveVC () {
    UILabel *_moveLable;
    CGFloat x;
}

@end

@implementation X_LabelMoveVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)labelStartAnimation {
    [UIView animateWithDuration:0.3f animations:^{
        _moveLable.hidden = NO;
        x -= 1;
        if (x == -1550) x = 320;
        _moveLable.frame = CGRectMake(x, 50, 1550, 20);
    }];
}

- (void)loadInitVariable {
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.title = @"文字移动";
    self.view.backgroundColor = CYBackgroundColor;
    
    NSString *str = @"流水潺潺，旧时光与新草依旧。又想起此时，已是绿瘦红肥时候。我倚在窗台，细数那些过往的流年，或伤悲，或欢喜；或微笑，或流泪。将那尘封的往事如烟，寄入这断续的丝雨。雨，落不尽愁肠，落尽...";
    CGSize size = [str sizeWithFont:[UIFont systemFontOfSize:17] forWidth:MAXFLOAT lineBreakMode:NSLineBreakByWordWrapping];
    
    _moveLable = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.bounds), 50, size.width, size.height)];
    [_moveLable setFont:[UIFont systemFontOfSize:17]];
    [_moveLable.layer setBorderWidth:1.f];
    [_moveLable.layer setCornerRadius:2.f];
    [_moveLable.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    //[_moveLable.layer setMasksToBounds:YES];
    _moveLable.text = str;
    _moveLable.hidden = YES;
    [self.view addSubview:_moveLable];
    
    x = 320;
    [NSTimer scheduledTimerWithTimeInterval:0.02
                                     target:self
                                   selector:@selector(labelStartAnimation)
                                   userInfo:nil
                                    repeats:YES];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
