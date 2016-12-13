//
//  OfferViewCell.h
//  GlassessBiz
//
//  Created by Guibin on 14-5-21.
//  Copyright (c) 2014年 深圳呱呱网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EXPandButton.h"
@interface OfferViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *imageBg;
@property (strong, nonatomic) IBOutlet EXPandButton *btnSelect;
@property (weak, nonatomic) IBOutlet UIButton *BtnDetail;
@property (strong, nonatomic) IBOutlet UILabel *labTypeName;
@property (strong, nonatomic) IBOutlet UIImageView *imageLine;
@property (strong, nonatomic) IBOutlet UILabel *labNum1;
@property (strong, nonatomic) IBOutlet UILabel *labNum2;


@end
