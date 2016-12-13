//
//  OfferViewController.m
//  GlassessBiz
//
//  Created by Guibin on 14-5-21.
//  Copyright (c) 2014年 深圳呱呱网络科技有限公司. All rights reserved.
//

#import "OfferViewController.h"
#import "OfferViewCell.h"
#import "OfferViewCell_ipad.h"
#import "CustomOneTableView.h"
#import "SelectTermViewController.h"
#import "CollectSql.h"
#import "ReferSal.h"
#import "EXPandButton.h"
#import "ItemDetailsViewController.h"
@interface OfferViewController ()<UITableViewDataSource,UITableViewDelegate,CustomOneTableViewDelegate>
{
    CustomOneTableView      *_customOneTableView;
    IBOutlet UITableView    *_tableView;
    
    IBOutlet UILabel *_labTitle1;
    IBOutlet UILabel *_labTitle2;
    IBOutlet UILabel *_labTitle3;
    
    IBOutlet UIButton *_btnType1;
    IBOutlet UIButton *_btnType2;
    IBOutlet UIButton *_btnType3;
    
    IBOutlet UILabel *_labType1;
    IBOutlet UILabel *_labType2;
    IBOutlet UILabel *_labType3;
    

    IBOutlet UIImageView *_footViewBg;
    IBOutlet UIButton   *_btnCollect;
    IBOutlet UIButton   *_btnNext;
    
    
    NSInteger           _titleIndex;
    
    NSInteger           _maxNum;
    NSInteger           _leastNum;
    BOOL                _isCollect;
}
@property (nonatomic , strong)NSMutableArray *arrSelect; //保存已收藏的button数据（从已收藏赋值）
@property (nonatomic , strong)NSMutableDictionary   *dicData;
@end

