//
//  MyCollectViewController.h
//  GlassessBiz
//
//  Created by Guibin on 14-5-23.
//  Copyright (c) 2014年 深圳呱呱网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    jcsortTypeCollect   = 0,        //我的收藏
    jcsortTypeScanList  = 1,        //我查看过的报价
}jcsortType;
@interface MyCollectViewController : BaseViewController

@property (nonatomic) jcsortType jcsortTypePage;
@end
