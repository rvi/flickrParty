//
//  RVPhotoAPI.h
//  flickrParty
//
//  Created by Rémy on 24/06/13.
//  Copyright (c) 2013 Rémy Virin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RVPhotoAPI : NSObject


+ (void)getPhotosTaggedPartyPage:(NSUInteger)page
            numberOfItemsPerPage:(NSUInteger)numberOfItems
                        Succeded:(void (^) (NSArray *photos))success
                          failed:(void (^) (NSError *error))failure;

@end
