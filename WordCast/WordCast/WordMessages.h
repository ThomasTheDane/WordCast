//
//  WordMessages.h
//  WordCast
//
//  Created by Thomas Nattestad on 2/27/14.
//  Copyright (c) 2014 Thomas Nattestad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Word.h"

@interface WordMessages : UIViewController{
    IBOutlet UINavigationItem *titleBar;
    IBOutlet UIScrollView *contentScroll;
    int messageHeightSoFar;
    NSMutableArray *textboxes;
}

-(void)setWordObject:(id)theWord;

@property (strong, nonatomic) Word *word;

@end
