//
//  ResultViewController.m
//  GlassessBiz
//
//  Created by Guibin on 14-5-22.
//  Copyright (c) 2014年 深圳呱呱网络科技有限公司. All rights reserved.
//

#import "ResultViewController.h"
#import "SelectTermViewCell.h"
#import "ResultDtlViewController.h"
#import "OfferViewController.h"
#import "SelectTermViewCell_ipad.h"
@interface ResultViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UIView *_headView;
    
    IBOutlet UIView *_headView1;
    
    IBOutlet UIView *_headView2;
    IBOutlet UIView *_headView3;
    IBOutlet UIView *_headView4;
    __weak IBOutlet UILabel *_labHeadType;
    __weak IBOutlet UILabel *_labHeadLocation;
    __weak IBOutlet UILabel *_labHeadRule;
    __weak IBOutlet UILabel *_labHeadTime;
    
    
    UILabel     *_labTotal;

    NSString      *_idsID;
}

@end

@implementation ResultViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil dicInfo:(NSMutableDictionary *)dicInfo
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       
        // Custom initialization
    }
    
    [self initLoadData:dicInfo];
    _idsID = [dicInfo[@"ids"] copy];
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
  
    self.labTitle.text = IsEnglish ? @"Result for Enquiry": @"查询结果";
    self.rightbtn.hidden = NO;

    _headView.backgroundColor = [SavaData getColor:@"dcdddd" alpha:1.f];
    _headView1.backgroundColor = [SavaData getColor:@"dcdddd" alpha:1.f];
    _headView2.layer.borderWidth = 0.5f;
    _headView2.layer.borderColor = [SavaData getColor:@"dcdddd" alpha:1.f].CGColor;
    
    _headView3.layer.borderWidth = 0.5f;
    _headView3.layer.borderColor = [SavaData getColor:@"dcdddd" alpha:1.f].CGColor;
    
    _headView4.layer.borderWidth = 0.5f;
    _headView4.layer.borderColor = [SavaData getColor:@"dcdddd" alpha:1.f].CGColor;
    
    self.baseTableView.tableHeaderView = _headView;
    
  
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (_resultType == 0) {
        [self.rightbtn setTitle:IsEnglish ? @"Done": @"完成" forState:UIControlStateNormal];
        
    }else{
        self.rightbtn.titleLabel.font = [UIFont systemFontOfSize:10];
        if (isPad) {
            CGRect rightFrame = self.rightbtn.frame;
            rightFrame.size.width = 100;
            self.rightbtn.frame = rightFrame;
           self.rightbtn.titleLabel.font = [UIFont systemFontOfSize:15];
        }
        
        [self.rightbtn setTitle:IsEnglish ? @"History": @"复制查询条件" forState:UIControlStateNormal];
    }
    [self.rightbtn setTitleColor:[SavaData getColor:@"a0c23a" alpha:1.f] forState:UIControlStateNormal];
    
    [self setHeadTextContent];
}
- (void)initLoadData:(NSMutableDictionary *)dic
{
    
    [self.view addHUDActivityView:Loading];
    LOG(@"dicInfo = %@",dic);
    
    [[Connection shareInstance] requestWithParams:dic withURL:Api_ProductQueryrs  withType:POST completed:^(id content, ResponseType responseType) {
        [self.view removeHUDActivityView];
        
        if (responseType == SUCCESS)
        {
            LOG(@"data = %@",content[@"data"]);
            
            [self.dicData setDictionary: content[@"data"]];
            
             _labHeadTime.text = self.dicData[@"queryTime"];
         
            [self.baseTableView reloadData];
        } else if (responseType == FAIL) {
            [self.view addHUDLabelView:content Image:nil afterDelay:2.0f];
        }
        
    }];
    
    
}
- (NSInteger)titleTypeJcsort:(NSString *)text
{
    if ([text isEqualToString:Eyewear]) {//眼镜类
        return 0;
    }else if ([text isEqualToString:Chemical])//化学类
    {
        return 1;
    }else{
        return 2;
    }
    return 0;
}
#pragma  mark 完成操作
- (void)tapRightBtn
{
    if (_resultType == 0) {
        
        [self tenseSendEmailAction];
        
    }else{
        OfferViewController *offerVC = [[OfferViewController alloc] initWithNibName:isPad ?@"OfferViewController-ipad":@"OfferViewController" bundle:nil];
        offerVC.offerType = [self titleTypeJcsort:_arrQueryData[0][@"jcsort"]];
        offerVC.arrTitleType = _arrQueryData;
        [self.navigationController pushViewController:offerVC animated:NO];
    }
}
- (void)setHeadTextContent
{
    if (_resultType == 0) {
        NSDictionary *dic = [DataStorer sharedInstance].dicDefiner;
        LOG(@"dic = %@",dic);
        if (dic.allKeys.count >0) {
            _labHeadType.text = [dic[@"type1"] length] >0 ? dic[@"type1"] : Category;
            _labHeadLocation.text = [dic[@"type2"] length] >0 ? dic[@"type2"] :Area;
            _labHeadRule.text = [dic[@"type3"] length] >0 ? dic[@"type3"] : Standard;
        }
    }else{
        LOG(@"_arrQueryData = %@",_arrQueryData);
        if (_arrQueryData.count >0) {
            _labHeadType.text = [_arrQueryData[0][@"type1"] length] >0 ? _arrQueryData[0][@"type1"] : Category;
            _labHeadLocation.text = [_arrQueryData[0][@"type2"] length] >0 ? _arrQueryData[0][@"type2"] :Area;
            _labHeadRule.text = [_arrQueryData[0][@"type3"] length] >0 ? _arrQueryData[0][@"type3"] : Standard;
        }
    }
    
}
- (void)tenseSendEmailAction
{
    NSDictionary *userDic = [SavaData parseDicFromFile:User_File];
    // 添加图片
    UIImage *addPic = [self getResultViewPageImage];
    NSData *data = UIImagePNGRepresentation(addPic);
//    NSData *data = UIImageJPEGRepresentation(addPic, 0.8);
    
    LOG(@"_idsID = %@",_idsID);
    NSURL *registerUrl = [NSURL URLWithString:[BASE_REQUEST_URL stringByAppendingString:Api_ProductSendImg]];
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:registerUrl];
    
    request.shouldAttemptPersistentConnection = NO;
    [request setPostValue:userDic[@"email"] forKey:@"email"];
    [request setPostValue:_idsID forKey:@"ids"];
    [request setPostValue:language forKey:langType];
    if (data) {
//        [request setData:data forKey:@"rsimage.png"];
        [request addData:data withFileName:@"rsimage.png" andContentType:@"png" forKey:@"rsimage"];
    }
    [request setRequestMethod:@"POST"];
    [request setTimeOutSeconds:15.0];
    [request setDelegate:self];
    
    [request startAsynchronous];
    
    [self.view addHUDActivityView:IsEnglish ? @"Please wait a minute.An email will be sent to your mailbox...": @"请稍候,正在发送邮件至您的邮箱..."];
}
- (UILabel *)cellForFirstLab
{
    if (_labTotal == nil) {
        _labTotal = [[UILabel alloc] initWithFrame:CGRectMake(isPad ? 244 : 20, 5, 280, 39)];
        _labTotal.font = [UIFont systemFontOfSize:18];
        _labTotal.backgroundColor = [UIColor clearColor];
        _labTotal.textAlignment = NSTextAlignmentCenter;
    }
    _labTotal.text = [NSString stringWithFormat:IsEnglish ? @"Total cost:%@": @"检测费用总计：%@",self.dicData[@"cost"]];
    return _labTotal;
}
- (UIButton *)cellForBackBtn:(NSInteger)index
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(WIDTH(self.view)-100, 0, 100, 49);
    button.tag = index;
    if (index == 2) {
        [button setImage:[UIImage imageNamed:@"Inquiry_iv_Phone"] forState:UIControlStateNormal];
    }
    UILabel *labLine = [[UILabel alloc] initWithFrame:CGRectMake(1, 4, 1, 40)];
    labLine.backgroundColor = [SavaData getColor:@"dcdddd" alpha:1.f];;
    [button addSubview:labLine];
    
    [button addTarget:self action:@selector(didCallPhoneNum:) forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}
