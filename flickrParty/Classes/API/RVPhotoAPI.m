//
//  RVPhotoAPI.m
//  flickrParty
//
//  Created by Rémy on 24/06/13.
//  Copyright (c) 2013 Rémy Virin. All rights reserved.
//

#import "RVPhotoAPI.h"


// API
#import "AFNetworking.h"

// Model
#import "RVPhoto.h"

// KEYs
#define METHOD_KEY @"method"
#define SEARCH_METHOD @"flickr.photos.search"
#define API_KEY @"api_key"
#define API @"a642bcc2804e16bf75704ba89f632399"
#define TAGS_KEY @"tags"
#define PARTY_KEY @"party"
#define FORMAT_KEY @"format"
#define NO_JSON_CALLBACK_KEY @"nojsoncallback"
#define JSON @"json"
#define EXTRAS_KEY @"extras"
#define URL_KEY @"url_n"

#define PHOTOS_KEY @"photos"
#define PHOTO_KEY @"photo"

#define PATH_KEY @"/services/rest/"

@implementation RVPhotoAPI

+ (void)getPhotosTaggedPartySucceded:(void (^) (NSArray *photos))success
                              failed:(void (^) (NSError *error))failure
{
    NSURL *url = [NSURL URLWithString:@"http://api.flickr.com/"];
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:url];
    
    NSDictionary *params = @{METHOD_KEY: SEARCH_METHOD,
                             API_KEY: API,
                             NO_JSON_CALLBACK_KEY: @1,
                             TAGS_KEY: PARTY_KEY,
                             EXTRAS_KEY: URL_KEY,
                             FORMAT_KEY: JSON};
    
    [client getPath:PATH_KEY
         parameters:params
            success:^(AFHTTPRequestOperation *operation, id responseObject) {
                
                NSError *error;
                NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
                NSDictionary *photosDict = [result objectForKey:PHOTOS_KEY];
                NSArray *photos = [photosDict objectForKey:PHOTO_KEY];
                
                NSMutableArray *parsedPhotos = [NSMutableArray array];
                
                for (NSDictionary *aPhoto in photos)
                {
                    RVPhoto *photo = [RVPhoto photoWithJSONDict:aPhoto];
                    
                    if (photo)
                    {
                        [parsedPhotos addObject:photo];
                    }
                }
                
                DLog(@"result : %@", parsedPhotos);
                
                if (success)
                {
                    success([NSArray arrayWithArray:parsedPhotos]);
                }
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
                if (failure)
                {
                    failure(error);
                }
            }];
}

@end
