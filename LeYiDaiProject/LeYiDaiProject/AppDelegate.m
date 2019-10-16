//
//  AppDelegate.m
//  LeYiDaiProject
//
//  Created by 貟一凡 on 2019/9/5.
//  Copyright © 2019 貟一凡. All rights reserved.
//

#import "AppDelegate.h"
#import "IQKeyboardManager.h"
#import "LoginViewController.h"
#import "BaseTabbarViewController.h"

#import "IDLFaceSDK/IDLFaceSDK.h"
#import "FaceParameterConfig.h"

#import "LoginModel.h"
@interface AppDelegate ()

@end

@implementation AppDelegate
+(AppDelegate*)shareAppDelegate{
    return (AppDelegate*)[UIApplication sharedApplication].delegate;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    [IQKeyboardManager sharedManager].enable = YES;
    if (@available(iOS 13.0, *)) {
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDarkContent;
    } else {
        // Fallback on earlier versions
    }

    NSString* licensePath = [[NSBundle mainBundle] pathForResource:FACE_LICENSE_NAME ofType:FACE_LICENSE_SUFFIX];
    NSAssert([[NSFileManager defaultManager] fileExistsAtPath:licensePath], @"license文件路径不对，请仔细查看文档");
    [[FaceSDKManager sharedInstance] setLicenseID:FACE_LICENSE_ID andLocalLicenceFile:licensePath];
    NSLog(@"canWork = %d",[[FaceSDKManager sharedInstance] canWork]);
    NSLog(@"version = %@",[[FaceVerifier sharedInstance] getVersion]);

    
    [self initCustomWindow];
    
    return YES;
}
-(void)initCustomWindow{
    
//    判断是否登录
    
    LoginModel *loginMode = [LoginModel sharedInstance];
    
    if (loginMode.isLogin) {
        BaseTabbarViewController *vc = [[BaseTabbarViewController alloc] init];
        self.window.rootViewController = vc;

    }else{
        LoginViewController *vc = [[LoginViewController alloc] init];
        self.window.rootViewController = vc;

    }
    
    [self.window makeKeyAndVisible];

    
}
-(void)logout{
    
    LoginViewController *vc = [[LoginViewController alloc] init];
    self.window.rootViewController = vc;
    [self.window makeKeyAndVisible];

}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
