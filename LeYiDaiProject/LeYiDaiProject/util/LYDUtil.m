//
//  LYDUtil.m
//  LeYiDaiProject
//
//  Created by 貟一凡 on 2019/9/5.
//  Copyright © 2019 貟一凡. All rights reserved.
//

#import "LYDUtil.h"

@implementation LYDUtil
+(NSMutableAttributedString *)LableTextShowInBottom:(NSString *)text InsertWithString:(NSString *)str InsertSecondStr:(NSString *)secondStr InsertStringColor:(UIColor *)strColor  WithInsertStringFont:(UIFont *)font{
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:text];
    //取出 “string” 在字符串中的位置
    
    NSRange range = [text rangeOfString:str];
    NSRange range2 = [text rangeOfString:secondStr];
    [string addAttribute:NSFontAttributeName value:font range:range];
    [string addAttribute:NSFontAttributeName value:font range:range2];
    
    [string addAttribute:NSForegroundColorAttributeName value:strColor range:range];
    [string addAttribute:NSForegroundColorAttributeName value:strColor range:range2];
    
    
    return string;
}
+(UIImage *)imageWithColor:(UIColor *)color{
    // 描述矩形
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    // 开启位图上下文
    UIGraphicsBeginImageContext(rect.size);
    // 获取位图上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 使用color演示填充上下文
    CGContextSetFillColorWithColor(context, [color CGColor]);
    // 渲染上下文
    CGContextFillRect(context, rect);
    // 从上下文中获取图片
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    // 结束上下文
    UIGraphicsEndImageContext();
    return theImage;
}
/**
 ** lineView:       需要绘制成虚线的view
 ** lineLength:     虚线的宽度
 ** lineSpacing:    虚线的间距
 ** lineColor:      虚线的颜色
 **/
+(void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:lineView.bounds];
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame))];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    
    //  设置虚线颜色为
    [shapeLayer setStrokeColor:lineColor.CGColor];
    
    //  设置虚线宽度
    [shapeLayer setLineWidth:CGRectGetHeight(lineView.frame)];
    [shapeLayer setLineJoin:kCALineJoinRound];
    
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
    
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, CGRectGetWidth(lineView.frame), 0);
    
    [shapeLayer setPath:path];
    CGPathRelease(path);
    
    //  把绘制好的虚线添加上来
    [lineView.layer addSublayer:shapeLayer];
}
+(BOOL)isPhoneNumber:(NSString *)number{
    
    //首先验证是不是手机号码
       
   NSString *MOBILE = @"^[1]([3-9])[0-9]{9}$";
   
   NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
   
   BOOL isOk = [regextestmobile evaluateWithObject:number];
   return isOk;
}
/**
 过滤字典中的null

 */
+ (NSMutableDictionary *)nullDicToDic:(NSDictionary *)dic{
    
    NSMutableDictionary *resultDic = [@{} mutableCopy];
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return resultDic;
    }
    for (NSString *key in [dic allKeys]) {
        if ([(id)[dic objectForKey:key] isKindOfClass:[NSNull class]]) {
            [resultDic setValue:@"" forKey:key];
        }else{
            [resultDic setValue:[dic objectForKey:key] forKey:key];
        }
    }
    return resultDic;
}

@end
