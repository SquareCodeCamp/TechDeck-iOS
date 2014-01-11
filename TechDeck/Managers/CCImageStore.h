//
//  CCImageStore.h
//  TechDeck
//
//  Created by square on 1/10/14.
//  Copyright (c) 2014 CodeCamp2014. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCImageStore : NSObject

+ (instancetype)sharedImageStore;
- (void)fetchImageForURL:(NSURL *)url completion:(void(^)(UIImage *image, NSError *error))completion;

@end