- (NSString *)cellForRowTitle:(NSInteger)index
{
    switch (index) {
        case 0:
            return IsEnglish ? @"Testing item(s)" : @"检测项目";
            break;
        case 1:
            return IsEnglish ? @"Service level" : @"服务要求";
            break;
        case 2:
            return IsEnglish ? @"Lead-time" : @"检测时限";
            break;
//        case 3:
//            return @"活动折扣";
//            break;
        case 3:
            return IsEnglish ? @"Rest" : @"其他";
            break;
        default:
            break;
    }
    return nil;
}
- (UIImage *)getResultViewPageImage
{
    UIGraphicsBeginImageContext([UIScreen mainScreen].bounds.size);
    
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];

    UIImage *image=UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    UIImageWriteToSavedPhotosAlbum(image,self, nil, nil);
    return image;
}
- (void)didCallPhoneNum:(UIButton *)btn
{
    if (btn.tag == 2) {
        if (isPad) {
            [self.view addHUDLabelView:IsEnglish ? @"Sorry, the device does not support the phone": @"抱歉,该设备不支持打电话" Image:nil afterDelay:2.0f];
            return;
        }
        NSString *number = [NSString stringWithFormat:@"tel://%@",self.dicData[@"phone"]];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:number]]; //拨号
    }else if (btn.tag ==3){
        LOG(@"发邮件");
        [self sendEmailAction];
    }else{
        NSURL *url = [NSURL URLWithString:self.dicData[@"website"]];
        if (![[UIApplication sharedApplication] openURL:url]) {
            [self.view addHUDLabelView:IsEnglish ? @"Invalid" : @"无效的网址" Image:nil afterDelay:2.0f];
        }
        
    }
}
- (void)sendEmailAction
{
    Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
    if (mailClass != nil)
    {
        if ([mailClass canSendMail])
        {
            [self displayComposerSheet];
        }
        else
        {
            [self launchMailAppOnDevice];
        }
    }
    else
    {
        [self launchMailAppOnDevice];
    }
}

