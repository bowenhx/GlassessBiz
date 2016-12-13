//
//  BaseTableViewController.h
//  ChaoLinSecond
//
//  Created by Guibin on 14-4-24.
//  Copyright (c) 2014年 cai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface BaseTableViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>

@property (retain, nonatomic) UITableView *baseTableView;

@property (nonatomic , strong)NSMutableArray *arrData;
@property (nonatomic , strong)NSMutableDictionary *dicData;
@property (nonatomic , assign)UITableViewStyle baseTableViewStype;

@end
