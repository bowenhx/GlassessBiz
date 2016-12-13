//
//  SavaData.m
//  CarMobile
//
//  Created by Guibin on 14-4-21.
//  Copyright (c) 2014年 Guibin. All rights reserved.
//

#import "SavaData.h"
#import "DataDefine.h"

@implementation SavaData

static SavaData * _shareInstance = nil;

+ (SavaData *)shareInstance{
    if (!_shareInstance) {
        _shareInstance = [[SavaData alloc] init];
    }
    return _shareInstance;
}

+ (UIColor *)getColor:(NSString *)hexColor alpha:(CGFloat)alpha{
    unsigned int red, green, blue;
    NSRange range;
    range.length = 2;
    
    range.location = 0;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&red];
    range.location = 2;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&green];
    
    range.location = 4;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&blue];
    
    return [UIColor colorWithRed:(float)(red/255.0f) green:(float)(green/255.0f) blue:(float)(blue/255.0f) alpha:alpha];
}


-(NSString *)currentUid {
    return [NSString stringWithFormat:@"%d", [[NSUserDefaults standardUserDefaults] integerForKey:USER_ID_SAVA]];
    //    return [[NSUserDefaults standardUserDefaults] stringForKey:USER_ID_SAVA];
}

-(NSMutableDictionary *)dataForUser:(NSString *)uid
{
    if (uid.length > 0) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:uid]];
        if (dict != nil) {
            return dict;
        } else {
            return [NSMutableDictionary dictionary];
        }
    }
    return nil;
}

//保存bool值类型
- (void)savaDataBool:(BOOL)dataBool KeyString:(NSString *)key{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([key isEqualToString:USER_ID_SAVA]) {
        
        [defaults setBool:dataBool forKey:key];
        
    }
    NSMutableDictionary *dict = [self dataForUser:[self currentUid]];
    if (dict) {
        [dict setValue:[NSNumber numberWithBool:dataBool] forKey:key];
        [defaults setValue:dict forKey:[self currentUid]];
    } else {
        [defaults setBool:dataBool forKey:key];
    }
    [defaults synchronize];
    
    
}

- (BOOL)printBoolData:(NSString *)key{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *dict = [self dataForUser:[self currentUid]];
    if (dict) {
        return [[dict objectForKey:key] boolValue];
    } else {
        return [defaults boolForKey:key];
    }
    
}
//保存nsinteger
- (void)savaDataInteger:(NSInteger)dataInt KeyString:(NSString*)key{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([key isEqualToString:USER_ID_SAVA]) {
        [defaults setInteger:dataInt forKey:key];
    }
    NSMutableDictionary *dict = [self dataForUser:[self currentUid]];
    if (dict) {
        [dict setValue:[NSNumber numberWithInteger:dataInt] forKey:key];
        [defaults setValue:dict forKey:[self currentUid]];
    } else {
        [defaults setInteger:dataInt forKey:key];
    }
    [defaults synchronize];
}
- (NSInteger)printDataInteger:(NSString*)key{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *dict = [self dataForUser:[self currentUid]];
    if (dict) {
        return [[dict objectForKey:key] integerValue];
    } else {
        return [defaults integerForKey:key];
    }
}

//保存字符串类型
- (void)savadataStr:(NSString*)dataStr KeyString:(NSString*)key{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([key isEqualToString:USER_ID_SAVA]) {//保存用户ID
        
        [defaults setValue:dataStr forKey:key];
        
    }
    NSMutableDictionary *dict = [self dataForUser:[self currentUid]];
    if (dict) {//用户登录的情况下，按照用户ID存储
        [dict setValue:dataStr forKey:key];
        [defaults setValue:dict forKey:[self currentUid]];
    } else {//用户没登录的情况下，没ID存储(像注册里面的存储)
        [defaults setValue:dataStr forKey:key];
    }
    [defaults synchronize];
}

- (NSString*)printDataStr:(NSString*)key{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *dict = [self dataForUser:[self currentUid]];
    if (dict) {
        return [dict objectForKey:key];
    } else {
        return [defaults objectForKey:key];
    }
}

//保存数组类型
- (void)savaArray:(NSMutableArray *)dataAry KeyString:(NSString *)key{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *dict = [self dataForUser:[self currentUid]];
    if (dict) {
        [dict setValue:dataAry forKey:key];
        [defaults setValue:dict forKey:[self currentUid]];
    } else {
        [defaults setValue:dataAry forKey:key];
    }
    [defaults synchronize];
}

- (NSMutableArray*)printDataAry:(NSString *)key{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *dict = [self dataForUser:[self currentUid]];
    if (dict) {
        return [NSMutableArray arrayWithArray:[dict objectForKey:key]];
    } else {
        return [NSMutableArray arrayWithArray:[defaults objectForKey:key]];
    }
}

