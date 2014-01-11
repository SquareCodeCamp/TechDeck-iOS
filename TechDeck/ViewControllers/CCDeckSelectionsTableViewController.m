//
//  CCDeckSelectionsTableViewController.m
//  TechDeck
//
//  Created by square on 1/10/14.
//  Copyright (c) 2014 CodeCamp2014. All rights reserved.
//

#import "CCDeckSelectionsTableViewController.h"
#import "CCMatchViewController.h"
#import "CCServerManager.h"
#import "CCDeck.h"

@interface CCDeckSelectionsTableViewController ()

@property (nonatomic, strong) NSArray *decks;

@end

@implementation CCDeckSelectionsTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[self tableView] registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];

    [[CCServerManager sharedManager] downloadDecks:^(NSArray *decks, NSError *error) {
        if (!error) {
            // Decks are downloaded
            [self setDecks:decks];
            
            [[self tableView] reloadData];
        }
    }];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self decks] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    CCDeck *deck = [[self decks] objectAtIndex:indexPath.row];
    
    [[cell textLabel] setText:[deck deckName]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    CCDeck *deck = [[self decks] objectAtIndex:indexPath.row];
    
    CCMatchViewController *matchViewController = [[CCMatchViewController alloc] initWithDeck:deck];
    
    [[self navigationController] pushViewController:matchViewController animated:YES];
}

@end
