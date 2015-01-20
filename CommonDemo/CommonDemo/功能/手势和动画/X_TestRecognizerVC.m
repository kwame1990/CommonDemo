//
//  X_TestRecognizerVC.m
//  CommonDemo
//
//  Created by xiongjw on 14-7-15.
//  Copyright (c) 2014年 xiongjw. All rights reserved.
//

#import "X_TestRecognizerVC.h"

#import "Constans.h"

@interface X_TestRecognizerVC () {
    UILabel *_moveLabel;
}

@end

@implementation X_TestRecognizerVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

/*
 UITapGestureRecognizer         Tap（点击）
 UIPinchGestureRecognizer       Pinch（捏合）
 UIRotationGestureRecognizer    Rotation（旋转）
 UISwipeGestureRecognizer       Swipe（滑动，快速移动，是用于监测滑动的方向的）
 UIPanGestureRecognizer         Pan （拖移，慢速移动，是用于监测偏移的量的）
 UILongPressGestureRecognizer   LongPress（长按）
 */

- (void)handlePan:(UIPanGestureRecognizer*) recognizer
{
    NSLog(@"拖移，慢速移动");
    CGPoint translation = [recognizer translationInView:self.view];
    
    CGFloat x = recognizer.view.center.x + translation.x;
    CGFloat y = recognizer.view.center.y + translation.y;
    CGPoint point = CGPointMake(x, y);
    recognizer.view.center = point;
    [recognizer setTranslation:CGPointZero inView:self.view];
    
    _moveLabel.center = point;
}

-(void)SingleTap:(UITapGestureRecognizer*)recognizer
{
    //处理单击操作
    NSLog(@"单击");
}

-(void)DoubleTap:(UITapGestureRecognizer*)recognizer
{
    //处理双击操作
    NSLog(@"双击");
}

- (void) handlePinch:(UIPinchGestureRecognizer*) recognizer
{
    NSLog(@"捏合, %f", recognizer.scale);
    recognizer.view.transform = CGAffineTransformScale(recognizer.view.transform, recognizer.scale, recognizer.scale);
    recognizer.scale = 1;
}

- (void) handleRotate:(UIRotationGestureRecognizer*) recognizer
{
    NSLog(@"旋转, %f", recognizer.rotation);
    recognizer.view.transform = CGAffineTransformRotate(recognizer.view.transform, recognizer.rotation);
    recognizer.rotation = 0;
}

-(void)handleLongPress:(UILongPressGestureRecognizer*)recognizer
{
    //处理长按操作
    NSLog(@"长按, %f", recognizer.minimumPressDuration);
}

-(void)handleSwipe:(UISwipeGestureRecognizer*)recognizer
{
    //处理滑动操作
    NSLog(@"滑动，快速移动");
    CGPoint translation = [recognizer locationInView:self.view];
    NSLog(@"Swipe - start location: %f,%f", translation.x, translation.y);
    //recognizer.view.transform = CGAffineTransformMakeTranslation(translation.x, translation.y);
}

- (void)loadInitVariable {
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.title = @"手势＋动画";
    self.view.backgroundColor = CYBackgroundColor;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn setFrame:CGRectMake(50, 50, 100, 100)];
    [btn setBackgroundImage:[UIImage imageNamed:@"1.png"] forState:UIControlStateNormal];
    //如果在这里添加，button就被view压在下面了
    //[self.view addSubview:btn];
    
    // 1.拖移的Recognizer
    UIPanGestureRecognizer *panGesture;
    panGesture= [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [btn addGestureRecognizer:panGesture];
    
    UIView *tapView = [[UIView alloc] initWithFrame:CGRectMake(10, 50, 300, 300)];
    [tapView setBackgroundColor:[UIColor purpleColor]];
    [self.view addSubview:tapView];
    
    // 2.单击的 Recognizer
    UITapGestureRecognizer *singleTap;
    singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(SingleTap:)];
    singleTap.numberOfTapsRequired = 1; //单击
    //singleTap.numberOfTouchesRequired = 2;//点击的手指数
    [tapView addGestureRecognizer:singleTap];
    
    // 3.双击的 Recognizer
    UITapGestureRecognizer *doubleTap;
    doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(DoubleTap:)];
    doubleTap.numberOfTapsRequired = 2; // 双击
    [tapView addGestureRecognizer:doubleTap];
    
    // 关键在这一行，双击手势确定监测失败才会触发单击手势的相应操作
    [singleTap requireGestureRecognizerToFail:doubleTap];
    
    // 4.捏合的 Recognizer
    UIPinchGestureRecognizer *pinchGesture;
    pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinch:)];
    [tapView addGestureRecognizer:pinchGesture];
    
    // 5.旋转的 Recognizer
    UIRotationGestureRecognizer *rotateRecognizer;
    rotateRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(handleRotate:)];
    [tapView addGestureRecognizer:rotateRecognizer];
    
    // 6.长按的 Recognizer
    UILongPressGestureRecognizer *longPress;
    longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    [longPress setMinimumPressDuration:1.0];//设置长按时间间隔
    [tapView addGestureRecognizer:longPress];
    
    // 7.滑动的 Recognizer
    UISwipeGestureRecognizer *swipeRecognizer;
    swipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    [swipeRecognizer setDirection:UISwipeGestureRecognizerDirectionDown];//设置滑动方向
    [tapView addGestureRecognizer:swipeRecognizer];
    
    //最后添加，让button在最上层
    [self.view addSubview:btn];
    
    _moveLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 85, 100, 30)];
    _moveLabel.text = @"Code4App";
    _moveLabel.font = [UIFont boldSystemFontOfSize:17];
    _moveLabel.textColor = [UIColor redColor];
    _moveLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_moveLabel];
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
