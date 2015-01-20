//
//  X_PathButtonVC.m
//  CommonDemo
//
//  Created by xiongjw on 14-7-15.
//  Copyright (c) 2014年 xiongjw. All rights reserved.
//

#import "X_PathButtonVC.h"

#import "Constans.h"
#import "QuadCurveMenu.h"

@interface X_PathButtonVC () <QuadCurveMenuDelegate>

@end

@implementation X_PathButtonVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (NSArray *)getMenu {
    UIImage *normalItem = [UIImage imageNamed:@"bg-menuitem.png"];
    UIImage *pressedItem = [UIImage imageNamed:@"bg-menuitem-highlighted.png"];
    
    NSMutableArray *menuArray = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i < 6; i++) {
        QuadCurveMenuItem *menu = [[QuadCurveMenuItem alloc] initWithImage:normalItem
                                                          highlightedImage:pressedItem
                                                              ContentImage:[UIImage imageNamed:@"icon-star.png"]
                                                   highlightedContentImage:nil];
        [menuArray addObject:menu];
    }
    return [NSArray arrayWithArray:menuArray];
}

- (void)loadInitVariable {
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.title = @"Path按钮效果";
    self.view.backgroundColor = CYBackgroundColor;
    
    QuadCurveMenu *menu = [[QuadCurveMenu alloc] initWithFrame:self.view.frame menus:[self getMenu]];
    menu.delegate = self;
    [self.view addSubview:menu];
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

#pragma mark - QuadCurveMenu delegate
- (void)quadCurveMenu:(QuadCurveMenu *)menu didSelectIndex:(NSInteger)idx
{
    NSLog(@"Select the index : %d",idx);
}

@end
