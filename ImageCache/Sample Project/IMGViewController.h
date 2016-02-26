//
//  ViewController.h
//  ImageCache
//
//  Created by Sunayna Jain on 12/28/15.
//  Copyright © 2015 Enhatch. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IMGViewModel;

@interface IMGViewController : UITableViewController

- (instancetype)initWithViewModel:(IMGViewModel *)viewModel;

@end

