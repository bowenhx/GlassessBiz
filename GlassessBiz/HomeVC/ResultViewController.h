//
//  ResultViewController.h
//  GlassessBiz
//
//  Created by Guibin on 14-5-22.
//  Copyright (c) 2014年 深圳呱呱网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
typedef enum
{
    resultTypeSelect    = 0,    //从选择条件进入该页面
    resultTypeCollect   = 1,    //从缓存信息进入该页面
    
}resultType;
@interface ResultViewController : BaseTableViewController<MFMailComposeViewControllerDelegate,ASIHTTPRequestDelegate>

@property (nonatomic , copy)NSString *serveType;
@property (nonatomic , strong)NSArray *arrQueryData;
@property (nonatomic )resultType resultType;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil dicInfo:(NSMutableDictionary *)dicInfo;
@end
