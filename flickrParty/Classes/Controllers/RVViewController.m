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

@interface RVViewController ()

@end

@implementation RVViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [RVPhotoAPI getPhotosTaggedPartySucceded:^(NSArray *photos) {
        
    } failed:^(NSError *error) {
        DLog(@"failure in getting photo : %@",error);
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
