//
//  Connection.m
//  ChaoLin
//
//  Created by seven on 13-12-4.
//  Copyright (c) 2013年 深圳呱呱网络科技有限公司. All rights reserved.
//

#import "Connection.h"
#import "Reachability.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "JSONKit.h"
#import "DataDefine.h"

#define _SEVER_URL   @"www.apple.com"
#define SYSTEM_REQUEST_TIMEOUT  15
static Connection * _shareInstance = nil;

@interface Connection ()
{
    __block ASIHTTPRequest *_request;
    
}
@property (nonatomic,strong) NSMutableArray *queueRequestArray;
@property (nonatomic , strong)__block ASIHTTPRequest *request;
@end

@implementation Connection
@synthesize queueRequestArray = _queueRequestArray;

- (void)dealloc {
    if (_request) {
        [_request isCancelled];
        [_request clearDelegatesAndCancel];
        _request = nil;
    }
}

+ (Connection *)shareInstance {
    if (_shareInstance == nil) {
        _shareInstance = [[Connection alloc] init];
        _shareInstance.queueRequestArray = [[NSMutableArray alloc] init];
    }
    return _shareInstance;
}
//- (id)init
//{
//    self = [super init];
//    if (self) {
//        bself = self;
//    }
//    return self;
//}
//检查网络
+ (BOOL)checkNetwork{
    
    Reachability *reachability = [Reachability reachabilityWithHostName:_SEVER_URL];
    return  [reachability connectedToNetWork];
    
}

- (void)cancelCurrentRequest:(ASIHTTPRequest *)request {
    
    for (ASIFormDataRequest *re in _queueRequestArray) {
        
        if (request == re) {
            if (request) {
                [_queueRequestArray removeObject:re];
                [request clearDelegatesAndCancel];
                request = nil;
            }
        }
        
    }
}

- (void)cancelAllRequest {
    for (ASIFormDataRequest *request in _queueRequestArray) {
        if (request) {
            [_queueRequestArray removeObject:request];
            [request clearDelegatesAndCancel];
        }
    }
    
}


- (void)requestWithParams:(NSMutableDictionary *)aParams withURL:(NSString *)url withType:(RequestType)type completed:(void (^)(id, ResponseType))completed{
    
    if (CHECK_NETWORK) {
        
        NSString *requestType = nil;

        if (type == POST) {
            requestType = @"POST";
            _request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASE_REQUEST_URL,url]]];
            for (id aKey in aParams) {
                [(ASIFormDataRequest *)_request setPostValue:[aParams objectForKey:aKey] forKey:aKey];
            }
        } else if (type == GET){
            _request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASE_REQUEST_URL,url]]];
            requestType = @"GET";
        }
        
        [_shareInstance.queueRequestArray addObject:_request];
        
        
        [_request setRequestMethod:requestType];
        [_request setTimeOutSeconds:SYSTEM_REQUEST_TIMEOUT];
        [_request setShouldAttemptPersistentConnection:NO];
        [_request startAsynchronous];
        __block Connection *bself = self;
        
        [_request setCompletionBlock:^{

            //转化成字典
            NSMutableDictionary *response = [NSMutableDictionary dictionaryWithDictionary:[[bself->_request responseString] objectFromJSONString]];
            
            [bself cancelCurrentRequest:bself->_request];
            
            NSInteger codeStatus = [[response objectForKey:@"status"] integerValue];
            
            ResponseType responseType = [bself handeCode:codeStatus];
            
            if (completed) {
                
                if (responseType == SUCCESS) {
                    completed(response,responseType);
                } else if (responseType == FAIL) {
                    completed([response objectForKey:@"message"],responseType);
                    
                }
                
            }
        }];
        
        [_request setFailedBlock:^{
            
            NSLog(@"error %@",[bself->_request.error description]);
            if (completed) {
                completed(IsEnglish ? @"The request failed" : @"请求失败",FAIL);
            }
            [bself cancelCurrentRequest:bself->_request];
            
        }];
        
    } else {
        if (completed) {
            if (completed) {
                completed(IsEnglish ? @"No network" : @"无网络",FAIL);
            }
        }
    }
}

- (ResponseType)handeCode:(NSInteger)code {
    
    if (code == 1) {
        //请求成功
        return SUCCESS;
    } else {

        return FAIL;
    }
}

@end
