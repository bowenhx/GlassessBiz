//
//  OfferViewController.h
//  GlassessBiz
//
//  Created by Guibin on 14-5-21.
//  Copyright (c) 2014年 深圳呱呱网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    offerTypeGlassess = 0,
    offerTypeChemistry = 1,
    offerTypeMaterial = 2,
}offerTypes;
@interface OfferViewController : BaseViewController



@property (nonatomic)offerTypes offerType;
@property (nonatomic , strong)NSArray *arrTitleType;


@end
