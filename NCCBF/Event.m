//
//  Event.m
//  NCCBF
//
//  Created by Keita on 2/12/15.
//  Copyright (c) 2015 Keita Ito. All rights reserved.
//

#import "Event.h"

@implementation Event

- (instancetype)initWithEventTitle:(NSString *)title {
    self = [super init];
    
    if (self) {
        self.title = title;
//        self.eventDescription = dictionary[@"eventDescription"];

    }
    
    NSLog(@"an instance of Event initialized");
    
    return self;
}

@end
