//
//  Connection.h
//  ChaoLin
//
//  Created by seven on 13-12-4.
//  Copyright (c) 2013年 深圳呱呱网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    POST = 1,
    GET
}RequestType;

typedef enum {
    SUCCESS = 1,
    FAIL,
}ResponseType;

@interface Connection : NSObject

+ (Connection *)shareInstance;
//检查网络
+(BOOL)checkNetwork;


- (void)requestWithParams:(NSMutableDictionary *)aParams withURL:(NSString *)url withType:(RequestType)type completed:(void (^)(id content,ResponseType responseType))completed;

- (void)cancelAllRequest;
@end