//可以发送邮件的话
-(void)displayComposerSheet
{
    MFMailComposeViewController *mailPicker = [[MFMailComposeViewController alloc] init];
    mailPicker.mailComposeDelegate = self;
    //设置主题
    [mailPicker setSubject: @"Mail"];
    // 添加发送者
    NSArray *toRecipients = [NSArray arrayWithObject:self.dicData[@"email"]];
    //NSArray *ccRecipients = [NSArray arrayWithObjects:@"second@example.com", @"third@example.com", nil];
    //NSArray *bccRecipients = [NSArray arrayWithObject:@"fourth@example.com", nil];
    [mailPicker setToRecipients: toRecipients];
    //[picker setCcRecipients:ccRecipients];
    //[picker setBccRecipients:bccRecipients];
    // 添加图片
    UIImage *addPic = [self getResultViewPageImage];
    NSData *imageData = UIImagePNGRepresentation(addPic); // png
    // NSData *imageData = UIImageJPEGRepresentation(addPic, 1); // jpeg
    [mailPicker addAttachmentData: imageData mimeType: @"" fileName: @"rsimage.png"];
    NSString *emailBody = IsEnglish ? @"PEL testing services Co. Ltd." : @"精科眼镜检测检验服务有限公司";
    [mailPicker setMessageBody:emailBody isHTML:YES];
    [self presentViewController:mailPicker animated:YES completion:nil];

}
-(void)launchMailAppOnDevice
{
    NSString *recipients = @"mailto:first@example.com&subject=my email!";
    //@"mailto:first@example.com?cc=second@example.com,third@example.com&subject=my email!";
    NSString *body = @"&body=email body!";
    NSString *email = [NSString stringWithFormat:@"%@%@", recipients, body];
    email = [email stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    [[UIApplication sharedApplication] openURL: [NSURL URLWithString:email]];
}

- (void)mailComposeController:(MFMailComposeViewController *)controller
          didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    NSString *msg;
    switch (result)
    {
        case MFMailComposeResultCancelled:
            msg = @"邮件发送取消";
            break;
        case MFMailComposeResultSaved:
            msg = IsEnglish ? @"Mail saved successfully": @"邮件保存成功";
             [self.view addHUDLabelView:msg Image:nil afterDelay:2.0f];
            break;
        case MFMailComposeResultSent:
            msg = IsEnglish ? @"Mail success": @"邮件发送成功";
             [self.view addHUDLabelView:msg Image:nil afterDelay:2.0f];
            break;
        case MFMailComposeResultFailed:
            msg = IsEnglish ? @"Message sending failed": @"邮件发送失败";
             [self.view addHUDLabelView:msg Image:nil afterDelay:2.0f];
            break;
        default:
            break;
    }
    [controller dismissViewControllerAnimated:YES completion:nil];
}
#define mark UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section ==0) {
        return 4;
    }else if (section ==1){
        return 0;
    }
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (isPad) {
        static NSString *defineString = @"defineString";
        SelectTermViewCell_ipad *cell = [tableView dequeueReusableCellWithIdentifier:defineString];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"SelectTermViewCell_ipad" owner:self options:nil]objectAtIndex:0];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        [self showLoadSelectTermViewCell_ipad:cell cellForRowInSection:indexPath];
        return cell;
    }else{
        static NSString *defineString = @"defineString";
        SelectTermViewCell *cell = [tableView dequeueReusableCellWithIdentifier:defineString];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"SelectTermViewCell" owner:self options:nil]objectAtIndex:0];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        
        [self showLoadSelectTermViewCell:cell cellForRowInSection:indexPath];
        return cell;
    }
}

