//
//  CCDownload.m
//  TechDeck
//
//  Created by square on 1/10/14.
//  Copyright (c) 2014 CodeCamp2014. All rights reserved.
//

#import "CCDownload.h"

@interface CCDownload () <NSURLConnectionDataDelegate>

@property (nonatomic, strong) NSURLConnection *connection;
@property (nonatomic, strong) void(^completionBlock)(NSData *data, NSError *error);

@property (nonatomic, strong) NSMutableData *data;

@end

@implementation CCDownload

- (instancetype)initWithURL:(NSURL *)url completionBlock:(void(^)(NSData *, NSError *))completionBlock;
{
    self = [super init];
    if (self) {
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
        
        _connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:NO];
        _completionBlock = completionBlock;
        
        _data = [[NSMutableData alloc] init];
    }
    return self;
}

- (void)start;
{
    [[self connection] start];
}

#pragma mark - NSURLConnection Delegate Methods

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)passedInData;
{
    [[self data] appendData:passedInData];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error;
{
    NSLog(@"something went wrong %@", [error localizedDescription]);
    self.completionBlock(nil, error);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection;
{
    NSLog(@"data is finished %i", [[self data] length]);
    self.completionBlock([self data], nil);
}

@end
