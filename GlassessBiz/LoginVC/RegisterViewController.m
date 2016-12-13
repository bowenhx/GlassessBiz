//
//  RegisterViewController.m
//  GlassessBiz
//
//  Created by Guibin on 14-5-14.
//  Copyright (c) 2014年 深圳呱呱网络科技有限公司. All rights reserved.
//

#import "RegisterViewController.h"
#import "RegisterViewCell.h"
#import "NoteVerifyViewController.h"
#import "CountryViewController.h"
#import "ForgetViewController.h"
#import "ExceptionsViewController.h"
@interface RegisterViewController ()<UITextFieldDelegate,UIScrollViewDelegate>
{
    IBOutlet UIView *_footView;
    
    __weak IBOutlet UIButton *_btnNext;
    
    UITextField            *_myTextFiled;
    
    NSMutableArray         *_arrText;
    
    NSString               *_countryName;
}
@end

@implementation RegisterViewController

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
    self.labTitle.text = IsEnglish ? @"Registration" : @"注册";
    _footView.backgroundColor = [SavaData getColor:@"dcdddd" alpha:1.f];
    self.baseTableView.backgroundColor = [SavaData getColor:@"dcdddd" alpha:1.f];
    self.baseTableView.tableFooterView = _footView;
    
    [self initViewData];
}
- (void)initViewData
{
    _countryName = @"";
    _arrText = [[NSMutableArray alloc] initWithArray:IsEnglish ? @[@"Email (required)",@"Password (required)",@"Confirm password (required)",@"Country",@"Name (required)",@"Mobile number (required)",@"Company phone number (required)",@"Company"] : @[@"邮箱（必填）",@"密码（必填）",@"确认密码（必填）",@"国家",@"名字（必填）",@"手机（必填）",@"联系电话（必填）",@"公司"]];
}
#pragma mark TableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arrText.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *defineString = @"defineString";
    RegisterViewCell *cell = [tableView dequeueReusableCellWithIdentifier:defineString];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"RegisterViewCell" owner:self options:nil]objectAtIndex:0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    
    [self showLoadDataRegisterViewCell:cell cellForRowInSection:indexPath];
    
    return cell;
}
//#define 
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row  == 3) {
        CountryViewController *countryVC = [[CountryViewController alloc] initWithNibName:isPad ? @"CountryViewController-ipad" : @"CountryViewController" bundle:nil];
        [self.navigationController pushViewController:countryVC animated:YES];
        __block typeof(self)bself = self;
        countryVC.changeCountryNameBlock = ^(NSString *country, NSString *state){
            UITextField *textField = (UITextField *)[bself.baseTableView viewWithTag:50];
            textField.text = country;
            _countryName = [country copy];
            [bself.dicData setObject:state forKey:@"state"];
            if ([country isEqualToString:@"China"]) {
                [_arrText setObject:IsEnglish ? @"Mobile number (required)" : @"手机（必填）" atIndexedSubscript:5];
            }else{
                [_arrText setObject:IsEnglish ? @"Mobile number" : @"手机" atIndexedSubscript:5];
            }
            [self.baseTableView reloadData];
        };
    }
    
}
- (NSString *)textFieldContent:(NSInteger)index
{
    NSString *text = @"";
    switch (index) {
        case 0:
            text = self.dicData[@"email"];
            break;
        case 1:
            text = self.dicData[@"password"];
            break;
        case 2:
            text = self.dicData[@"password2"];
            break;
        case 4:
            text = self.dicData[@"username"];
            break;
        case 5:
            text = self.dicData[@"mobile"];
            break;
        case 6:
            text = self.dicData[@"bgphone"];
            break;
        case 7:
            text = self.dicData[@"company"];
            break;
        default:
            break;
    }
    return text;
}
- (void)showLoadDataRegisterViewCell:(RegisterViewCell *)cell cellForRowInSection:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 3) {
        cell.textFieldIndex.tag = 50;
        cell.textFieldIndex.text = _countryName.length >0  ? _countryName : _arrText[indexPath.row];
        cell.textFieldIndex.enabled = NO;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }else {
        NSString *content = [self textFieldContent:indexPath.row];
        if (content.length > 0) {
            cell.textFieldIndex.text = content;
        }else{
            cell.textFieldIndex.placeholder = _arrText[indexPath.row];
        }
        
        cell.textFieldIndex.delegate = self;
        
        if (indexPath.row>3) {
            cell.textFieldIndex.tag = 10 + indexPath.row -1;
        }else{
            cell.textFieldIndex.tag = 10 + indexPath.row;
            if (indexPath.row >0) {
                cell.textFieldIndex.secureTextEntry = YES;
            }
        }
        
    }
}
- (BOOL)isKeyValue
{
    NSString *email = self.dicData[@"email"];
    UITextField *textCountry = (UITextField *)[self.baseTableView viewWithTag:50];
    
    if (email.length ==0 || [self isValidateEmailCorrect:email] == NO)
    {
        [self.view addHUDLabelView:IsEnglish ? @"Please enter the valid email address" : @"请输入正确的邮箱地址" Image:nil afterDelay:2.0f];
        return NO;
    }else if ([self isTextContentBlank:self.dicData[@"password"]])
    {
        [self.view addHUDLabelView:IsEnglish ? @"Please enter the original password" : @"请输入原密码" Image:nil afterDelay:2.0f];
        return NO;
    }else if (![self.dicData[@"password"] isEqualToString:self.dicData[@"password2"]])
    {
         [self.view addHUDLabelView:IsEnglish ? @"The password is not consistent": @"两次输入的新密码不一致" Image:nil afterDelay:2.0f];
        return NO;
    }else  if ([textCountry.text isEqualToString:@"中国"])
    {
        if ([self isTextContentBlank:self.dicData[@"username"]]) {
            [self.view addHUDLabelView:IsEnglish ? @"Please enter the name" : @"请输入名字" Image:nil afterDelay:2.0f];
            return NO;
        }else if ([self isTextContentBlank:self.dicData[@"mobile"]])
        {
            [self.view addHUDLabelView:IsEnglish ? @"Please enter mobile number" : @"请输入手机" Image:nil afterDelay:2.0f];
            return NO;
        }else if ([self phoneNumberCorrect:self.dicData[@"mobile"]] == NO)
        {
            return NO;
        }
    }else if ([self isTextContentBlank:self.dicData[@"bgphone"]])
    {
        [self.view addHUDLabelView:IsEnglish ? @"Please enter company phone number": @"请输入联系电话" Image:nil afterDelay:2.0f];
        return NO;
    }else{
         return YES;
    }
    
    return YES;
}
- (IBAction)selectNextAction:(UIButton *)sender {
    
    if ([self isKeyValue]) {
       [self referFinishReginster];
    }
    
    
}

