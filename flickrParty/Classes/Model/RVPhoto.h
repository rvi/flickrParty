//
//  RVPhoto.h
//  flickrParty
//
//  Created by Rémy on 25/06/13.
//  Copyright (c) 2013 Rémy Virin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RVPhoto : NSObject

/**************************************************************************************************/
#pragma mark - Getters & Setters

@property (nonatomic, strong) NSString *url;

/**************************************************************************************************/
#pragma mark - Birth & Death

+ (RVPhoto *)photoWithJSONDict:(NSDictionary *)dict;

@end
