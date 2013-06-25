//
//  RVPhoto.m
//  flickrParty
//
//  Created by Rémy on 25/06/13.
//  Copyright (c) 2013 Rémy Virin. All rights reserved.
//

#import "RVPhoto.h"

#define URL_KEY @"url_n"

@implementation RVPhoto

/**************************************************************************************************/
#pragma mark - Birth & Death

+ (RVPhoto *)photoWithJSONDict:(NSDictionary *)dict
{
    RVPhoto *result = nil;

    if ([dict isKindOfClass:[NSDictionary class]])
    {
        result = [[RVPhoto alloc] init];
        result.url = [dict objectForKey:URL_KEY];
    }
    
    return result;
}

/**************************************************************************************************/
#pragma mark - description

-(NSString *)description
{
    return [NSString stringWithFormat:@"Photo [\r\
            url : %@]", self.url];
}

@end
