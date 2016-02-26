//
//  NSString+BytesConversion.m
//  ImageCache
//
//  Created by Sunayna Jain on 2/16/16.
//  Copyright © 2016 Enhatch. All rights reserved.
//

#import "NSString+BytesConversion.h"

@implementation NSString (BytesConversion)

+ (NSString *)stringFromBytes:(NSData *)bytes
{
  NSString *string = [[NSString alloc] initWithData:bytes encoding:NSUTF8StringEncoding];
  return string;
}

@end
