//
//  CCDownload.h
//  TechDeck
//
//  Created by square on 1/10/14.
//  Copyright (c) 2014 CodeCamp2014. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCDownload : NSObject

- (instancetype)initWithURL:(NSURL *)url completionBlock:(void(^)(NSData *data, NSError *error))completionBlock;
- (void)start;

@end
