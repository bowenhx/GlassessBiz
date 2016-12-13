//
//  LoginViewController.m
//  GlassessBiz
//
//  Created by Guibin on 14-5-14.
//  Copyright (c) 2014年 深圳呱呱网络科技有限公司. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "ForgetViewController.h"
#import "HomeViewController.h"
@interface LoginViewController ()<UITextFieldDelegate>
{
    
    __weak IBOutlet UIView *_viewBg;
    __weak IBOutlet UITextField *_textFieldEmail;
    __weak IBOutlet UITextField *_textFieldPassword;
    
    __weak IBOutlet UIButton *_btnPassword;
    __weak IBOutlet UIButton *_btnRegister;
    
    __weak IBOutlet UIImageView *_imageLine1;
    
}

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
//        if (iOS7) {
//            self.navigationController.interactivePopGestureRecognizer.enabled = NO;
//        }
//        self.view.layer.borderWidth = 2;
//        self.view.layer.borderColor = [UIColor redColor].CGColor;
//        self.navigationController.navigationBar.hidden=YES;
        // Custom initialization
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
    
    _imageLine1.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"login_btn_Landed_pressed"]];
    
    if (!iPhone5) {
        
        if (isPad)
        {
            CGRect btnFrame1 = _btnPassword.frame;
            btnFrame1.origin.y = SCREEN_HEIGHT -59;
            _btnPassword.frame = btnFrame1;
            _btnRegister.frame = CGRectMake(CGRectGetMaxX(_btnPassword.frame),_btnPassword.frame.origin.y, _btnRegister.frame.size.width, _btnRegister.frame.size.height);
        }else{
            CGRect btnFrame1 = _btnPassword.frame;
            btnFrame1.origin.y = SCREEN_HEIGHT -(iOS7 ? 44:64);
            _btnPassword.frame = btnFrame1;
            _btnRegister.frame = CGRectMake(CGRectGetMaxX(_btnPassword.frame),_btnPassword.frame.origin.y, _btnRegister.frame.size.width, _btnRegister.frame.size.height);
        }

    }
    NSString *emailStr = [SavaData parseDicFromFile:@"userEmail"][@"email"];
    if (emailStr != nil && emailStr.length >0) {
        _textFieldEmail.text = emailStr;
    }
    
    [self addObserverCenter];
    // Do any additional setup after loading the view from its nib.
}
- (void)addObserverCenter
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLoginInfo:) name:ChangeUsreInfoDataotificationCenter object:nil];
}
- (void)changeLoginInfo:(NSNotification *)infor
{
    NSDictionary *dic = [infor object];
    _textFieldEmail.text = dic[@"email"];
    _textFieldPassword.text = dic[@"password2"];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
//登录操作
- (IBAction)beginLoginAction:(UIButton *)sender {
    if (![self isTextContentBlank:_textFieldEmail.text] && [self isValidateEmailCorrect:_textFieldEmail.text]) {
        if ([self isTextContentBlank:_textFieldPassword.text]) {
            [self.view addHUDLabelView:IsEnglish ? @"Please enter the password": @"请输入密码" Image:nil afterDelay:2.0f];
            return;
        }
        
        [self.view addHUDActivityView:IsEnglish ? @"Completing login" : @"正在登录..."];
        
        [[Connection shareInstance] requestWithParams:[NSMutableDictionary dictionaryWithDictionary:@{langType:language,@"email":_textFieldEmail.text,@"password":_textFieldPassword.text}] withURL:Api_LoginUrl withType:POST completed:^(id content, ResponseType responseType) {
            [self.view removeHUDActivityView];
            
            if (responseType == SUCCESS) {
                if ([content[@"status"] integerValue] == 1) {
                    
                    LOG(@"data = %@",content[@"data"]);
                    [DataStorer sharedInstance].isLogin = YES;
                    
                    //保存用户ID
                    NSString *userid = content[@"data"][@"id"];
                    [[SavaData shareInstance] savadataStr:userid KeyString:USER_ID_SAVA];
                    
                    
                    
                    [SavaData setUserInfoData:userid];
                    
                    NSLog(@"userINforid = %@",[SavaData getOutUserFile]);

                    //TODO: 由于服务器返回 discount = "<null>"，故在这里设置写才能写入本地文件
                    
                    NSMutableDictionary *dicData = [NSMutableDictionary dictionaryWithDictionary:content[@"data"]];
                    [dicData setObject:@"没有数据" forKey:@"discount"];
                    
                    //存入用户信息
                    [SavaData writeDicToFile:dicData FileName:User_File];
                    
                    LOG(@"userData = %@",[SavaData parseDicFromFile:User_File]);
                    //登录成功后跳入主页面
                    HomeViewController *homeVC = [[HomeViewController alloc] initWithNibName:isPad ? @"HomeViewController-ipad":@"HomeViewController" bundle:nil];
                    [self.navigationController pushViewController:homeVC animated:YES];
                    homeVC.navigationController.navigationBar.hidden = NO;
                }
                LOG(@"message = %@",content[@"message"]);
            } else if (responseType == FAIL) {
                [self.view addHUDLabelView:content Image:nil afterDelay:2.0f];
            }
            
        }];
    }else{
        [self.view addHUDLabelView:IsEnglish ? @"Please enter the valid email address" :@"请输入正确的邮箱地址" Image:nil afterDelay:2.0f];
    }
    
}
- (IBAction)forgetPasswordAction:(UIButton *)sender {
    ForgetViewController *forgetVC = [[ForgetViewController alloc] initWithNibName:isPad ? @"ForgetViewController-ipad":@"ForgetViewController" bundle:nil];
    forgetVC.fotgetStatus = forgetTypeSend;
    [self.navigationController pushViewController:forgetVC animated:YES];
    forgetVC.navigationController.navigationBar.hidden = NO;
}
- (IBAction)registerGlassessAction:(UIButton *)sender {
    RegisterViewController *registerVC = [[RegisterViewController alloc] initWithNibName:isPad ? @"RegisterViewController-ipad" : @"RegisterViewController" bundle:nil];
    [self.navigationController pushViewController:registerVC animated:YES];
     registerVC.navigationController.navigationBar.hidden = NO;
}

#pragma mark TextField
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self changeViewBgFrame:textField.tag];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.tag == 0) {
        [_textFieldPassword becomeFirstResponder];
    }else if (textField.tag == 1) {
        [textField resignFirstResponder];
        [self changeViewBgFrame:3];
    }
    return YES;
}
- (void)changeViewBgFrame:(int)index
{
    if (!iPhone5 && isIphone) {
        __block CGRect imageFrame = _viewBg.frame;
        if (index ==0 || index ==1)
        {
            imageFrame.origin.y = 0;
        }else{
            imageFrame.origin.y = 77;
        }
        [UIView animateWithDuration:0.37 animations:^{
            _viewBg.frame = imageFrame;
        }];
    }
}
//判断邮箱是否正确
- (BOOL)isValidateEmailCorrect:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
