//
//  ImageCache.h
//  ImageCache
//
//  Created by Sunayna Jain on 12/29/15.
//  Copyright © 2015 Enhatch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageCache : NSObject

@property (nonatomic) NSInteger maxCacheSize;

@property (nonatomic) NSInteger maxCacheCount;

- (instancetype)initWithMaxCacheSize:(NSInteger)cacheSize maxCacheCount:(NSInteger)cacheCount;

- (instancetype)initWithMaxCacheSize:(NSInteger)cacheSize;

- (instancetype)initWithMaxCacheCount:(NSInteger)cacheCount;

- (void)setObject:(id)object forKey:(NSData *)bytes;

- (id)objectForKey:(NSString *)key;

- (void)clearCache;

@end
