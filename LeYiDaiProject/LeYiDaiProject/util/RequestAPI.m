//
//  RequestAPI.m
//  LeYiDaiProject
//
//  Created by 貟一凡 on 2019/9/20.
//  Copyright © 2019 貟一凡. All rights reserved.
//

#import "RequestAPI.h"
#import "YLDDefine.h"
#import "AFNetworking.h"
#import <SystemConfiguration/SCNetworkReachability.h>
#import "AppDelegate.h"
#import "LoginModel.h"
@interface RequestAPI ()
@property(nonatomic,retain)AFHTTPSessionManager *sessionManager;
//@property(nonatomic,strong)YSSNetWorkStatesManager *netStates;
@property (nonatomic,strong)LoginModel *loginModel;
@end

@implementation RequestAPI

+ (instancetype)shareInstance
{
    static RequestAPI * _sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[RequestAPI alloc] init];
    });
    
    return _sharedInstance;
}
-(LoginModel *)loginModel{
    if (!_loginModel) {
        _loginModel = [LoginModel sharedInstance];
    }
    return _loginModel;
}
- (AFHTTPSessionManager*)sessionManager{
    if (!_sessionManager) {
        _sessionManager = [AFHTTPSessionManager manager];
        _sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
        
        _sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
        
        _sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html", nil];
        //        _sessionManager.requestSerializer.HTTPShouldHandleCookies=YES;
        // 设置超时时间
        [_sessionManager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        _sessionManager.requestSerializer.timeoutInterval = 10.f;
        [_sessionManager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        
    }
    return _sessionManager;
}
- (void)POST:(NSString *)URLString
  parameters:(id)parameters
  completion:(void (^)(BOOL succeed, NSDictionary* result, NSError *error))completion
{
    NSLog(@"传入的参数 %@,%@",parameters,URLString);
    AFHTTPSessionManager *manager = self.sessionManager;
    if([self.loginModel isLogin]){
        [manager.requestSerializer setValue:self.loginModel.token forHTTPHeaderField:@"X-Access-Token"];

    }
            
    [manager.requestSerializer setValue:APPID forHTTPHeaderField:@"appId"];
    @weakify(self);
    [manager POST:URLString parameters:parameters progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        @strongify(self);
        NSDictionary *dic = (NSDictionary *)responseObject;
        NSLog(@"JSON: %@", dic);
        if ([dic[@"code"] intValue] == 995) {
            [self.loginModel removeFromLocal];
            
            [[AppDelegate shareAppDelegate] logout];
        }
        
        completion(TRUE,responseObject,nil);
        
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error in request %@: %@", URLString, error);
        if(error.code>=500){
            [MBProgressHUD showError:@"不好意思，服务器走神了，请稍后再试"];

        }else{
            [MBProgressHUD showError:@"网络链接失败，请检查网络设置"];

        }
        completion(FALSE,nil,error);
    }];
}
- (void)GET:(NSString *)URLString
  parameters:(id)parameters
  completion:(void (^)(BOOL succeed, NSDictionary* result, NSError *error))completion
{
    NSLog(@"传入的参数 %@,%@",parameters,URLString);
    AFHTTPSessionManager *manager = self.sessionManager;
            
    if([self.loginModel isLogin]){
        
        [manager.requestSerializer setValue:self.loginModel.token forHTTPHeaderField:@"X-Access-Token"];

       }
    [manager.requestSerializer setValue:APPID forHTTPHeaderField:@"appId"];
        
    [manager GET:URLString parameters:parameters progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        NSDictionary *dic = (NSDictionary *)responseObject;
        NSLog(@"JSON: %@,%@", dic,URLString);
        if ([dic[@"code"] intValue] == 995) {
            [self.loginModel removeFromLocal];
            
            [[AppDelegate shareAppDelegate] logout];
        }
        
        completion(TRUE,responseObject,nil);
        
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error in request %@: %@", URLString, error);
        if(error.code>=500){
            [MBProgressHUD showError:@"不好意思，服务器走神了，请稍后再试"];

        }else{
            [MBProgressHUD showError:@"网络链接失败，请检查网络设置"];

        }
        completion(FALSE,nil,error);
    }];
}
/**
 客户获取验证码

 */
