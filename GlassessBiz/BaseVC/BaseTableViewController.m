//
//  BaseTableViewController.m
//  ChaoLinSecond
//
//  Created by Guibin on 14-4-24.
//  Copyright (c) 2014年 cai. All rights reserved.
//

#import "BaseTableViewController.h"

@interface BaseTableViewController ()

@end

@implementation BaseTableViewController

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
    self.baseTableView.backgroundColor =  [SavaData getColor:@"dcdddd" alpha:1.f];
    _arrData = [[NSMutableArray alloc] initWithCapacity:0];
    _dicData = [[NSMutableDictionary alloc] initWithCapacity:0];
    
    [self loadTableView];
    // Do any additional setup after loading the view from its nib.
}
- (void)loadTableView
{
     UITableView *tmpTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-65) style:self.baseTableViewStype];
    self.baseTableView = tmpTable;
    [self.view addSubview:_baseTableView];
    _baseTableView.delegate = self;
    _baseTableView.dataSource = self;
//    _baseTableView.backgroundColor = [SavaData getColor:@"dcdddd" alpha:1.f];
//    _baseTableView.layer.borderWidth = 3;
//    _baseTableView.layer.borderColor = [UIColor greenColor].CGColor;
    if (self.baseTableViewStype == UITableViewStyleGrouped)
    {
        UIView *tmpView =[[UIView alloc] initWithFrame:CGRectMake(0, 44, 320, self.baseTableView.frame.size.height)];
        self.baseTableView.backgroundView = tmpView;
        self.baseTableView.backgroundView.backgroundColor = RGBCOLOR(238, 242, 245);
    }

}
- (void)showLoadData
{
    
}
#pragma mark -   TableViewDataSource / delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.arrData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
