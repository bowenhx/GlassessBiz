//
//  ExceptionsViewController.m
//  GlassessBiz
//
//  Created by Guibin on 14-5-26.
//  Copyright (c) 2014年 深圳呱呱网络科技有限公司. All rights reserved.
//

#import "ExceptionsViewController.h"

@interface ExceptionsViewController ()
{
    __weak IBOutlet UIWebView *_webViewContent;
    
}
@end

@implementation ExceptionsViewController

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
    if (_explainType == explainTypeExceptions) {
        self.labTitle.text = IsEnglish ? @"Disclaimer" : @"免责声明";
        
    }else{
        self.labTitle.text = IsEnglish ? @"About PEL": @"关于";
    }
    
    
    // Do any additional setup after loading the view from its nib.
    [self initLoadData];
}
- (void)initLoadData
{
     [self.view addHUDActivityView:Loading];
    
    if (_explainType == explainTypeExceptions) {
        [[Connection shareInstance] requestWithParams:[NSMutableDictionary dictionaryWithDictionary:@{langType:language,@"identifier":@"mzsm"}] withURL:Api_Getexplain withType:POST completed:^(id content, ResponseType responseType) {
            [self.view removeHUDActivityView];
            
            if (responseType == SUCCESS)
            {
                
                
                LOG(@"data = %@",content[@"data"]);

                NSString *text = content[@"data"][@"content"];
                NSData *data = [text dataUsingEncoding:NSUTF8StringEncoding];
                [_webViewContent loadData:data MIMEType:@"text/html" textEncodingName:@"UTF-8" baseURL:nil];
            } else if (responseType == FAIL) {
                [self.view addHUDLabelView:content Image:nil afterDelay:2.0f];
            }
            
        }];
    }else{
        [[Connection shareInstance] requestWithParams:[NSMutableDictionary dictionaryWithDictionary:@{langType:language,@"identifier":@"gy"}] withURL:Api_Getexplain withType:POST completed:^(id content, ResponseType responseType) {
            [self.view removeHUDActivityView];
            
            if (responseType == SUCCESS)
            {
                
                
                LOG(@"data = %@",content[@"data"]);
                NSString *text = content[@"data"][@"content"];
                NSData *data = [text dataUsingEncoding:NSUTF8StringEncoding];
                [_webViewContent loadData:data MIMEType:@"text/html" textEncodingName:@"UTF-8" baseURL:nil];
//                _textViewContent.text = content[@"data"][@"content"];
                
            } else if (responseType == FAIL) {
                [self.view addHUDLabelView:content Image:nil afterDelay:2.0f];
            }
            
        }];
    }
   
    
   
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