- (void)referFinishReginster
{
    UITextField *textCountry = (UITextField *)[self.baseTableView viewWithTag:50];
    
    if ([textCountry.text isEqualToString:@"China"])
    {
        UITextField *textNote = (UITextField *)[self.baseTableView viewWithTag:14];
        if (textNote.text.length !=0)
        {
            //到短信验证页
            NoteVerifyViewController *noteVerifyVC = [[NoteVerifyViewController alloc] initWithNibName:isPad ? @"NoteVerifyViewController-ipad":@"NoteVerifyViewController" bundle:nil];
            noteVerifyVC.telNum = textNote.text;
            noteVerifyVC.dicUserInfo = self.dicData;
            [self.navigationController pushViewController:noteVerifyVC animated:YES];
        }else
        {
            [self.view addHUDLabelView:IsEnglish ? @"Please enter the correct mobile number" : @"请输入正确的手机" Image:nil afterDelay:2.0f];
        }
    }else
    {
        //邮件验证页
        ForgetViewController *forgetVC = [[ForgetViewController alloc] initWithNibName:isPad ? @"ForgetViewController-ipad": @"ForgetViewController" bundle:nil];
        forgetVC.fotgetStatus = forgetTypeVerify;
        forgetVC.dicUserInfo = self.dicData;
        [self.navigationController pushViewController:forgetVC animated:YES];
    }
}
- (void)seeExceptionsVC
{
    ExceptionsViewController *exceptionsVC = [[ExceptionsViewController alloc] initWithNibName:isPad ? @"ExceptionsViewController-ipad":@"ExceptionsViewController" bundle:nil];
    exceptionsVC.explainType = explainTypeExceptions;
    [self.navigationController pushViewController:exceptionsVC animated:YES];
}
- (IBAction)selectDealAssertAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        _btnNext.enabled = YES;
        [self seeExceptionsVC];
    }else{
        _btnNext.enabled = NO;
    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (![self isTextContentBlank:textField.text]) {
        switch (textField.tag) {
            case 10:
                [self.dicData setObject:textField.text forKey:@"email"];
                break;
            case 11:
                [self.dicData setObject:textField.text forKey:@"password"];
                break;
            case 12:
                [self.dicData setObject:textField.text forKey:@"password2"];
                break;
            case 13:
                [self.dicData setObject:textField.text forKey:@"username"];
                break;
            case 14:
                [self.dicData setObject:textField.text forKey:@"mobile"];
                break;
            case 15:
                [self.dicData setObject:textField.text forKey:@"bgphone"];
                break;
            case 16:
                [self.dicData setObject:textField.text forKey:@"company"];
                break;
            default:
                break;
        }
    }
   
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    _myTextFiled = textField;
    if (iPhone5 ) {
        if (textField.tag >14) {
            [self setTableViewContentOffsetBySubview:textField offsetY:130];
        }
    }else{
        if (textField.tag > 12) {
            [self setTableViewContentOffsetBySubview:textField offsetY:50];
        }
    }
    
   
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    LOG(@"text.tag = %d",textField.tag);
    if (textField.tag == 16) {
        [textField resignFirstResponder];
    }else{
        [[self.baseTableView viewWithTag:textField.tag +1] becomeFirstResponder];
    }
    
    
    return YES;
}
- (void)setTableViewContentOffsetBySubview:(UIView *)view offsetY:(CGFloat)offsetY
{
    CGPoint point = [view convertPoint:CGPointZero toView:self.baseTableView];
    
    
    [self.baseTableView setContentOffset:CGPointMake(0, point.y - (iOS7?offsetY + 64 : offsetY)) animated:YES];
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if ([_myTextFiled isFirstResponder]) {
        [_myTextFiled resignFirstResponder];
    }
    
}
//验证手机号是否正确
- (BOOL)phoneNumberCorrect:(NSString *)phone
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
