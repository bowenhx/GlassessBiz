//
//  SelectTermViewCell_ipad.h
//  GlassessBiz
//
//  Created by Guibin on 14-10-14.
//  Copyright (c) 2014年 深圳呱呱网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectTermViewCell_ipad : UITableViewCell


@property (strong, nonatomic) IBOutlet UILabel *labTitle;

@property (strong, nonatomic) IBOutlet UILabel *labType;
@property (strong, nonatomic) UIButton *btnDetail;

- (void)changeLabelFrame;

@end
