//
//  NSString_Md5Tests.m
//  NSString+Md5Tests
//
//  Created by 胡 桓铭 on 14/11/30.
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

- (void)testExample {
    NSString * string = @"123456";
    XCTAssertEqualObjects(@"e10adc3949ba59abbe56e057f20f883e", string.encodeMd5);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