-(void)getSysCode:(NSDictionary *)prameDic Completion:(void (^)(BOOL succeed, NSDictionary* result, NSError *error))completion{
    
    [[RequestAPI shareInstance] POST:[NSString stringWithFormat:@"%@api/cust/sms",BASEUEL] parameters:prameDic completion:^(BOOL succeed, NSDictionary *result, NSError *error) {
        completion(succeed,result,error);
    }];

}

/**
 登录
 
 */
-(void)useLoginInsert:(NSDictionary *)pramDic Completion:(void (^)(BOOL succeed, NSDictionary* result, NSError *error))completion{
    
    [[RequestAPI shareInstance] POST:[NSString stringWithFormat:@"%@api/cust/querySysUser",BASEUEL] parameters:pramDic completion:^(BOOL succeed, NSDictionary *result, NSError *error) {
        completion(succeed,result,error);
    }];

}
/**
 
 首页接口
 */
-(void)useMainInsert:(NSDictionary *)pramDic Completion:(void (^)(BOOL succeed, NSDictionary* result, NSError *error))completion{
    
    [[RequestAPI shareInstance] GET:[NSString stringWithFormat:@"%@api/cust/getUserInfo",BASEUEL] parameters:pramDic completion:^(BOOL succeed, NSDictionary *result, NSError *error) {
        completion(succeed,result,error);

    }];
}
/**
 
 查询认证列表
 */
-(void)useCustAuthGetCustAuth:(NSDictionary *)pramDic Completion:(void (^)(BOOL succeed, NSDictionary* result, NSError *error))completion{
    
    [[RequestAPI shareInstance] GET:[NSString stringWithFormat:@"%@api/custAuth/getCustAuth",BASEUEL] parameters:pramDic completion:^(BOOL succeed, NSDictionary *result, NSError *error) {
        completion(succeed,result,error);

    }];
}


/**
 
 身份信息认证

 */
-(void)useCusAuthInsert:(NSDictionary *)pramDic Completion:(void (^)(BOOL succeed, NSDictionary* result, NSError *error))completion{
    
    [[RequestAPI shareInstance] POST:[NSString stringWithFormat:@"%@api/custAuth/IdCard.do",BASEUEL] parameters:pramDic completion:^(BOOL succeed, NSDictionary *result, NSError *error) {
        completion(succeed,result,error);

    }];
}
/**
 运营商认证
 
 */
-(void)useCustAuthOperatorInsert:(NSDictionary *)pramDic Completion:(void (^)(BOOL succeed, NSDictionary* result, NSError *error))completion{
    
    [[RequestAPI shareInstance] GET:[NSString stringWithFormat:@"%@api/custAuth/operator.do",BASEUEL] parameters:pramDic completion:^(BOOL succeed, NSDictionary *result, NSError *error) {
        completion(succeed,result,error);

    }];
}
/**
 银行卡认证
 
 */
-(void)useCustAuthBankInsert:(NSDictionary *)pramDic Completion:(void (^)(BOOL succeed, NSDictionary* result, NSError *error))completion{
    
    [[RequestAPI shareInstance] POST:[NSString stringWithFormat:@"%@api/custAuth/bankCard.do",BASEUEL] parameters:pramDic completion:^(BOOL succeed, NSDictionary *result, NSError *error) {
        completion(succeed,result,error);

    }];
}
/**
 人脸识别
 
 */
-(void)useFaceRecognition:(NSDictionary *)pramDic Completion:(void (^)(BOOL succeed, NSDictionary* result, NSError *error))completion{
    
    [[RequestAPI shareInstance] POST:[NSString stringWithFormat:@"%@api/custAuth/faceRecognition.do",BASEUEL] parameters:pramDic completion:^(BOOL succeed, NSDictionary *result, NSError *error) {
        completion(succeed,result,error);

    }];
}

