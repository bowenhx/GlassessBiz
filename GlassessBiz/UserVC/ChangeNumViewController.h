//
//  ChangeNumViewControllerr.h
//  GlassessBiz
//
//  Created by Guibin on 14-5-23.
//  Copyright (c) 2014年 深圳呱呱网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *const UpdataUserInforDataNotificationCenter = @"updataUserInforDataNotificationCenter";
typedef enum {
    changeNumberType_Password = 0,  //修改密码
    changeNumberType_Phone = 1,     //修改手机号码
    changeNumberType_TelePhone = 2, //修改办公电话
}changeNumType;

@interface ChangeNumViewController : BaseTableViewController

@property (nonatomic)changeNumType changeNumberType;

@end
