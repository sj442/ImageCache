//
//  DoublyLinkedList.h
//  ImageCache
//
//  Created by Sunayna Jain on 12/28/15.
//  Copyright © 2015 Enhatch. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Node;

@interface DoublyLinkedList : NSObject

@property (strong, nonatomic) Node *firstNode;

@property (strong, nonatomic) Node *lastNode;

@property (nonatomic) NSInteger count;
@property (nonatomic) NSInteger maxCount;
@property (nonatomic) NSInteger maxSize;

- (instancetype)initWithMaxCount:(NSInteger)count maxSize:(NSInteger)size;

- (void)insertBeginning:(Node *)node;

- (void)insertEnd:(Node *)node;

- (void)insertBefore:(Node *)node newNode:(Node *)newNode;

- (void)insertAfter:(Node *)node newNode:(Node *)newNode;

- (void)removeNode:(Node *)node;

- (void)removeLastNode;

- (void)removeAllNodes;
                               
@end
