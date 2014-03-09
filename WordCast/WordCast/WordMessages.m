//
//  WordMessages.m
//  WordCast
//
//  Created by Thomas Nattestad on 2/27/14.
//  Copyright (c) 2014 Thomas Nattestad. All rights reserved.
//

#import "WordMessages.h"
#import "Word.h"

@interface WordMessages ()

@end

@implementation WordMessages

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)setWordObject:(id)theWord{
    self.word = theWord;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"touched: %@", self.word.wordName);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [titleBar setTitle:self.word.wordName];
    NSLog(@"loading word name: %@", self.word.wordName);
    
    //setup firebase listener
    [self.word.wordListener observeEventType:FEventTypeChildAdded withBlock:^(FDataSnapshot *snapshot) {
        NSLog(@"loading message: %@", snapshot.value);
        UITextView *aMessage = [[UITextView alloc] init];
        [aMessage setText:snapshot.value];
        aMessage.frame = CGRectMake(10, 0, 310, 50);
        [contentScroll addSubview:aMessage];
        [aMessage setFont:[UIFont fontWithName:@"Helvetica" size:20]];

        CGSize size = [aMessage sizeThatFits:CGSizeMake(320, FLT_MAX)];

        NSLog(@"Height of thing: %f", size.height);
        NSLog(@"Height so far: %d", messageHeightSoFar);
        
        [aMessage.layer setBorderColor:[[UIColor grayColor] CGColor]];
        [aMessage.layer setBorderWidth:1.0];
        [aMessage.layer setMasksToBounds:YES];

        [aMessage setFrame:CGRectMake(10, messageHeightSoFar, 300, size.height + 10)];
        [aMessage setEditable:NO];
        
        messageHeightSoFar += size.height;
        [contentScroll setContentSize:CGSizeMake(320, messageHeightSoFar)];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
