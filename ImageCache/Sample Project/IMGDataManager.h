//
//  DataManager.h
//  ImageCache
//
//  Created by Sunayna Jain on 12/30/15.
//  Copyright © 2015 Enhatch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IMGDataManager : NSObject

- (void)fetchPhotoInfoWithCompletion:(void (^)(NSDictionary *))completion;

- (void)fetchImageWithURL:(NSString *)imageURL completion:(void (^)(NSData *data))completion;

@end
