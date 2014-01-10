//
//  CCServerManager.m
//  TechDeck
//
//  Created by square on 1/10/14.
//  Copyright (c) 2014 CodeCamp2014. All rights reserved.
//

#import "CCServerManager.h"
#import "CCDownload.h"

#import "CCPersonImage.h"
#import "CCPersonInfo.h"
#import "CCMatch.h"
#import "CCDeck.h"

@implementation CCServerManager

+ (instancetype)sharedManager;
{
    static CCServerManager *sharedServerManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedServerManager = [[self alloc] init];
    });
    return sharedServerManager;
}

- (void)downloadDecks:(void(^)(NSArray *decks, NSError *error))completion;
{
    NSURL *decks = [NSURL URLWithString:@"https://codecamp-techdeck.herokuapp.com/api/v1"];
    
    CCDownload *downloader = [[CCDownload alloc] initWithURL:decks completionBlock:^(NSData *data, NSError *error) {
        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:NULL];
        
        NSMutableArray *decks = [[NSMutableArray alloc] init];
        
        // Inflate model objects with JSON data.
        for (NSDictionary *deckDictionary in [jsonDictionary objectForKey:@"decks"]) {
            
            CCDeck *deck = [[CCDeck alloc] init];
            [deck setDeckName:[deckDictionary valueForKey:@"name"]];
            
            [decks addObject:deck];

            for (NSDictionary *cardDictionary in [deckDictionary objectForKey:@"cards"]) {
                CCMatch *match = [[CCMatch alloc] init];
                [deck addMatch:match];
                
                CCPersonImage *personImage = [[CCPersonImage alloc] init];
                [personImage setImageURL:[NSURL URLWithString:[cardDictionary valueForKey:@"image_url"]]];
                
                [match addPersonImage:personImage];
                
                CCPersonInfo *personInfo = [[CCPersonInfo alloc] init];
                
                [personInfo setBio:[cardDictionary valueForKey:@"bio"]];
                [personInfo setName:[cardDictionary valueForKey:@"name"]];
                [personInfo setWikiLink:[cardDictionary valueForKey:@"wiki_link"]];
                [personInfo setPersonID:[cardDictionary valueForKey:@"id"]];
                
                [match setPersonInfo:personInfo];
            }
        }
        
        completion(decks, error);
    }];
    
    [downloader start];
}

@end
