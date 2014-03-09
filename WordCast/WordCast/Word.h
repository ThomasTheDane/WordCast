//
//  Word.h
//  WordCast
//
//  Created by Thomas Nattestad on 3/8/14.
//  Copyright (c) 2014 Thomas Nattestad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Firebase/Firebase.h>

@interface Word : NSObject{
    NSString *wordName;
    NSString *firebaseId;
    NSMutableArray *wordMessages;
    Firebase *wordListener;
}

@property (strong, nonatomic) NSString *wordName;
@property (strong, nonatomic) NSString *firebaseId;
@property (strong, nonatomic) NSMutableArray *wordMessages;
@property (strong, nonatomic) Firebase *wordListener;

@end
