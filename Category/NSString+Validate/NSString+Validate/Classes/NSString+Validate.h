//
//  NSString+Validate.h
//  NSString+Validate
//
//  Created by Johnson Hwuang on 14/12/3.
//  Copyright (c) 2014年 AgileTeam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Validate)

/**
 *  验证字符串是否为邮箱
 *
 *  @return 判断值
 */
- (BOOL)validateEmail;

/**
 *  验证字符串是否为电话
 *
 *  @return 判断值
 */
- (BOOL)validatePhoneNumber;

/**
 *  验证字符串是否全为汉字
 *
 *  @return 判断值
 */
- (BOOL)validateStringIsALLChinese;

/**
 *  验证字符串是否全为字母
 *
 *  @return 判断值
 */
- (BOOL)validateStringIsALLLetter;

/**
 *  验证字符串
 *
 *  @return 判断值
 */
- (BOOL)validateUserName;

@end
