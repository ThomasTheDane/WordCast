//
//  FirstViewController.m
//  WordCast
//
//  Created by Thomas Nattestad on 2/24/14.
//  Copyright (c) 2014 Thomas Nattestad. All rights reserved.
//

#import "FirstViewController.h"
#import <Firebase/Firebase.h>

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad
{
    NSLog(@"first view loaded");
    [super viewDidLoad];
    [self.messageText.layer setBorderColor:[[UIColor grayColor] CGColor]];
    [self.messageText.layer setBorderWidth:1.0];
    [self.messageText.layer setMasksToBounds:YES];
    [self registerForKeyboardNotifications];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    CGPoint pt = [[touches anyObject] locationInView:self.view];
    if(CGRectContainsPoint([self.sendButton frame], pt)){
        NSLog(@"hit send");
        NSLog(@"To: %@", [self.toText text]);
        if(![[self.toText text] isEqualToString:@""] && ![[self.messageText text] isEqualToString:@""]){
            NSString *toUrl = [@"https://wordcast.firebaseio.com/" stringByAppendingString:[self.toText text]];
            fSender = [[Firebase alloc] initWithUrl:toUrl];
            Firebase *fPusher = [fSender childByAutoId];
            [fPusher setValue:[self.messageText text]];
            [self.messageText setText:@""];
            [self displaySentMessage];
        }
    }
    [self.view endEditing:YES];
}

-(void)displaySentMessage{
    UIImageView *sentMessageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 150, 150)];
    [sentMessageView setCenter:CGPointMake(320 / 2, 480 /2)];
    [sentMessageView setImage:[UIImage imageNamed:@"sentMessage.png"]];
    [self.view addSubview:sentMessageView];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationDelay:1.0];
    
    [sentMessageView setAlpha:0.0];
    
    [UIView commitAnimations];
}

- (void) animateTextView:(BOOL) up
{
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: .3f];

    if(up){
        self.messageText.frame = CGRectMake(20, 150, 220, 100);
        self.sendButton.frame = CGRectMake(248, 178, 50, 50);
    }else{
        self.messageText.frame = CGRectMake(20, 150, 280, 216);
        self.sendButton.frame = CGRectMake(70, 374, 180, 50);
    }
    [UIView commitAnimations];
}

// Call this method somewhere in your view controller setup code.
- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    [self animateTextView: YES];
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    [self animateTextView:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
