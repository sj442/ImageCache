//
//  PhotoObject.h
//  ImageCache
//
//  Created by Sunayna Jain on 1/2/16.
//  Copyright © 2016 Enhatch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IMGPhotoObject : NSObject

@property (strong, nonatomic) NSString *identifier;
@property (strong, nonatomic) NSString *imageURL;

- (instancetype)initWithIdentifier:(NSString *)identifier url:(NSString *)url;

@end
