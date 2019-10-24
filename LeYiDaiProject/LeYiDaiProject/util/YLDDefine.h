//
//  YLDDefine.h
//  LeYiDaiProject
//
//  Created by 貟一凡 on 2019/9/5.
//  Copyright © 2019 貟一凡. All rights reserved.
//

#ifndef YLDDefine_h
#define YLDDefine_h

#import "MBProgressHUD+MJ.h"
#import "MJRefresh.h"
#import "NSArray+beyond.h"
#import "UIColor+HexColor.h"
#import "Masonry.h"
#import "UIButton+Touch.h"
#import "UIButton+WebCache.h"
#import "FSCustomButton.h"
#import "YSSModelDialog.h"
#import "UIImageView+WebCache.h"
#import "AppIdentificationManage.h"
#import "PhoneBookModel.h"

// 环境开关
#define ENVIRONMENT_FLAG 0

#define BASEUEL @"http://47.100.11.188:8090/jeecg-boot/"

// 开发环境
#if ENVIRONMENT_FLAG == 0



// 测试环境
#elif ENVIRONMENT_FLAG == 1


#endif

//[[AppIdentificationManage sharedAppIdentificationManage] readUDID]
#define APPID  @"31abe42dff0ad8d160905910b5c1df93"


#define  SCREEN_WIDTH             [UIScreen mainScreen].bounds.size.width
#define  SCREEN_HEIGHT         [UIScreen mainScreen].bounds.size.height

#define  versionStr           [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

//在release模式禁用nslog
#ifndef __OPTIMIZE__
#define NSLog(...) NSLog(__VA_ARGS__)
#else
#define NSLog(...) {}
#endif

// iPhoneX iPhoneXs
#define IPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
//判断iPhoneXr
#define IPHONE_Xr ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1624), [[UIScreen mainScreen] currentMode].size): NO)
//判断iPhoneXsMax
#define IPHONE_Xs_Max ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) : NO)

//判断iPhoneX所有系列
#define PhoneXAll (IPhoneX || IPHONE_Xr || IPHONE_Xs_Max)
#define Height_NavContentBar 44.0f
#define Height_StatusBar (PhoneXAll? 44.0 : 20.0)
#define Height_NavBar (PhoneXAll ? 88.0 : 64.0)
#define Height_TabBar (PhoneXAll ? 83.0 : 49.0)

#define FONT(a) [UIFont systemFontOfSize:a]
#define BOLDFONT(a) [UIFont boldSystemFontOfSize:a]

#define Line_Color [UIColor colorWithHex:@"#EFEFEF"]
#define Tit_Black_Color [UIColor colorWithHex:@"#333333"]
#define Tit_Gray_Color [UIColor colorWithHex:@"#999999"]
#define Tit_Red_Color [UIColor colorWithHex:@"#FF0E2E"]


#define But_Bg_Color [UIColor colorWithHex:@"#4D56EF"]


//  按钮暴力时间
#define TimeInterval 3

/* 判定字符串是否为空 */
#define STRING_ISNIL(__POINTER) (__POINTER == nil || [__POINTER isEqualToString:@""] || [__POINTER isEqualToString:@"(null)"] || [__POINTER isEqualToString:@"null"] || [__POINTER isEqualToString:@"(NULL)"] || [__POINTER isEqualToString:@"NULL"] || [__POINTER isEqualToString:@"<null>"])?YES:NO
//字符串空字符处理
#define EMPTY_IF_NIL(str) (str == nil ? @"" : (str == (id)[NSNull null] ? @"" : str))

#define Empoty_Data_Title(a,b) [[NSAttributedString alloc] initWithString:a attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:b]}]


#ifndef weakify
#if DEBUG
#if __has_feature(objc_arc)
#define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif

#ifndef strongify
#if DEBUG
#if __has_feature(objc_arc)
#define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
#endif
#else
#if __has_feature(objc_arc)
#define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
#endif
#endif
#endif

/**
 *    永久存储对象
 *
 *    @param    object    需存储的对象
 *    @param    key    对应的key
 */
#define DEF_PERSISTENT_SET_OBJECT(object, key)                                                                                                 \
({                                                                                                                                             \
NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];                                                                         \
[defaults setObject:object forKey:key];                                                                                                    \
[defaults synchronize];                                                                                                                    \
})

/**
 *    取出永久存储的对象
 *
 *    @param    key    所需对象对应的key
 *    @return    key所对应的对象
 */
#define DEF_PERSISTENT_GET_OBJECT(key) [[NSUserDefaults standardUserDefaults] objectForKey:key]
#define DEF_PERSISTENT_REMOVE_OBJECT(key) [[NSUserDefaults standardUserDefaults] removeObjectForKey:key]

/*
 
 获取系统版本号
 
 */
#define IOSVERSION [UIDevice currentDevice].systemVersion





typedef NS_ENUM(NSInteger, RecordType){
    
    RecordTypeLoanning = 1,  // 放款中
    RecordTypeUseing,  // 使用中
    RecordTypeSettlement,  // 已结算
    RecordTypeRepayment,  // 还款
    RecordTypeDefault  //违约
    
};


#endif /* YLDDefine_h */
