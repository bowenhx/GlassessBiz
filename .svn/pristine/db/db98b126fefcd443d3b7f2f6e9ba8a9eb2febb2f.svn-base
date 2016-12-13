//
//  BaseDatas.m
//  GlassessBiz
//
//  Created by Guibin on 14-5-23.
//  Copyright (c) 2014年 深圳呱呱网络科技有限公司. All rights reserved.
//

#import "BaseDatas.h"
#import "DataDefine.h"
@implementation BaseDatas

+ (FMDatabase *)getBaseDatasInstance
{
    NSString *paths = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) objectAtIndex:0];
    NSString * fileName = [paths stringByAppendingPathComponent:@"glassess.db"];
    FMDatabase * db = [FMDatabase databaseWithPath:fileName];
    return db;
}
+ (void)openBaseDatas:(NSString *)uid
{
    FMDatabase *fmDats = [BaseDatas getBaseDatasInstance];
    if (![fmDats open])
    {
        return;
    }
    else
    {
        //在这里创建数据表
        [self creatTable:fmDats andUserId:uid];
    }
    [fmDats setShouldCacheStatements:YES];
    [fmDats beginTransaction];
    [fmDats commit];
    
}

+ (void)creatTable:(FMDatabase *)fmDats andUserId:(NSString *)uid{
    
    if (![fmDats tableExists:@"DBVersion"]) {
        [fmDats executeUpdate:DBVersion];
    }
    
    if (![fmDats tableExists:[NSString stringWithFormat:@"Collect_%@",uid]]) {
        [fmDats executeUpdate:Collect(uid)];
    }
    if (![fmDats tableExists:[NSString stringWithFormat:@"ReferData_%@",uid]]) {
        [fmDats executeUpdate:ReferData(uid)];
    }
}

+ (void)closeBaseDatas:(NSString *)uid
{
	FMDatabase *fmDats = [BaseDatas getBaseDatasInstance];
    if (![fmDats close])
    {
    }else
    {
    }
}
@end
