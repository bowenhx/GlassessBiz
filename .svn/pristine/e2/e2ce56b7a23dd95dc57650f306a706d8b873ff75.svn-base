//
//  BaseViewController.m
//  BloodPressure
//
//  Created by Guibin on 14-5-9.
//  Copyright (c) 2014年 深圳呱呱网络科技有限公司. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void) loadView{
    [super loadView];
    self.view.backgroundColor = [SavaData getColor:@"dcdddd" alpha:1.f];
    if (iOS7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
         [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    }
    
//    [self.navigationItem setHidesBackButton:YES];
    
//    if (iPhone5) {
//        <#statements#>
//    }

    //导航条标题
    _labTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    _labTitle.font = [UIFont boldSystemFontOfSize:18];
    _labTitle.backgroundColor = [UIColor clearColor];
    _labTitle.textColor = [SavaData getColor:@"004861" alpha:1.f];
    _labTitle.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = _labTitle;
    
    
    //返回按钮
    UIImage *backImage = [UIImage imageNamed: @"def_iv_return"];
    _backBtn = [UIButton buttonWithType: UIButtonTypeCustom];
    _backBtn.frame = CGRectMake(0, 0, backImage.size.width, backImage.size.height);
    [_backBtn setImage: backImage forState: UIControlStateNormal];
    [_backBtn addTarget: self action: @selector(tapBackBtn) forControlEvents: UIControlEventTouchUpInside];
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithCustomView: _backBtn];
    left.style = UIBarButtonItemStylePlain;
    left.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = left;
 
    
    //右按钮
    _rightbtn = [UIButton buttonWithType: UIButtonTypeCustom];
    _rightbtn.frame = CGRectMake(0, 0, 60, 44);
    _rightbtn.hidden = YES;
    _rightbtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [_rightbtn addTarget: self action: @selector(tapRightBtn) forControlEvents: UIControlEventTouchUpInside];
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView: _rightbtn];
    right.style = UIBarButtonItemStylePlain;
    self.navigationItem.rightBarButtonItem = right;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view.
}

//点击右按钮
- (void)tapRightBtn{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)tapBackBtn{
    [self.navigationController popViewControllerAnimated: YES];
}
- (void)setTitleImageName:(NSString *)titleImageName{
    UIImageView *titleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:titleImageName]];
    [self.navigationItem setTitleView:titleImageView];
}
- (void)setTitle:(NSString *)title{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 220, 44)];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setText:title];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setFont:[UIFont systemFontOfSize:18.0]];
    [label setTextColor:[UIColor whiteColor]];
    [self.navigationItem setTitleView:label];
}

//判断字符串是否为空
- (BOOL)isTextContentBlank:(NSString *)str {
    if (str == nil && [str length] == 0)return YES;
    if ([str isEqual:[NSNull null]]) return YES;
    if ([[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""]) return YES;
    return NO;
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
