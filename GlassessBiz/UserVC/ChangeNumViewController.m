//
//  ChangeNumViewController.m
//  GlassessBiz
//
//  Created by Guibin on 14-5-23.
//  Copyright (c) 2014年 深圳呱呱网络科技有限公司. All rights reserved.
//

#import "ChangeNumViewController.h"
#import "RegisterViewCell.h"
#import "AppDelegate.h"
@interface ChangeNumViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    
    IBOutlet UIView *_footView;
    
    __weak IBOutlet UIImageView *_imageLine;
    
    UITextField     *_textFieldN;
}

@end

@implementation ChangeNumViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (iOS7 == YES) {
        _imageLine.hidden = NO;
        _imageLine.backgroundColor = [SavaData getColor:@"dcdddd" alpha:1.f];
    }else {
        _imageLine.hidden = YES;
    }
    
    self.baseTableView.tableFooterView = _footView;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (_changeNumberType == 0) {
        self.labTitle.text = IsEnglish ? @"Change password":@"修改密码";
    }else if (_changeNumberType == 1)
    {
        self.labTitle.text = IsEnglish ? @"Modify mobile number":@"修改手机";
    }else{
        self.labTitle.text = IsEnglish ? @"Modify company phone number":@"修改联系电话";
    }
    
    
}
#define mark UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_changeNumberType == 0) {
        return 3;
    }
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *defineString = @"defineString";
    RegisterViewCell *cell = [tableView dequeueReusableCellWithIdentifier:defineString];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"RegisterViewCell" owner:self options:nil]objectAtIndex:0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textFieldIndex.delegate = self;
    }
    if (isPad) {
        cell.textFieldIndex.frame = CGRectMake(X(cell.textFieldIndex), Y(cell.textFieldIndex), WIDTH(self.view)-X(cell.textFieldIndex), HEIGHT(cell.textFieldIndex));
    }
    
    [self showLoadDataRegisterViewCell:cell cellForRowInSection:indexPath];
    
    return cell;
}
- (void)showLoadDataRegisterViewCell:(RegisterViewCell *)cell cellForRowInSection:(NSIndexPath *)indexPath
{
    cell.textFieldIndex.tag = 5+indexPath.row;
    if (_changeNumberType ==0) {
        cell.textFieldIndex.secureTextEntry = YES;
        switch (indexPath.row) {
            case 0:
                cell.textFieldIndex.placeholder = IsEnglish ? @"Current password": @"当前密码";
                break;
            case 1:
                cell.textFieldIndex.placeholder = IsEnglish ? @"New password":@"新密码";
                break;
            case 2:
                cell.textFieldIndex.placeholder = IsEnglish ? @"Confirm password":@"确认密码";
                break;
                
            default:
                break;
        }
    }else if (_changeNumberType ==1)
    {
        if (indexPath.row ==0) {
            cell.textFieldIndex.placeholder = IsEnglish ? @"Mobile mobile number":@"手机";
        }else{
            cell.textFieldIndex.placeholder = IsEnglish ? @"Reconfirm mobile number":@"确认手机";
        }
    }else
    {
        if (indexPath.row == 0) {
            cell.textFieldIndex.placeholder = IsEnglish ? @"Company phone number":@"联系电话";
        }else
        {
            cell.textFieldIndex.placeholder = IsEnglish ? @"Reconfirm company phone number":@"确认联系电话";
        }
    }
    
}
//确定修改操作
- (IBAction)didFinishConfirmChangeNumAction:(UIButton *)sender
{
    [self resign];
    if (_changeNumberType == 0) {
        //修改密码
        [self beginChangeNumRequest:Api_changePassword changeType:0];
    }else if (_changeNumberType == 1)
    {
        //修改手机号码
        [self beginChangeNumRequest:Api_changeMobile changeType:1];
    }else{
        //修改办公电话
        [self beginChangeNumRequest:Api_changePhone changeType:2];
    }
}
- (void)changeNumberJudgeResult:(NSInteger)index textFieldBlock:(void(^)(NSString *text1,NSString *text2))block
{

    UITextField *textField1 = (UITextField *)[self.baseTableView viewWithTag:5];
    UITextField *textField2 = (UITextField *)[self.baseTableView viewWithTag:6];
    if (index ==0) {
        //修改密码
        UITextField *textField3 = (UITextField *)[self.baseTableView viewWithTag:7];
        if ([self isTextContentBlank:textField1.text]) {
            [self.view addHUDLabelView:IsEnglish ? @"Please enter current password": @"请输入当前密码" Image:nil afterDelay:2.0f];
            
        }else if (![self isTextContentBlank:textField2.text] && ![self isTextContentBlank:textField3.text])
        {
            if ([textField2.text isEqualToString:textField3.text]) {

                block (textField1.text, textField2.text);
            }else{
                [self.view addHUDLabelView:IsEnglish ? @"The new password is not consistent": @"新密码,两次输入的不一致" Image:nil afterDelay:2.0f];
            }
        }else{
            [self.view addHUDLabelView:IsEnglish ? @"Please complete the password input": @"请完成密码输入" Image:nil afterDelay:2.0f];
        }
        
    }else
    {
        if (![self isTextContentBlank:textField1.text] && ![self isTextContentBlank:textField2.text])
        {
            if (index ==1) {
                if ([textField1.text isEqualToString:textField2.text])
                {//修改手机号
                    if ([self mobileNumberCorrect:textField2.text]) {
                        
                        block (textField1.text, textField2.text);
                    }
                }else{
                    [self.view addHUDLabelView:IsEnglish ? @"The mobile number is not consistent": @"两次输入的手机号不一致" Image:nil afterDelay:2.0f];
                }
            }else{
                if ([textField1.text isEqualToString:textField2.text])
                {//修改办公电话
//                    if ([self phoneNumberContent:textField2.text]) {
                    
                        block (textField1.text, textField2.text);
//                    }
                }else{
                     [self.view addHUDLabelView:IsEnglish ? @"The phone number is not consistent": @"两次输入的电话号码不一致" Image:nil afterDelay:2.0f];
                }
            }
        }else{
            if (index ==1) {
                [self.view addHUDLabelView:IsEnglish ? @"Please enter the complete mobile number": @"请输入完整的手机" Image:nil afterDelay:2.0f];
            }else{
                [self.view addHUDLabelView:IsEnglish ? @"Please enter company phone number": @"请输入联系电话" Image:nil afterDelay:2.0f];
            }
            
        }

        
    }
}
- (void)beginChangeNumRequest:(NSString *)url changeType:(NSInteger)numType
{
    
    [self changeNumberJudgeResult:numType textFieldBlock:^(NSString *text1,NSString *text2){
       
        LOG(@"text1 = %@,text2 = %@",text1,text2);
         NSDictionary *dicInfo = [NSDictionary dictionary];
        if (numType ==0) {
            //密码字典
             dicInfo = @{langType:language,@"id":USERID,@"yspwd":text1,@"newpwd":text2,@"newpwd2":text2};
        }else if (numType ==1)
        {
            //手机号字典
            dicInfo = @{langType:language,@"id":USERID,@"mobile":text2};
        }else{
            //办公电话
            dicInfo = @{langType:language,@"id":USERID,@"bgphone":text2};
        }
       
        
        [self.view addHUDActivityView:Loading];
        
        [[Connection shareInstance] requestWithParams:[NSMutableDictionary dictionaryWithDictionary:dicInfo] withURL:url withType:POST completed:^(id content, ResponseType responseType) {
            [self.view removeHUDActivityView];
            
            if (responseType == SUCCESS)
            {
                LOG(@"content = %@",content);
                if (numType ==0) {
                    [self.view addHUDLabelView:IsEnglish ? @"Change password successfully": @"修改密码成功" Image:nil afterDelay:.0f];
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:CloseNSTimerNSNotificationCenter object:nil];
                    [[AppDelegate getAppDelegate] showLoginVC];
                    
                }else if (numType ==1)
                {
                    NSMutableDictionary *dicFile = [NSMutableDictionary dictionaryWithDictionary:[SavaData parseDicFromFile:User_File]];
                    [dicFile setObject:text2 forKey:@"mobile"];
                    [SavaData writeDicToFile:dicFile FileName:User_File];
                    [[NSNotificationCenter defaultCenter] postNotificationName:UpdataUserInforDataNotificationCenter object:nil];
                    [self.view addHUDLabelView:content[@"message"] Image:nil afterDelay:5.0f];
                }else{
                    
                    NSMutableDictionary *dicFile = [NSMutableDictionary dictionaryWithDictionary:[SavaData parseDicFromFile:User_File]];
                    [dicFile setObject:text2 forKey:@"bgphone"];
                    [SavaData writeDicToFile:dicFile FileName:User_File];
                    [[NSNotificationCenter defaultCenter] postNotificationName:UpdataUserInforDataNotificationCenter object:nil];
                    [self.view addHUDLabelView:content[@"message"] Image:nil afterDelay:5.0f];
                }
                
                [self performSelector:@selector(tapBackBtn) withObject:nil afterDelay:2.f];
                
            } else if (responseType == FAIL) {
                [self.view addHUDLabelView:content Image:nil afterDelay:2.0f];
            }
            
        }];
        
        
    }];
    
    
}
//验证手机号是否正确
- (BOOL)mobileNumberCorrect:(NSString *)phone
{
    NSString *mobilephoneRegex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0-2,5-9]))\\d{8}$";//验证手机号是否正确
    
    NSPredicate *mobilePhonePred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobilephoneRegex];
    
    BOOL mobileIsMatch = [mobilePhonePred evaluateWithObject:phone];
    
    if (!mobileIsMatch ) {
        [self.view addHUDLabelView:IsEnglish ? @"Please enter the correct mobile number": @"请输入正确的手机" Image:nil afterDelay:2.0f];
        return NO;
    }else{
        return YES;
    }
}
- (BOOL)phoneNumberContent:(NSString *)phone
{
     NSString *telephoneRegex = @"^0(10|2[0-5789]|\\d{3})\\d{7}$";
     NSPredicate *telephonePred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",telephoneRegex];
    BOOL teleIsMatch = [telephonePred evaluateWithObject:phone];
    if (!teleIsMatch) {
        [self.view addHUDLabelView:IsEnglish ? @"Please enter the company phone number": @"请输入正确的联系电话" Image:nil afterDelay:2.0f];
        return NO;
    }else{
        return YES;
    }

}
#pragma mark TextField
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    _textFieldN = textField;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (_changeNumberType == 0) {
        if (textField.tag == 7) {
            [textField resignFirstResponder];
        }else{
            [[self.baseTableView viewWithTag:textField.tag +1] becomeFirstResponder];
        }
    }else{
        if (textField.tag == 6) {
            [textField resignFirstResponder];
        }else{
            [[self.baseTableView viewWithTag:textField.tag +1] becomeFirstResponder];
        }
    }
    return YES;
}
- (void)resign
{
    [_textFieldN resignFirstResponder];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
