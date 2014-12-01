//
//  NSString+Md5.h
//  NSString+Md5
//
//  Created by 胡 桓铭 on 14/11/30.
//  Copyright (c) 2014年 agile-team. All rights reserved.
//  version 1.0
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

@interface NSString (Md5)

/**
    为字符串进行 Md5 编码
 **/
- (NSString *)encodeMd5;

@end
