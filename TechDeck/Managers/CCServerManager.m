//
//  CCServerManager.m
//  TechDeck
//
//  Created by square on 1/10/14.
//  Copyright (c) 2014 CodeCamp2014. All rights reserved.
//

#import "CCServerManager.h"
#import "CCDownload.h"

@implementation CCServerManager

- (void)downloadDecks:(void(^)(NSArray *decks, NSError *error))completion;
{
    NSURL *decks = [NSURL URLWithString:@"https://codecamp-techdeck.herokuapp.com/api/v1"];
    
    CCDownload *downloader = [[CCDownload alloc] initWithURL:decks completionBlock:^(NSData *data, NSError *error) {
        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:NULL];
        NSLog(@"josn Dictionary is %@", jsonDictionary);
    }];
    
    [downloader start];
}

@end
