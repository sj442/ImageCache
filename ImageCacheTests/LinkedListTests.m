//
//  LinkedListTests.m
//  ImageCache
//
//  Created by Sunayna Jain on 1/4/16.
//  Copyright © 2016 Enhatch. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "DoublyLinkedList.h"
#import "Node.h"

@interface LinkedListTests : XCTestCase

@property (strong, nonatomic) DoublyLinkedList *list;

@property (strong, nonatomic) Node *node;

@end

@implementation LinkedListTests

- (void)setUp {
  [super setUp];
  self.list = [[DoublyLinkedList alloc] initWithMaxCount:10 maxSize:1000];
  self.node = [[Node alloc] initWithName:@"test" value:nil];

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

- (void)testListInit
{
  DoublyLinkedList *list = [[DoublyLinkedList alloc] initWithMaxCount:10 maxSize:1000];
  XCTAssertNotNil(list);
  XCTAssertEqual(list.maxCount, 10);
  XCTAssertEqual(list.maxSize, 1000);
}

- (void)testNodeInit
{
  Node *node = [[Node alloc] initWithName:@"name" value:@"value"];
  XCTAssertEqual(node.name, @"name");
  XCTAssertEqual(node.value, @"value");
}

- (void)testInsertBeginning
{
  [self.list insertBeginning:self.node];
  XCTAssertEqual(self.list.firstNode, self.node);
}

- (void)testInsertEnd
{
  [self.list insertEnd:self.node];
  XCTAssertEqual(self.list.lastNode, self.node);
}

- (void)testRemoveAllNodes
{
  [self.list removeAllNodes];
  XCTAssertEqual(self.list.count, 0);
}

- (void)testRemoveNode
{
  [self.list removeNode:self.node];
  XCTAssertNotEqual(self.node, self.list.lastNode);
}

- (void)testRemoveLastNode
{
  Node *node = self.list.lastNode.prev;
  [self.list removeLastNode];
  XCTAssertEqual(node, self.list.lastNode);
}

- (void)testInsertNodeAfterGivenNode
{
  Node *nodeToInsert = [[Node alloc] initWithName:@"node" value:nil];
  [self.list insertAfter:self.node newNode:nodeToInsert];
  XCTAssertEqual(self.node.next, nodeToInsert);
  XCTAssertEqual(nodeToInsert.prev, self.node);
}

- (void)testInsertBeforeGivenNode
{
  Node *nodeToInsert = [[Node alloc] initWithName:@"node" value:nil];
  [self.list insertBefore:self.node newNode:nodeToInsert];
  XCTAssertEqual(self.node.prev, nodeToInsert);
  XCTAssertEqual(nodeToInsert.next, self.node);
}

@end
