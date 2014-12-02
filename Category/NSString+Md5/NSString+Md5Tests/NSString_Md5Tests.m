//
//  NSString_Md5Tests.m
//  NSString+Md5Tests
//
//  Created by 胡 桓铭 on 14/11/30.
//  Updated by Johnson Hwuang on 14/12/2
//  Copyright (c) 2014年 agile-team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "NSString+Md5.h"

@interface NSString_Md5Tests : XCTestCase

@end

@implementation NSString_Md5Tests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testEncode32LowerCaseMd5 {
    NSString * string = @"123456";
    XCTAssertEqualObjects(@"e10adc3949ba59abbe56e057f20f883e", [string encode32LowercaseMd5]);
}

- (void)testEncode32UppercaseMd5 {
    NSString * string = @"123456";
    XCTAssertEqualObjects(@"E10ADC3949BA59ABBE56E057F20F883E", string.encode32UppercaseMd5, @"Not Equal");
}

- (void)testEncode16LowercaseMd5 {
    NSString * string = @"123456";
    XCTAssertEqualObjects(@"49ba59abbe56e057", string.encode16LowercaseMd5, @"Not Equal");
}

- (void)testEncode16UppercaseMd5 {
    NSString * string = @"123456";
    XCTAssertEqualObjects(@"49BA59ABBE56E057", string.encode16UppercaseMd5, @"Not Equal");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
