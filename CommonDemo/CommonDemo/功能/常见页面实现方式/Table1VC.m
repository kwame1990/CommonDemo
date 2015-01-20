//
//  Table1VC.m
//  PathDemo
//
//  Created by JiWei.Xiong on 14-7-3.
//  Copyright (c) 2014年 Transn. All rights reserved.
//

#import "Table1VC.h"

#define kImageHight 170
#define kImageWidth CGRectGetWidth(self.view.bounds)

@interface Table1VC () {
    UIImageView *_myImageView;
}

@end

@implementation Table1VC

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.title = @"Table1";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView.contentInset = UIEdgeInsetsMake(kImageHight, 0, 0, 0);
    
    _myImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -kImageHight, kImageWidth, kImageHight)];
    _myImageView.image = [UIImage imageNamed:@"image.jpg"];
    [self.tableView addSubview:_myImageView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
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
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Table1VCCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = @"test";
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    return;
}

#pragma mark - UIScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat yOffset  = scrollView.contentOffset.y;
    if (yOffset < -kImageHight) {
        CGRect f = _myImageView.frame;
        f.origin.y = yOffset;
        f.size.height =  -yOffset;
        
        CGFloat factor = ((ABS(-yOffset-kImageHight) + kImageHight)*kImageWidth)/kImageHight;
        f.origin.x = -(factor-kImageWidth)/2;
        f.size.width = factor;
        _myImageView.frame = f;
        
    }
 
}

@end
