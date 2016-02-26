//
//  ViewController.m
//  ImageCache
//
//  Created by Sunayna Jain on 12/28/15.
//  Copyright © 2015 Enhatch. All rights reserved.
//

#import "IMGViewController.h"
#import "ImageCache.h"
#import "IMGImageTableViewCell.h"
#import "IMGDataManager.h"
#import "IMGPhotoObject.h"

#import "IMGViewModel.h"

@interface IMGViewController ()

@property (strong, nonatomic) NSMutableArray *photos;

@property (strong, nonatomic) ImageCache *imageCache;

@property (strong, nonatomic) IMGViewModel *viewModel;

@end

@implementation IMGViewController

static NSString *imageTableViewCellIdentifier = @"imageCell";

- (instancetype)initWithViewModel:(IMGViewModel *)viewModel
{
  self = [super init];
  if (self) {
    self.viewModel = viewModel;
  }
  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  [self registerTableViewCells];
  
  self.tableView.contentInset = UIEdgeInsetsMake(30, 0, 0, 0);
  
  [self.viewModel fetchPhotoInfoWithCompletion:^{
    [self.tableView reloadData];
  }];
}

- (void)registerTableViewCells
{
  UINib *nib = [UINib nibWithNibName:@"IMGImageTableViewCell" bundle:[NSBundle mainBundle]];
  
  [self.tableView registerNib:nib forCellReuseIdentifier:imageTableViewCellIdentifier];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
}

#pragma mark - TableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return [self.viewModel numberOfSectionsInTableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return [self.viewModel numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  IMGImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:imageTableViewCellIdentifier];
  
  cell.photoImageView.image = nil;
  
  IMGPhotoObject *photoObject = [self.viewModel objectAtIndex:indexPath.row];
    
  NSData *data = [self.viewModel cacheObjectForKey:photoObject.imageURL];
  
  if (data) {
    
    cell.photoImageView.image = [UIImage imageWithData:data];
    
  } else {
    
    [self.viewModel fetchImageWithURL:photoObject.imageURL completion:^(NSData *data) {
      
      cell.photoImageView.image = [UIImage imageWithData:data];
      
    }];
  }
  return cell;
}

#pragma mark - TableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return 200;
}

@end
