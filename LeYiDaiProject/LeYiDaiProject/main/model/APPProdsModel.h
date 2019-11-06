//
//  APPProdsModel.h
//  LeYiDaiProject
//
//  Created by 貟一凡 on 2019/11/6.
//  Copyright © 2019 貟一凡. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface APPProdsModel : NSObject

@property (nonatomic,strong)NSString *amount; //金额    amountType为1时必输
@property (nonatomic,strong)NSString *amountType;  // 金额是否固定    1-固定期限,3-区域范围
@property (nonatomic,strong)NSString *basefee;  // 费用(元)
@property (nonatomic,strong)NSString *interate;  //日利率(万分之)
@property (nonatomic,strong)NSString *prodId;  // 产品编码
@property (nonatomic,strong)NSString *prodName; // 产品名称
@property (nonatomic,strong)NSString *prodState;  // 产品状态    1-正常,2-停止,3-冻结
@property (nonatomic,strong)NSString *term; // 期限    termType为1时必输
@property (nonatomic,strong)NSString *termType;// 期限类型   1-固定期限,2-可选列表,3-区域范围

@property (nonatomic,strong)NSString *termUnit;// 期限单位
@property (nonatomic,strong)NSString *terms;  // 期限    termType为1时必输

@property (nonatomic,strong)NSString *retunKind; //还款方式key    
@property (nonatomic,strong)NSString *retunKindValue;

@end

NS_ASSUME_NONNULL_END
