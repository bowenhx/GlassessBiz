//
//  ItemDetailsViewController.m
//  GlassessBiz
//
//  Created by Guibin on 14-7-29.
//  Copyright (c) 2014年 深圳呱呱网络科技有限公司. All rights reserved.
//

#import "ItemDetailsViewController.h"

@interface ItemDetailsViewController ()
{

    __weak IBOutlet UITextView *_textView;
    
}
@end

@implementation ItemDetailsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.labTitle.text = IsEnglish ? @"Test item(s) description": @"项目描述";
    
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    _textView.text = _content;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
