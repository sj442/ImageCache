//
//  ImageCache.m
//  ImageCache
//
//  Created by Sunayna Jain on 12/29/15.
//  Copyright © 2015 Enhatch. All rights reserved.
//

#import "ImageCache.h"
#import "DoublyLinkedList.h"
#import "Node.h"

#import "NSString+BytesConversion.h"
#import "NSData+StringConversion.h"

/*
The image cache has 2 requirements : fast lookup of image keys, and maintaining LRU order of images. Fast lookup can be done through a hash map. Ordering can be maintained using a linked list in which each node keeps a point to its previous node and next node. This way, if we have a reference ot any node in the list, we can access it in O(1) time, remove and reposition it.
 
This image cache imaplementation consists of 2 data structures: an NSDictionary and a doubly linked list. The dictionary keys are image keys and values are pointers to corresponding nodes in the linked list. The most recently used images are at list head and least recently used at the tail. The last node is node whenever the cache is full. When an image is accessed, its corresponding node is removed from its present position and moved to the head. This enables O(1) lookup of image key in dictionary and reordering of nodes to maintain LRU order
*/

@interface ImageCache ()

@property (strong, nonatomic) NSMutableDictionary *cacheMap;

@property (strong, nonatomic) DoublyLinkedList *list;

@property (nonatomic) NSInteger currentCacheSize;

@property (nonatomic) BOOL cacheBeingAccessed;

@end

@implementation ImageCache

// Default cache count and size values in case the user does not specify them
// Max caxhe count default is assumed 15 because it is approximately double the number of images that is visible on an iPhone screen at a time. Max cache size is assumed 1 MB keeping phone memory constraints in mind and also to accommodate the 15 image cache count
static NSInteger MAX_CACHE_COUNT = 15;
static NSInteger MAX_CACHE_SIZE = 1024 * 1024;

#pragma mark - Initializers

/// Initializes image cache with default cache count and size
- (instancetype)init
{
  return [self initWithMaxCacheSize:MAX_CACHE_SIZE maxCacheCount:MAX_CACHE_COUNT];
}

/// Initializes image cache with default cache sizer and given cache count
/// @param cacheCount: max number of images to store in cache
- (instancetype)initWithMaxCacheCount:(NSInteger)cacheCount
{
  return [self initWithMaxCacheSize:MAX_CACHE_SIZE maxCacheCount:cacheCount];
}

/// Initializes image cache with default cache count and given cache size
/// @param cacheSize: max size of cache
- (instancetype)initWithMaxCacheSize:(NSInteger)cacheSize
{
  return [self initWithMaxCacheSize:cacheSize maxCacheCount:MAX_CACHE_COUNT];
}

/// Designated initializer
///
/// @param cacheSize: max size of cache allowed, cacheCount: max count of cache objects allowed
/// @returns imageCache: initialized instance of image cache
- (instancetype)initWithMaxCacheSize:(NSInteger)cacheSize maxCacheCount:(NSInteger)cacheCount
{
  self = [super init];
  if (self) {
    self.maxCacheCount = cacheCount;
    self.maxCacheSize = cacheSize;
    self.cacheMap = [[NSMutableDictionary alloc] initWithCapacity:cacheCount];
    self.list = [[DoublyLinkedList alloc] initWithMaxCount:cacheCount maxSize:cacheSize];
  }
  return self;
}

/// Set image key value pair in cache map and inserts a node at the head of linked list. If the max capacity of the list is hit, the last node is removed from the list and corresponding key value pair is removed from cache map
///
/// @param key: a name identifying the image
/// @param object: the value associated with key
- (void)setObject:(id)object forKey:(NSData *)bytes
{
  NSData *data = (NSData *)object;
  if (data.length > self.maxCacheSize) {
    return;
  }
  
  NSString *key = [NSString stringFromBytes:bytes];
  Node *newNode = [[Node alloc] initWithName:key value:object];
  [self.cacheMap setObject:newNode forKey:key];
  [self.list insertBeginning:newNode];
  self.currentCacheSize += data.length;
  
  if ([self leastRecentlyUsedImageShouldBeRemovedForInsertingObjectOfSize:data.length] && self.cacheBeingAccessed == NO) {
    Node *lastNode = self.list.lastNode;
    if (lastNode) {
      NSData *lastNodeData = (NSData *)lastNode.value;
      self.currentCacheSize -= lastNodeData.length;
      [self.cacheMap removeObjectForKey:lastNode.name];
      [self.list removeLastNode];
    }
  }
}

/// Checks the cache image count and size to determine if the least recently used image should be evicted
/// @returns BOOL
- (BOOL)leastRecentlyUsedImageShouldBeRemovedForInsertingObjectOfSize:(NSInteger)imageSize
{
  if (self.list.count == self.maxCacheCount || (self.currentCacheSize + imageSize >= self.maxCacheSize)) {
    return YES;
  }
  return NO;
}

/// Returns object associated with key in the cache map. Also moves the corresponding node to the head of the list to keep least recently used objects towards the tail of the list
- (id)objectForKey:(NSString *)key
{
  self.cacheBeingAccessed = YES;

  NSData *bytes = [NSData bytesFromString:key];
  NSString *imageKey = [NSString stringFromBytes:bytes];
  
  Node *node = [self.cacheMap objectForKey:imageKey];
  if (!node) {
    self.cacheBeingAccessed = NO;
    return nil;
  }
  [self.list removeNode:node];
  [self.list insertBeginning:node];
  self.cacheBeingAccessed = NO;
  return node.value;
}

/// Removes all objects from the cache map and linked list
- (void)clearCache
{
  [self.cacheMap removeAllObjects];
  
  [self.list removeAllNodes];
}

@end
