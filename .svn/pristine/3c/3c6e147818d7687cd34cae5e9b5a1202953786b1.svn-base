//
//  DetailsViewController.m
//  GlassessBiz
//
//  Created by Guibin on 14-5-21.
//  Copyright (c) 2014年 深圳呱呱网络科技有限公司. All rights reserved.
//

#import "DetailsViewController.h"

@interface DetailsViewController ()
{
    
//    __weak IBOutlet UIScrollView *_scrollViewBg;
    
//    IBOutlet UIButton *_btnNum;
    IBOutlet UILabel *_labText;
    __weak IBOutlet UILabel *_labTitle;
    __weak IBOutlet UILabel *_labTitme;
    
    NSMutableArray      *_arrIDCode;
    
//    __weak IBOutlet UIWebView *_webView;
    UIWebView           *_webView;
    
}
@property (nonatomic, assign) BOOL copyingEnabled; // Defaults to YES
@property (nonatomic, assign) UIMenuControllerArrowDirection copyMenuArrowDirection; // Defaults to UIMenuControllerArrowDefault
@end

@implementation DetailsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _dicData = [NSDictionary dictionary];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (_contentType == 0) {
        self.labTitle.text = IsEnglish ? @"Activity details": @"活动详情";
        _labText.hidden = YES;
        
        [self initLoadData];
    }else{
        self.labTitle.text = IsEnglish ? @"Push details": @"推送详情";
    }
    
    
    if (_dicData.allKeys.count>0) {
        _labTitle.text = _dicData[@"title"];
        _labText.text = _dicData[@"content"];
        _labTitme.text = _dicData[@"formattime"];
        
        CGRect labFrame = _labText.frame;
        labFrame.size.height = [self labTextHeight:_dicData[@"content"]];
        _labText.frame = labFrame;

        
//        _scrollViewBg.contentSize = CGSizeMake(WIDTH(_scrollViewBg), HEIGHT(_labText)+50);
    }
    
//    if (!iPhone5) {
//        CGRect btnFrame = _btnNum.frame;
//        btnFrame.origin.y = HEIGHT(self.view) -(iOS7 ? 44:64);
//        _btnNum.frame = btnFrame;
//        
//    }
    
    
    _copyMenuArrowDirection = UIMenuControllerArrowDefault;
    _copyingEnabled = YES;
    
   
}

- (CGFloat)labTextHeight:(NSString *)str
{
    CGSize size =[str sizeWithFont:[UIFont systemFontOfSize:13.0f] constrainedToSize:CGSizeMake(295, 3000) lineBreakMode:NSLineBreakByWordWrapping];
    return size.height<20 ? 26 : size.height+25;
}
- (void)initLoadData
{
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, WIDTH(self.view), CommonMinusNavHeight(self.view))];

    float flo = [[UIScreen mainScreen] currentMode].size.height;
    if (flo <1136) {
        _webView.frame = CGRectMake(0, 0, WIDTH(self.view), SCREEN_HEIGHT-64);
    }
//    [_webView sizeToFit];
    [_webView setScalesPageToFit:YES];
    _webView.autoresizesSubviews = YES;
//    _webView.layer.borderWidth = 2;
//    _webView.layer.borderColor = [UIColor redColor].CGColor;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@?id=%@",BASE_REQUEST_URL,Api_AvDetail,_dicData[@"id"]]];
   
    [_webView loadRequest:[NSURLRequest requestWithURL:url]];
    
    [self.view addSubview:_webView];
    
    
//    _arrIDCode = [[NSMutableArray alloc] initWithArray:[SavaData parseArrFromFile:User_avCode]];
//    if (_arrIDCode.count >0) {
//        NSInteger codeId = [_dicData[@"id"] integerValue];
//        [_arrIDCode enumerateObjectsUsingBlock:^(NSArray *arr , NSUInteger index, BOOL *stop){
//            if (codeId == [arr[0] integerValue]) {
//                [_btnNum setBackgroundImage:[UIImage imageNamed:@"login_btn_Landed_unpressed.png"] forState:UIControlStateNormal];
//                [_btnNum setTitle:arr[1] forState:UIControlStateNormal];
//            }
//            
//        }];
//       
//    }
}
- (IBAction)gainCodeNum:(UIButton *)sender
{
    if ([sender.titleLabel.text isEqualToString:@"获取活动兑换码"]) {
        [self.view addHUDActivityView:@"正在加载..."];
        
        LOG(@"id = %@",_dicData[@"id"]);
        [[Connection shareInstance] requestWithParams:[NSMutableDictionary dictionaryWithDictionary:@{@"id":_dicData[@"id"]}] withURL:Api_AvDetail  withType:POST completed:^(id content, ResponseType responseType) {
            [self.view removeHUDActivityView];
            
            if (responseType == SUCCESS)
            {
                
                LOG(@"data = %@",content[@"data"]);
                //            [sender setTitle:content forState:UIControlStateNormal];
                
                NSString *title = content[@"data"][@"wayFirst"][@"cdkey"];
                [sender setBackgroundImage:[UIImage imageNamed:@"login_btn_Landed_unpressed.png"] forState:UIControlStateNormal];
                [sender setTitle:title forState:UIControlStateNormal];
                
                NSArray *arrId = @[_dicData[@"id"],title];
                
                [_arrIDCode addObject:arrId];
                [SavaData writeArrToFile:_arrIDCode FileName:User_avCode];
                
            } else if (responseType == FAIL) {
                [self.view addHUDLabelView:content Image:nil afterDelay:2.0f];
            }
            
        }];
    }else{
        NSAssert([self becomeFirstResponder], @"Sorry, UIMenuController will not work with %@ since it cannot become first responder", self);
        
        UIMenuController *copyMenu = [UIMenuController sharedMenuController];
        
//        [copyMenu setTargetRect:_btnNum.frame inView:_scrollViewBg];
        
        copyMenu.arrowDirection = self.copyMenuArrowDirection;
        [copyMenu setMenuVisible:YES animated:YES];
    }
    
   
    
}
#pragma mark - Public

- (void)setCopyingEnabled:(BOOL)copyingEnabled
{
    if (_copyingEnabled != copyingEnabled)
    {
        [self willChangeValueForKey:@"copyingEnabled"];
        _copyingEnabled = copyingEnabled;
        [self didChangeValueForKey:@"copyingEnabled"];
    }
}


#pragma mark - UIResponder

- (BOOL)canBecomeFirstResponder
{
    return self.copyingEnabled;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    BOOL retValue = NO;
    
    if (action == @selector(copy:))
    {
        if (self.copyingEnabled)
        {
            retValue = YES;
        }
	}
    else
    {
        // Pass the canPerformAction:withSender: message to the superclass
        // and possibly up the responder chain.
        retValue = [super canPerformAction:action withSender:sender];
    }
    
    return retValue;
}

- (void)copy:(id)sender
{
    if (self.copyingEnabled)
    {
//        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        
//        [pasteboard setString:_btnNum.titleLabel.text];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
