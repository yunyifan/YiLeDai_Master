//
//  YSSModelDialog.h
//  YSSProject-master
//
//  Created by 貟一凡 on 2019/5/16.
//  Copyright © 2019 貟一凡. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YSSModelDialog : NSObject
/**
 *  模态视图
 *
 *  @param view  显示的view
 *  @param alpha 背景的alpha值
 */
+(void)showView:(UIView *)view andAlpha:(CGFloat) alpha;

+(void)hideView;

+(void)showView:(UIView *)view andAlpha:(CGFloat) alpha andViewUserEnab:(BOOL)isEable;
@end

NS_ASSUME_NONNULL_END
