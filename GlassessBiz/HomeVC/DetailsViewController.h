//
//  DetailsViewController.h
//  GlassessBiz
//
//  Created by Guibin on 14-5-21.
//  Copyright (c) 2014年 深圳呱呱网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    detailsContentType = 0,
    newsContentType = 1,
}contentType;

@interface DetailsViewController : BaseViewController

@property (nonatomic)contentType contentType;
@property (nonatomic , strong)NSDictionary *dicData;


@end
