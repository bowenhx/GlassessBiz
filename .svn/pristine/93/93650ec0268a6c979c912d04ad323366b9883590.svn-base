//
//  MyCollectViewController.m
//  GlassessBiz
//
//  Created by Guibin on 14-5-23.
//  Copyright (c) 2014年 深圳呱呱网络科技有限公司. All rights reserved.
//

#import "MyCollectViewController.h"
#import "YFJLeftSwipeDeleteTableView.h"
#import "CollectViewCell.h"
#import "CollectSql.h"
#import "ReferSal.h"
#import "OfferViewController.h"
#import "ResultViewController.h"
#import "CollectViewCell_ipad.h"

@interface MyCollectViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    
    NSMutableArray         *_arrData;
    
}
@property (nonatomic, strong) UITableView * tableView;
@end

@implementation MyCollectViewController

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
    if (_jcsortTypePage == jcsortTypeCollect) {
        self.labTitle.text = IsEnglish ? @"My collection": @"我的收藏";
    }else{
        self.labTitle.text = IsEnglish ? @"My enquires": @"我的查询";
    }
    
   
    [self initLoadView];
    
    [self initLoadData];
}
- (void)initLoadView
{
    self.rightbtn.hidden = NO;
    [self.rightbtn setTitle:IsEnglish ? @"Clear": @"清空" forState:UIControlStateNormal];
    [self.rightbtn setTitleColor:[SavaData getColor:@"a0c23a" alpha:1.f] forState:UIControlStateNormal];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,CommonMinusNavHeight(self.view))];
    float flo = [[UIScreen mainScreen] currentMode].size.height;
    if (flo <1136) {
        _tableView.frame = CGRectMake(0, 0, WIDTH(self.view), SCREEN_HEIGHT-64);
    }
    _tableView.delegate = self;
    _tableView.dataSource = self;
