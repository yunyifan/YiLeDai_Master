//
//  BaseTabbarViewController.m
//  LeYiDaiProject
//
//  Created by 貟一凡 on 2019/9/6.
//  Copyright © 2019 貟一凡. All rights reserved.
//

#import "BaseTabbarViewController.h"
#import "MainViewController.h"
#import "RecordViewController.h"
#import "SelfViewController.h"
#import "KLTNavigationController.h"

#import "LYDUtil.h"
@interface BaseTabbarViewController ()

@end

@implementation BaseTabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tabBar.tintColor = [UIColor whiteColor];
    self.tabBar.barTintColor = [UIColor whiteColor];
    // 去掉黑线
    [[UITabBar appearance] setShadowImage:[UIImage new]];
    [[UITabBar appearance] setBackgroundImage:[LYDUtil imageWithColor:[UIColor whiteColor]]];
    
    MainViewController *mainVc = [[MainViewController alloc] init];
    [self addChildVc:mainVc title:@"首页" image:@"tab_main" selectedImage:@"tab_main_sel"];
    
    RecordViewController *recodeVc = [[RecordViewController alloc] init];
    [self addChildVc:recodeVc title:@"记录" image:@"tab_record" selectedImage:@"tab_record_sel"];
    
    SelfViewController *selfVc = [[SelfViewController alloc] init];
    [self addChildVc:selfVc title:@"我的" image:@"tab_self" selectedImage:@"tab_self_sel"];
    
    /*  tabbbar 增加阴影    */
    [self dropShadowWithOffset:CGSizeMake(0, -3) radius:15 color:[UIColor colorWithRed:211/255.0 green:211/255.0 blue:211/255.0 alpha:0.5] opacity:1];
}
- (void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    
    // 设置子控制器的文字
    //    childVc.title = title; // 同时设置tabbar和navigationBar的文字
    childVc.tabBarItem.title = title; // 设置tabbar的文字
    //    childVc.navigationItem.title = title; // 设置navigationBar的文字
    
    // 设置子控制器的图片
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    NSDictionary *textTitleOptions;
    NSDictionary *textTitleOptionsSelected;
    if (!PhoneXAll) {
        
        [childVc.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -3)]; //设置tabbar上的文字的位置
        
    }
    // 设置文字的样式
    //    if(IS_iPhoneX){
    //        textTitleOptions = @{NSForegroundColorAttributeName:[UIColor blackColor] ,NSFontAttributeName:[UIFont systemFontOfSize:12]};
    //        textTitleOptionsSelected = @{NSForegroundColorAttributeName: kOrangeColor,NSFontAttributeName:[UIFont systemFontOfSize:12]};
    //
    //
    //    }else{
    textTitleOptions = @{NSForegroundColorAttributeName:[UIColor colorWithHex:@"#999999"] };
    textTitleOptionsSelected = @{NSForegroundColorAttributeName: [UIColor blackColor]};
    //    }
    
    
    
    [childVc.tabBarItem setTitleTextAttributes:textTitleOptions forState:UIControlStateNormal];
    [childVc.tabBarItem setTitleTextAttributes:textTitleOptionsSelected forState:UIControlStateSelected];
    //    childVc.tabBarItem.imageInsets=UIEdgeInsetsMake(2,0,1,0);
    
    
    // 先给外面传进来的小控制器 包装 一个导航控制器
    //    YSSBSNavViewController *nav = [[YSSBSNavViewController alloc] initWithRootViewController:childVc];
    KLTNavigationController *nav = [[KLTNavigationController alloc] initWithRootViewController:childVc];
    // 添加为子控制器
    [self addChildViewController:nav];
    
}
- (void)dropShadowWithOffset:(CGSize)offset
                      radius:(CGFloat)radius
                       color:(UIColor *)color
                     opacity:(CGFloat)opacity {
    
    // Creating shadow path for better performance
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, self.tabBar.bounds);
    self.tabBar.layer.shadowPath = path;
    CGPathCloseSubpath(path);
    CGPathRelease(path);
    
    self.tabBar.layer.shadowColor = color.CGColor;
    self.tabBar.layer.shadowOffset = offset;
    self.tabBar.layer.shadowRadius = radius;
    self.tabBar.layer.shadowOpacity = opacity;
    
    // Default clipsToBounds is YES, will clip off the shadow, so we disable it.
    self.tabBar.clipsToBounds = NO;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
