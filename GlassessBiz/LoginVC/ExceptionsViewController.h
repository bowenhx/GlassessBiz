//
//  ExceptionsViewController.h
//  GlassessBiz
//
//  Created by Guibin on 14-5-26.
//  Copyright (c) 2014年 深圳呱呱网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    explainTypeExceptions,
    explainTypeAbout,
}explainType;
@interface ExceptionsViewController : BaseViewController
@property (nonatomic , assign)explainType explainType;

@end
