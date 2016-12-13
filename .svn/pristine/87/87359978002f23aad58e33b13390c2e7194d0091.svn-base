//
//  CustomOneTableView.m
//  ChaoLin
//
//  Created by jianle chen on 13-12-16.
//  Copyright (c) 2013年 深圳呱呱网络科技有限公司. All rights reserved.
//

#import "CustomOneTableView.h"

@implementation CustomOneTableView
{
    UITableView         *_tableView;
}
@synthesize dataSource1 = _dataSource1;
@synthesize delegate = _delegate;


- (id)initWithFrame:(CGRect)frame withType:(Type)type withDataSource1:(NSMutableArray *)dataSource
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIControl *control = [[UIControl alloc] initWithFrame:self.bounds];
        control.backgroundColor = [UIColor blackColor];
        control.alpha = 0.5f;
        control.tag = 100;
        [self addSubview:control];
        
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
        tapGestureRecognizer.numberOfTapsRequired = 1;
        tapGestureRecognizer.numberOfTouchesRequired = 1;
        [control addGestureRecognizer:tapGestureRecognizer];

        
        float offsetY = 44.0f;
        
        if (type == HaveTopView) {
            
            UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 44.0f, self.frame.size.width, 44.0f)];
            topView.backgroundColor = [UIColor whiteColor];
            for (int i = 0; i < 2; i++) {
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                [button setFrame:CGRectMake(i * 200.0f + 20.0f, (topView.frame.size.height - 30.0f) / 2.0f, 80.0f, 30.0f)];
                if (i == 0) {
                    [button setTitle:@"本地标签" forState:UIControlStateNormal];
                } else if (i == 1) {
                    [button setTitle:@"外地标签" forState:UIControlStateNormal];
                }
                button.tag = 100 + i;
//                [button setTitleColor:[Common getColor:@"f87573"] forState:UIControlStateSelected];
//                [button setTitleColor:[Common getColor:@"ca3e53"] forState:UIControlStateNormal];
                
                [button addTarget:self action:@selector(buttonActtion:) forControlEvents:UIControlEventTouchUpInside];
                
                [topView addSubview:button];
            }
            
            [self addSubview:topView];

            
            offsetY = topView.frame.size.height + topView.frame.origin.y;

            
        }
        

        
        
        _dataSource1 = [[NSMutableArray arrayWithArray:dataSource] copy];
        
        //table1
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, offsetY, self.frame.size.width, self.frame.size.height - 220.0f) style:UITableViewStylePlain];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Table1Cell"];
        _tableView.tag = 500;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self addSubview:_tableView];
       

    }
    return self;
}

//展示
- (void)showData:(NSMutableArray *)arrData {
    [UIView animateWithDuration:0.3f delay:0.0f options:UIViewAnimationOptionCurveLinear animations:^{

        self.transform = CGAffineTransformMakeTranslation(0.0f, self.frame.size.height);
    } completion:^(BOOL finished) {
        
    }];
    _dataSource1 = [arrData copy];
    [_tableView reloadData];
}

- (void)hide {
    
    [UIView animateWithDuration:0.3f delay:0.0f options:UIViewAnimationOptionCurveLinear animations:^{
        self.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark  UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_dataSource1 count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Table1Cell"];
    cell.textLabel.text = _dataSource1[indexPath.row][_nameType];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

#pragma mark
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_delegate && [_delegate respondsToSelector:@selector(customOneTableView:withSelectCell:withIndex:typeID:)]) {
        
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        [_delegate customOneTableView:self withSelectCell:cell withIndex:indexPath typeID:[_dataSource1[indexPath.row][@"id"] integerValue]];
    }
    
}

#pragma mark 处理点击button切换
- (void)buttonActtion:(UIButton *)button {

    UITableView *tableView = (UITableView *)[self viewWithTag:500];
    [tableView reloadData];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
