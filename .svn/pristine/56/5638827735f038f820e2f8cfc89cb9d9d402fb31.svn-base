//
//  NewsPageViewController.m
//  GlassessBiz
//
//  Created by Guibin on 14-5-22.
//  Copyright (c) 2014年 深圳呱呱网络科技有限公司. All rights reserved.
//

#import "NewsPageViewController.h"
#import "NewsViewCell.h"
#import "YFJLeftSwipeDeleteTableView.h"
#import "DetailsViewController.h"
@interface NewsPageViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray      *_arrData;
    
}
@property (nonatomic, strong) YFJLeftSwipeDeleteTableView * tableView;
@end

@implementation NewsPageViewController

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
    self.labTitle.text = IsEnglish ?@"Push Message": @"推送消息";
    
    self.rightbtn.hidden = NO;
    [self.rightbtn setTitleColor:[SavaData getColor:@"a0c23a" alpha:1.f] forState:UIControlStateNormal];
    [self.rightbtn setTitle:IsEnglish ? @"Clear": @"清空" forState:UIControlStateNormal];
    
    
    _arrData = [[NSMutableArray alloc] initWithCapacity:0];
    
    [self initLoadView];
    
    [self initLoadData];
}
- (void)initLoadView
{
    
    _tableView = [[YFJLeftSwipeDeleteTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, HEIGHT(self.view))];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    //    _tableView.layer.borderWidth = 1;
    //    _tableView.layer.borderColor = [UIColor redColor].CGColor;
    [self.view addSubview:_tableView];
}
- (void)initLoadData
{
    [self.view addHUDActivityView:Loading];
    
    [[Connection shareInstance] requestWithParams:[NSMutableDictionary dictionaryWithDictionary:@{langType:language,@"page":@(1),@"pagesize":@(10)}] withURL:Api_PushListUrl  withType:POST completed:^(id content, ResponseType responseType) {
        [self.view removeHUDActivityView];
        
        if (responseType == SUCCESS)
        {
            LOG(@"data = %@",content[@"data"]);
            NSArray *arr = content[@"data"][@"list"];
            NSMutableArray *arrID = [SavaData parseArrFromFile:Delete_News_ID];

            if (arrID.count >0) {//只显示未删除的消息
                
                 for (NSDictionary *dic in arr) {
                    NSNumber *newsID = dic[@"id"];
                     BOOL isDelete = NO;
                     
                    for (NSNumber *delID in arrID){
                        if ([newsID isEqual:delID]) {
                            LOG(@"newsID = %@,delID = %@",newsID,delID);
                            isDelete = YES;
                        }
                    }
                    
                     if (!isDelete) {
                         [_arrData addObject:dic];
                     }
                    
                }
            }else{//第一次进来显示全部推送消息
                [_arrData setArray:arr];
            }
                
            
            [self.tableView reloadData];
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
    return  _arrData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *defineString = @"defineString";
    NewsViewCell *cell = [tableView dequeueReusableCellWithIdentifier:defineString];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"NewsViewCell" owner:self options:nil]objectAtIndex:0];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }

    [self showLoadDataNewsViewCell:cell cellForRowInSection:indexPath];
    
    return cell;
}
- (void)showLoadDataNewsViewCell:(NewsViewCell *)cell cellForRowInSection:(NSIndexPath *)indexPath
{
    cell.labContent.text    = _arrData[indexPath.row][@"title"];
    cell.labTime.text       = _arrData[indexPath.row][@"formattime"];
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSString *delectId = _arrData[indexPath.row][@"id"];
         NSMutableArray *arrDeleteID = [NSMutableArray arrayWithArray:[SavaData parseArrFromFile:Delete_News_ID]];
        [arrDeleteID addObject:delectId];
        [SavaData writeArrToFile:arrDeleteID FileName:Delete_News_ID];
        [_arrData removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    DetailsViewController *detailsVC = [[DetailsViewController alloc] initWithNibName:@"DetailsViewController" bundle:nil];
    detailsVC.contentType = 1;
    detailsVC.dicData = _arrData[indexPath.row];
    [self.navigationController pushViewController:detailsVC animated:YES];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
- (void)tapRightBtn
{
    NSMutableArray *arrDeleteID = [NSMutableArray arrayWithArray:[SavaData parseArrFromFile:Delete_News_ID]];
    [_arrData enumerateObjectsUsingBlock:^(NSDictionary *dic, NSUInteger index1,BOOL *stop){
        NSNumber *delID = dic[@"id"];
        [arrDeleteID addObject:delID];
    }];
    
    [SavaData writeArrToFile:arrDeleteID FileName:Delete_News_ID];
    [_arrData removeAllObjects];
    [_tableView reloadData];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
