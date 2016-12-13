//
//  DataDefine.h
//  BloodPressure
//
//  Created by Guibin on 14-5-9.
//  Copyright (c) 2014年 深圳呱呱网络科技有限公司. All rights reserved.
//

#ifndef BloodPressure_DataDefine_h
#define BloodPressure_DataDefine_h


#define BASE_REQUEST_URL @"http://203.198.56.253:8080/api/app_api/"

//手机激活 -- TODO
#define Api_ActiveUser  @"http://203.198.56.253:8080/api/common/common/activeUser/"


//判断系统语言是否是英语
#define IsEnglish       [SavaData isEnglish]



//检查网络
#define CHECK_NETWORK      [Connection checkNetwork]

#define USER_ID_SAVA        @"OWNUSERID"

//获取用户UID
#define USERID              [[SavaData shareInstance] printDataStr:USER_ID_SAVA]

//用户信息的缓存文件plist
#define User_File           [NSString stringWithFormat:@"user_%@.plist",USERID]

//用户获取过的活动码
#define User_avCode     [NSString stringWithFormat:@"avcode_%@.plist",USERID]

//国家列表plist
#define Country_list  @"country.plist"

//存储推送用户消息ID数据
#define Delete_News_ID  [NSString stringWithFormat:@"newsID_%@.plist",USERID]

//用户是否推送消息
#define NewsImage  [NSString stringWithFormat:@"showNews_%@",USERID]

//收藏lds数据
#define COLLECT_LDS_ITEMS [NSString stringWithFormat:@"collectlds_%@.plist",USERID]

//查询过的lds显示数据
#define QUERY_LDS_ITEMS  [NSString stringWithFormat:@"querylds_%@.plist",USERID]


//获取用户登录账号
#define ChangeUsreInfoDataotificationCenter @"changeUsreInfoDataotificationCenter"

//关闭定时器监听
#define CloseNSTimerNSNotificationCenter @"closeNSTimerNSNotificationCenter"

#ifndef PX_STRONG
#if __has_feature(objc_arc)
#define PX_STRONG strong
#else
#define PX_STRONG retain
#endif
#endif

#ifndef PX_WEAK
#if __has_feature(objc_arc_weak)
#define PX_WEAK weak
#elif __has_feature(objc_arc)
#define PX_WEAK unsafe_unretained
#else
#define PX_WEAK assign
#endif
#endif

#if __has_feature(objc_arc)
#define PX_AUTORELEASE(expression) expression
#define PX_RELEASE(expression) expression
#define PX_RETAIN(expression) expression
#else
#define PX_AUTORELEASE(expression) [expression autorelease]
#define PX_RELEASE(expression) [expression release]
#define PX_RETAIN(expression) [expression retain]
#endif



//判断系统语言要传的参数
#define langType    @"langtype"
#define language  IsEnglish ? @"en" : @"ch"

#define Loading  IsEnglish ? @"Loading..." : @"正在加载..."

#define NetworkFail IsEnglish ? @"network link abnormal" : @"网络链接异常"


#define Eyewear  IsEnglish ? @"Eyewear Category" : @"眼镜类"

#define Chemical  IsEnglish ? @"Chemical Category" : @"化学类"

#define Material  IsEnglish ? @"Material Category" : @"材料类"

#define Category    IsEnglish ? @"The default category" : @"默认类别"

#define Area    IsEnglish ? @"The default area" : @"默认地区"

#define Standard    IsEnglish ? @"The default standard" : @"默认标准"



    /*-------------------------------------------------------------------------------------
     **   接口部分api
     **   这里写成宏方便调用
    */

//国家列表
#define API_CountryURL @"member/stateList"

//注册
#define API_RegisterURL @"member/register/"

//发送邮件激活帐号
#define Api_SendEmail @"member/sendEmail/"

//发送手机验证码激活帐号
#define Api_SendMobileSms @"member/sendMobileSms/"



//帐号详细信息
#define Api_InUerUrl @"member/inUser/"

//登录
#define Api_LoginUrl @"member/login/"

//忘记密码
#define Api_forgetPassword @"member/forgetPwd/"

//主界面
#define Api_MainUrl @"main/index"

//活动详情
#define Api_AvDetail @"main/avDetail/"

//读取说明
#define Api_Getexplain @"explain/getexplain/"

//报价查询列表页
#define Api_QueryList @"main/queryList/"

//获取产品类别列表
#define Api_GetpsList @"main/getpsList/"

//获取目标市场列表
#define Api_GetprList  @"main/getprList/"

//获取标准名称列表
#define Api_GetPnList @"main/getpnList/"

//修改密码
#define Api_changePassword @"member/editPwd/"

//修改手机号码
#define Api_changeMobile @"member/editMobile/"

//修改办公电话
#define Api_changePhone @"member/editBgphone/"

//条件选择
#define Api_ProductIndex @"product/index/"

//查询结果
#define Api_ProductQueryrs @"product/queryrs/"

//查询详细
#define Api_ProductList @"product/queryinList/"

//截图并上传发送邮箱
#define Api_ProductSendImg @"product/cutImageSend/"

//推送列表
#define Api_PushListUrl     @"main/pushList/"

//监测活动兑换码是否存在
#define Api_ProductYzcdKey @"product/yzcdkey/"

#define Api_FeedBack @"feedback/add/"


#define Api_VersionUpdata @"version/isupdate/"

/*
 ** 数据库部分 表单结构-----------------------------------------------------------------------------------------------
 ** 关联数据库
 */

#define DBVersion   @"CREATE TABLE if not exists 'DBVersion'('id' INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,dbVersion integer)"

//收藏数据表结构
#define Collect(UIDNAME)[NSString stringWithFormat:@"CREATE TABLE if not exists 'Collect_%@'('id' INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,cname TEXT,cdescription TEXT,edescription TEXT,ename TEXT,formattime TEXT,listID INTEGER,jcsort TEXT,name TEXT,nid INTEGER,number INTEGER,offer INTEGER,pid INTEGER,rid INTEGER,workday INTEGER,collectTime TEXT,type1 TEXT,type2 TEXT,type3 TEXT)",UIDNAME]

//查询数据表
#define ReferData(UIDNAME)[NSString stringWithFormat:@"CREATE TABLE if not exists 'ReferData_%@'('id' INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,cname TEXT,cdescription TEXT,edescription TEXT,ename TEXT,formattime TEXT,listID INTEGER,jcsort TEXT,name TEXT,nid INTEGER,number INTEGER,offer INTEGER,pid INTEGER,rid INTEGER,workday INTEGER,collectTime TEXT,fields TEXT,type1 TEXT,type2 TEXT,type3 TEXT)",UIDNAME]




#endif
