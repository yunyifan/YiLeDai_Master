//
//  YSSModelDialog.m
//  YSSProject-master
//
//  Created by 貟一凡 on 2019/5/16.
//  Copyright © 2019 貟一凡. All rights reserved.
//

#import "YSSModelDialog.h"

@implementation YSSModelDialog

+(void)showView:(UIView *)view andAlpha:(CGFloat) alpha{
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    UIView *backgroundView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    backgroundView.backgroundColor=[UIColor blackColor];
    backgroundView.alpha = 0;
    backgroundView.tag = 88889;
    backgroundView.userInteractionEnabled = YES;
    
    // 点击背景后消失
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideView:)];
    [backgroundView addGestureRecognizer: tap];
    [window addSubview:backgroundView];
    
    UIView *newView =view;
    // 注意tag 值，view 是加在window上的，确保不要有相同的tag
    newView.tag = 88888;
    newView.alpha = 0;
    
    [window addSubview:newView];
    
    [UIView animateWithDuration:0.3 animations:^{
        newView.alpha = 1;
        backgroundView.alpha = alpha;
    } completion:^(BOOL finished) {
        
    }];
}

+ (void)hideView:(UITapGestureRecognizer*)tap{
    
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    UIView *backgroundView=tap.view;
    UIView *view=(UIView*)[window viewWithTag:88888];
    [UIView animateWithDuration:0.3 animations:^{
        view.alpha = 0;
        backgroundView.alpha=0;
    } completion:^(BOOL finished) {
        [view removeFromSuperview];
        [backgroundView removeFromSuperview];
    }];
}

+(void)hideView
{
    // 删除 window 上的view
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    UIView *backgroundView= (UIView*)[window viewWithTag:88889];;
    UIView *view=(UIView*)[window viewWithTag:88888];
    [UIView animateWithDuration:0.1 animations:^{
        view.alpha = 0;
        backgroundView.alpha=0;
    } completion:^(BOOL finished) {
        [view removeFromSuperview];
        [backgroundView removeFromSuperview];
    }];
}
+(void)showView:(UIView *)view andAlpha:(CGFloat) alpha andViewUserEnab:(BOOL)isEable{
    
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    UIView *backgroundView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    backgroundView.backgroundColor=[UIColor blackColor];
    backgroundView.alpha = 0;
    backgroundView.tag = 88889;
    backgroundView.userInteractionEnabled = isEable;
    
    // 点击背景后消失
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideView:)];
    [backgroundView addGestureRecognizer: tap];
    [window addSubview:backgroundView];
    
    UIView *newView =view;
    // 注意tag 值，view 是加在window上的，确保不要有相同的tag
    newView.tag = 88888;
    newView.alpha = 0;
    
    [window addSubview:newView];
    
    [UIView animateWithDuration:0.3 animations:^{
        newView.alpha = 1;
        backgroundView.alpha = alpha;
    } completion:^(BOOL finished) {
        
    }];

}
@end
