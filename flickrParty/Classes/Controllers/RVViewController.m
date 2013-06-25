//
//  RVViewController.m
//  flickrParty
//
//  Created by Rémy on 24/06/13.
//  Copyright (c) 2013 Rémy Virin. All rights reserved.
//

#import "RVViewController.h"

// API
#import "RVPhotoAPI.h"

// Model
#import "RVPhoto.h"

// View
#import "RVPhotoCell.h"

@interface RVViewController ()

// Data
@property (nonatomic, strong) NSArray *photos;

// UI
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;


@end

@implementation RVViewController

/**************************************************************************************************/
#pragma mark - View Management

- (void)viewDidLoad
{
    [super viewDidLoad];

    [RVPhotoAPI getPhotosTaggedPartySucceded:^(NSArray *inPhotos) {
        
        self.photos = inPhotos;
        [self.collectionView reloadData];
        
    } failed:^(NSError *error) {
        DLog(@"failure in getting photo : %@",error);
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**************************************************************************************************/
#pragma mark - UICollectionDatasource


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.photos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    RVPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"photoCellID" forIndexPath:indexPath];
    
    if (indexPath.row < self.photos.count)
    {
        RVPhoto *photo = [self.photos objectAtIndex:indexPath.row];
        [cell updateUIWithPhoto:photo];
    }
    return cell;
}


@end