@implementation OfferViewController
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
    if (_offerType == offerTypeGlassess) {
        self.labTitle.text = IsEnglish ? @"Eyewear Product Quotation Enquiry" : @"眼镜类报价查询";
    }else if (_offerType == offerTypeChemistry)
    {
        self.labTitle.text = IsEnglish ? @"Chemicals Quotation Enquiry" : @"化学类报价查询";
    }else{
        self.labTitle.text = IsEnglish ? @"Materials Quotation Enquiry" : @"材料类报价查询";
    }
    
    _isCollect = NO;
    _maxNum = 0;
    _leastNum = 0;
    self.arrSelect = [[NSMutableArray alloc] initWithCapacity:0];
    self.dicData = [[NSMutableDictionary alloc] init];
    [self initShowView];
    
    [self initLoadData];
}
- (void)initShowView
{
    CGRect footViewFrmae = _footViewBg.frame;
    footViewFrmae.origin.y = SCREEN_HEIGHT - footViewFrmae.size.height-(iOS7 ? 64:64);
    _footViewBg.frame = footViewFrmae;
    _btnCollect.frame = CGRectMake(X(_btnCollect), Y(_footViewBg)+10, WIDTH(_btnCollect), HEIGHT(_btnCollect));
    _btnNext.frame = CGRectMake(X(_btnNext), Y(_footViewBg)+10, WIDTH(_btnNext), HEIGHT(_btnNext));
    
    _customOneTableView = [[CustomOneTableView alloc] initWithFrame:CGRectMake(0.0f, -self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height) withType:NoTopView withDataSource1:nil];
    _customOneTableView.delegate = self;
    [self.view addSubview:_customOneTableView];
   

    
    LOG(@"_arrTitleType = %@",_arrTitleType);
    if (_arrTitleType.count >0) {
        NSDictionary *dic = _arrTitleType[0];
        [_labType1 setText:dic[@"type1"]];
        [_labType2 setText:dic[@"type2"]];
        [_labType3 setText:dic[@"type3"]];
        
        
        _btnType1.tag = [dic[@"pid"] integerValue];
        _btnType2.tag = [dic[@"rid"] integerValue];
        _btnType3.tag = [dic[@"nid"] integerValue];
        _isCollect = YES;
        
    }
    
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}
- (NSString *)titleTypeJcsort
{
    NSString *type = @"";
    if (_offerType == offerTypeGlassess) {
        type = @"眼镜类";
    }else if (_offerType == offerTypeChemistry)
    {
        type = @"化学类";
    }else{
        type = @"材料类";
    }
    return type;
}
- (void)initLoadData
{
    if (_arrTitleType.count ==0) {
        [_arrSelect removeAllObjects];
        
        _maxNum = 0;
        _leastNum = 0;
    }
    [self.view addHUDActivityView:Loading];
    
    
    NSString *type = [self titleTypeJcsort];
    
    LOG(@"userid = %@",USERID);
    NSDictionary *dic = @{langType:language,@"uid":USERID,@"jcsort":type,@"pid":@(_btnType1.tag),@"rid":@(_btnType2.tag),@"nid":@(_btnType3.tag)};
    LOG(@"type = %@",dic);
    
    [[Connection shareInstance] requestWithParams:[NSMutableDictionary dictionaryWithDictionary:dic] withURL:Api_QueryList  withType:POST completed:^(id content, ResponseType responseType) {
        [self.view removeHUDActivityView];
        
        if (responseType == SUCCESS)
        {
             LOG(@"data = %@",content[@"data"]);
            [self.dicData setDictionary:content[@"data"]];
//            NSMutableArray *showListArr = [NSMutableArray arrayWithArray:self.dicData[@"list"]];
//            for (int i=0; i<showListArr.count; i++) {
//                NSInteger isallxm = [showListArr[i][@"isallxm"] integerValue];
//                if (isallxm == 1) {
//                    [showListArr removeObjectAtIndex:i];
//                }
//            }
//            [self.dicData setObject:showListArr forKey:@"list"];
            
            [self selectCollectItemsList];
            
            [_tableView reloadData];

        } else if (responseType == FAIL) {
            [self.view addHUDLabelView:content Image:nil afterDelay:1.0f];
            [self.dicData removeAllObjects];
            [_tableView reloadData];
        }
        
    }];
}
- (void)selectCollectItemsList
{
    if (_arrTitleType.count ==0) {
        return;
    }
    
    NSArray *arrData = [self cellListDataArr];
    
    [_arrSelect removeAllObjects];
    
    __block BOOL isShow = NO;
    [arrData enumerateObjectsUsingBlock:^(NSDictionary *dicList, NSUInteger idx, BOOL *stop) {
        
        NSInteger ID = [dicList[@"id"] integerValue];
        [_arrTitleType enumerateObjectsUsingBlock:^(NSDictionary *dic, NSUInteger idx, BOOL *stop) {
            if (ID == [dic[@"id"] integerValue]) {
                isShow = YES;
            }
        }];
        
        if (isShow) {
            [_arrSelect addObject:@[@(idx),@(ID)]];
        }
        isShow = NO;
    }];
    
}
#pragma  mark 选择title类型
//产品分类
- (IBAction)selectProtuctAction:(UIButton *)sender {
    _titleIndex = 1;
    _customOneTableView.nameType = @"cname";
    
    [self.view addHUDActivityView:Loading];
     NSString *type = [self titleTypeJcsort];
    
    [[Connection shareInstance] requestWithParams:[NSMutableDictionary dictionaryWithDictionary:@{langType:language,@"jcsort":type}] withURL:Api_GetpsList  withType:POST completed:^(id content, ResponseType responseType) {
        [self.view removeHUDActivityView];
        
        if (responseType == SUCCESS)
        {
            LOG(@"data = %@",content[@"data"]);
             [_customOneTableView showData:content[@"data"]];

        } else if (responseType == FAIL) {
            [self.view addHUDLabelView:content Image:nil afterDelay:1.0f];
        }
        
    }];

}
//选择地区
- (IBAction)selectLatitudeAction:(UIButton *)sender {
    _titleIndex = 2;
    _customOneTableView.nameType = @"cname";
    [self.view addHUDActivityView:Loading];
    
    NSString *type = [self titleTypeJcsort];
    LOG(@"btn1.tag = %d",_btnType1.tag);
    
    [[Connection shareInstance] requestWithParams:[NSMutableDictionary dictionaryWithDictionary:@{langType:language,@"jcsort":type,@"pid":@(_btnType1.tag)}] withURL:Api_GetprList  withType:POST completed:^(id content, ResponseType responseType) {
        [self.view removeHUDActivityView];
        
        if (responseType == SUCCESS)
        {
            LOG(@"data = %@",content[@"data"]);
            [_customOneTableView showData:content[@"data"]];
            
        } else if (responseType == FAIL) {
            [self.view addHUDLabelView:content Image:nil afterDelay:1.0f];
        }
        
    }];
}
//标准名称
- (IBAction)selectStandardAction:(UIButton *)sender {
    _titleIndex = 3;
    _customOneTableView.nameType = @"sname";
    
    [self.view addHUDActivityView:Loading];
    NSString *type = [self titleTypeJcsort];
    LOG(@"btn1.tag = %d-- btn2.tag = %d",_btnType1.tag,_btnType2.tag);
    
    [[Connection shareInstance] requestWithParams:[NSMutableDictionary dictionaryWithDictionary:@{langType:language,@"jcsort":type,@"pid":@(_btnType1.tag),@"rid":@(_btnType2.tag)}] withURL:Api_GetPnList  withType:POST completed:^(id content, ResponseType responseType) {
        [self.view removeHUDActivityView];
        
        if (responseType == SUCCESS)
        {
            LOG(@"data = %@",content[@"data"]);
            [_customOneTableView showData:content[@"data"]];
            
        } else if (responseType == FAIL) {
            [self.view addHUDLabelView:content Image:nil afterDelay:1.0f];
        }
        
    }];
}

