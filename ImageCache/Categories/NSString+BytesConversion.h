//
//  NSString+BytesConversion.h
//  ImageCache
//
//  Created by Sunayna Jain on 2/16/16.
//  Copyright © 2016 Enhatch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (BytesConversion)

+ (NSString *)stringFromBytes:(NSData *)bytes;

@end
