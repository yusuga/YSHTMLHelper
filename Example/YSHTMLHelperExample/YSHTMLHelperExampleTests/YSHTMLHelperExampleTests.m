//
//  YSHTMLHelperExampleTests.m
//  YSHTMLHelperExampleTests
//
//  Created by Yu Sugawara on 2014/06/12.
//  Copyright (c) 2014年 Yu Sugawara. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "YSHTMLHelper.h"
#import <TKRGuard/TKRGuard.h>

@interface YSHTMLHelperExampleTests : XCTestCase

@end

@implementation YSHTMLHelperExampleTests

- (void)setUp
{
    [super setUp];

    [TKRGuard setDefaultTimeoutInterval:10.];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (NSArray*)urlStrings
{
    return @[@"http://www.apple.co.jp"];
}

- (NSStringEncoding)encoding
{
    return NSASCIIStringEncoding;
}

- (void)testSyncGetHTML
{
    for (NSString *urlStr in [self urlStrings]) {
        NSString *html = [YSHTMLHelper htmlForURLString:urlStr withEncoding:[self encoding]];
        XCTAssertNotNil(html);
        XCTAssertTrue(html.length > 0);
    }
}

- (void)testAsyncGetHTML
{
    for (NSString *urlStr in [self urlStrings]) {
        [YSHTMLHelper htmlForURLString:urlStr withEncoding:[self encoding] completion:^(NSString *str) {
            XCTAssertNotNil(str);
            XCTAssertTrue(str.length > 0);
            RESUME;
        }];
        WAIT;
    }
}

- (void)testSyncGetOGPImage
{
    for (NSString *urlStr in [self urlStrings]) {
        NSString *imageUrlStr = [YSHTMLHelper ogpForURLString:urlStr property:YSHTMLHelperOGPPropertyImage];
        XCTAssertNotNil(imageUrlStr);
        XCTAssertTrue(imageUrlStr.length > 0);
    }
}

- (void)testAsyncGetOGPImage
{
    for (NSString *urlStr in [self urlStrings]) {
        [YSHTMLHelper ogpForURLString:urlStr property:YSHTMLHelperOGPPropertyImage completion:^(NSString *str) {
            XCTAssertNotNil(str);
            XCTAssertTrue(str.length > 0);
            RESUME;
        }];
        WAIT;
    }
}

@end
