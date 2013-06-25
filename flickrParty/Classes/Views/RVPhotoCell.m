//
//  RVPhotoCell.m
//  flickrParty
//
//  Created by Rémy on 25/06/13.
//  Copyright (c) 2013 Rémy Virin. All rights reserved.
//

#import "RVPhotoCell.h"

#import "AFNetworking.h"

@interface RVPhotoCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end


@implementation RVPhotoCell

/**************************************************************************************************/
#pragma mark - UI

- (void)updateUIWithPhoto:(RVPhoto *)photo
{
    // TODO: add cache on photo
    NSURL *url = [NSURL URLWithString:photo.url];
    [self.imageView setImageWithURL:url];
}

@end
