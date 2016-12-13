//
//  CustomOneTableView.h
//  ChaoLin
//
//  Created by jianle chen on 13-12-16.
//  Copyright (c) 2013年 深圳呱呱网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    HaveTopView = 0,
    NoTopView
}Type;

@protocol CustomOneTableViewDelegate;

@interface CustomOneTableView : UIView <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,retain) NSMutableArray *dataSource1;
@property (nonatomic,assign) id<CustomOneTableViewDelegate> delegate;
@property (nonatomic , copy) NSString *nameType;
- (id)initWithFrame:(CGRect)frame withType:(Type)type withDataSource1:(NSMutableArray *)dataSource;

//展示
- (void)showData:(NSMutableArray *)arrData;

//隐藏
- (void)hide;

@end

@protocol CustomOneTableViewDelegate <NSObject>

@optional
- (void)customOneTableView:(CustomOneTableView *)customOneTableView withSelectCell:(UITableViewCell *)cell withIndex:(NSIndexPath *)indexPath typeID:(NSInteger)typeID;

@end
