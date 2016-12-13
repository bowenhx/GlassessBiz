//
//  SelectTermViewController.h
//  GlassessBiz
//
//  Created by Guibin on 14-5-22.
//  Copyright (c) 2014年 深圳呱呱网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
@interface SelectTermViewController : BaseViewController<ASIHTTPRequestDelegate>
@property (nonatomic , strong)NSArray    *arrLds;
@property (nonatomic , strong)NSArray    *arrScanList;
@property (nonatomic , strong)NSArray    *arrQueryLds;
@end
