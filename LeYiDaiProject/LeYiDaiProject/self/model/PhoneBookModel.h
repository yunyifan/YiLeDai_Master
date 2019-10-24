//
//  PhoneBookModel.h
//  LeYiDaiProject
//
//  Created by 貟一凡 on 2019/10/22.
//  Copyright © 2019 貟一凡. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface PhoneBookModel : NSObject
+(id)sharedInstance;

- (void)requestContactAuthorAfterSystemVersion9;
@end

NS_ASSUME_NONNULL_END
