//
//  UserCenterViewController.m
//  GlassessBiz
//
//  Created by Guibin on 14-5-22.
//  Copyright (c) 2014年 深圳呱呱网络科技有限公司. All rights reserved.
//

#import "UserCenterViewController.h"
#import "NewsPageViewController.h"
#import "UserInforViewController.h"
#import "MyCollectViewController.h"
#import "IdeaViewController.h"
#import "LoginViewController.h"
#import "AppDelegate.h"
#import "ExceptionsViewController.h"
@interface UserCenterViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    
    IBOutlet UIView *_footView;
    
    IBOutlet UIButton *_loginOutBtn;
    NSArray     *_arrData;
    
    NSString    *_emailStr;
}
@end

@implementation UserCenterViewController

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
    self.labTitle.text = IsEnglish ? @"Personal Center" : @"个人中心";
    
    [_loginOutBtn setTitle:IsEnglish ? @"Sign out":@"退出登录" forState:UIControlStateNormal];
    
    if (IsEnglish) {
         _arrData = @[@"Push Message",@"My collection",@"My enquires",@"About PEL",@"Feedback to PEL",@"Latest Version"];
    }else{
        _arrData = @[@"推送消息",@"我的收藏",@"我查询的报价",@"关于精科",@"意见反馈",@"版本检测更新"];
    }
   
    
    self.baseTableView.backgroundColor =  [SavaData getColor:@"dcdddd" alpha:1.f];
    _footView.backgroundColor =  [SavaData getColor:@"dcdddd" alpha:1.f];
    self.baseTableView.tableFooterView = _footView;
    
    _emailStr = [[SavaData parseDicFromFile:User_File][@"email"] copy];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.baseTableView reloadData];
}
//退出登录操作
- (IBAction)didSelcetQuitLoginAction:(UIButton *)sender {
    
    NSString *emailStr = [SavaData parseDicFromFile:User_File][@"email"];
    [SavaData writeDicToFile:@{@"email":emailStr} FileName:@"userEmail"];
    
    //清除缓存信息
    [[SavaData shareInstance] savadataStr:nil KeyString:USER_ID_SAVA];
    [SavaData removeUserDataManager];
    //        [[NSNotificationCenter defaultCenter] postNotificationName:CloseNSTimerNSNotificationCenter object:nil];
    [[AppDelegate getAppDelegate] showLoginVC];
    
//    [[[UIAlertView alloc] initWithTitle:IsEnglish ? @"Prompt":@"提示" message:IsEnglish ? @"Are you sure you want to exit sign?": @"您确定要退出登录吗？" delegate:self cancelButtonTitle:IsEnglish ? @"Cancel": @"取消" otherButtonTitles:IsEnglish ? @"Confirm": @"确定", nil] show];
    
    
}
//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    if (buttonIndex == 1) {
//        
//       
//    }
//}

#define mark UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section ==0) {
        return 1;
    }
    return _arrData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *defineString = @"defineString";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:defineString];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:defineString];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    if (indexPath.section ==0) {
        cell.textLabel.text = _emailStr;
    }else {
        cell.textLabel.text = _arrData[indexPath.row];
        if (indexPath.row==0) {
            NSString *newImage = [[SavaData shareInstance] printDataStr:NewsImage];
            if ([newImage isEqualToString:@"1"]) {
                cell.imageView.image = [UIImage imageNamed:@"Personal_iv_new"];
            }else{
                cell.imageView.image = nil;
            }
            
        }else if (indexPath.row == 5)
        {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        
    }
    
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section ==0) {
        //我的账户
        UserInforViewController *userInforVC = [[UserInforViewController alloc] initWithNibName:isPad ? @"UserInforViewController-ipad":@"UserInforViewController" bundle:nil];
        [self.navigationController pushViewController:userInforVC animated:YES];
    }else{
        switch (indexPath.row) {
            case 0:{
                //推送消息
                [[SavaData shareInstance] savadataStr:@"0" KeyString:NewsImage];
                NewsPageViewController *newsPageVC = [[NewsPageViewController alloc] initWithNibName:isPad ? @"NewsPageViewController-ipad":@"NewsPageViewController" bundle:nil];
                [self.navigationController pushViewController:newsPageVC animated:YES];
                
                break;
            }
            case 1:{
                //我得收藏
                MyCollectViewController *collectVC = [[MyCollectViewController alloc] initWithNibName:isPad ? @"MyCollectViewController-ipad":@"MyCollectViewController" bundle:nil];
                collectVC.jcsortTypePage = 0;
                [self.navigationController pushViewController:collectVC animated:YES];
                
                break;
            }
            case 2:{
                //我查询过的报价
                MyCollectViewController *collectVC = [[MyCollectViewController alloc] initWithNibName:isPad ? @"MyCollectViewController-ipad":@"MyCollectViewController" bundle:nil];
                collectVC.jcsortTypePage = 1;
                [self.navigationController pushViewController:collectVC animated:YES];
                
                break;
            }
            case 3:{
                //关于
                ExceptionsViewController *excePVC = [[ExceptionsViewController alloc] initWithNibName:isPad ? @"ExceptionsViewController-ipad":@"ExceptionsViewController" bundle:nil];
                excePVC.explainType = explainTypeAbout;
                [self.navigationController pushViewController:excePVC animated:YES];
                break;
            }
            case 4:{
                //意见反馈
                IdeaViewController *ideaVC = [[IdeaViewController alloc] initWithNibName:isPad ? @"IdeaViewController-ipad":@"IdeaViewController" bundle:nil];
                [self.navigationController pushViewController:ideaVC animated:YES];
                
                break;
            }
            case 5:{
                //版本更新
                [self versionUpdata];
//                [[[UIAlertView alloc] initWithTitle:nil message:@"没有发现新版本！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
                
                break;
            }
                
            default:
                break;
        }
    }
}
- (void)versionUpdata
{
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    LOG(@"version = %@",version);
    [self.view addHUDActivityView:Loading];
    
    [[Connection shareInstance] requestWithParams:(NSMutableDictionary *)@{langType:language,@"type":@"ios",@"number":version} withURL:Api_VersionUpdata  withType:POST completed:^(id content, ResponseType responseType) {
        [self.view removeHUDActivityView];
        
        if (responseType == SUCCESS)
        {
            LOG(@"data = %@",content[@"data"]);
            
          
        } else if (responseType == FAIL) {
            [self.view addHUDLabelView:content Image:nil afterDelay:2.0f];
        }
        
    }];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section ==0) {
        return 10;
    }
    return 0;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
