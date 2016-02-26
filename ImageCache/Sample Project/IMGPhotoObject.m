//
//  PhotoObject.m
//  ImageCache
//
//  Created by Sunayna Jain on 1/2/16.
//  Copyright © 2016 Enhatch. All rights reserved.
//

#import "IMGPhotoObject.h"

@implementation IMGPhotoObject

- (instancetype)initWithIdentifier:(NSString *)identifier url:(NSString *)url
{
  self = [super init];
  if (self) {
    self.identifier = identifier;
    self.imageURL = url;
  }
  return self;
}

@end