- (NSString *)cellForTextContent:(NSInteger)index
{
    LOG(@"self.dicData = %@",self.dicData);
    switch (index) {
        case 0:
            return IsEnglish ? @"All" : @"全部";//self.dicData[@"serviceSort"];
            break;
        case 1:
            LOG(@"_serveType条件 = %@",_serveType);
            return _serveType;
            break;
        case 2:
            return [NSString stringWithFormat:@"%@ %@",self.dicData[@"pmin"],IsEnglish ? @"working day(s)":@"(工作日)"];
            break;
//        case 3:
//            return self.dicData[@"discount"];
            break;
        case 3:
            return self.dicData[@"cost"];
            break;
        default:
            break;
    }
    return nil;
}
- (void)showLoadSelectTermViewCell:(SelectTermViewCell *)cell cellForRowInSection:(NSIndexPath *)indexPath
{
    
    if (indexPath.section ==0) {
        
        cell.labTitle.text = [self cellForRowTitle:indexPath.row];
        
        cell.labType.text  = [self cellForTextContent:indexPath.row];
        if (indexPath.row ==0) {
            [cell changeLabelFrame];
            //了解详情
            [cell.btnDetail addTarget:self action:@selector(didSelectDetailPage) forControlEvents:UIControlEventTouchUpInside];
            
        }
        
        if (indexPath.row == 3) {
            cell.labTitle.hidden = YES;
            cell.labType.hidden = YES;
            [cell.contentView addSubview:[self cellForFirstLab]];
        }
    }else if (indexPath.section ==2)
    {
        cell.labType.hidden = YES;
        cell.labTitle.text = self.dicData[@"phone"];
        [cell.contentView addSubview:[self cellForBackBtn:indexPath.section]];
    }else if (indexPath.section ==3)
    {
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.labType.hidden = YES;
        cell.labTitle.text = self.dicData[@"email"];
//        [cell.contentView addSubview:[self cellForBackBtn:indexPath.section]];
    }else if (indexPath.section == 4)
    {
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.labType.hidden = YES;
        cell.labTitle.text = self.dicData[@"website"];
//        [cell.contentView addSubview:[self cellForBackBtn:indexPath.section]];
    }
}
- (void)showLoadSelectTermViewCell_ipad:(SelectTermViewCell_ipad *)cell cellForRowInSection:(NSIndexPath *)indexPath
{
    
    if (indexPath.section ==0) {
        
        cell.labTitle.text = [self cellForRowTitle:indexPath.row];
        
        cell.labType.text  = [self cellForTextContent:indexPath.row];
        if (indexPath.row ==0) {
            [cell changeLabelFrame];
            //了解详情
            [cell.btnDetail addTarget:self action:@selector(didSelectDetailPage) forControlEvents:UIControlEventTouchUpInside];
            
        }
        
        if (indexPath.row == 3) {
            cell.labTitle.hidden = YES;
            cell.labType.hidden = YES;
            [cell.contentView addSubview:[self cellForFirstLab]];
        }
    }else if (indexPath.section ==2)
    {
        cell.labType.hidden = YES;
        cell.labTitle.text = self.dicData[@"phone"];
        [cell.contentView addSubview:[self cellForBackBtn:indexPath.section]];
    }else if (indexPath.section ==3)
    {
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.labType.hidden = YES;
        cell.labTitle.text = self.dicData[@"email"];
        //        [cell.contentView addSubview:[self cellForBackBtn:indexPath.section]];
    }else if (indexPath.section == 4)
    {
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.labType.hidden = YES;
        cell.labTitle.text = self.dicData[@"website"];
        //        [cell.contentView addSubview:[self cellForBackBtn:indexPath.section]];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 3) {
         [self sendEmailAction];
    }else if (indexPath.section ==4)
    {
        NSURL *url = [NSURL URLWithString:self.dicData[@"website"]];
        if (![[UIApplication sharedApplication] openURL:url]) {
            [self.view addHUDLabelView:IsEnglish ? @"Invalid" : @"无效的网址" Image:nil afterDelay:2.0f];
        }
    }
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return _headView1;
    }else if (section ==2)
    {
        return _headView2;
    }else if (section ==3)
    {
        return _headView3;
    }else if (section ==4)
    {
        return _headView4;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section ==1) {
        return 40;
    }else if (section ==0 || section ==1){
        return 0;
    }
    return 25;
}

