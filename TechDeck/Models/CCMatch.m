//
//  CCMatch.m
//  TechDeck
//
//  Created by square on 1/10/14.
//  Copyright (c) 2014 CodeCamp2014. All rights reserved.
//

#import "CCMatch.h"
#import "CCPersonInfo.h"
#import "CCPersonImage.h"


@implementation CCMatch

- (instancetype)init;
{
    self = [super init];
    if (self) {
        _personImages = [[NSMutableArray alloc] init];
        
    }
    return self;
}

- (void)addPersonImage:(CCPersonImage *)personImage;
{
    [[self personImages] addObject:personImage];
    [personImage setMatch:self];
}

- (void)setPersonInfo:(CCPersonInfo *)personInfo;
{
    _personInfo = personInfo;
    [personInfo setMatch:self];
}

- (NSString *)description;
{
    return [[self personInfo] name];
}
@end
