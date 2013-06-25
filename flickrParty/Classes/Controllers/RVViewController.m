//
//  RVViewController.m
//  flickrParty
//
//  Created by Rémy on 24/06/13.
//  Copyright (c) 2013 Rémy Virin. All rights reserved.
//

#import "RVViewController.h"

// API
#import "AFNetworking.h"
#import "RVPhotoAPI.h"

// Model
#import "RVPhoto.h"

// View
#import "RVPhotoCell.h"

// Utils
#import "UIImage+crop.h"

#define NUMBER_OF_ITEM_PER_PAGE 100

@interface RVViewController ()

// Data
@property (nonatomic, strong) NSMutableArray *photos;

// UI
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) UIImageView *detailImageView;

@end

@implementation RVViewController


/**************************************************************************************************/
#pragma mark - View Management

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.photos = [NSMutableArray array];
    
    self.detailImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.detailImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.detailImageView.userInteractionEnabled = YES;
    self.detailImageView.backgroundColor = [UIColor colorWithRed:0. green:0. blue:0. alpha:0.8];
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(detailImageViewTapped:)];
    [self.detailImageView addGestureRecognizer:tapRecognizer];
    [self.view addSubview:self.detailImageView];
    
    [self retrievePhotos];
}

/**************************************************************************************************/
#pragma mark - API

- (void)retrievePhotos
{
    NSUInteger page = self.photos.count / NUMBER_OF_ITEM_PER_PAGE + 1;

    [RVPhotoAPI getPhotosTaggedPartyPage:page
                    numberOfItemsPerPage:NUMBER_OF_ITEM_PER_PAGE
                                Succeded:^(NSArray *inPhotos) {
                                
                                    NSUInteger numberOfPreviousPhotos = self.photos.count;
                                    [self.photos addObjectsFromArray:inPhotos];

                                    NSMutableArray *indexPaths = [NSMutableArray arrayWithCapacity:inPhotos.count];
                                    
                                    for (NSUInteger i = numberOfPreviousPhotos; i < self.photos.count; i++)
                                    {
                                        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
                                        [indexPaths addObject:indexPath];
                                    }
                                    
                                    [self.collectionView insertItemsAtIndexPaths:indexPaths];
                                    
    } failed:^(NSError *error) {
        DLog(@"failure in getting photo : %@",error);
    }];
}

/**************************************************************************************************/
#pragma mark - Actions

- (void)detailImageViewTapped:(id)sender
{
    NSArray *selectedIndexPath = [self.collectionView indexPathsForSelectedItems];
    RVPhotoCell *cell = (RVPhotoCell *) [self.collectionView cellForItemAtIndexPath:[selectedIndexPath objectAtIndex:0]];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.detailImageView.frame = [self.view convertRect:cell.frame fromView:self.collectionView];
        
    } completion:^(BOOL finished) {
        self.detailImageView.frame = CGRectZero;
    }];
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

/***************************:***********************************************************************/
#pragma mark - UICollectionDelegate

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    RVPhotoCell *cell = (RVPhotoCell *) [collectionView cellForItemAtIndexPath:indexPath];

    self.detailImageView.image = [UIImage imageFromView:cell];

    self.detailImageView.frame = [self.view convertRect:cell.frame fromView:self.collectionView];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.detailImageView.frame = self.view.bounds;
        
    } completion:^(BOOL finished) {
        
        self.detailImageView.image = cell.imageView.image;
        
    }];
}

/**************************************************************************************************/
#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y == scrollView.contentSize.height - scrollView.frame.size.height
        && ![[AFNetworkActivityIndicatorManager sharedManager] isNetworkActivityIndicatorVisible])
    {
        [self retrievePhotos];
    }
}

@end
