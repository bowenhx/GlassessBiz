//
//  IdeaViewController.m
//  GlassessBiz
//
//  Created by Guibin on 14-5-26.
//  Copyright (c) 2014年 深圳呱呱网络科技有限公司. All rights reserved.
//

#import "IdeaViewController.h"

@interface IdeaViewController ()<UITextViewDelegate>
{
    IBOutlet UITextView *_textView;
    IBOutlet UILabel *_labText;
    
}
@end

@implementation IdeaViewController

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
    self.labTitle.text = IsEnglish ? @"Feedback to PEL": @"意见反馈";
    self.rightbtn.hidden = NO;
    [self.rightbtn setTitle:IsEnglish ? @"Send": @"发送" forState:UIControlStateNormal];
    [self.rightbtn setTitleColor:[SavaData getColor:@"a0c23a" alpha:1.f] forState:UIControlStateNormal];
    
    _labText.text = IsEnglish ? @"Please enter your precious opinions": @"请输入你的宝贵意见";
    // Do any additional setup after loading the view from its nib.
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    _labText.hidden = YES;
    return YES;
}

//TODO:发送意见反馈
- (void)tapRightBtn
{
    LOG(@"发送意见");
    [_textView resignFirstResponder];
    
    if ([self isTextContentBlank:_textView.text]) {
        [self.view addHUDLabelView:IsEnglish ? @"Please enter your precious opinions": @"请输入你的宝贵意见" Image:nil afterDelay:2.0f];
        return;
    }
    [self.view addHUDActivityView:Loading];
    NSString *email = [SavaData parseDicFromFile:User_File][@"email"];
    NSString *mobile =  [SavaData parseDicFromFile:User_File][@"mobile"];
    LOG(@"file = %@", [SavaData parseDicFromFile:User_File]);
    LOG(@"uid = %@",USERID);
    [[Connection shareInstance] requestWithParams:(NSMutableDictionary *)@{@"uid":USERID,@"email":email,@"mobile":mobile,langType:language,@"content":_textView.text} withURL:Api_FeedBack withType:POST completed:^(id content, ResponseType responseType) {
        [self.view removeHUDActivityView];
        
        if (responseType == SUCCESS)
        {
            LOG(@"data = %@",content[@"data"]);
            [self.view addHUDLabelView:IsEnglish ? @"Opinions sent successfully": @"意见发送成功！" Image:nil afterDelay:1.0f];
            [self performSelector:@selector(tapBackBtn) withObject:nil afterDelay:1.f];
            
        } else if (responseType == FAIL) {
            [self.view addHUDLabelView:content Image:nil afterDelay:2.0f];
        }
        
    }];
   
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
