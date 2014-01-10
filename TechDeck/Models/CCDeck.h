//
//  CCDeck.h
//  TechDeck
//
//  Created by square on 1/10/14.
//  Copyright (c) 2014 CodeCamp2014. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CCMatch;

@interface CCDeck : NSObject

@property (nonatomic, strong) NSMutableArray *matches;
@property (nonatomic, strong) NSString *deckName;

- (void)addMatch:(CCMatch *)match;

@end
