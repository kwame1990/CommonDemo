//
//  X_Scroll+ImageVC.m
//  CommonDemo
//
//  Created by xiongjw on 14-7-15.
//  Copyright (c) 2014年 xiongjw. All rights reserved.
//

#import "X_Scroll+ImageVC.h"

#import "Constans.h"

@interface X_Scroll_ImageVC () <UIScrollViewDelegate> {
    UIScrollView *_scrView;
    UIImageView *_imageView;
}

@end

@implementation X_Scroll_ImageVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadInitVariable {
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.title = @"放大缩小图片";
    self.view.backgroundColor = [UIColor blackColor];
    
    _scrView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    _scrView.delegate = self;
    _scrView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    _scrView.minimumZoomScale = 1.0;
    _scrView.maximumZoomScale = 2.0;
    _scrView.multipleTouchEnabled = YES;
    _scrView.scrollEnabled = YES;
    _scrView.directionalLockEnabled = YES;
    _scrView.canCancelContentTouches = YES;
    _scrView.delaysContentTouches = YES;
    _scrView.clipsToBounds = YES;
    _scrView.alwaysBounceHorizontal = YES;
    _scrView.bounces = YES;
    _scrView.showsVerticalScrollIndicator = NO;
    _scrView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_scrView];
    
    UIImage *myImage = [UIImage imageNamed:@"1.png"];
    _imageView = [[UIImageView alloc] initWithImage:myImage];
    [_imageView setFrame:_scrView.frame];
    _imageView.opaque = YES;
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    _imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    [_scrView addSubview:_imageView];
    
    UITapGestureRecognizer* doubleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap)];
    doubleRecognizer.numberOfTapsRequired = 2; // 双击
    [_scrView addGestureRecognizer:doubleRecognizer];
    
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

#pragma mark -
#pragma mark === UIScrollView Delegate ===
#pragma mark -
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    
}
//ScrollView 划动的动画结束后调用.
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
}

//ScrollView缩放时候响应事件
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
	return _imageView;
}

//松开手指事件
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale {
	
	CGFloat zs = scrollView.zoomScale;
	zs = MAX(zs, 1.0);
	zs = MIN(zs, 2.0);
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.3];
	scrollView.zoomScale = zs;
	[UIView commitAnimations];
}

//增加双击扩大图片事件
- (void) handleDoubleTap {
    CGFloat zs = _scrView.zoomScale;
    zs = (zs == 1.0) ? 2.0 : 1.0;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    _scrView.zoomScale = zs;
    [UIView commitAnimations];
}

@end
