//
//  CountryViewController.m
//  GlassessBiz
//
//  Created by Guibin on 14-5-20.
//  Copyright (c) 2014年 深圳呱呱网络科技有限公司. All rights reserved.
//

#import "CountryViewController.h"

@interface CountryViewController ()

@end

@implementation CountryViewController

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
    self.labTitle.text = IsEnglish ? @"Country" : @"国家";
    
    [self initData];
    // Do any additional setup after loading the view from its nib.
}
- (void)initData
{
    //获取国家列表
    [self.view addHUDActivityView:Loading];
    
    [[Connection shareInstance] requestWithParams:nil withURL:API_CountryURL withType:GET completed:^(id content, ResponseType responseType) {
        [self.view removeHUDActivityView];
        
        if (responseType == SUCCESS) {
            
            LOG(@"data = %@",content[@"data"]);
            self.arrData = [content[@"data"][@"list"] copy];
            
            //保存国家列表
            [SavaData writeArrToFile:self.arrData FileName:Country_list];
            [self.baseTableView reloadData];
            
        } else if (responseType == FAIL) {
            [self.view addHUDLabelView:content Image:nil afterDelay:2.0f];
        }
        
    }];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *defineCell = @"defineCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:defineCell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:defineCell];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    cell.textLabel.text = self.arrData[indexPath.row][@"country"];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *countryID = self.arrData[indexPath.row][@"id"];
    if (_changeCountryNameBlock) {
        LOG(@"cell.text = %@",cell.textLabel.text);
        _changeCountryNameBlock(cell.textLabel.text,countryID);
    }
    [self tapBackBtn];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
