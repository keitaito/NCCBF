//
//  Event.m
//  NCCBF
//
//  Created by Keita on 2/12/15.
//  Copyright (c) 2015 Keita Ito. All rights reserved.
//

#import "Event.h"

@interface Event ()

@property (strong, nonatomic) NSArray *events;

@end

@implementation Event

- (instancetype)initWithEventDictionary:(NSDictionary *)dictionary {
    self = [super init];
    
    self.name = dictionary[@"name"];
    self.date = dictionary[@"date"];
    self.location = dictionary[@"location"];
    self.imageString = dictionary[@"imageString"];
    self.eventDescription = dictionary[@"eventDescription"];
    
    return self;
}




//- (instancetype)initWithEventTitle:(NSString *)title {
//    self = [super init];
//    
//    if (self) {
//        // Create path for plist.
//        NSString *path = [[NSBundle mainBundle] pathForResource:@"Event" ofType:@"plist"];
//        // Create dictionary to store plist's root dictionary.
//        NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
//        // Store Events Array into events property
//        self.events = dict[@"Events"];
//        
//        self.name = title;
//        self.eventDescription = @"eventDescription";
//        
//    }
//    
//    NSLog(@"an instance of Event class initialized");
//    
//    return self;
//}

@end
