//
//  DoublyLinkedList.m
//  ImageCache
//
//  Created by Sunayna Jain on 12/28/15.
//  Copyright © 2015 Enhatch. All rights reserved.
//

#import "DoublyLinkedList.h"
#import "Node.h"

@implementation DoublyLinkedList

#pragma mark - Initiliazation

/// Initialzes a linked list with given max count of nodes and max size
///
/// @param count: max count of nodes in the list
/// @param size: max size of list
- (instancetype)initWithMaxCount:(NSInteger)count maxSize:(NSInteger)size
{
  self = [super init];
  if (self) {
    self.maxCount = count;
    self.maxSize = size;
  }
  return self;
}

#pragma mark - Helper functions

/// Inserts node at the end of the list
///
/// @param node: Node to be inserted
- (void)insertEnd:(Node *)node
{
  Node *tempNode = self.lastNode;
  node.prev = tempNode;
  node.next = nil;
  tempNode.next = node;
  self.lastNode = node;
  self.count ++;
}

/// Inserts node at the beginning of the list
///
/// @param node: Node to be inserted
- (void)insertBeginning:(Node *)node
{
  Node *tempNode = self.firstNode;
  tempNode.prev = node;
  node.next = tempNode;
  self.firstNode = node;
  if (self.count == 0) {
    self.lastNode = self.firstNode;
  }
  self.count ++;
}

/// Removes a given node from the list
///
/// @param node: Node to be removed from list
- (void)removeNode:(Node *)node
{
  Node *prevNode = node.prev;
  Node *nextNode = node.next;
  prevNode.next = nextNode;
  nextNode.prev = prevNode;
  self.count --;
}

/// Inserts a new node before given node
///
/// @param node: given node before which new node will be inserted
/// @param newNode: node to be inserted
- (void)insertBefore:(Node *)node newNode:(Node *)newNode
{
  Node *prevNode = node.prev;
  node.prev = newNode;
  prevNode.next = newNode;
  newNode.prev = prevNode;
  newNode.next = node;
  self.count ++;
}

/// Inserts a new node after given node
///
/// @param node: given node after which new node will be inserted
/// @param newNode: node to be inserted
- (void)insertAfter:(Node *)node newNode:(Node *)newNode
{
  Node *nextNode = node.next;
  node.next = newNode;
  nextNode.prev = newNode;
  newNode.prev = node;
  newNode.next = nextNode;
  self.count ++;
}

/// Removes last node from the list
- (void)removeLastNode
{
  Node *prevNode = self.lastNode.prev;
  prevNode.next = nil;
  self.lastNode = prevNode;
  self.count --;
}

/// Removes all nodes from the linked list iteratively
- (void)removeAllNodes
{
  while (self.count > 0) {
    [self removeLastNode];
    self.count --;
  }
}

@end
