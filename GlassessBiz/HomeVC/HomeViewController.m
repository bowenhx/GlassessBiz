//
//  HomeViewController.m
//  GlassessBiz
//
//  Created by Guibin on 14-5-14.
//  Copyright (c) 2014年 深圳呱呱网络科技有限公司. All rights reserved.
//
#import "objc/runtime.h"
#import "HomeViewController.h"
#import "UIImageView+WebCache.h"
#import "DetailsViewController.h"
#import "OfferViewController.h"
#import "UserCenterViewController.h"
#import "GDIInfinitePageScrollViewController.h"
#import "ImageViewController.h"

static char valueScrollVCkey;



@interface HomeViewController ()<UIScrollViewDelegate>
{
    IBOutlet UIButton *_btnChemistry;
    IBOutlet UIButton *_btnStuff;
    
    IBOutlet UIScrollView *_scrollView;
    
    NSMutableArray      *_arrData;
    
    NSInteger           _countNum;
    NSInteger           _pageNum;
    NSTimer     *_timer;
}


@end

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _arrData = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.labTitle.text = IsEnglish ? @"Precision Eyewear Testing & Inspection" : @"精科检测";
    self.backBtn.hidden = YES;
    
    
    _pageNum = 0;
    
//    _scrollView.userInteractionEnabled = YES;
    
    _scrollView.hidden = YES;
    
    [self initShowView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closeTimer) name:CloseNSTimerNSNotificationCenter object:nil];
}
- (void)initShowView
{
    self.rightbtn.hidden = NO;
    [self.rightbtn setImage:[UIImage imageNamed:@"home_iv_right"] forState:UIControlStateNormal];
    
    if (iPhone5 == NO) {
        CGRect btnFrame1 = _btnChemistry.frame;
        btnFrame1.origin.y -= 88;
        _btnChemistry.frame = btnFrame1;
        
        _btnStuff.frame = CGRectMake(_btnStuff.frame.origin.x, _btnChemistry.frame.origin.y, _btnStuff.frame.size.width, _btnStuff.frame.size.height);
        
        CGRect scrllViewFrame = _scrollView.frame;
        scrllViewFrame.size.height -= 87;
        _scrollView.frame = scrllViewFrame;
//        _scrollView.layer.borderWidth = 1;
//        _scrollView.layer.borderColor = [UIColor redColor].CGColor;
    }
    
    
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    if (_arrData.count ==0) {
         [self initLoadData];
    }
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}
- (void)initLoadData
{
   
    [self.view addHUDActivityView:Loading];
    
    [[Connection shareInstance] requestWithParams:nil withURL:Api_MainUrl withType:GET completed:^(id content, ResponseType responseType) {
        [self.view removeHUDActivityView];
        
        if (responseType == SUCCESS)
        {
             [_arrData setArray:content[@"data"][@"list"]];
            
            [self showImageView:_arrData];
            LOG(@"data = %@",content[@"data"]);
            
        } else if (responseType == FAIL) {
            [self.view addHUDLabelView:content Image:nil afterDelay:2.0f];
        }
        
    }];
}
- (void)showImageView:(NSArray *)arrData
{
    if (arrData.count == 0) {
        return;
    }
    
    
    _countNum = arrData.count;
//    _scrollView.contentSize = CGSizeMake(WIDTH(_scrollView)*_countNum, HEIGHT(_scrollView));
    
    NSMutableArray *arrImage = [NSMutableArray array];
    
    for (int i=0;i<_countNum;i++) {
        ImageViewController *imageVC = [[ImageViewController alloc] init];
        imageVC.view.backgroundColor = [UIColor clearColor];
        
        UIImageView *imageVg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,WIDTH(_scrollView), HEIGHT(_scrollView))];//WIDTH(_scrollView)*i
        imageVg.userInteractionEnabled = YES;
        NSURL *url = [NSURL URLWithString:arrData[i][@"image"]];
        [imageVg sd_setImageWithURL:url placeholderImage:nil];
        UIButton *btnImage = [UIButton buttonWithType:UIButtonTypeCustom];
        btnImage.frame = CGRectMake(0, 0, WIDTH(_scrollView), HEIGHT(_scrollView));
        btnImage.tag = i;
        [imageVg addSubview:btnImage];
        [btnImage addTarget:self action:@selector(selectImageView:) forControlEvents:UIControlEventTouchUpInside];
//        imageVg.layer.borderColor = [UIColor grayColor].CGColor;
//        imageVg.layer.borderWidth = 1;
//        imageVg.backgroundColor = [UIColor yellowColor];
        
        [imageVC.view addSubview:imageVg];
        [arrImage addObject:imageVC];
    }
    
    GDIInfinitePageScrollViewController *infiniteScrollerVC = [[GDIInfinitePageScrollViewController alloc] initWithViewControllers:arrImage];
    [infiniteScrollerVC.view setFrame:_scrollView.frame];
//    self.infiniteScrollerVC.view.layer.borderWidth = 1;
//    self.infiniteScrollerVC.view.layer.borderColor = [UIColor redColor].CGColor;

    objc_setAssociatedObject(self, &valueScrollVCkey, infiniteScrollerVC, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self.view addSubview:infiniteScrollerVC.view];
    
    
    if (_countNum>0) {
        [self initTimerChange];
    }
   
}
- (void)initTimerChange
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.5f target:self                                                                                                                                                                                                                                                                            selector:@selector(changeImage:) userInfo:nil repeats:YES];
    [_timer fire];
}
- (void)changeImage:(NSTimer *)time
{
    GDIInfinitePageScrollViewController *infiniteScrollView = objc_getAssociatedObject(self, &valueScrollVCkey);
    if (_pageNum == _countNum)
    {
        [infiniteScrollView setCurrentPageIndex:_pageNum];
         _pageNum = 0;
    }else
    {
        
     [infiniteScrollView setCurrentPageIndex:_pageNum];
    _pageNum ++;
    }
    
}
- (void)closeTimer
{
    [_timer invalidate];
}
#pragma mark ScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
//    CGFloat pageViewWidth = scrollView.frame.size.width;
//    int page = floor((scrollView.contentOffset.x - pageViewWidth / 2) / pageViewWidth) + 1;
    
}
- (void)selectImageView:(UIButton *)btn
{
    DetailsViewController *detailsVC = [[DetailsViewController alloc] initWithNibName:isPad? @"DetailsViewController-ipad":@"DetailsViewController" bundle:nil];
    detailsVC.dicData = _arrData[btn.tag];
    detailsVC.contentType = 0;
    [self.navigationController pushViewController:detailsVC animated:YES];
    
}
- (IBAction)selectGlassessAction:(UIButton *)sender {
    
     [self pushOfferViewController:0];
}

- (IBAction)selectGlassessClassAction:(UIButton *)sender {
    [self pushOfferViewController:0];
}
- (IBAction)didSelectChemistryAction:(UIButton *)sender{
    [self pushOfferViewController:1];
}
- (IBAction)didSelectMaterialAction:(UIButton *)sender {
    [self pushOfferViewController:2];
}

- (void)pushOfferViewController:(int)index
{
    OfferViewController *offerVC = [[OfferViewController alloc] initWithNibName:isPad ? @"OfferViewController-ipad":@"OfferViewController" bundle:nil];
    offerVC.offerType = index;
    [self.navigationController pushViewController:offerVC animated:YES];
}
- (void)tapRightBtn
{
    UserCenterViewController *userCenterVC = [[UserCenterViewController alloc] initWithNibName:isPad? @"UserCenterViewController-ipad":@"UserCenterViewController" bundle:nil];
    [self.navigationController pushViewController:userCenterVC animated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
