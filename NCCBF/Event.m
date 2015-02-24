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

static NSDictionary *locations;

@implementation Event


// Set up static locations variable.
+ (void)initialize
{
    locations = @{@0: @"Post St",
                  @1: @"Laguna St",
                  @2: @"Webster St"};
}


- (instancetype)initWithEventDictionary:(NSDictionary *)dictionary {
    self = [super init];
    
    self.name = dictionary[@"name"];
    self.date = dictionary[@"date"];
    self.locationId = [dictionary[@"location_id"] intValue];
    self.location = [self locationConvertedFromLocationId:self.locationId];
    self.imageString = dictionary[@"imageString"];
    self.eventDescription = dictionary[@"eventDescription"];
    
    return self;
}

- (NSString *)locationConvertedFromLocationId:(int)i
{
    NSNumber *num = [[NSNumber alloc] initWithInt:i];
    
    return locations[num];
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
