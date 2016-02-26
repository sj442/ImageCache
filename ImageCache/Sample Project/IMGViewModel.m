//
//  ViewModel.m
//  ImageCache
//
//  Created by Sunayna Jain on 1/3/16.
//  Copyright © 2016 Enhatch. All rights reserved.
//

#import "IMGViewModel.h"
#import "IMGDataManager.h"
#import "IMGPhotoObject.h"
#import "ImageCache.h"

#import "NSData+StringConversion.h"

@interface IMGViewModel ()

@property (strong, nonatomic) IMGDataManager *dataManager;

@property (strong, nonatomic) ImageCache *imageCache;

@property (strong, nonatomic) NSMutableArray *photoInfo;

@end

@implementation IMGViewModel

- (instancetype)initWithDataManager:(IMGDataManager *)dataManager
{
  self = [super init];
  
  if (self) {
    self.dataManager = dataManager;
    self.imageCache = [ImageCache new];
    self.photoInfo = [NSMutableArray new];
  }
  return self;
}

/// Number of sections in TableView
/// @return sections
- (NSInteger)numberOfSectionsInTableView
{
  return 1;
}

/// Number of rows in a given section of tableView
/// @return rows
- (NSInteger)numberOfRowsInSection:(NSInteger)section
{
  return self.photoInfo.count;
}

/// Fetches info about popular photos on 500Px and converts the response into JSON. Photo objects are created to store image info for each image
- (void)fetchPhotoInfoWithCompletion:(void (^)(void))completion
{
  [self.dataManager fetchPhotoInfoWithCompletion:^(NSDictionary *dictionary) {
    
    NSArray *photos = dictionary[@"photos"];
    
    for (NSDictionary *photo in photos) {
      IMGPhotoObject *photoObject = [[IMGPhotoObject alloc] initWithIdentifier:photo[@"id"] url:photo[@"image_url"]];
      [self.photoInfo addObject:photoObject];
    }
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
      if (completion) {
        completion();
      }
    }];
    
  }];
}

/// Fetches image data for a given URL
- (void)fetchImageWithURL:(NSString *)imageURL completion:(void (^)(NSData *data))completion
{
  [self.dataManager fetchImageWithURL:imageURL completion:^(NSData *data) {
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
      
      NSData *bytes = [NSData bytesFromString:imageURL];
      
      [self.imageCache setObject:data forKey:bytes];
      
      if (completion) {
        completion(data);
      }
      
    }];
    
  }];
}


- (IMGPhotoObject *)objectAtIndex:(NSInteger)index
{
  return self.photoInfo[index];
}

/// Returns cached image from the image cache
- (id)cacheObjectForKey:(NSString *)key
{
  return [self.imageCache objectForKey:key];
}


@end
