//
//  CCImageStore.m
//  TechDeck
//
//  Created by square on 1/10/14.
//  Copyright (c) 2014 CodeCamp2014. All rights reserved.
//

#import "CCImageStore.h"
#import "CCDownload.h"


@interface CCImageStore ()

@property (nonatomic, strong) NSMutableDictionary *images;

@end


@implementation CCImageStore

+ (instancetype)sharedImageStore;
{
    static CCImageStore *sharedImageStore = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedImageStore = [[self alloc] init];
    });
    return sharedImageStore;
}

- (instancetype)init;
{
    self = [super init];
    if (self) {
        _images = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)fetchImageForURL:(NSURL *)url completion:(void(^)(UIImage *image, NSError *error))completion;
{
    // First check to see if image is cached.
    __block UIImage *image = [[self images] objectForKey:url];
    
    // If image is not cached...
    if (!image) {
        // go to server and download it
        CCDownload *downloader = [[CCDownload alloc] initWithURL:url completionBlock:^(NSData *data, NSError *error) {
            if (!error) {
                image = [UIImage imageWithData:data];
                
                // Cache the image.
                [[self images] setObject:image forKey:url];
            }
            completion(image, error);
        }];
        
        [downloader start];
    } else {
        // Performing completion block after 1 run loop.
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            completion(image, nil);
        }];
    }
}

@end
