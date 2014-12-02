//
//  NSString+Md5.m
//  NSString+Md5
//
//  Created by 胡 桓铭 on 14/11/30.
//  Copyright (c) 2014年 agile-team. All rights reserved.
//

#import "NSString+Md5.h"

@implementation NSString (Md5)

- (NSString *)encode32LowercaseMd5
{
    const char* str = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (unsigned int)strlen(str), result);
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i ++) {
        [ret appendFormat:@"%02x",result[i]];
    }
    return ret;
}

- (NSString *)encode32UppercaseMd5 {
    
    NSString *ret = [NSString stringWithString:[self encode32LowercaseMd5]];
    
    return ret.uppercaseString;
    
}

- (NSString *)encode16LowercaseMd5 {
    
    NSString *ret = [NSString stringWithString:[self encode32LowercaseMd5]];
    
    return [ret substringWithRange:NSMakeRange(8, 16)];
    

}

- (NSString *)encode16UppercaseMd5 {
    
    NSString *ret = [NSString stringWithString:[self encode16LowercaseMd5]];
    
    return ret.uppercaseString;
}


@end
