//
//  ViewModel.h
//  ImageCache
//
//  Created by Sunayna Jain on 1/3/16.
//  Copyright © 2016 Enhatch. All rights reserved.
//

#import <Foundation/Foundation.h>

@class IMGPhotoObject, IMGDataManager;

@interface IMGViewModel : NSObject

- (instancetype)initWithDataManager:(IMGDataManager *)dataManager;

- (NSInteger)numberOfSectionsInTableView;

- (NSInteger)numberOfRowsInSection:(NSInteger)section;

- (void)fetchPhotoInfoWithCompletion:(void (^)(void))completion;

- (void)fetchImageWithURL:(NSString *)imageURL completion:(void (^)(NSData *data))completion;

- (IMGPhotoObject *)objectAtIndex:(NSInteger)index;

- (id)cacheObjectForKey:(NSString *)key;

@end
