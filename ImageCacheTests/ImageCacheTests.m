//
//  ImageCacheTests.m
//  ImageCacheTests
//
//  Created by Sunayna Jain on 12/28/15.
//  Copyright © 2015 Enhatch. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ImageCache.h"

@interface ImageCacheTests : XCTestCase

@end

@implementation ImageCacheTests

static NSInteger MAX_CACHE_COUNT = 15;
static NSInteger MAX_CACHE_SIZE = 1024 * 1024;

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (void)testImageCacheDefaultInit
{
  ImageCache *cache = [ImageCache new];
  XCTAssertNotNil(cache);
  XCTAssertEqual(cache.maxCacheCount, MAX_CACHE_COUNT);
  XCTAssertEqual(cache.maxCacheSize, MAX_CACHE_SIZE);
}

- (void)testImageCacheCountInit
{
  ImageCache *cache = [[ImageCache alloc] initWithMaxCacheCount:20];
  XCTAssertNotNil(cache);
  XCTAssertEqual(cache.maxCacheCount, 20);
  XCTAssertEqual(cache.maxCacheSize, MAX_CACHE_SIZE);
}

- (void)testImageCacheSizeInit
{
  ImageCache *cache = [[ImageCache alloc] initWithMaxCacheSize:1000];
  XCTAssertNotNil(cache);
  XCTAssertEqual(cache.maxCacheCount, MAX_CACHE_COUNT);
  XCTAssertEqual(cache.maxCacheSize, 1000);
}

- (void)testImageCacheSizeAndCount
{
  ImageCache *cache = [[ImageCache alloc] initWithMaxCacheSize:1000 maxCacheCount:20];
  XCTAssertNotNil(cache);
  XCTAssertEqual(cache.maxCacheSize, 1000);
  XCTAssertEqual(cache.maxCacheCount, 20);
}


@end
