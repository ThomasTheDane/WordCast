//
//  Word.h
//  WordCast
//
//  Created by Thomas Nattestad on 3/8/14.
//  Copyright (c) 2014 Thomas Nattestad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Word : NSObject{
    NSString *wordName;
    NSMutableArray *wordMessages;
}

@property (strong, nonatomic) NSString *wordName;
@property (strong, nonatomic) NSMutableArray *wordMessages;

@end
