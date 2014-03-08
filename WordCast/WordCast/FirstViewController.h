//
//  FirstViewController.h
//  WordCast
//
//  Created by Thomas Nattestad on 2/24/14.
//  Copyright (c) 2014 Thomas Nattestad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Firebase/Firebase.h>

@interface FirstViewController : UIViewController{

    IBOutlet UITextField *toText;
    IBOutlet UITextView *messageText;
    IBOutlet UIImageView *sendButton;
    Firebase *fSender;
}

-(IBAction)sendMessage:(id)sender;

@property(strong, nonatomic) IBOutlet UITextField *toText;
@property(strong, nonatomic) IBOutlet UITextView *messageText;
@property(strong, nonatomic) IBOutlet UIImageView *sendButton;

@end


