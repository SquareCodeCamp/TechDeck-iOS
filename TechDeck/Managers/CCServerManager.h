//
//  CCServerManager.h
//  TechDeck
//
//  Created by square on 1/10/14.
//  Copyright (c) 2014 CodeCamp2014. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCServerManager : NSObject

+ (instancetype)sharedManager;

- (void)downloadDecks:(void(^)(NSArray *decks, NSError *error))completionBlock;

@end
