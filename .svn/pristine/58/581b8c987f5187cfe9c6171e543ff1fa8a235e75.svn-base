//
//  ReferSal.m
//  GlassessBiz
//
//  Created by Guibin on 14-5-27.
//  Copyright (c) 2014年 深圳呱呱网络科技有限公司. All rights reserved.
//

#import "ReferSal.h"
#import "BaseDatas.h"

@implementation ReferSal

+ (NSString *)getNonceTimer
{
    //获取当前时间戳
    NSDate *date = [NSDate date];
    NSString *timeStr =[NSString stringWithFormat:@"%@",date];
    
    return timeStr;
}

+ (void)readReferFileData:(NSDictionary *)dic andUid:(NSString *)uid
{
    [BaseDatas openBaseDatas:uid];
    FMDatabase *fmDatabase = [BaseDatas getBaseDatasInstance];
    NSString *tableName = [NSString stringWithFormat:@"ReferData_%@",uid];
    if([fmDatabase open])
    {
        NSString *cname = dic[@"cname"];
        NSString *cdescription = dic[@"cdescription"];
        NSString *edescription = dic[@"edescription"];
        NSString *ename = dic[@"ename"];
        NSString *formattime = dic[@"formattime"];
        NSNumber *listID = dic[@"id"];
        NSString *jcsort = dic[@"jcsort"];
        NSString *name = dic[IsEnglish ? @"ename" : @"name"];
        NSNumber *nid = dic[@"nid"];
        NSNumber *number = dic[@"number"];
        NSNumber *offer = dic[@"offer"];
        NSNumber *pid = dic[@"pid"];
        NSNumber *rid = dic[@"rid"];
        NSNumber *workday = dic[@"workday"];
        NSString *collectTime = [self getNonceTimer];
        NSString *fields = dic[@"fields"];
        NSString *type1 = dic[@"type1"];
        NSString *type2 = dic[@"type2"];
        NSString *type3 = dic[@"type3"];
        
        
        NSString *sqlStr = [NSString stringWithFormat:@"INSERT INTO %@ (cname,cdescription,edescription,ename,formattime,listID,jcsort,name,nid,number,offer,pid,rid,workday,collectTime,fields,type1,type2,type3) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",tableName];
        BOOL successd = ([fmDatabase executeUpdate:sqlStr,cname,cdescription,edescription,ename,formattime,listID,jcsort,name,nid,number,offer,pid,rid,workday,collectTime,fields,type1,type2,type3]);
        LOG(@"创建查询数据列表 = %d",successd);
        
    }
    [fmDatabase close];
}

+ (NSMutableArray *)getReferFileData:(NSString *)uid
{
    [BaseDatas openBaseDatas:uid];
    NSMutableArray *arrData = [[NSMutableArray alloc] initWithCapacity:0];
    FMDatabase *fmDatabase = [BaseDatas getBaseDatasInstance];
    if([fmDatabase open])
    {
        NSString *tableName = [NSString stringWithFormat:@"ReferData_%@",uid];
        NSString *sql = [NSString stringWithFormat:@"select * from %@",tableName];
        FMResultSet *rs = [fmDatabase executeQuery:sql];
        if ( rs !=nil )
        {
            while ( [rs next] )
            {
                NSString *cname = [rs stringForColumn:@"cname"];
                NSString *cdescription = [rs stringForColumn:@"cdescription"];
                NSString *edescription = [rs stringForColumn:@"edescription"];
                NSString *ename = [rs stringForColumn:@"ename"];
                NSString *formattime = [rs stringForColumn:@"formattime"];
                NSNumber *listID = [NSNumber numberWithInt:[rs intForColumn:@"listID"]];
                NSString *jcsort = [rs stringForColumn:@"jcsort"];
                NSString *name = [rs stringForColumn:@"name"];
                NSNumber *nid = [NSNumber numberWithInt:[rs intForColumn:@"nid"]];
                NSNumber *number = [NSNumber numberWithInt:[rs intForColumn:@"number"]];
                NSNumber *offer = [NSNumber numberWithInt:[rs intForColumn:@"offer"]];
                NSNumber *pid = [NSNumber numberWithInt:[rs intForColumn:@"pid"]];
                NSNumber *rid = [NSNumber numberWithInt:[rs intForColumn:@"rid"]];
                NSNumber *workday = [NSNumber numberWithInt:[rs intForColumn:@"workday"]];
                NSString *collectTime = [rs stringForColumn:@"collectTime"];
                NSString *fields = [rs stringForColumn:@"fields"];
                NSString *type1 = [rs stringForColumn:@"type1"];
                NSString *type2 = [rs stringForColumn:@"type2"];
                NSString *type3 = [rs stringForColumn:@"type3"];

                if (edescription == nil) {
                    edescription = @"";
                }
                NSDictionary *dicInfo = @{@"cname":cname,@"cdescription":cdescription,@"edescription":edescription,@"ename":ename,@"formattime":formattime,@"id":listID,@"jcsort":jcsort,@"name":name,@"nid":nid,@"number":number,@"offer":offer,@"pid":pid,@"rid":rid,@"workday":workday,@"collectTime":collectTime,@"fields":fields,@"type1":type1,@"type2":type2,@"type3":type3};
                
                [arrData addObject:dicInfo];
            }
        }
    }
    return arrData;
}

+ (BOOL)deleteReferFileDataID:(NSString *)collectID
{
    FMDatabase *fmDataBase = [BaseDatas getBaseDatasInstance];
    if ([fmDataBase open]) {
        NSString *tableName = [NSString stringWithFormat:@"ReferData_%@",USERID];
        NSString *sql = [NSString stringWithFormat:@"delete from %@ where listID=?",tableName];
        if ([fmDataBase executeUpdate:sql,collectID]) {
            [fmDataBase close];
            return YES;
        }else{
            [fmDataBase close];
            return NO;
        }
    }else{
        [fmDataBase close];
        return NO;
    }
    
}

+ (BOOL)deleteReferFileDataListTable
{
    FMDatabase *fmDataBase = [BaseDatas getBaseDatasInstance];
    if ([fmDataBase open]) {
        NSString *tableName = [NSString stringWithFormat:@"ReferData_%@",USERID];
        NSString *sql = [NSString stringWithFormat:@"delete from %@",tableName];
        if ([fmDataBase executeUpdate:sql]) {
            [fmDataBase close];
            return YES;
        }else{
            [fmDataBase close];
            return NO;
        }
    }else{
        [fmDataBase close];
        return NO;
    }
}
@end
