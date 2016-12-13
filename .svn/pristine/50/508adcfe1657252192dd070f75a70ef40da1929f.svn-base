 //
//  ForgetViewController.m
//  GlassessBiz
//
//  Created by Guibin on 14-5-20.
//  Copyright (c) 2014年 深圳呱呱网络科技有限公司. All rights reserved.
//

#import "ForgetViewController.h"

@interface ForgetViewController ()
{
    __weak IBOutlet UITextField *_textFieldEmail;
    __weak IBOutlet UIButton    *_btnEmail;
    
    __weak IBOutlet UILabel *_labShowTitle;
    
}
@end

@implementation ForgetViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _dicUserInfo = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.labTitle.text = IsEnglish ? @"Get back password" : @"找回密码";
    
    if (_fotgetStatus == forgetTypeVerify) {
        _textFieldEmail.text = self.dicUserInfo[@"email"];
        self.labTitle.text = IsEnglish ? @"E-mail verification": @"邮箱验证";
        [_btnEmail setTitle:IsEnglish ? @"Email activation" : @"邮箱激活" forState:UIControlStateNormal];
    }
}
- (IBAction)didSelectSendEmailNumberAction:(UIButton *)sender {
    [[self.view viewWithTag:10] resignFirstResponder];
    if ( [self isTextContentBlank:_textFieldEmail.text]) {
        [self.view addHUDLabelView:IsEnglish ? @"Please enter the valid email address" : @"请输入邮箱地址" Image:nil afterDelay:2.0f];
        return;
    }
   
    
    if (_fotgetStatus == forgetTypeVerify) {
        [self beginRegisterUserInfo];
    }else{
         [self.view addHUDActivityView:Loading];
        [self sendEmailRetrievedPassword:Api_forgetPassword];
    }
}
- (void)beginRegisterUserInfo
{
    [self.view addHUDActivityView:Loading];
    
    LOG(@"self.dicData = %@",self.dicUserInfo);
    [self.dicUserInfo setValue:language forKey:langType];
    [[Connection shareInstance] requestWithParams:self.dicUserInfo withURL:API_RegisterURL withType:POST completed:^(id content, ResponseType responseType) {
        
        if (responseType == SUCCESS) {
            
            LOG(@"data = %@",content[@"data"]);
            //TODO:是否返回继续，还是直接注册
             [self sendEmailRetrievedPassword:Api_SendEmail];
            
        } else if (responseType == FAIL) {
            [self.view addHUDLabelView:content Image:nil afterDelay:2.0f];
            [self.view removeHUDActivityView];
        }
        
    }];
}
- (void)sendEmailRetrievedPassword:(NSString *)url
{
    [[Connection shareInstance] requestWithParams:[NSMutableDictionary dictionaryWithDictionary:@{langType:language,@"email":_textFieldEmail.text}] withURL:url withType:POST completed:^(id content, ResponseType responseType) {
        [self.view removeHUDActivityView];
        
        if (responseType == SUCCESS) {
            
            LOG(@"data = %@",content[@"data"]);
            if (_fotgetStatus == forgetTypeSend) {
                _labShowTitle.hidden = NO;
                [self.view addHUDLabelView:IsEnglish ? @"Send successfully, please check the email" : @"邮件发送成功,请查看邮件" Image:nil afterDelay:2.0f];
                [self performSelector:@selector(popViewRootVC) withObject:self afterDelay:2.5f];
                
            }else{
                 [self.view addHUDLabelView:IsEnglish ? @"The activation message was sent to your registered mailbox." :  @"激活信息已发送至您的注册邮箱" Image:nil afterDelay:2.0f];
                 [self performSelector:@selector(popViewRootVC) withObject:self afterDelay:2.5f];
            }
           
            
        } else if (responseType == FAIL) {
            [self.view addHUDLabelView:content Image:nil afterDelay:2.0f];
        }
        
    }];
}
- (void)popViewRootVC
{
    [self.navigationController popToViewController:self.navigationController.viewControllers[0] animated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
