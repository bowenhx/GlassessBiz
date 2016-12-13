//
//  DataStorer.h
//  GlassessBiz
//
//  Created by Guibin on 14-5-20.
//  Copyright (c) 2014年 深圳呱呱网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataStorer : NSObject
+ (DataStorer *)sharedInstance;

@property (nonatomic , strong)NSMutableArray *arrDefiner;
@property (nonatomic , strong)NSMutableDictionary *dicDefiner;
@property (nonatomic , assign)BOOL isNews;
@property (nonatomic , assign)BOOL isLogin; //判断是否是登录进入成员
@property (nonatomic , assign)NSInteger backQuery;// 判断查看是否重复操作

//@property (nonatomic) NSInteger countNews; //消息个数对比
//判断是否有新消息推送过来
//+ (BOOL)requestNewsPush;

@end
