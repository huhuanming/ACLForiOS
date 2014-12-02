//
//  NSString+Md5.h
//  NSString+Md5
//
//  Created by 胡 桓铭 on 14/11/30.
//  Updated by Johnson Hwuang on 14/12/2
//  Copyright (c) 2014年 agile-team. All rights reserved.
//  Version 0.1.1
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

@interface NSString (Md5)

/**
*  对字符串进行 Md5 32位小写编码
*
*  @return 32位小写编码字符串
*/
- (NSString *)encode32LowercaseMd5;

/**
 *  对字符串进行 Md5 32位大写编码
 *
 *  @return 32位大写编码字符串
 */
- (NSString *)encode32UppercaseMd5;

/**
 *  对字符串进行 Md5 16位小写编码
 *
 *  @return 16位小写编码字符串
 */
- (NSString *)encode16LowercaseMd5;

/**
 *  对字符串进行 Md5 16位大写编码
 *
 *  @return 16位大写编码字符串
 */
- (NSString *)encode16UppercaseMd5;
@end
