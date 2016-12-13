//
//  ResultDtlViewController.m
//  GlassessBiz
//
//  Created by Guibin on 14-5-27.
//  Copyright (c) 2014年 深圳呱呱网络科技有限公司. All rights reserved.
//

#import "ResultDtlViewController.h"
#import "ResultDtlViewCell.h"
#import "ResultDtlViewCell_ipad.h"
@interface ResultDtlViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray  *_arrData;
    
}
@end

@implementation ResultDtlViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil idsID:(NSString *)idsId
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self initLoadData:idsId];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.labTitle.text = IsEnglish ? @"Details（subtotal）": @"详情（小计）";
   
}
- (void)initLoadData:(NSString *)idsID
{
    [self.view addHUDActivityView:Loading];

    [[Connection shareInstance] requestWithParams:[NSMutableDictionary dictionaryWithDictionary:@{langType:language,@"ids":idsID,@"uid":USERID}] withURL:Api_ProductList  withType:POST completed:^(id content, ResponseType responseType) {
        [self.view removeHUDActivityView];
        
        if (responseType == SUCCESS)
        {
            LOG(@"data = %@",content[@"data"]);
            
            _arrData = [NSMutableArray arrayWithArray:content[@"data"]];
            
            [self.baseTableView reloadData];
        } else if (responseType == FAIL) {
            [self.view addHUDLabelView:content Image:nil afterDelay:2.0f];
        }
        
    }];
}
#define mark UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arrData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (isPad) {
        static NSString *defineString = @"defineString";
        ResultDtlViewCell_ipad *cell = [tableView dequeueReusableCellWithIdentifier:defineString];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"ResultDtlViewCell_ipad" owner:nil options:nil]objectAtIndex:0];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.labTitle.textColor = [SavaData getColor:@"004861" alpha:1.f];
        }
        
        [self showLoadDataResultDtlViewCell_ipad:cell cellForRowInSection:indexPath];
        
        return cell;
    }else{
        static NSString *defineString = @"defineString";
        ResultDtlViewCell *cell = [tableView dequeueReusableCellWithIdentifier:defineString];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"ResultDtlViewCell" owner:nil options:nil]objectAtIndex:0];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.labTitle.textColor = [SavaData getColor:@"004861" alpha:1.f];
        }
        
        [self showLoadDataResultDtlViewCell:cell cellForRowInSection:indexPath];
        
        return cell;
    }
    
   
}
- (void)showLoadDataResultDtlViewCell_ipad:(ResultDtlViewCell_ipad *)cell cellForRowInSection:(NSIndexPath *)indexPath
{
    cell.labTitle.text      = _arrData[indexPath.row][@"cname"];
    cell.labNumber1.text    = _arrData[indexPath.row][@"number"];
    cell.labNumber2.text    = _arrData[indexPath.row][@"workday"];
    cell.labNumber3.text    = _arrData[indexPath.row][@"offer"];
}
- (void)showLoadDataResultDtlViewCell:(ResultDtlViewCell *)cell cellForRowInSection:(NSIndexPath *)indexPath
{
    cell.labTitle.text      = _arrData[indexPath.row][@"cname"];
    cell.labNumber1.text    = _arrData[indexPath.row][@"number"];
    cell.labNumber2.text    = _arrData[indexPath.row][@"workday"];
    cell.labNumber3.text    = _arrData[indexPath.row][@"offer"];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
