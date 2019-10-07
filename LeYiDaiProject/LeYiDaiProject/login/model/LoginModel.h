//
//  LoginModel.h
//  LeYiDaiProject
//
//  Created by 貟一凡 on 2019/10/6.
//  Copyright © 2019 貟一凡. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YYModel/YYModel.h>

NS_ASSUME_NONNULL_BEGIN

@interface LoginModel : NSObject
@property (nonatomic,strong)NSString *accountType;
@property (nonatomic,strong)NSString *account;
@property (nonatomic,strong)NSString *userId;
@property (nonatomic,strong)NSString *userName;
@property (nonatomic,strong)NSString *custId;
@property (nonatomic,strong)NSString *custName;
@property (nonatomic,strong)NSString *token;

+(id)sharedInstance;

-(void)setLogonData:(NSDictionary *)dic;

-(BOOL)isLogin;

-(void)removeFromLocal;

@end

NS_ASSUME_NONNULL_END
