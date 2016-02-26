//
//  DataManager.m
//  ImageCache
//
//  Created by Sunayna Jain on 12/30/15.
//  Copyright © 2015 Enhatch. All rights reserved.
//

#import "IMGDataManager.h"

@interface IMGDataManager ()

@property (nonatomic, strong) NSURLSession *session;

@end

@implementation IMGDataManager

/// The sample project is using 500px API for fetching images
static NSString *URL = @"https://api.500px.com/v1/photos?feature=popular&consumer_key=Mtb5tEsQAI2MiYYVfiKWLYL0Tnd3EEkO4spw9zFT";

/// Creates an NSURLSession instance with default session configuration
- (NSURLSession *)session
{
  if (!_session) {
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    _session = [NSURLSession sessionWithConfiguration:config];
  }
  return  _session;
}

/// Fetches popular photos info from 500px
///
/// Completion block returns a dictionary with popular photos info
- (void)fetchPhotoInfoWithCompletion:(void (^)(NSDictionary *))completion
{
  NSURL *url = [NSURL URLWithString:URL];
  
  NSURLSessionDownloadTask *task = [self.session downloadTaskWithURL:url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
    if (!error) {
      NSData *data  = [NSData dataWithContentsOfURL:location];
      NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data
                                                           options:kNilOptions
                                                             error:nil];
      if (completion) {
        completion(json);
      }
    }
  }];
  
  [task resume];
}


/// Fetches image data for given URL.
///
/// @param imageURL: URL from which NSURL is composed
- (void)fetchImageWithURL:(NSString *)imageURL completion:(void (^)(NSData *data))completion
{
  NSURL *url = [NSURL URLWithString:imageURL];
  
  NSURLSessionDataTask *task = [self.session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
    if (!error) {
      if (completion) {
        completion(data);
      }
    }
  }];
  
  [task resume];
}

@end
