//
//  LoginModel.m
//  LeYiDaiProject
//
//  Created by 貟一凡 on 2019/10/6.
//  Copyright © 2019 貟一凡. All rights reserved.
//

#import "LoginModel.h"
#import "YLDDefine.h"
@implementation LoginModel
+(id)sharedInstance
{
    static id _sharedInstance = nil;
    if (!_sharedInstance) {
        _sharedInstance = [[[self class] alloc] init];
    }
    
    return _sharedInstance;

}
-(instancetype)init{
    self = [super init];
    if (self) {
       
        NSDictionary *dic= DEF_PERSISTENT_GET_OBJECT(@"Login_info");
        [self initPDUserWithDic:dic];

    }
    return self;
}
-(void)initPDUserWithDic:(NSDictionary *)dic{
    
//    @property (nonatomic,strong)NSString *accountType;
//    @property (nonatomic,strong)NSString *account;
//    @property (nonatomic,strong)NSString *userId;
//    @property (nonatomic,strong)NSString *userName;
//    @property (nonatomic,strong)NSString *custName;
//    @property (nonatomic,strong)NSString *token;
    self.accountType = [NSString stringWithFormat:@"%@",EMPTY_IF_NIL(dic[@"accountType"])];
    self.account = EMPTY_IF_NIL(dic[@"account"]);
    self.userId = EMPTY_IF_NIL(dic[@"userId"]);
    self.userName = EMPTY_IF_NIL(dic[@"userName"]);
    self.custId = EMPTY_IF_NIL(dic[@"custId"]);
    self.custName = EMPTY_IF_NIL(dic[@"custName"]);
    self.token = EMPTY_IF_NIL(dic[@"token"]);
}
-(void)setLogonData:(NSDictionary *)dic{
    
    self.accountType = [NSString stringWithFormat:@"%@",EMPTY_IF_NIL(dic[@"accountType"])];
    self.account = EMPTY_IF_NIL(dic[@"account"]);
    self.userId = EMPTY_IF_NIL(dic[@"userId"]);
    self.userName = EMPTY_IF_NIL(dic[@"userName"]);
    self.custId = EMPTY_IF_NIL(dic[@"custId"]);
    self.custName = EMPTY_IF_NIL(dic[@"custName"]);
    self.token = EMPTY_IF_NIL(dic[@"token"]);
    
    DEF_PERSISTENT_SET_OBJECT(dic, @"Login_info");
    
}
-(void)removeFromLocal{
    
    self.accountType = @"";
    self.account = @"";
    self.userId = @"";
    self.userName = @"";
    self.custId = @"";
    self.custName = @"";
    self.token = @"";

    DEF_PERSISTENT_REMOVE_OBJECT(@"Login_info");
}
-(BOOL)isLogin{
    if (self.token != nil && ![self.token isEqualToString:@""]){
        return TRUE;
    }
    
    return FALSE;
}
@end
