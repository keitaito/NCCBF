//
//  EventAnnotation.h
//  NCCBF
//
//  Created by Keita on 3/12/15.
//  Copyright (c) 2015 Keita Ito. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@class Event;

@interface EventAnnotation : NSObject <MKAnnotation>

+ (MKAnnotationView *)createViewAnnotationForMapView:(MKMapView *)mapView annotation:(id <MKAnnotation>)annotation;
- (instancetype)initWithEvent:(Event *)event;

@end