/**
 
 查询可用银行卡
 
 */
-(void)quryCustBankcardQueryList:(NSDictionary *)pramDic Completion:(void (^)(BOOL succeed, NSDictionary* result, NSError *error))completion{
    
    [[RequestAPI shareInstance] GET:[NSString stringWithFormat:@"%@api/custBankcard/queryList",BASEUEL] parameters:pramDic completion:^(BOOL succeed, NSDictionary *result, NSError *error) {
        completion(succeed,result,error);

    }];
}

/**
 查询借款/还款记录
 
 */
-(void)useLoanLendTradeListInsert:(NSDictionary *)pramDic Completion:(void (^)(BOOL succeed, NSDictionary* result, NSError *error))completion{
    
    [[RequestAPI shareInstance] GET:[NSString stringWithFormat:@"%@api/loanLendTrade/loanLendTradeList",BASEUEL] parameters:pramDic completion:^(BOOL succeed, NSDictionary *result, NSError *error) {
        completion(succeed,result,error);

    }];
}

/**
 查询协议h5页面
 
 */
-(void)quryWebGetWebInfo:(NSDictionary *)pramDic Completion:(void (^)(BOOL succeed, NSDictionary* result, NSError *error))completion{
    
//    1.综合授权书 2.借款协议 3.权益服务协议 4，委托扣款协议
    [[RequestAPI shareInstance] GET:[NSString stringWithFormat:@"%@api/web/getWebInfo",BASEUEL] parameters:pramDic completion:^(BOOL succeed, NSDictionary *result, NSError *error) {
        completion(succeed,result,error);

    }];
}

/**
 上传图片
 
 */
-(void)uploadMoreImage:(NSString *)userId UrlString:(NSString *)urlString :(NSArray *)arr Completion:(void (^)(BOOL succeed, NSDictionary* result, NSError *error))completion{
 
 //   服务器提交图片
     AFHTTPSessionManager *manager = self.sessionManager;
       if([self.loginModel isLogin]){
           [manager.requestSerializer setValue:self.loginModel.token forHTTPHeaderField:@"X-Access-Token"];

       }
               
       [manager.requestSerializer setValue:APPID forHTTPHeaderField:@"appId"];

    NSDictionary *param = @{@"userId":userId};
    @weakify(self);
    [manager POST:[NSString stringWithFormat:@"%@api/custAuth/IdCard.do",BASEUEL] parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        // 上传 多张图片
        for(NSInteger i = 0; i < arr.count; i++)
        {
            NSData * imageData = [arr objectAtIndex: i];
            // 上传的参数名
            NSString * Name;
            if(i == 0){
                Name = @"front";
            }else{
                Name = @"back";
            }
            // 上传filename
            NSString * fileName = [NSString stringWithFormat:@"%@.jpg", Name];
            
            [formData appendPartWithFileData:imageData name:Name fileName:fileName mimeType:@"image/jpg"];
        }

    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        @strongify(self);
        NSDictionary * dic = responseObject;
//        [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"完成 %@", responseObject);
//
        if ([dic[@"code"] intValue] == 995) {
            [self.loginModel removeFromLocal];
            
//            [[AppDelegate shareAppDelegate] logout];
        }
        completion(TRUE,responseObject,nil);


    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"错误 %@", error.localizedDescription);
        if(error.code>=500){
              [MBProgressHUD showError:@"不好意思，服务器走神了，请稍后再试"];

          }else{
              [MBProgressHUD showError:@"网络链接失败，请检查网络设置"];

          }
          completion(FALSE,nil,error);

    }];

}
/**
 
 提交额度审批资料
 */
