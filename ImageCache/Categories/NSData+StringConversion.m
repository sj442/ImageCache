//
//  NSData+StringConversion.m
//  ImageCache
//
//  Created by Sunayna Jain on 2/16/16.
//  Copyright © 2016 Enhatch. All rights reserved.
//

#import "NSData+StringConversion.h"

@implementation NSData (StringConversion)

static NSInteger KEY_SIZE = 32;

+ (NSData *)bytesFromString:(NSString *)string
{
  NSInteger length = MIN(KEY_SIZE, string.length);
  NSString *str = [string substringFromIndex:string.length - length];
  NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
  return data;
}

@end