//保存字典类型
- (void)savaDictionary:(NSDictionary *)dataDic keyString:(NSString *)key{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString * uid = [self currentUid];
    NSString *str = [NSString stringWithFormat:@"%@_%@",key,[self currentUid]];
    if (uid) {
        [defaults setObject:dataDic forKey:str];
    } else {
        [defaults setObject:dataDic forKey:key];
    }
    [defaults synchronize];
}

- (NSMutableDictionary*)printDataMutableDic:(NSString *)key{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *str = [NSString stringWithFormat:@"%@_%@",key,[self currentUid]];
    NSDictionary *dict = [defaults dictionaryForKey:str];
    NSMutableDictionary *result = nil;
    if (dict) {
        result = [NSMutableDictionary dictionaryWithDictionary:[dict objectForKey:key]];
    } else {
        result = [NSMutableDictionary dictionaryWithDictionary:[defaults objectForKey:key]];
    }
    return result == nil ? [NSMutableDictionary dictionary] : result;
}

- (NSDictionary*)printDataDic:(NSString *)key{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *uid = [self currentUid];
    NSString *str = [NSString stringWithFormat:@"%@_%@",key,[self currentUid]];
    NSDictionary *dict = nil;//[NSDictionary dictionary];
    if (uid) {
        dict = [defaults dictionaryForKey:str];
        
    }else{
        dict = [defaults dictionaryForKey:key];
    }
    return dict;
}

//把数组写入文件
+(void) writeArrToFile:(NSArray *)arr FileName:(NSString *)file
{
	NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *path=[paths    objectAtIndex:0];
    NSString *filename=[path stringByAppendingPathComponent:file];
    
    [arr writeToFile:filename  atomically:YES];
}

//解析文件得到数组
+(NSMutableArray *) parseArrFromFile:(NSString *)file
{
	NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
	NSString *path=[paths   objectAtIndex:0];
	NSString *filename=[path stringByAppendingPathComponent:file];
	NSMutableArray *array= [[NSMutableArray alloc] initWithContentsOfFile:filename];
	return array;
}
//把字典写入文件
+(void) writeDicToFile:(NSDictionary *)dic FileName:(NSString *)file
{
	NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *path=[paths objectAtIndex:0];
    NSString *filename=[path stringByAppendingPathComponent:file];
    BOOL isFinish = [dic writeToFile:filename  atomically:YES];
    LOG(@"写入本地文件状态为： %d",isFinish);
    
}
//解析文件得到字典
+(NSDictionary *)parseDicFromFile:(NSString *)file
{
	NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
	NSString *path=[paths objectAtIndex:0];
	NSString *filename=[path stringByAppendingPathComponent:file];
	NSMutableDictionary *dic= [NSMutableDictionary dictionaryWithContentsOfFile:filename] ;
	return dic;
}

+ (NSString *)convertTimestempToDateWithString:(NSString *)timeStemp{
    NSTimeInterval interval = [timeStemp doubleValue] / 1000;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy.MM.dd"];
    NSString *dateStr = [dateFormatter stringFromDate:date];
    
    return dateStr;
}
//创建用户路径
+(NSString *)setUserInfoData:(NSString *)pathName
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *savePath = [SavaData getZipFilePathManager];
    if (![fileManager fileExistsAtPath:savePath]) {
        [fileManager createDirectoryAtPath:savePath withIntermediateDirectories:YES attributes:nil error:nil];
        NSString *textPath = [savePath stringByAppendingPathComponent:@"text.txt"];
        [fileManager createFileAtPath:textPath contents:[pathName dataUsingEncoding:NSUTF8StringEncoding] attributes:nil];
    }else
    {
        return @"0";
    }
    return savePath;
}

//建立用户文件夹
+ (NSString *)getZipFilePathManager
{
    //在Library下的Documentation创建文件
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    //    NSString *downFileName = [NSString stringWithFormat:@"userNew%@",USERID];
    NSString *testDirectory = [documentsDirectory stringByAppendingPathComponent:@"userText"];
    
    return  testDirectory;
}

//取出用户文件路径
+ (NSString *)getOutUserFile
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *savePath = [SavaData getZipFilePathManager];
    
    NSArray *arrFiles = [fileManager subpathsAtPath:savePath];
    
    NSString *strFile = [savePath stringByAppendingPathComponent:arrFiles[0]];
    NSString *textPath = [NSString stringWithContentsOfFile:strFile encoding:NSUTF8StringEncoding error:nil];
    
    return textPath;
}
//删除用户信息文件
+ (void)removeUserDataManager
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *savePath = [SavaData getZipFilePathManager];
    if ( [fileManager removeItemAtPath:savePath error:NULL] ) {
        LOG(@"删除用户数据成功");
    }
}
+ (BOOL)isEnglish
{
    NSArray *languages = [NSLocale preferredLanguages];
    NSString *currentLanguage = [languages objectAtIndex:0];
    if([currentLanguage hasPrefix:@"en"])
    {
        return YES;
    }
    return NO;
}
@end