#pragma mark 收藏
- (IBAction)selectCollectAction:(UIButton *)sender {
    
    if (_arrSelect.count ==0) {
        [self.view addHUDLabelView:IsEnglish ? @"Please select a category in the collection": @"请选择类别再收藏" Image:nil afterDelay:2.f];
        return;
    }
    __block BOOL isFinish = NO;
    
    __block NSMutableArray *ldsArray = [NSMutableArray array];
    NSMutableArray *arrCollectLds = [NSMutableArray arrayWithArray:[SavaData parseArrFromFile:COLLECT_LDS_ITEMS]];
    NSMutableArray *cellectArr = [CollectSql getCollectData:USERID];
    
    if (cellectArr.count >0) {
        [_arrSelect enumerateObjectsUsingBlock:^(NSArray *arrData, NSUInteger index, BOOL *stop )
         {
             NSInteger tag0 = [arrData[0]integerValue];
             NSInteger tag1 = [arrData[1]integerValue];

             [cellectArr enumerateObjectsUsingBlock:^(NSDictionary *dic, NSUInteger index1,BOOL *stop)
              {
                  
                  NSString *type1 = dic[@"type1"];
                  NSString *type2 = dic[@"type2"];
                  NSString *type3 = dic[@"type3"];
                  NSInteger collectID = [dic[@"id"] integerValue];
                  
                  if (collectID ==tag1 && [type1 isEqualToString:_labType1.text] && [type2 isEqualToString:_labType2.text] && [type3 isEqualToString:_labType3.text])
                  {
                      isFinish = YES;
                  }else{
                     
                  }
              }];
             
             if (!isFinish) {
                 
                 NSMutableDictionary *dicData = [NSMutableDictionary dictionaryWithDictionary:[self cellListDataArr][tag0]];
                 [dicData setObject:_labType1.text forKey:@"type1"];
                 [dicData setObject:_labType2.text forKey:@"type2"];
                 [dicData setObject:_labType3.text forKey:@"type3"];

                 //收藏到数据库
                 [CollectSql selctCollectData:dicData andUid:USERID];
                 
                 [self.view addHUDLabelView:IsEnglish ? @"Current query conditions have been collected sussesfully":@"当前查询条件收藏成功" Image:nil afterDelay:1.f];
                 
                  [ldsArray addObject:@(tag1)];
                 
             }else{
                  [self.view addHUDLabelView:IsEnglish ? @"The current record is saved in 'my collection'":@"已收藏当前查询条件" Image:nil afterDelay:1.f];
             }
             
             isFinish = NO;

         }];
    }else{
        
        [_arrSelect enumerateObjectsUsingBlock:^(NSArray *arrTag, NSUInteger index, BOOL *stop )
         {
             NSInteger tag0 = [arrTag[0] integerValue];
             NSInteger tag1 = [arrTag[1] integerValue];
             NSMutableDictionary *dicData = [NSMutableDictionary dictionaryWithDictionary:[self cellListDataArr][tag0]];
             [dicData setObject:_labType1.text forKey:@"type1"];
             [dicData setObject:_labType2.text forKey:@"type2"];
             [dicData setObject:_labType3.text forKey:@"type3"];

             //收藏到数据库
             [CollectSql selctCollectData:dicData andUid:USERID];
             
             [ldsArray addObject:@(tag1)];

             
             [self.view addHUDLabelView:IsEnglish ? @"Current query conditions have been collected sussesfully":@"当前查询条件收藏成功" Image:nil afterDelay:1.f];
         }];
    }
    
    if (ldsArray.count ==0) {
        return;//避免重复收藏
    }
    
    NSString *ldsSelect = [[ldsArray componentsJoinedByString:@","] JSONString];
    if (arrCollectLds.count) {
        __block BOOL isCollectLDS = NO;
        
        [arrCollectLds enumerateObjectsUsingBlock:^(NSArray *arrLDS, NSUInteger idx, BOOL *stop) {
            NSString *strLDS = [[arrLDS componentsJoinedByString:@","] JSONString];
            if ([ldsSelect isEqualToString:strLDS]) {
                isCollectLDS = YES;
            }
        }];
        if (!isCollectLDS) {
            [arrCollectLds addObject:ldsArray];
            [SavaData writeArrToFile:arrCollectLds FileName:COLLECT_LDS_ITEMS];
        }
    }else{
        [arrCollectLds addObject:ldsArray];
        [SavaData writeArrToFile:arrCollectLds FileName:COLLECT_LDS_ITEMS];
    }
    
    
   
    

}
#pragma mark 下一步
- (IBAction)selectNextAction:(UIButton *)sender {
    if (_arrSelect.count ==0) {
        [self.view addHUDLabelView:IsEnglish ? @"Please select a category":@"请选择类别才能操作" Image:nil afterDelay:2.f];
        return;
    }
    
//    NSInteger allnum = [_dicData[@"bjnumber"][@"allnum"]  integerValue];
//    NSInteger oddnum = [_dicData[@"bjnumber"][@"oddnum"] integerValue];
//    NSString *allStr = [NSString stringWithFormat:@"不可超过最大检测项数目限制:%ld",(long)allnum];
//    NSString *oddStr = [NSString stringWithFormat:@"不可小于最小检测项数目限制:%ld",(long)oddnum];
//    if (_arrSelect.count > allnum) {
//        [self.view addHUDLabelView:allStr Image:nil afterDelay:2.f];
//        return;
//    }else if (_arrSelect.count < oddnum) {
//        [self.view addHUDLabelView:oddStr Image:nil afterDelay:2.f];
//        return;
//    }
    
    SelectTermViewController *selectTermVC = [[SelectTermViewController alloc] initWithNibName:isPad ? @"SelectTermViewController-ipad":@"SelectTermViewController" bundle:nil];
    selectTermVC.arrLds = [self getSelectArrDataID];
//    selectTermVC.arrScanList = [self getSelectScanListData];
    [self getSelectScanListData:^(NSArray *arr1, NSArray *arr2) {
        selectTermVC.arrScanList = arr1;
        selectTermVC.arrQueryLds = arr2;
    }];
    [self.navigationController pushViewController:selectTermVC animated:YES];
}
//获取项目id
- (NSMutableArray *)getSelectArrDataID
{
    NSMutableArray *arr = [NSMutableArray array];
    for (NSArray *arrTag in _arrSelect) {
        
        [arr addObject:arrTag[1]];
    }
    return arr;
}
- (void)getSelectScanListData:(void (^)(NSArray *arr1 , NSArray *arr2))block
{
    __block BOOL isFinish = NO;
    __block NSMutableArray *arrInfo = [NSMutableArray array];
    __block NSMutableArray *ldsArray = [NSMutableArray array];
   
    NSMutableArray *cellectArr = [ReferSal getReferFileData:USERID];
    
    if (cellectArr.count >0) {
        [_arrSelect enumerateObjectsUsingBlock:^(NSArray *arrData, NSUInteger index, BOOL *stop )
         {
             NSInteger tag0 = [arrData[0]integerValue];
             NSInteger tag1 = [arrData[1]integerValue];
             
             [cellectArr enumerateObjectsUsingBlock:^(NSDictionary *dic, NSUInteger index1,BOOL *stop)
              {
                  
                  NSString *type1 = dic[@"type1"];
                  NSString *type2 = dic[@"type2"];
                  NSString *type3 = dic[@"type3"];
                  NSInteger collectID = [dic[@"id"] integerValue];
                  
                  if (collectID ==tag1 && [type1 isEqualToString:_labType1.text] && [type2 isEqualToString:_labType2.text] && [type3 isEqualToString:_labType3.text])
                  {
                      isFinish = YES;
                  }else{
                      
                  }
              }];
             
             if (!isFinish) {
                 
                 NSMutableDictionary *dicData = [NSMutableDictionary dictionaryWithDictionary:[self cellListDataArr][tag0]];
                 [dicData setObject:_labType1.text forKey:@"type1"];
                 [dicData setObject:_labType2.text forKey:@"type2"];
                 [dicData setObject:_labType3.text forKey:@"type3"];
                 
                 [arrInfo addObject:dicData];
                 
                 [ldsArray addObject:@(tag1)];
                 
                 block (arrInfo , ldsArray);
//                 //收藏到数据库
//                 [ReferSal readReferFileData:dicData andUid:USERID];
//                 
//                 [self.view addHUDLabelView:@"当前查询条件收藏成功" Image:nil afterDelay:2.f];
             }else{
//                 [self.view addHUDLabelView:@"已收藏当前查询条件  " Image:nil afterDelay:2.f];
             }
             
             isFinish = NO;
             
         }];
    }else{
        
        [_arrSelect enumerateObjectsUsingBlock:^(NSArray *arrTag, NSUInteger index, BOOL *stop )
         {
             NSInteger tag0 = [arrTag[0] integerValue];
             NSInteger tag1 = [arrTag[1] integerValue];
             NSMutableDictionary *dicData = [NSMutableDictionary dictionaryWithDictionary:[self cellListDataArr][tag0]];
             [dicData setObject:_labType1.text forKey:@"type1"];
             [dicData setObject:_labType2.text forKey:@"type2"];
             [dicData setObject:_labType3.text forKey:@"type3"];
             
              [arrInfo addObject:dicData];
             
             [ldsArray addObject:@(tag1)];
             
              block (arrInfo , ldsArray);
             //把查看的数据收藏到数据库
//             [ReferSal readReferFileData:dicData andUid:USERID];
             
//             [self.view addHUDLabelView:@"当前查询条件收藏成功" Image:nil afterDelay:2.f];
         }];
    }

}
- (NSArray *)cellListDataArr
{
    NSArray * arrData = _dicData[@"list"];
    if (arrData.count>0) {
        return arrData;
    }
    return nil;
}
- (NSString *)cellForRowContent:(NSInteger)index value:(NSString *)text
{
    id obj = [self cellListDataArr][index][text];
    NSString *content = [NSString stringWithFormat:@"%@",obj];
    if ([content isEqualToString:@"<null>"]) {
        return @"0";
    }
    return content;
}
#define mark UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    LOG(@"cell.count = %d",[self cellListDataArr].count);
    return  [self cellListDataArr].count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (isPad) {
        static NSString *defineString = @"defineString";
        OfferViewCell_ipad *cell = [tableView dequeueReusableCellWithIdentifier:defineString];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"OfferViewCell_ipad" owner:self options:nil]objectAtIndex:0];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        [self showLoadDataOfferViewCell_ipad:cell cellForRowInSection:indexPath];
        
        return cell;
    }else{
        static NSString *defineString = @"defineString";
        OfferViewCell *cell = [tableView dequeueReusableCellWithIdentifier:defineString];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"OfferViewCell" owner:self options:nil]objectAtIndex:0];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        [self showLoadDataOfferViewCell:cell cellForRowInSection:indexPath];
        
        return cell;
    }
   
}
- (void)showLoadDataOfferViewCell:(OfferViewCell *)cell cellForRowInSection:(NSIndexPath *)indexPath
{
    NSInteger ID = [[self cellListDataArr][indexPath.row][@"id"] integerValue];
    NSInteger isallxm = [[self cellListDataArr][indexPath.row][@"isallxm"] integerValue];
    cell.btnSelect.btnID = ID;
    cell.btnSelect.isallxm = isallxm;
    cell.btnSelect.tag = indexPath.row;
    cell.BtnDetail.tag = indexPath.row;
    
    [cell.btnSelect addTarget:self action:@selector(selectTypeStatus:) forControlEvents:UIControlEventTouchUpInside];
    [cell.BtnDetail addTarget:self action:@selector(didSelectDetailAction:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.labTypeName.text   =  [self cellForRowContent:indexPath.row value:IsEnglish ? @"ename" : @"cname"];
    cell.labNum1.text       =  [self cellForRowContent:indexPath.row value:@"number"];
    cell.labNum2.text       =  [self cellForRowContent:indexPath.row value:@"workday"];
    
    //从收藏进入时，第一次加载要去添加；点击选择时，不再添加，因为选择时已添加了数组中
    if (_isCollect) {
        [self changeTitleLab];
    }
    
    for (NSArray *arrBtn in _arrSelect) {
        if (ID == [arrBtn[1] integerValue]) {
            cell.btnSelect.selected = YES;
            cell.imageBg.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"login_btn_Landed_unpressed"]];
        }
    }
    
}
- (void)showLoadDataOfferViewCell_ipad:(OfferViewCell_ipad *)cell cellForRowInSection:(NSIndexPath *)indexPath
{
    NSInteger ID = [[self cellListDataArr][indexPath.row][@"id"] integerValue];
    NSInteger isallxm = [[self cellListDataArr][indexPath.row][@"isallxm"] integerValue];
    cell.btnSelect.btnID = ID;
    cell.btnSelect.isallxm = isallxm;
    cell.btnSelect.tag = indexPath.row;
    cell.BtnDetail.tag = indexPath.row;
    
    [cell.btnSelect addTarget:self action:@selector(selectTypeStatus:) forControlEvents:UIControlEventTouchUpInside];
    [cell.BtnDetail addTarget:self action:@selector(didSelectDetailAction:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.labTypeName.text   =  [self cellForRowContent:indexPath.row value:IsEnglish ? @"ename" : @"cname"];
    cell.labNum1.text       =  [self cellForRowContent:indexPath.row value:@"number"];
    cell.labNum2.text       =  [self cellForRowContent:indexPath.row value:@"workday"];
    
    //从收藏进入时，第一次加载要去添加；点击选择时，不再添加，因为选择时已添加了数组中
    if (_isCollect) {
        [self changeTitleLab];
    }

    
    for (NSArray *arrBtn in _arrSelect) {
        if (ID == [arrBtn[1] integerValue]) {
            cell.btnSelect.selected = YES;
            cell.imageBg.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"login_btn_Landed_unpressed"]];
        }
    }

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 72;
}