-(void)useCustAuthCustInfoUp:(NSDictionary *)pramDic Completion:(void (^)(BOOL succeed, NSDictionary* result, NSError *error))completion{
    
//    1.综合授权书 2.借款协议 3.权益服务协议 4，委托扣款协议
    [[RequestAPI shareInstance] POST:[NSString stringWithFormat:@"%@api/custAuth/custInfoUp",BASEUEL] parameters:pramDic completion:^(BOOL succeed, NSDictionary *result, NSError *error) {
        completion(succeed,result,error);

    }];
}

/**
 
 还款计算
 */
-(void)useLoanLendTradeGetRepayInfo:(NSDictionary *)pramDic Completion:(void (^)(BOOL succeed, NSDictionary* result, NSError *error))completion{
    

    [[RequestAPI shareInstance] GET:[NSString stringWithFormat:@"%@api/loanLendTrade/getRepayInfo",BASEUEL] parameters:pramDic completion:^(BOOL succeed, NSDictionary *result, NSError *error) {
        completion(succeed,result,error);

    }];
}
/**
 
 申请放款
 */
-(void)useLoanLendTradeUpInsert:(NSDictionary *)pramDic Completion:(void (^)(BOOL succeed, NSDictionary* result, NSError *error))completion{
    

    [[RequestAPI shareInstance] POST:[NSString stringWithFormat:@"%@api/loanLendTrade/loanLendTradeUp",BASEUEL] parameters:pramDic completion:^(BOOL succeed, NSDictionary *result, NSError *error) {
        completion(succeed,result,error);

    }];
}
/**
 查询待还款列表
 
 */
-(void)useGetRepayList:(NSDictionary *)prmDic Completion:(void (^)(BOOL succeed, NSDictionary* result, NSError *error))completion{
    
    [[RequestAPI shareInstance] GET:[NSString stringWithFormat:@"%@api/repayList/getRepayList",BASEUEL] parameters:prmDic completion:^(BOOL succeed, NSDictionary *result, NSError *error) {
        completion(succeed,result,error);

    }];
}

/**
 
 新增银行卡
 */
-(void)useAddSeleBank:(NSDictionary *)prmDic Completion:(void (^)(BOOL succeed, NSDictionary* result, NSError *error))completion{
    
    [[RequestAPI shareInstance] POST:[NSString stringWithFormat:@"%@api/custBankcard/add",BASEUEL] parameters:prmDic completion:^(BOOL succeed, NSDictionary *result, NSError *error) {
        completion(succeed,result,error);

    }];
}
/**
 借款详情
 
 */
-(void)useGetLoanAccountInfo:(NSDictionary *)prmDic Completion:(void (^)(BOOL succeed, NSDictionary* result, NSError *error))completion{
    
    [[RequestAPI shareInstance] GET:[NSString stringWithFormat:@"%@api/loanLendTrade/getLoanAccountInfo",BASEUEL] parameters:prmDic completion:^(BOOL succeed, NSDictionary *result, NSError *error) {
        completion(succeed,result,error);

    }];
}
/**
 
 申请还款
 */
-(void)useRepayListUpInsert:(NSDictionary *)prmDic Completion:(void (^)(BOOL succeed, NSDictionary* result, NSError *error))completion{
    
    [[RequestAPI shareInstance] POST:[NSString stringWithFormat:@"%@api/repayList/repayListUp",BASEUEL] parameters:prmDic completion:^(BOOL succeed, NSDictionary *result, NSError *error) {
        completion(succeed,result,error);

    }];
}
/**
 还款详情
 
 */
-(void)useRepayListGetrepayInfo:(NSDictionary *)prmDic Completion:(void (^)(BOOL succeed, NSDictionary* result, NSError *error))completion{
    
    [[RequestAPI shareInstance] GET:[NSString stringWithFormat:@"%@api/repayList/getrepayInfo",BASEUEL] parameters:prmDic completion:^(BOOL succeed, NSDictionary *result, NSError *error) {
        completion(succeed,result,error);

    }];
}
@end
