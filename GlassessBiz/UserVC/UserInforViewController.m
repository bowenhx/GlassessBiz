//
//  UserInforViewController.m
//  GlassessBiz
//
//  Created by Guibin on 14-5-22.
//  Copyright (c) 2014年 深圳呱呱网络科技有限公司. All rights reserved.
//

#import "UserInforViewController.h"
#import "SelectTermViewCell.h"
#import "ChangeNumViewController.h"
#import "SelectTermViewCell_ipad.h"

@interface UserInforViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray     *_arrDataType;
    
    NSMutableDictionary     *_dicUserInfor;
}
@end

@implementation UserInforViewController

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
    self.labTitle.text = IsEnglish ? @"My account": @"我的账户";

    [self initLoadData];
    
    [self.baseTableView setTableFooterView:[[UIView alloc] init]];
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)initLoadData
{
    if (IsEnglish) {
        _arrDataType = @[@"Company",@"Country",@"Name",@"Mobile number",@"Company phone number"];
    }else{
        _arrDataType = @[@"公司",@"国家",@"姓名",@"手机",@"联系电话"];
    }
    
    
    _dicUserInfor = [NSMutableDictionary dictionaryWithDictionary:[SavaData parseDicFromFile:User_File]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(upDataNumber) name:UpdataUserInforDataNotificationCenter object:nil];
    
    self.arrData = [[SavaData parseArrFromFile:Country_list] copy];
    if (self.arrData.count >0) {
        [self changCountryName];
    }else{
        //获取国家列表
        [self.view addHUDActivityView:Loading];
        
        [[Connection shareInstance] requestWithParams:nil withURL:API_CountryURL withType:GET completed:^(id content, ResponseType responseType) {
            [self.view removeHUDActivityView];
            
            if (responseType == SUCCESS) {
                
                self.arrData = [content[@"data"][@"list"] copy];
                
                if (self.arrData.count >0) {
                    [self changCountryName];
                    
                    [SavaData writeArrToFile:self.arrData FileName:Country_list];
                    [self.baseTableView reloadData];
                }
                
            } else if (responseType == FAIL) {
                [self.view addHUDLabelView:content Image:nil afterDelay:2.0f];
            }
            
        }];
    }
    
    
}
- (void)changCountryName
{
    __block BOOL _isFinish = YES;
    NSInteger state = [_dicUserInfor[@"sid"] integerValue];
    [self.arrData enumerateObjectsUsingBlock:^(NSDictionary *dic, NSUInteger index, BOOL *stop){
        if ([dic[@"id"] integerValue] == state  && _isFinish) {
            [_dicUserInfor setObject:dic[@"country"] forKey:@"state"];
            _isFinish = NO;
        }
    }];
}
- (void)upDataNumber
{
    _dicUserInfor = (NSMutableDictionary *)[SavaData parseDicFromFile:User_File];
    [self.baseTableView reloadData];
    
}
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
    return _arrDataType.count;
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
        
        
        [self showLoadDataSelectTermViewCell_ipad:cell cellForRowInSection:indexPath];
        
        return cell;
    }else{
        static NSString *defineString = @"defineString";
        SelectTermViewCell *cell = [tableView dequeueReusableCellWithIdentifier:defineString];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"SelectTermViewCell" owner:self options:nil]objectAtIndex:0];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        
        [self showLoadDataSelectTermViewCell:cell cellForRowInSection:indexPath];
        
        return cell;
    }
    
}
- (void)showLoadDataSelectTermViewCell:(SelectTermViewCell *)cell cellForRowInSection:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.labTitle.text = _dicUserInfor[@"email"];
        cell.labType.text = IsEnglish ? @"Change password": @"修改密码";
        
    }else{
        cell.labTitle.text = _arrDataType[indexPath.row];
        
        
        if (indexPath.row >2) {
            cell.selectionStyle = UITableViewCellSelectionStyleGray;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
        }else{
            cell.labType.textColor = [UIColor blackColor];
        }
        
        switch (indexPath.row ) {
            case 0:
                cell.labType.text = _dicUserInfor[@"company"];
                break;
            case 1:
                cell.labType.text = _dicUserInfor[@"state"];
                break;
            case 2:
                cell.labType.text = _dicUserInfor[@"username"];
                break;
            case 3:
                cell.labType.text = _dicUserInfor[@"mobile"];
                break;
            case 4:
                cell.labType.text = _dicUserInfor[@"bgphone"];
                break;
                
            default:
                break;
        }
    }
}
- (void)showLoadDataSelectTermViewCell_ipad:(SelectTermViewCell_ipad *)cell cellForRowInSection:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.labTitle.text = _dicUserInfor[@"email"];
        cell.labType.text = IsEnglish ? @"Change password":@"修改密码";
        
    }else{
        cell.labTitle.text = _arrDataType[indexPath.row];
        
        
        if (indexPath.row >2) {
            cell.selectionStyle = UITableViewCellSelectionStyleGray;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
        }else{
            cell.labType.textColor = [UIColor blackColor];
        }
        
        switch (indexPath.row ) {
            case 0:
                cell.labType.text = _dicUserInfor[@"company"];
                break;
            case 1:
                cell.labType.text = _dicUserInfor[@"state"];
                break;
            case 2:
                cell.labType.text = _dicUserInfor[@"username"];
                break;
            case 3:
                cell.labType.text = _dicUserInfor[@"mobile"];
                break;
            case 4:
                cell.labType.text = _dicUserInfor[@"bgphone"];
                break;
                
            default:
                break;
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        //修改密码
        [self beginPushChangeNumberVC:0];
    }else{
        //修改手机号码
        if (indexPath.row == 3) {
           [self beginPushChangeNumberVC:1];
        }else if (indexPath.row == 4)
        {//修改电话
            [self beginPushChangeNumberVC:2];
        }
    }
}

- (void)beginPushChangeNumberVC:(int)index
{
    ChangeNumViewController *changeNumVC = [[ChangeNumViewController alloc] initWithNibName:isPad  ? @"ChangeNumViewController-ipad":@"ChangeNumViewController" bundle:nil];
    changeNumVC.changeNumberType = index;
    [self.navigationController pushViewController:changeNumVC animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
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
