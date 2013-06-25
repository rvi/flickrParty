//
//  RVPhotoCell.h
//  flickrParty
//
//  Created by Rémy on 25/06/13.
//  Copyright (c) 2013 Rémy Virin. All rights reserved.
//

#import <Foundation/Foundation.h>

// Model
#import "RVPhoto.h"

@interface RVPhotoCell : UICollectionViewCell

/**************************************************************************************************/
#pragma mark - Getters & Setters

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

/**************************************************************************************************/
#pragma mark - UI

- (void)updateUIWithPhoto:(RVPhoto *)photo;

@end
