//
//  EventDetailViewBaseCell.m
//  NCCBF
//
//  Created by Keita on 3/22/15.
//  Copyright (c) 2015 Keita Ito. All rights reserved.
//

#import "EventDetailViewBaseCell.h"
#import "Event.h"

@implementation EventDetailViewBaseCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setupWithModel:(Event *)event {
    NSLog(@"Called setupWithModel method");
}

@end

// Subclasses of EventDetailViewBaseCell

@implementation EventImageCell

- (void)setupWithModel:(Event *)event
{
    NSString *string = event.imageString;
    self.detailPosterView.image = [UIImage imageNamed:string];
    NSLog(@"%@", event.imageString);
}

@end

@implementation EventNameCell

- (void)setupWithModel:(Event *)event
{
    self.titleLabel.text = event.name;
    NSLog(@"%@", event.name);
}

@end

@implementation EventDescriptionCell

- (void)setupWithModel:(Event *)event
{
    self.eventDescriptionLabel.text = event.eventDescription;
    NSLog(@"%@", event.eventDescription);
}

@end

@implementation EventLocationCell

- (void)setupWithModel:(Event *)event
{
    self.eventLocationLabel.text = event.location;
    NSLog(@"%@", event.location);
}

@end

@implementation EventScheduleCell

- (void)setupWithModel:(Event *)event
{
    // Store event schedule data from event model.
    NSDate *eventDateAndStartTime = event.date;
    NSDate *eventEndTime = event.endTime;
    
    // Set locale with formatter to prevent bug with 24-Hour time and language/region settings.
    NSLocale *enUSPOSIXLocale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
    
    // Create string of event's date.
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:enUSPOSIXLocale];
    [dateFormatter setDateFormat:@"MMM dd"];
    NSString *eventDateString = [dateFormatter stringFromDate:eventDateAndStartTime];
    
    // Create string of event's start time.
    NSDateFormatter *startTimeFormatter = [[NSDateFormatter alloc] init];
    [startTimeFormatter setLocale:enUSPOSIXLocale];
    [startTimeFormatter setDateFormat:@"h:mm a"];
    NSString *eventStartTimeString = [startTimeFormatter stringFromDate:eventDateAndStartTime];

    // Create string of event's end time.
    NSDateFormatter *endTimeFormatter = [[NSDateFormatter alloc] init];
    [endTimeFormatter setLocale:enUSPOSIXLocale];
    [endTimeFormatter setDateFormat:@"h:mm a"];
    NSString *eventEndTimeString = [endTimeFormatter stringFromDate:eventEndTime];
    
    // Create event schedule string.
    NSString *eventScheduleString = [NSString stringWithFormat:@"%@, %@ - %@", eventDateString, eventStartTimeString, eventEndTimeString];
    
    // Pass schedule string in eventScheduleLabel.
    self.eventScheduleLabel.text = eventScheduleString;
    
    NSLog(@"%@", eventScheduleString);
}

@end

