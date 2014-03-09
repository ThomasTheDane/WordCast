//
//  SubscriptionTableViewController.h
//  WordCast
//
//  Created by Thomas Nattestad on 2/27/14.
//  Copyright (c) 2014 Thomas Nattestad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SubscriptionTableViewController : UITableViewController{
    NSString *uniqueId;
    NSMutableArray *subscriptions;
    NSMutableArray *firebaseListeners;
}

@property (strong, nonatomic) NSString *uniqueId;
@property (strong, nonatomic) NSMutableArray *subscriptions;
@property (strong, nonatomic) NSMutableArray *firebaseListeners;

@end
