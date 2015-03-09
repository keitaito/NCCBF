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
//static NSDictionary *locationCoordinates;

@implementation Event


// Set up static locations variable.
+ (void)initialize
{
    locations = @{@0: @"Peace Plaza Stage",
                  @1: @"JCCNC Stage",
                  @2: @"Webster Street Stage",
                  @3: @"Sakura 360 Stage",
                  
                  @4: @"Japan Center East Mall - Suite 525",
                  @5: @"JCCNC Exhibit Spaces",
                  @6: @"Tateuchi Audtorium",
                  @7: @"National JACL",
                  @8: @"Union Bank Community Room",
                  @9: @"Sequola's Auditorium",
                  @10: @"National Japanese American Historical Society",
                  @11: @"Hokka Nichibei-kai"};
    
//    CLLocationCoordinate2D theCoordinate;
//    theCoordinate.latitude = 37.785257;
//    theCoordinate.longitude = -122.429648;
    
    
//    locationCoordinates = @{@0:
//                            
//                            };
}


- (instancetype)initWithEventDictionary:(NSDictionary *)dictionary {
    self = [super init];
    
    self.name = dictionary[@"name"];
    
    // Prepare dateFormatter.
    NSDateFormatter *parseFormatter = [[NSDateFormatter alloc] init];
    //    NSTimeZone *tz = [NSTimeZone timeZoneWithName:@"America/Los_Angeles"];
    [parseFormatter setDateFormat:@"yyyy-MM-dd HH:mm a"];
    
    NSString *dateString = dictionary[@"start_at"];
    self.date = [parseFormatter dateFromString:dateString];
//    self.date = dictionary[@"start_at"];
    
    NSString *endTimeString = dictionary[@"end_at"];
    self.endTime = [parseFormatter dateFromString:endTimeString];
//    self.endTime = dictionary[@"end_at"];
    
    self.locationId = [dictionary[@"location_id"] intValue];
    self.location = [self locationConvertedFromLocationId:self.locationId];
    self.imageString = dictionary[@"image_name"];
    self.eventDescription = dictionary[@"description"];
    
    return self;
}

- (NSString *)locationConvertedFromLocationId:(NSInteger)i
{
    NSNumber *num = [[NSNumber alloc] initWithInteger:i];
    
    return locations[num];
}


- (NSString *)description
{
    //    return [NSString stringWithFormat:@"<Employee %d>", self.employeeID];
    return [NSString stringWithFormat:@"<Event - name:%@, date:$%@, location:%@>", self.name, self.date, self.location];
}



@end
