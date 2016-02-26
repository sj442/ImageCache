//
//  Node.h
//  ImageCache
//
//  Created by Sunayna Jain on 12/28/15.
//  Copyright © 2015 Enhatch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Node : NSObject

@property (strong, nonatomic) id value;

@property (strong, nonatomic) NSString *name;

@property (strong, nonatomic) Node *prev;

@property (strong, nonatomic) Node *next;

- (instancetype)initWithName:(NSString *)name value:(id)value;

- (BOOL)isEqual:(id)object;

@end
