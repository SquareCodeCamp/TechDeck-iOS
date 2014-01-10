//
//  CCTestViewController.m
//  TechDeck
//
//  Created by square on 1/10/14.
//  Copyright (c) 2014 CodeCamp2014. All rights reserved.
//

#import "CCTestViewController.h"
#import "CCServerManager.h"

@interface CCTestViewController ()

@property (nonatomic, strong) IBOutlet UIButton *testConnectionButton;

@end

@implementation CCTestViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didTapDownloadDecksButton:(UIButton *)sender {
    CCServerManager *serverManager = [[CCServerManager alloc] init];
    [serverManager downloadDecks:^(NSArray *decks, NSError *error) {
        NSLog(@"decks downloaded %@", decks);
    }];
}

@end
