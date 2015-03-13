//
//  EventAnnotation.m
//  NCCBF
//
//  Created by Keita on 3/12/15.
//  Copyright (c) 2015 Keita Ito. All rights reserved.
//

#import "EventAnnotation.h"
#import "Event.h"

@interface EventAnnotation ()

@property (nonatomic, strong) Event *event;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;


@end

//static NSDictionary *locationCoordinates;

@implementation EventAnnotation

//+ (void)initialize
//{
//    CLLocationCoordinate2D theCoordinate;
//    theCoordinate.latitude = 37.785257;
//    theCoordinate.longitude = -122.429648;
//    
//    //    NSValue *japanTownCooordinate = [NSValue value: &theCoordinate
//    //                         withObjCType:@encode(CLLocationCoordinate2D)];
//    
//    NSValue *jTownCoorValue = [NSValue valueWithMKCoordinate:theCoordinate];
//    
//    locationCoordinates = @{@0: jTownCoorValue,
//                            @1: @"Laguna St",
//                            @2: @"Webster St"};
//}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.event = [[Event alloc] init];
        self.event.name = @"Japantown Peace Plaza";
        self.event.location = @"Peace Pagoda";
        self.event.locationId = 0;
        NSLog(@"EventAnnotation object initialized");
    }
    return self;
}

- (instancetype)initWithEvent:(Event *)event {
    self = [super init];
    if (self) {
        self.event = event;
        NSLog(@"Annotation initialized: %@", self.event);
    }
    
    return self;
}

- (CLLocationCoordinate2D)coordinate
{
        CLLocationCoordinate2D theCoordinate;
        theCoordinate.latitude = 37.785257;
        theCoordinate.longitude = -122.429648;
        return theCoordinate;
//    CLLocationCoordinate2D c = [locationCoordinates[@0] MKCoordinateValue];
//    return c;
}

// required if you set the MKPinAnnotationView's "canShowCallout" property to YES
- (NSString *)title
{
    return self.event.name;
}

// optional
- (NSString *)subtitle
{
    return self.event.location;
}


+ (MKAnnotationView *)createViewAnnotationForMapView:(MKMapView *)mapView annotation:(id <MKAnnotation>)annotation
{
    // try to dequeue an existing pin view first
    MKAnnotationView *returnedAnnotationView =
    [mapView dequeueReusableAnnotationViewWithIdentifier:NSStringFromClass([EventAnnotation class])];
    if (returnedAnnotationView == nil)
    {
        returnedAnnotationView =
        [[MKPinAnnotationView alloc] initWithAnnotation:annotation
                                        reuseIdentifier:NSStringFromClass([EventAnnotation class])];
        
        ((MKPinAnnotationView *)returnedAnnotationView).pinColor = MKPinAnnotationColorRed;
        ((MKPinAnnotationView *)returnedAnnotationView).animatesDrop = YES;
        ((MKPinAnnotationView *)returnedAnnotationView).canShowCallout = YES;
    }
    
    return returnedAnnotationView;
}


@end
