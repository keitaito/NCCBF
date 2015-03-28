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
    CLLocationCoordinate2D JCCCNCStageCoord;
    CLLocationCoordinate2D WebsterCoord;
    CLLocationCoordinate2D sakura360StageCoord;
    CLLocationCoordinate2D JapanCenterCoord;
    CLLocationCoordinate2D JCCCNCExhibitCoord;
    CLLocationCoordinate2D TateuchiCoord;
    CLLocationCoordinate2D JACLCoord;
    CLLocationCoordinate2D UnionBankCoord;
    CLLocationCoordinate2D SequoiaCoord;
    CLLocationCoordinate2D NJAHSCoord;
    CLLocationCoordinate2D HokkaCoord;
    
    // Create coordinates from CGPoint from string in plist.
    CGPoint peacePlazaStageCGPoint = CGPointFromString(coordinates[@"Peace Plaza Stage"]);
    peacePlazaStageCoord = CLLocationCoordinate2DMake(peacePlazaStageCGPoint.x, peacePlazaStageCGPoint.y);
    
    CGPoint JCCCNCStageCGPoint = CGPointFromString(coordinates[@"JCCCNC Stage"]);
    JCCCNCStageCoord = CLLocationCoordinate2DMake(JCCCNCStageCGPoint.x, JCCCNCStageCGPoint.y);
    
    CGPoint WebsterCGPoint = CGPointFromString(coordinates[@"Webster Street Stage"]);
    WebsterCoord = CLLocationCoordinate2DMake(WebsterCGPoint.x, WebsterCGPoint.y);
    
    CGPoint sakura360StageCGPoint = CGPointFromString(coordinates[@"Sakura 360 Stage"]);
    sakura360StageCoord = CLLocationCoordinate2DMake(sakura360StageCGPoint.x, sakura360StageCGPoint.y);
    
    CGPoint JapanCenterCGPoint = CGPointFromString(coordinates[@"Japan Center East Mall - Suite 525"]);
    JapanCenterCoord = CLLocationCoordinate2DMake(JapanCenterCGPoint.x, JapanCenterCGPoint.y);

    CGPoint JCCCNCExhibitCGPoint = CGPointFromString(coordinates[@"JCCCNC Exhibit Spaces"]);
    JCCCNCExhibitCoord = CLLocationCoordinate2DMake(JCCCNCExhibitCGPoint.x, JCCCNCExhibitCGPoint.y);
    
    CGPoint TateuchiCGPoint = CGPointFromString(coordinates[@"Tateuchi Auditorium Tea Ceremony"]);
    TateuchiCoord = CLLocationCoordinate2DMake(TateuchiCGPoint.x, TateuchiCGPoint.y);

    CGPoint JACLCGPoint = CGPointFromString(coordinates[@"National JACL"]);
    JACLCoord = CLLocationCoordinate2DMake(JACLCGPoint.x, JACLCGPoint.y);
    
    CGPoint UnionBankCGPoint = CGPointFromString(coordinates[@"Union Bank Community Room"]);
    UnionBankCoord = CLLocationCoordinate2DMake(UnionBankCGPoint.x, UnionBankCGPoint.y);

    CGPoint SequoiaCGPoint = CGPointFromString(coordinates[@"Sequola's Auditorium"]);
    SequoiaCoord = CLLocationCoordinate2DMake(SequoiaCGPoint.x, SequoiaCGPoint.y);
    
    CGPoint NJAHSCGPoint = CGPointFromString(coordinates[@"National Japanese American Historical Society"]);
    NJAHSCoord = CLLocationCoordinate2DMake(NJAHSCGPoint.x, NJAHSCGPoint.y);
    
    CGPoint HokkaCGPoint = CGPointFromString(coordinates[@"Hokka Nichibei-kai Tea Ceremony"]);
    HokkaCoord = CLLocationCoordinate2DMake(HokkaCGPoint.x, HokkaCGPoint.y);
    
    // Convert coordinates to NSValue to store in dictionary.
    NSValue *peacePlazaStageCV = [NSValue valueWithMKCoordinate:peacePlazaStageCoord];
    NSValue *JCCCNCStageCV = [NSValue valueWithMKCoordinate:JCCCNCStageCoord];
    NSValue *websterCV = [NSValue valueWithMKCoordinate:WebsterCoord];
    NSValue *sakura360CV = [NSValue valueWithMKCoordinate:sakura360StageCoord];
    NSValue *japanCenterCV = [NSValue valueWithMKCoordinate:JapanCenterCoord];
    NSValue *JCCCNCExhibitCV = [NSValue valueWithMKCoordinate:JCCCNCExhibitCoord];
    NSValue *tateuchiCV = [NSValue valueWithMKCoordinate:TateuchiCoord];
    NSValue *JACLCV = [NSValue valueWithMKCoordinate:JACLCoord];
    NSValue *UnionBankCV = [NSValue valueWithMKCoordinate:UnionBankCoord];
    NSValue *sequoiaCV = [NSValue valueWithMKCoordinate:SequoiaCoord];
    NSValue *NJAHSCV = [NSValue valueWithMKCoordinate:NJAHSCoord];
    NSValue *hokkaCV = [NSValue valueWithMKCoordinate:HokkaCoord];
    
    
    
    
    ///////////////////////////
    
    locationCoordinates = @{@0: peacePlazaStageCV,
                            @1: JCCCNCStageCV,
                            @2: websterCV,
                            @3: sakura360CV,
                            @4: japanCenterCV,
                            @5: JCCCNCExhibitCV,
                            @6: tateuchiCV,
                            @7: JACLCV,
                            @8: UnionBankCV,
                            @9: sequoiaCV,
                            @10: NJAHSCV,
                            @11: hokkaCV
                            };
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

- (instancetype)initWithEvents:(NSArray *)events {
    self = [super init];
    if (self) {
        self.events = events;
        NSLog(@"Annotation initialized: %@", self.events);
    }
    
    return self;
}

- (CLLocationCoordinate2D)coordinate
{
//        CLLocationCoordinate2D theCoordinate;
//        theCoordinate.latitude = 37.785257;
//        theCoordinate.longitude = -122.429648;
//        return theCoordinate;
    
//    NSInteger locationId = self.event.locationId;
    Event *event = [self.events firstObject];
    NSInteger locationId = event.locationId;
    NSNumber *n = [NSNumber numberWithInteger:locationId];
    CLLocationCoordinate2D c = [locationCoordinates[n] MKCoordinateValue];
    return c;
}

// required if you set the MKPinAnnotationView's "canShowCallout" property to YES
- (NSString *)title
{
    Event *event = [self.events firstObject];
    NSString *locationName = event.location;
    return locationName;
}

//// optional
//- (NSString *)subtitle
//{
//    return self.event.location;
//}


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
