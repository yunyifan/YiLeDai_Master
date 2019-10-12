//
//  IDCardAutherModel.h
//  LeYiDaiProject
//
//  Created by 貟一凡 on 2019/10/11.
//  Copyright © 2019 貟一凡. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface IDCardAutherModel : NSObject
@property (nonatomic,strong)NSString *address; // 地址
@property (nonatomic,strong)NSString *birth; // 出生日期
@property (nonatomic,strong)NSString *expiryDate; //到期日
@property (nonatomic,strong)NSString *gender; // 性别
@property (nonatomic,strong)NSString *id_name; //姓名(正面信息)

@property (nonatomic,strong)NSString *id_no; // 身份证号
@property (nonatomic,strong)NSString *issuingAuthority; //所属公安机构
@property (nonatomic,assign)NSString *issuingDate; // 发行日期
@property (nonatomic,assign)NSString *nation; // 名族    

@end

NS_ASSUME_NONNULL_END
