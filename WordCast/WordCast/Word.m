//
//  Word.m
//  WordCast
//
//  Created by Thomas Nattestad on 3/8/14.
//  Copyright (c) 2014 Thomas Nattestad. All rights reserved.
//

#import "Word.h"

@implementation Word

-(id)init{
    self = [super init];
    return self;
}

-(id)initWithName:(NSString *)name{
    self = [super init];
    if(self){
        self.wordName = name;
    }
    return self;
}

@end