//    _tableView.layer.borderWidth = 1;
//    _tableView.layer.borderColor = [UIColor redColor].CGColor;
    [self.view addSubview:_tableView];
}
- (void)initLoadData
{
    _arrData = [[NSMutableArray alloc] initWithCapacity:0];
    
    if (_jcsortTypePage == jcsortTypeCollect) {
        
        [_arrData setArray:[self showListData:0 isList:YES]];
    }else{
        
        [_arrData setArray:[self queryListData:0 isFirst:YES]];
    }
    
   
     LOG(@"_arrdata = %@",_arrData);
}
- (NSInteger)titleTypeJcsort:(NSInteger)index
{
    NSString *jcsort = _arrData[index][@"jcsort"];
    
    if ([jcsort isEqualToString:@"眼镜类"]) {
        return 0;
    }else if ([jcsort isEqualToString:@"化学类"])
    {
        return 1;
    }else{
        return 2;
    }
    return 0;
}
#pragma  mark TableView
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
        CollectViewCell_ipad *cell = [tableView dequeueReusableCellWithIdentifier:defineString];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"CollectViewCell_ipad" owner:self options:nil]objectAtIndex:0];
            cell.selectionStyle = UITableViewCellSelectionStyleGray;
        }
        [self showLoadDataCollectViewCell_ipad:cell cellForRowInSection:indexPath];
        return cell;
    }else{
        static NSString *defineString = @"defineString";
        CollectViewCell *cell = [tableView dequeueReusableCellWithIdentifier:defineString];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"CollectViewCell" owner:self options:nil]objectAtIndex:0];
            cell.selectionStyle = UITableViewCellSelectionStyleGray;
        }
        [self showLoadDataCollectViewCell:cell cellForRowInSection:indexPath];
        return cell;
    }
   
}
//收藏显示列表数据
- (NSMutableArray *)showListData:(NSInteger)row isList:(BOOL)isFirst
{
     NSMutableArray *arrLds = [NSMutableArray arrayWithArray:[SavaData parseArrFromFile:COLLECT_LDS_ITEMS]];
    __block NSMutableArray *arrList = [[NSMutableArray alloc] initWithCapacity:0];
    NSMutableArray *collectArr = [NSMutableArray arrayWithArray:[CollectSql getCollectData:USERID]];
   
    arrLds = (NSMutableArray *)[[arrLds reverseObjectEnumerator] allObjects];
    
    if (isFirst) {
        [arrLds enumerateObjectsUsingBlock:^(NSArray *ldsArr, NSUInteger idx, BOOL *stop) {
            NSInteger collectID = [ldsArr[0] integerValue];
            
            [collectArr enumerateObjectsUsingBlock:^(NSDictionary *dicObj, NSUInteger idx, BOOL *stop) {
                if (collectID == [dicObj[@"id"] integerValue]) {
                    [arrList addObject:dicObj];
                }
                
            }];
        }];
    }else{
        NSArray *arrLDSCollect = arrLds.count > row ? arrLds[row] : arrLds[arrLds.count-1];
        [arrLDSCollect enumerateObjectsUsingBlock:^(NSNumber *number, NSUInteger idx, BOOL *stop) {
            NSInteger collectID = [number integerValue];
            
            [collectArr enumerateObjectsUsingBlock:^(NSDictionary *dicObj, NSUInteger idx, BOOL *stop) {
                if (collectID == [dicObj[@"id"] integerValue]) {
                    [arrList addObject:dicObj];
                }
            }];
            
        }];
    }
    
    return arrList;
}
//查看显示列表数据
- (NSMutableArray *)queryListData:(NSInteger)row isFirst:(BOOL)isFirst
{
    NSMutableArray *arrLds = [NSMutableArray arrayWithArray:[SavaData parseArrFromFile:QUERY_LDS_ITEMS]];
    
    NSArray *collectArr = [ReferSal getReferFileData:USERID];
    __block NSMutableArray *arrList = [[NSMutableArray alloc] initWithCapacity:0];
    
    arrLds = (NSMutableArray *)[[arrLds reverseObjectEnumerator] allObjects];
    
    if (isFirst) {
        __block BOOL isAdd = YES;
        
        [arrLds enumerateObjectsUsingBlock:^(NSArray *ldsArr, NSUInteger idx, BOOL *stop) {
            NSInteger collectID = [ldsArr[ldsArr.count-1] integerValue];
            
            [collectArr enumerateObjectsUsingBlock:^(NSDictionary *dicObj, NSUInteger idx, BOOL *stop) {
                if (collectID == [dicObj[@"id"] integerValue] && isAdd) {
                    [arrList addObject:dicObj];
                    isAdd = NO;
                }
            }];
            
            isAdd = YES;
        }];
//        [arrLds enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(NSArray *ldsArr, NSUInteger idx, BOOL *stop) {
//          
//        }];

    }else{
        NSArray *arrLDSCollect = arrLds.count > row ? arrLds[row] : arrLds[arrLds.count-1];
        [arrLDSCollect enumerateObjectsUsingBlock:^(NSNumber *number, NSUInteger idx, BOOL *stop){
            NSInteger collectID = [number integerValue];
            
            [collectArr enumerateObjectsUsingBlock:^(NSDictionary *dicObj, NSUInteger idx, BOOL *stop) {
                if (collectID == [dicObj[@"id"] integerValue]) {
                    [arrList addObject:dicObj];
                }
            }];
            
        }];
    }

    return arrList;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (_jcsortTypePage == jcsortTypeCollect) {
        OfferViewController *offerVC = [[OfferViewController alloc] initWithNibName:isPad ? @"OfferViewController-ipad":@"OfferViewController" bundle:nil];
        offerVC.offerType = [self titleTypeJcsort:indexPath.row];
        offerVC.arrTitleType = [self showListData:indexPath.row isList:NO];
        [self.navigationController pushViewController:offerVC animated:YES];
    }else{
        NSDictionary *dic = [_arrData[indexPath.row][@"fields"] objectFromJSONString];
        ResultViewController *resultVC = [[ResultViewController alloc] initWithNibName:isPad ? @"ResultViewController-ipad":@"ResultViewController" bundle:nil dicInfo:(NSMutableDictionary*)dic];
        resultVC.arrQueryData = [self queryListData:indexPath.row isFirst:NO];
        resultVC.resultType = 1;
        NSInteger index = [dic[@"serviceSort"] integerValue];
        if ([DataStorer sharedInstance].arrDefiner.count >0) {
            resultVC.serveType = [DataStorer sharedInstance].arrDefiner[index];
        }else{
            resultVC.serveType = IsEnglish ? @"Regular service" : @"普通服务";
        }
        
        [self.navigationController pushViewController:resultVC animated:YES];
    }
    
    
}
- (void)showLoadDataCollectViewCell:(CollectViewCell *)cell cellForRowInSection:(NSIndexPath *)indexPath
{
    cell.labContent.text = _arrData[indexPath.row][@"type1"];
    cell.labTextType.text = _arrData[indexPath.row][@"type3"];
    cell.labTextType2.text = _arrData[indexPath.row][@"name"];
    NSString *time = [_arrData[indexPath.row][@"collectTime"] substringToIndex:11];
    cell.labTextTime.text = time;
}
- (void)showLoadDataCollectViewCell_ipad:(CollectViewCell_ipad *)cell cellForRowInSection:(NSIndexPath *)indexPath
{
    cell.labContent.text = _arrData[indexPath.row][@"type1"];
    cell.labTextType.text = _arrData[indexPath.row][@"type3"];
    cell.labTextType2.text = _arrData[indexPath.row][@"name"];
    NSString *time = [_arrData[indexPath.row][@"collectTime"] substringToIndex:11];
    cell.labTextTime.text = time;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSString *delectId = _arrData[indexPath.row][@"id"];
        [_arrData removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
      
        if (_jcsortTypePage == jcsortTypeCollect)
       {
           if ([CollectSql deleteCollectDataID:delectId]) {
               NSMutableArray *collectLDS = [NSMutableArray arrayWithArray:[SavaData parseArrFromFile:COLLECT_LDS_ITEMS]];
               [collectLDS removeObjectAtIndex:indexPath.row];
               [SavaData writeArrToFile:collectLDS FileName:COLLECT_LDS_ITEMS];
               [self.view addHUDLabelView:IsEnglish ? @"Database successfully updated": @"数据库更新成功" Image:nil afterDelay:2.f];
           }
       }else {
           if ([ReferSal deleteReferFileDataID:delectId])
           {
               NSMutableArray *collectLDS = [NSMutableArray arrayWithArray:[SavaData parseArrFromFile:QUERY_LDS_ITEMS]];
               [collectLDS removeObjectAtIndex:indexPath.row];
               [SavaData writeArrToFile:collectLDS FileName:QUERY_LDS_ITEMS];
               [self.view addHUDLabelView:IsEnglish ? @"Database successfully updated":@"数据库更新成功" Image:nil afterDelay:2.f];
           }
       }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
#define mark 清空数据缓存
- (void)tapRightBtn
{
    if (_jcsortTypePage == jcsortTypeCollect) {
        if ([CollectSql deleteCollectListTable]) {
            [_arrData removeAllObjects];
            [_tableView reloadData];
            [SavaData writeArrToFile:@[] FileName:COLLECT_LDS_ITEMS];
            [self.view addHUDLabelView:IsEnglish ? @"Cache data deleted successfully": @"缓存数据删除成功" Image:nil afterDelay:2.f];
        }
    }else{
        if ([ReferSal deleteReferFileDataListTable]) {
            [_arrData removeAllObjects];
            [_tableView reloadData];
             [SavaData writeArrToFile:@[] FileName:QUERY_LDS_ITEMS];
            [self.view addHUDLabelView:IsEnglish ? @"Cache data deleted successfully": @"缓存数据删除成功" Image:nil afterDelay:2.f];
        }
    }

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
