//
//  CCPersonInfo.h
//  TechDeck
//
//  Created by square on 1/10/14.
//  Copyright (c) 2014 CodeCamp2014. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CCMatch;

@interface CCPersonInfo : NSObject

@property (nonatomic, weak) CCMatch *match;

@property (nonatomic, strong) NSNumber *personID;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *bio;
@property (nonatomic, strong) NSString *wikiLink;

@end
