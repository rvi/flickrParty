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

@interface RVViewController ()

// Data
@property (nonatomic, strong) NSArray *photos;

// UI
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;


@end

@implementation RVViewController

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

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [collectionView dequeueReusableCellWithReuseIdentifier:@"photoCellID" forIndexPath:indexPath];
}


@end