#pragma  mark 了解详情

- (void)didSelectDetailPage
{
    ResultDtlViewController *resultDtlVC = [[ResultDtlViewController alloc] initWithNibName:isPad  ? @"ResultDtlViewController-ipad":@"ResultDtlViewController" bundle:nil idsID:_idsID];
    [self.navigationController pushViewController:resultDtlVC animated:YES];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 49;
}
- (void)requestFinished:(ASIHTTPRequest *)request
{
    [self.view removeHUDActivityView];
    NSData *data= [request responseData];
    NSDictionary *dicInfor = [data objectFromJSONData];
    LOG(@"message = %@",dicInfor[@"message"]);
    NSString *message = dicInfor[@"message"];
    
    if ([dicInfor[@"status"] integerValue] == 1) {
        [self.view addHUDLabelView:message Image:nil afterDelay:2.0f];
        [self performSelector:@selector(popViewFirstVC) withObject:nil afterDelay:1.f];
    }else{
        [self.view addHUDLabelView:message Image:nil afterDelay:2.0f];
    }
    
}
- (void)requestFailed:(ASIHTTPRequest *)request
{
     [self.view removeHUDActivityView];
     [self.view addHUDLabelView:NetworkFail Image:nil afterDelay:2.0f];
}
- (void)popViewFirstVC
{
    if ([DataStorer sharedInstance].isLogin == YES) {
        [self.navigationController popToViewController:self.navigationController.viewControllers[1] animated:YES];
    }else{
        [self.navigationController popToViewController:self.navigationController.viewControllers[0] animated:YES];
    }
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
