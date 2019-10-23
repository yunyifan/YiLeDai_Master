//
//  LYDUtil.h
//  LeYiDaiProject
//
//  Created by 貟一凡 on 2019/9/5.
//  Copyright © 2019 貟一凡. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYDUtil : NSObject
+(NSMutableAttributedString *)LableTextShowInBottom:(NSString *)text InsertWithString:(NSString *)str InsertSecondStr:(NSString *)secondStr InsertStringColor:(UIColor *)strColor  WithInsertStringFont:(UIFont *)font;

+(UIImage *)imageWithColor:(UIColor *)color;


+(void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor;

+(BOOL)isPhoneNumber:(NSString *)number;

// 过滤字典中的null
+ (NSMutableDictionary *)nullDicToDic:(NSDictionary *)dic;

//时间戳转时间
+ (NSString *)getTimeFromTimestamp:(NSString *)timeTamp;

+(UIViewController*) currentViewController;

@end

NS_ASSUME_NONNULL_END
