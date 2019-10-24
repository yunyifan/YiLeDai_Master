//
//  RequestAPI.h
//  LeYiDaiProject
//
//  Created by 貟一凡 on 2019/9/20.
//  Copyright © 2019 貟一凡. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RequestAPI : NSObject

+ (instancetype)shareInstance;

-(void)getSysCode:(NSDictionary *)prameDic Completion:(void (^)(BOOL succeed, NSDictionary* result, NSError *error))completion;

-(void)useLoginInsert:(NSDictionary *)pramDic Completion:(void (^)(BOOL succeed, NSDictionary* result, NSError *error))completion;

-(void)useMainInsert:(NSDictionary *)pramDic Completion:(void (^)(BOOL succeed, NSDictionary* result, NSError *error))completion;

-(void)useCusAuthInsert:(NSDictionary *)pramDic Completion:(void (^)(BOOL succeed, NSDictionary* result, NSError *error))completion;

-(void)quryCustBankcardQueryList:(NSDictionary *)pramDic Completion:(void (^)(BOOL succeed, NSDictionary* result, NSError *error))completion;

-(void)useCustAuthGetCustAuth:(NSDictionary *)pramDic Completion:(void (^)(BOOL succeed, NSDictionary* result, NSError *error))completion;

-(void)useCustAuthOperatorInsert:(NSDictionary *)pramDic Completion:(void (^)(BOOL succeed, NSDictionary* result, NSError *error))completion;

-(void)useCustAuthBankInsert:(NSDictionary *)pramDic Completion:(void (^)(BOOL succeed, NSDictionary* result, NSError *error))completion;

-(void)useLoanLendTradeListInsert:(NSDictionary *)pramDic Completion:(void (^)(BOOL succeed, NSDictionary* result, NSError *error))completion;

-(void)quryWebGetWebInfo:(NSDictionary *)pramDic Completion:(void (^)(BOOL succeed, NSDictionary* result, NSError *error))completion;

-(void)useFaceRecognition:(NSDictionary *)pramDic Completion:(void (^)(BOOL succeed, NSDictionary* result, NSError *error))completion;


-(void)uploadMoreImage:(NSString *)userId UrlString:(NSString *)urlString :(NSArray *)arr Completion:(void (^)(BOOL succeed, NSDictionary* result, NSError *error))completion;

-(void)useCustAuthCustInfoUp:(NSDictionary *)pramDic Completion:(void (^)(BOOL succeed, NSDictionary* result, NSError *error))completion;

-(void)useLoanLendTradeGetRepayInfo:(NSDictionary *)pramDic Completion:(void (^)(BOOL succeed, NSDictionary* result, NSError *error))completion;

-(void)useLoanLendTradeUpInsert:(NSDictionary *)pramDic Completion:(void (^)(BOOL succeed, NSDictionary* result, NSError *error))completion;

-(void)useGetRepayList:(NSDictionary *)prmDic Completion:(void (^)(BOOL succeed, NSDictionary* result, NSError *error))completion;

-(void)useAddSeleBank:(NSDictionary *)prmDic Completion:(void (^)(BOOL succeed, NSDictionary* result, NSError *error))completion;

-(void)useGetLoanAccountInfo:(NSDictionary *)prmDic Completion:(void (^)(BOOL succeed, NSDictionary* result, NSError *error))completion;

-(void)useRepayListUpInsert:(NSDictionary *)prmDic Completion:(void (^)(BOOL succeed, NSDictionary* result, NSError *error))completion;

-(void)useRepayListGetrepayInfo:(NSDictionary *)prmDic Completion:(void (^)(BOOL succeed, NSDictionary* result, NSError *error))completion;

-(void)custInfoPhoneBookInsert:(NSDictionary *)prmDic Completion:(void (^)(BOOL succeed, NSDictionary* result, NSError *error))completion;
@end

NS_ASSUME_NONNULL_END
