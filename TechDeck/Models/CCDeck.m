//
//  CCDeck.m
//  TechDeck
//
//  Created by square on 1/10/14.
//  Copyright (c) 2014 CodeCamp2014. All rights reserved.
//

#import "CCDeck.h"

@implementation CCDeck

- (instancetype)init;
{
    self = [super init];
    if (self) {
        // continue with setup
        _matches = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)addMatch:(CCMatch *)match;
{
    [[self matches] addObject:match];
}

@end
