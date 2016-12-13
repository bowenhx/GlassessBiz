//
//  NoteVerifyViewController.m
//  GlassessBiz
//
//  Created by Guibin on 14-5-20.
//  Copyright (c) 2014年 深圳呱呱网络科技有限公司. All rights reserved.
//

#import "NoteVerifyViewController.h"
#import "HomeViewController.h"


@interface NoteVerifyViewController ()
{

    __weak IBOutlet UILabel     *_labPhoneNum;

    __weak IBOutlet UITextField *_textFieldVN;
    
    __weak IBOutlet UIImageView *_imageLine;
    
    IBOutlet UIButton *_btnSendVerify;

    NSString            *_verifyString;
    
    NSInteger           _timeNum;
}
@property (nonatomic , strong)NSTimer   *timer;
@end

@implementation NoteVerifyViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _dicUserInfo = [NSDictionary dictionary];
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.labTitle.text = IsEnglish ? @"Message authentication": @"短信验证";
    
    _labPhoneNum.text = _telNum;
    
    _imageLine.backgroundColor = [SavaData getColor:@"dcdddd" alpha:1.f];

    [self initData];
}
- (void)initData
{
    _timeNum = 180;
}

- (void)beginRegisterUserInfo
{
    
    //短信验证
    [self sendMobileSmsVerify];
    
}
- (IBAction)beginVerifyNoteAction:(UIButton *)sender {
    sender.selected = YES;
    [sender setTitle:IsEnglish ? @"(180s) send again": @"（180s）重新发送" forState:UIControlStateNormal];
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.f target:self selector:@selector(didTimereRefreshSendBtn:) userInfo:nil repeats:YES];
    [_timer fire];
    sender.userInteractionEnabled = NO;
    
    [self beginRegisterUserInfo];
    
    
}
//确定后
- (IBAction)didSelectConfirmAction:(UIButton *)sender {
   LOG(@"_dicInfor = %@",_dicUserInfo);
    [_textFieldVN resignFirstResponder];
    
    if (![_verifyString isEqualToString:_textFieldVN.text]) {
        [self.view addHUDLabelView:IsEnglish ? @"Verification code input error": @"验证码输入有误" Image:nil afterDelay:2.0f];
        return;
    }
    [self.view addHUDActivityView:Loading];
    LOG(@"self.dicData = %@",self.dicUserInfo);
    [[Connection shareInstance] requestWithParams:(NSMutableDictionary *)self.dicUserInfo withURL:API_RegisterURL withType:POST completed:^(id content, ResponseType responseType) {
        
//        [self.view removeHUDActivityView];
        if (responseType == SUCCESS) {
            
            LOG(@"data = %@",content[@"data"]);
            
            [self activeUserPhoneMobile];
            
        } else if (responseType == FAIL) {
            [self.view addHUDLabelView:content Image:nil afterDelay:2.0f];
           
        }
        
    }];

   
//    [self tapBackBtn];
}
- (void)activeUserPhoneMobile
{
    NSURL *url = [NSURL URLWithString:Api_ActiveUser];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setRequestMethod:@"POST"];
    [request setPostValue:_telNum forKey:@"mobile"];
    [request setTimeOutSeconds:10];
    [request startAsynchronous];
    
    request.failedBlock = ^{
        [self.view removeHUDActivityView];
        [self.view addHUDLabelView:NetworkFail Image:nil afterDelay:2.0f];
    };
    
    __block ASIFormDataRequest *breq = request;
    request.completionBlock = ^(void){
        [self.view removeHUDActivityView];
        NSData *responseData = [breq responseData];
        NSDictionary *dic = [responseData objectFromJSONData];
        if ([dic[@"status"] integerValue] == 1) {
            
            [_timer invalidate];
            
            [self.navigationController popToViewController:self.navigationController.viewControllers[0] animated:YES];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:ChangeUsreInfoDataotificationCenter object:_dicUserInfo];
            
            //成功后跳入主页面
            //            HomeViewController *homeVC = [[HomeViewController alloc] initWithNibName:isPad ? @"HomeViewController-ipad":@"HomeViewController" bundle:nil];
            //            [self.navigationController pushViewController:homeVC animated:YES];
            
        }else{
            [self.view addHUDLabelView:dic[@"message"] Image:nil afterDelay:2.0f];
        }
        LOG(@"dic = %@",dic);
    };
}
- (void)didTimereRefreshSendBtn:(NSTimer *)timer
{
    LOG(@"str = %d",_timeNum);
    _timeNum--;
    _btnSendVerify.titleLabel.text = [NSString stringWithFormat:IsEnglish ? @"（%d）Re send" : @"（%d）重新发送",_timeNum];
    
    if (_timeNum ==0 ) {
        [timer invalidate];
        _timeNum = 180;
        _btnSendVerify.selected = NO;
        _btnSendVerify.userInteractionEnabled = YES;
        [_btnSendVerify setTitle:IsEnglish ? @"Re send" : @"重新发送" forState:UIControlStateNormal];
        
    }
}
//短信验证
- (void)sendMobileSmsVerify
{
    [self.view addHUDActivityView:Loading];
    
    [[Connection shareInstance] requestWithParams:[NSMutableDictionary dictionaryWithDictionary:@{@"mobile":_telNum}] withURL:Api_SendMobileSms withType:POST completed:^(id content, ResponseType responseType) {
        [self.view removeHUDActivityView];
        
        if (responseType == SUCCESS) {
            
            LOG(@"data = %@",content[@"data"]);
            
            _verifyString = [[NSString stringWithFormat:@"%@",content[@"data"][@"codes"] ] copy];
            [self.view addHUDLabelView:IsEnglish ? @"Verification code has been sent": @"验证码已发送" Image:nil afterDelay:1.f];
        } else if (responseType == FAIL) {
            [self.view addHUDLabelView:content Image:nil afterDelay:2.0f];
            _timeNum = 1;
        }
        
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
