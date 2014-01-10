//
//  CCMatch.h
//  TechDeck
//
//  Created by square on 1/10/14.
//  Copyright (c) 2014 CodeCamp2014. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CCPersonInfo;
@class CCPersonImage;

@interface CCMatch : NSObject

// Created a setter and a getter.
@property (nonatomic, strong) CCPersonInfo *personInfo;

// Created JUST a getter.
@property (nonatomic, strong, readonly) NSMutableArray *personImages;

- (void)addPersonImage:(CCPersonImage *)personImage;

@end
