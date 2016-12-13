//
//  DataStorer.m
//  GlassessBiz
//
//  Created by Guibin on 14-5-20.
//  Copyright (c) 2014年 深圳呱呱网络科技有限公司. All rights reserved.
//

#import "DataStorer.h"
#import "DataDefine.h"
@implementation DataStorer

static DataStorer *_sharedInstance = nil;

+ (DataStorer *)sharedInstance
{
    if (!_sharedInstance) {
        _sharedInstance = [[DataStorer alloc] init];
        
    }
    return _sharedInstance;
}
- (id)init
{
    self = [super init];
    if (self) {
        _isNews = NO;
        _arrDefiner = [[NSMutableArray alloc] init];
        _dicDefiner = [[NSMutableDictionary alloc] init];
    }
    return self;
}
//+ (BOOL)requestNewsPush
//{
//    __block BOOL isFinish = NO;
//    [[Connection shareInstance] requestWithParams:[NSMutableDictionary dictionaryWithDictionary:@{@"page":@(1),@"pagesize":@(10)}] withURL:Api_PushListUrl  withType:POST completed:^(id content, ResponseType responseType) {
//        
//        if (responseType == SUCCESS)
//        {
//            LOG(@"data = %@",content[@"data"]);
//            NSArray *arr = content[@"data"][@"list"];
//            NSInteger count = [[SavaData shareInstance] printDataInteger:@"countNews"];
//            if (arr.count == count ) {
//                isFinish = NO;
//                [[SavaData shareInstance] savadataStr:@"1" KeyString:NewsImage];
//            }else{
//                isFinish = YES;
//            }
//            [[SavaData shareInstance] savaDataInteger:[arr count] KeyString:@"countNews"] ;
//        }
//    }];
//    return isFinish;
//}
//+ (NSURL *)getVersionUpdata:(NSInteger)index
//{
//    NSString *address = @"version/isupdate/";
//    NSString *strUrl = [NSString stringWithFormat:@"%@%@&page=%d&size=%d",BASE_REQUEST_URL,address,page,size];
//    NSURL *url = [NSURL URLWithString:strUrl];
//    return url;
//    
//}


@end
