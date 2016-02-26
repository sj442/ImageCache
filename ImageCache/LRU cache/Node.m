//
//  Node.m
//  ImageCache
//
//  Created by Sunayna Jain on 12/28/15.
//  Copyright © 2015 Enhatch. All rights reserved.
//

#import "Node.h"

@implementation Node

- (instancetype)initWithName:(NSString *)name value:(id)value
{
  self = [super init];
  if (self) {
    self.value = value;
    self.name = name;
  }
  return self;
}

- (BOOL)isEqual:(id)object
{
  if (self.value == object) {
    return YES;
  }
  return NO;
}

- (NSString *)description
{
  return self.value;
}

@end
