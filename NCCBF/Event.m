//
//  Event.m
//  NCCBF
//
//  Created by Keita on 2/12/15.
//  Copyright (c) 2015 Keita Ito. All rights reserved.
//

#import "Event.h"

@interface Event ()

//@property (strong, nonatomic) NSArray *events;

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
    self.date = dictionary[@"start_at"];
    self.locationId = [dictionary[@"location_id"] intValue];
    self.location = [self locationConvertedFromLocationId:self.locationId];
    self.imageString = dictionary[@"image_name"];
    self.eventDescription = dictionary[@"description"];
    
    return self;
}

- (NSString *)locationConvertedFromLocationId:(int)i
{
    NSNumber *num = [[NSNumber alloc] initWithInt:i];
    
    return locations[num];
}


- (NSString *)description
{
    //    return [NSString stringWithFormat:@"<Employee %d>", self.employeeID];
    return [NSString stringWithFormat:@"<Event - name:%@, date:$%@, location:%@, image_name:%@, description:%@>", self.name, self.date, self.location, self.imageString, self.eventDescription];
}



@end
