//
//  CCMatchViewController.m
//  TechDeck
//
//  Created by square on 1/10/14.
//  Copyright (c) 2014 CodeCamp2014. All rights reserved.
//

#import "CCMatchViewController.h"
#import "CCServerManager.h"
#import "CCImageStore.h"

#import "CCPersonImage.h"
#import "CCPersonInfo.h"
#import "CCMatch.h"
#import "CCDeck.h"

@interface CCMatchViewController ()
@property (weak, nonatomic) IBOutlet UIView *personInfoView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *bioLabel;
@property (weak, nonatomic) IBOutlet UIImageView *wikiImageView;

@property (weak, nonatomic) IBOutlet UIImageView *personImageView;

@property (nonatomic, strong) CCDeck *deck;

@property (nonatomic) NSUInteger personInfoIndex;
@property (nonatomic) CCPersonInfo *currentlyDisplayedPersonInfo;
@property (nonatomic) CCPersonImage *currentlyDisplayedPersonImage;

@end

@implementation CCMatchViewController

- (instancetype)initWithDeck:(CCDeck *)deck;
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _deck = deck;
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    return [self initWithDeck:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[[self personInfoView] layer] setCornerRadius:5.0];
    [[[self personImageView] layer] setCornerRadius:5.0];
    
    UISwipeGestureRecognizer *personInfoSwipeGR = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(personInfoSwipeGestureRecognizerFired:)];
    [personInfoSwipeGR setDirection:(UISwipeGestureRecognizerDirectionLeft | UISwipeGestureRecognizerDirectionRight)];
    [[self personInfoView] addGestureRecognizer:personInfoSwipeGR];
    
    UITapGestureRecognizer *personInfoTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(personInfoTapGestureRecognizerFired:)];
    [personInfoTapGestureRecognizer setNumberOfTapsRequired:2];
    [[self personInfoView] addGestureRecognizer:personInfoTapGestureRecognizer];
    
    UITapGestureRecognizer *wikiTapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(wikiImageViewTapped:)];
    [[self personInfoView] addGestureRecognizer:wikiTapGR];
    
    [self displayRandomImageAndInfo];
}


- (void)displayRandomImageAndInfo;
{
    NSArray *matches = [[self deck] matches];
    
    NSUInteger matchesCount = [matches count];
    
    NSUInteger matchIndexForImage = arc4random() % matchesCount;
    NSUInteger matchIndexForInfo = arc4random() % matchesCount;
    
    CCMatch *matchForImage = [matches objectAtIndex:matchIndexForImage];
    CCMatch *matchForInfo = [matches objectAtIndex:matchIndexForInfo];
    
    [self displayPersonImage:[[matchForImage personImages] lastObject]];
    [self displayPersonInfo:[matchForInfo personInfo]];
}

- (void)personInfoSwipeGestureRecognizerFired:(UISwipeGestureRecognizer *)swipeGR;
{
    self.personInfoIndex++;
    NSArray *matches = [[self deck] matches];
    CCMatch *match = [matches objectAtIndex:self.personInfoIndex % [matches count]];
    [self displayPersonInfo:[match personInfo]];
}

- (void)displayPersonImage:(CCPersonImage *)personImage;
{
    [self setCurrentlyDisplayedPersonImage:personImage];
    // Download image at personImage URL.
    [[CCImageStore sharedImageStore] fetchImageForURL:[personImage imageURL] completion:^(UIImage *image, NSError *error) {
        
        if (!error) {
            // If there is no error, set the image on the imageView.
            [[self personImageView] setImage:image];
        }
    }];
}

- (void)displayPersonInfo:(CCPersonInfo *)info;
{
    [self setCurrentlyDisplayedPersonInfo:info];
    [[self nameLabel] setText:[info name]];
    [[self bioLabel] setText:[info bio]];
}

- (void)personInfoTapGestureRecognizerFired:(UITapGestureRecognizer *)gr;
{
    if ([[self currentlyDisplayedPersonImage] match] == [[self currentlyDisplayedPersonInfo] match]) {
        [[[UIAlertView alloc] initWithTitle:@"Correct" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Yeah!!", nil] show];
        [self displayRandomImageAndInfo];
    } else {
        [[[UIAlertView alloc] initWithTitle:@"wrong!!!" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"damn.", nil] show];
    }
}

- (void)wikiImageViewTapped:(UITapGestureRecognizer *)gr;
{
    CGPoint touchLocation = [gr locationInView:[self personInfoView]];
    if (CGRectContainsPoint([[self wikiImageView] frame], touchLocation)) {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[[self currentlyDisplayedPersonInfo] wikiLink]]];
    }
}
@end
