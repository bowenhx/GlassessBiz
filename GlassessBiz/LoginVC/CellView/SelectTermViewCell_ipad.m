//
//  SelectTermViewCell_ipad.m
//  GlassessBiz
//
//  Created by Guibin on 14-10-14.
//  Copyright (c) 2014年 深圳呱呱网络科技有限公司. All rights reserved.
//

#import "SelectTermViewCell_ipad.h"

@implementation SelectTermViewCell_ipad

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)changeLabelFrame
{
    self.labType.textAlignment = NSTextAlignmentLeft;
    
    _btnDetail = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnDetail.frame = CGRectMake(WIDTH(self)-150, 0, 150, HEIGHT(self));
    [_btnDetail setTitle:IsEnglish ? @"Details": @"了解详情" forState:UIControlStateNormal];
    [_btnDetail setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"glasses_btn_next_unpressed"]]];
    [self.contentView addSubview:_btnDetail];
    
}
@end
