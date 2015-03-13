//
//  MapViewController.m
//  NCCBF
//
//  Created by Keita on 2/14/15.
//  Copyright (c) 2015 Keita Ito. All rights reserved.
//

#import "MapViewController.h"
#import <MapKit/MapKit.h>

@interface MapViewController () <MKMapViewDelegate, CLLocationManagerDelegate>

@property (retain, nonatomic) IBOutlet MKMapView *mapView;
@property (retain, nonatomic) CLLocationManager *locationManager;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Set mapView delegate.
    self.mapView.delegate = self;
    // Instantiate CLLocationManager and set delegate.
    self.locationManager = [[CLLocationManager alloc] init];
//    self.locationManager.purpose = @"Tracking your movements on the map.";
    self.locationManager.delegate = self;
    
    [self prepareLocationManager];
    [self goToDefaultLocation];

    // Show user location.
    self.mapView.showsUserLocation = YES;
    
    // Set up map view.
    [self.mapView setMapType:MKMapTypeStandard];
    [self.mapView setZoomEnabled:YES];
    [self.mapView setScrollEnabled:YES];
    
    
//    #ifdef __IPHONE_8_0
//        if(IS_OS_8_OR_LATER) {
//            // Use one or the other, not both. Depending on what you put in info.plist
//            [self.locationManager requestWhenInUseAuthorization];
//            [self.locationManager requestAlwaysAuthorization];
//        }
//    #endif
    
//    [self.locationManager startUpdatingLocation];
    

    
//    // Check for iOS 8. Without this guard the code will crash with "unknown selector" on iOS 7.
//    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
//        [self.locationManager requestWhenInUseAuthorization];
//    }
//    [self.locationManager startUpdatingLocation];

}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    
//    self.locationManager.distanceFilter = kCLDistanceFilterNone;
//    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
//    [self.locationManager startUpdatingLocation];
    
//    NSLog(@"%@", [self deviceLocation]);
    
//    //View Area (display current location)
//    MKCoordinateRegion region = { { 0.0, 0.0 }, { 0.0, 0.0 } };
//    region.center.latitude = self.locationManager.location.coordinate.latitude;
//    region.center.longitude = self.locationManager.location.coordinate.longitude;
//    region.span.longitudeDelta = 0.005f;
//    region.span.longitudeDelta = 0.005f;
//    [self.mapView setRegion:region animated:YES];
}






#pragma mark - Setup Methods

- (void)goToDefaultLocation {
    
    // Create Japantown location coordinates.
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Japantown" ofType:@"plist"];
    NSDictionary *properties = [NSDictionary dictionaryWithContentsOfFile:filePath];
    
    CLLocationCoordinate2D midCoordinate;
    CLLocationCoordinate2D topLeftCoordinate;
    CLLocationCoordinate2D topRightCoordinate;
    CLLocationCoordinate2D bottomLeftCoordinate;
    CLLocationCoordinate2D bottomRightCoordinate;
    
    // Create 4 coordinates of Japantown.
    CGPoint midPoint = CGPointFromString(properties[@"midCoord"]);
    midCoordinate = CLLocationCoordinate2DMake(midPoint.x, midPoint.y);
    
    CGPoint topLeftPoint = CGPointFromString(properties[@"topLeftCoord"]);
    topLeftCoordinate = CLLocationCoordinate2DMake(topLeftPoint.x, topLeftPoint.y);
    
    CGPoint topRightPoint = CGPointFromString(properties[@"topRightCoord"]);
    topRightCoordinate = CLLocationCoordinate2DMake(topRightPoint.x, topRightPoint.y);
    
    CGPoint bottomLeftPoint = CGPointFromString(properties[@"bottomLeftCoord"]);
    bottomLeftCoordinate = CLLocationCoordinate2DMake(bottomLeftPoint.x, bottomLeftPoint.y);
    
    bottomRightCoordinate = CLLocationCoordinate2DMake(bottomLeftCoordinate.latitude, topRightCoordinate.longitude);
    
    
    // Create latitudeDelta.
    CLLocationDegrees latDelta = topLeftCoordinate.latitude - bottomRightCoordinate.latitude;
    NSLog(@"%f", latDelta);
    
    // think of a span as a tv size, measure from one corner to another
    MKCoordinateSpan span = MKCoordinateSpanMake(fabsf(latDelta), 0.0);
    NSLog(@"%f %f", span.latitudeDelta, span.longitudeDelta);
    
    // Create region with midCoordinate and span.
    MKCoordinateRegion region = MKCoordinateRegionMake(midCoordinate, span);
    
    // set map view region.
//    self.mapView.region = region;
    [self.mapView setRegion:region animated:YES];
}


- (void)prepareLocationManager {
    
    // Get the current authorization status.
    if (![CLLocationManager locationServicesEnabled]) {
        NSLog(@"location services are disabled");
        return;
    }
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied) {
        NSLog(@"location services are denied by the user");
        return;
    }
    if ([CLLocationManager authorizationStatus] == (kCLAuthorizationStatusAuthorizedAlways | kCLAuthorizationStatusAuthorizedWhenInUse)) {
        NSLog(@"location services are enabled");
    }
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
        NSLog(@"about to show a dialog requesting permission");
        [self.locationManager requestWhenInUseAuthorization];
    }
    
    // Set up location manager properties.
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    // If location services is enabled, start updateing location.
    if ([CLLocationManager locationServicesEnabled]) {
        [self.locationManager startUpdatingLocation];
    }

}

#pragma mark - MKMapView Delegate Methods

//- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
//{
//    __unused MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 800, 800);
//    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
//}

//- (NSString *)deviceLocation {
//    return [NSString stringWithFormat:@"latitude: %f longitude: %f", self.locationManager.location.coordinate.latitude, self.locationManager.location.coordinate.longitude];
//}
//- (NSString *)deviceLat {
//    return [NSString stringWithFormat:@"%f", self.locationManager.location.coordinate.latitude];
//}
//- (NSString *)deviceLon {
//    return [NSString stringWithFormat:@"%f", self.locationManager.location.coordinate.longitude];
//}
//- (NSString *)deviceAlt {
//    return [NSString stringWithFormat:@"%f", self.locationManager.location.altitude];
//}


#pragma mark - CLLocationManager Delegate Methods

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied){
        NSLog(@"User has denied location services");
    } else {
        NSLog(@"Location manager did fail with error: %@", error.localizedFailureReason);
    }
}


- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    NSLog(@"%@", [locations lastObject]);
}



#pragma mark - didReceiveMemoryWarning

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
