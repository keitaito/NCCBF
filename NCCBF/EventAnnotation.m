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

//@property (nonatomic, strong) Event *event;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;


@end

static NSDictionary *locationCoordinates;

@implementation EventAnnotation

+ (void)initialize
{
//    CLLocationCoordinate2D theCoordinate;
//    theCoordinate.latitude = 37.785257;
//    theCoordinate.longitude = -122.429648;
    
    //    NSValue *japanTownCooordinate = [NSValue value: &theCoordinate
    //                         withObjCType:@encode(CLLocationCoordinate2D)];
    
//    __unused NSValue *jTownCoordValue = [NSValue valueWithMKCoordinate:theCoordinate];
    
    ///////////////////////////
    
    // Create Japantown location coordinates.
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"LocationCoordinates" ofType:@"plist"];
    NSDictionary *coordinates = [NSDictionary dictionaryWithContentsOfFile:filePath];
    
    // Coordinates vars.
    CLLocationCoordinate2D peacePlazaStageCoord;
    CLLocationCoordinate2D JCCNCStageCoord;
    CLLocationCoordinate2D sakura360StageCoord;
    
    // Create coordinates from CGPoint from string in plist.
    CGPoint peacePlazaStageCGPoint = CGPointFromString(coordinates[@"Peace Plaza Stage"]);
    peacePlazaStageCoord = CLLocationCoordinate2DMake(peacePlazaStageCGPoint.x, peacePlazaStageCGPoint.y);
    
    CGPoint JCCNCStageCGPoint = CGPointFromString(coordinates[@"JCCNC Stage"]);
    JCCNCStageCoord = CLLocationCoordinate2DMake(JCCNCStageCGPoint.x, JCCNCStageCGPoint.y);
    
    CGPoint sakura360StageCGPoint = CGPointFromString(coordinates[@"Sakura 360 Stage"]);
    sakura360StageCoord = CLLocationCoordinate2DMake(sakura360StageCGPoint.x, sakura360StageCGPoint.y);
    
    // Convert coordinates to NSValue to store in dictionary.
    NSValue *peacePlazaStageCoordValue = [NSValue valueWithMKCoordinate:peacePlazaStageCoord];
    NSValue *JCCNCStageCoordValue = [NSValue valueWithMKCoordinate:JCCNCStageCoord];
    NSValue *sakura360StageCoordValue = [NSValue valueWithMKCoordinate:sakura360StageCoord];
    
    ///////////////////////////
    
    locationCoordinates = @{@0: peacePlazaStageCoordValue,
                            @1: JCCNCStageCoordValue,
                            @2: sakura360StageCoordValue};
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.event = [[Event alloc] init];
//        self.event.name = @"Japantown Peace Plaza";
//        self.event.location = @"Peace Pagoda";
//        self.event.locationId = 0;
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
//        CLLocationCoordinate2D theCoordinate;
//        theCoordinate.latitude = 37.785257;
//        theCoordinate.longitude = -122.429648;
//        return theCoordinate;
    NSInteger locationId = self.event.locationId;
    NSNumber *n = [NSNumber numberWithInteger:locationId];
    CLLocationCoordinate2D c = [locationCoordinates[n] MKCoordinateValue];
    return c;
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
