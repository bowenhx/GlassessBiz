//
//  ForgetViewController.h
//  GlassessBiz
//
//  Created by Guibin on 14-5-20.
//  Copyright (c) 2014年 深圳呱呱网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
        forgetTypeSend,
        forgetTypeVerify,
}forgetType;
@interface ForgetViewController : BaseViewController
@property (nonatomic , strong)NSMutableDictionary *dicUserInfo;
//@property (nonatomic , strong)NSDictionary *dicUserInfo;
@property (nonatomic)forgetType fotgetStatus;
@end