#pragma mark 选中产品类型

- (void)selectTypeStatus:(EXPandButton *)btn
{
    btn.selected = !btn.selected;
    
    if (btn.selected)
    {
        //判断选择查看提交是否大于最多，小于最少
        NSInteger allnum = [_dicData[@"bjnumber"][@"allnum"] integerValue];
        NSInteger oddnum = [_dicData[@"bjnumber"][@"oddnum"] integerValue];
        
        NSString *allStr = [NSString stringWithFormat:IsEnglish ? @"Should not exceed the numbers of all item(s) quotation :%ld item(s)":@"不可超过检测全项数目报价:%ld",(long)allnum];
        NSString *oddStr = [NSString stringWithFormat:IsEnglish ? @"Should not exceed the numbers of single item(s) quotation :%ld item(s)":@"不可超出检测单项数目报价:%ld",(long)oddnum];
        
        if (btn.isallxm == 0) {//单项目查询
            _maxNum += 1;
            if (_maxNum > oddnum) {
                btn.selected = !btn.selected;
                _maxNum -= 1;
                [self.view addHUDLabelView:oddStr Image:nil afterDelay:2.f];
                return;
            }
        }else{//全项目查询
            _leastNum +=1;
            if (_leastNum > allnum) {
                btn.selected = !btn.selected;
                _leastNum -= 1;
                [self.view addHUDLabelView:allStr Image:nil afterDelay:2.f];
                return;
            }
        }
        
        _isCollect = NO;
        [self.arrSelect addObject:@[@(btn.tag),@(btn.btnID)]];
        
    }else{
        
        if (btn.isallxm == 0) {
            _maxNum -= 1;
        }else{
            _leastNum -= 1;
        }
        
        for (int i =0;i<_arrSelect.count;i++) {
            NSInteger tagV = [_arrSelect[i][0] integerValue];
            if (btn.tag == tagV) {
                [self.arrSelect removeObjectAtIndex:i];
            }
        }
        
        if (_arrSelect.count ==0) {
            _maxNum = 0;
            _leastNum = 0;
        }
    }
    
    [_tableView reloadData];
    
    //计算选中的title值
    [self changeTitleLab];
}
//改变类别的显示个数
- (void)changeTitleLab
{
    _labTitle1.text = [NSString stringWithFormat:@"%d %@",_arrSelect.count,IsEnglish ? @"item(s)":@"项"];
    
    NSInteger number1 = 0;

    NSMutableArray *numArr = [NSMutableArray array];
    
    for (NSArray *arrTag in _arrSelect) {
        NSInteger index = [arrTag[0] integerValue];
        number1 += [[self cellListDataArr][index][@"number"] integerValue];
         NSNumber *number2 = [self cellListDataArr][index][@"workday"];
        [numArr addObject:number2];
    }
    _labTitle2.text = [NSString stringWithFormat:@"%d",number1];
    
    int temp;
    for (int i=0;i<numArr.count;i++)
    {
        for (int j=0;j<numArr.count -i-1;j++)
        {
            if ([numArr[j] intValue] < [numArr[j + 1] intValue])
            {
                temp = [numArr[j] intValue];
                [numArr replaceObjectAtIndex:j withObject:numArr[j+1]];
                [numArr replaceObjectAtIndex:j+1 withObject:[NSNumber numberWithInt:temp]];
            }
        }
    }
    
    if (numArr.count>0) {
        _labTitle3.text = [NSString stringWithFormat:@"%@ %@",numArr[0],IsEnglish ? @"day(s)":@"天"];
    }else{
        _labTitle3.text = IsEnglish ? @"0 day(s)":@"0天";
    }
    
}
- (void)cleanTitleTypeNum
{
    _labTitle1.text = IsEnglish ? @"0 item(s)":@"0项";
    _labTitle2.text = @"0";
    _labTitle3.text = IsEnglish ? @"0 day(s)":@"0天";
    
    
}
#pragma  mark 项目描述-详情
- (void)didSelectDetailAction:(UIButton *)btn
{
    ItemDetailsViewController *itemDetailsVC = [[ItemDetailsViewController alloc] initWithNibName:isPad ? @"ItemDetailsViewController-ipad" : @"ItemDetailsViewController" bundle:nil];
    itemDetailsVC.content =  [self cellListDataArr][btn.tag][@"cdescription"];
    [self.navigationController pushViewController:itemDetailsVC animated:YES];
}
#pragma mark CustomOneTableViewDelegate
- (void)customOneTableView:(CustomOneTableView *)customOneTableView withSelectCell:(UITableViewCell *)cell withIndex:(NSIndexPath *)indexPath typeID:(NSInteger)typeID{
    NSLog(@"取得选中的数据 = %@",cell.textLabel.text);
    if (_titleIndex ==1) {
        
        [[DataStorer sharedInstance].dicDefiner removeAllObjects];
        
        _labType1.text = cell.textLabel.text;
//        [_btnType1 setTitle:cell.textLabel.text forState:UIControlStateNormal];
        _btnType1.tag = typeID;
        [[DataStorer sharedInstance].dicDefiner setObject:cell.textLabel.text forKey:@"type1"];
        
        _btnType2.tag = 0;
        _btnType3.tag = 0;
        _labType2.text = IsEnglish ? @"Region":@"地区";
        _labType3.text = IsEnglish ? @"Test standard(s)":@"标准名称";
        
//        [_btnType2 setTitle:IsEnglish ? @"Region":@"地区" forState:UIControlStateNormal];
//        [_btnType3 setTitle:IsEnglish ? @"Standard name":@"标准名称" forState:UIControlStateNormal];
        [self cleanTitleTypeNum];
    }else if (_titleIndex == 2)
    {
         _labType2.text = cell.textLabel.text;
//        [_btnType2 setTitle:cell.textLabel.text forState:UIControlStateNormal];
        _btnType2.tag = typeID;
        [[DataStorer sharedInstance].dicDefiner setObject:cell.textLabel.text forKey:@"type2"];
    }else{
         _labType3.text = cell.textLabel.text;
//        [_btnType3 setTitle:cell.textLabel.text forState:UIControlStateNormal];
        _btnType3.tag = typeID;
        [[DataStorer sharedInstance].dicDefiner setObject:cell.textLabel.text forKey:@"type3"];
    }
    [_arrSelect removeAllObjects];
    _maxNum = 0;
    _leastNum = 0;
    
    [self initLoadData];
    [customOneTableView hide];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
