//
//  NSString+SHA256_BASE64.h
//  YSSProject-master
//
//  Created by 貟一凡 on 2019/7/6.
//  Copyright © 2019 貟一凡. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (SHA256_BASE64)
+(NSString *)hmac:(NSString *)plaintext withKey:(NSString *)key;
@end

NS_ASSUME_NONNULL_END
