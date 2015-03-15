//
//  MapViewController.m
//  NCCBF
//
//  Created by Keita on 2/14/15.
//  Copyright (c) 2015 Keita Ito. All rights reserved.
//

#import "MapViewController.h"
#import <MapKit/MapKit.h>
#import "EventAnnotation.h"
#import "Event.h"
#import "EventDetailViewController.h"

@interface MapViewController () <MKMapViewDelegate, CLLocationManagerDelegate>

@property (retain, nonatomic) IBOutlet MKMapView *mapView;
@property (retain, nonatomic) CLLocationManager *locationManager;

@property (nonatomic, strong) NSArray *eventsArray;
@property (nonatomic, strong) NSMutableArray *mapAnnotations;
@property (nonatomic, strong) UIPopoverController *eventPopoverController;

@property (nonatomic, strong) NSArray *eventsSortedByLocation;


@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Create Events.
    [self createEventsArray];
    
    
    
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
    
    
    
    // Create annotations in map view.
    [self createAnnotations];
    
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

- (void)createEventsArray {
    // Load events data.
    NSDictionary *dataDict = [self loadDataFromDocDir];
    NSArray *arrayFromDataDict = dataDict[@"Events"];
    // Create event models array.
    NSMutableArray *tmpArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < arrayFromDataDict.count; i++) {
        Event *eventModel = [[Event alloc] initWithEventDictionary:arrayFromDataDict[i]];
        [tmpArray addObject:eventModel];
    }
    self.eventsArray = [NSArray arrayWithArray:tmpArray];
    
    
    //////////// create arrays of events grouped by stage
    
    NSMutableArray *eventsAtLocation0 = [[NSMutableArray alloc] init];
    NSMutableArray *eventsAtLocation1 = [[NSMutableArray alloc] init];
    NSMutableArray *eventsAtLocation2 = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < tmpArray.count; i++) {
        Event *event = tmpArray[i];
        NSInteger locationId = event.locationId;
        
        switch (locationId) {
            case 0:
                [eventsAtLocation0 addObject:event];
                break;
            case 1:
                [eventsAtLocation1 addObject:event];
                break;
            case 2:
                [eventsAtLocation2 addObject:event];
                break;
                
            default:
                break;
        }
    }

    self.eventsSortedByLocation = @[eventsAtLocation0, eventsAtLocation1, eventsAtLocation2];
    
    
    ///////////
}

- (NSDictionary *)loadDataFromDocDir {
    
    // create path to Events.plist in documents directory.
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths firstObject];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"Events.plist"];
    NSLog(@"path to plist file in documents directory --> \n%@", path);
    
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    // check if file exists.
//    if (![fileManager fileExistsAtPath:path]) {
//        // If it doesn't, copy it from the default file in main bundle.
//        NSLog(@"path does not exist. plist file will be copied to the path from main bundle.");
//        // create path to Events.plist in main bundle.
//        NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"Events" ofType:@"plist"];
//        if (bundlePath) {
//            NSLog(@"file exists in the main bundle.");
//            NSDictionary *resultDictionary = [NSDictionary dictionaryWithContentsOfFile:bundlePath];
//            NSLog(@"Bundle Events.plist file is --> \n%@", [resultDictionary description]);
//            
//            // copy dictionary from main bundle to document directory path.
//            [fileManager copyItemAtPath:bundlePath toPath:path error:nil];
//            NSLog(@"plist file is copied from main bundle to document directory");
//        } else {
//            NSLog(@"Events.plist not found in main bundle. Please, make sure it is part of the bundle.");
//        }
//        // use this to delete file from documents directory
//        // [fileManager removeItemAtPath:path error:nil];
//    }
    
    // store plist file which is in documents directory to dictionary.
    NSDictionary *resultDictionary = [NSDictionary dictionaryWithContentsOfFile:path];
    NSLog(@"Loaded Events.plist file at Documents Directory is --> \n%@", [resultDictionary description]);
    
    if (!resultDictionary) {
        NSLog(@"WARNING: Couldn't create dictionary from Events.plist at Documents Dicretory! Default values will be used!");
    }
    
    return resultDictionary;
}

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

#pragma mark - Annotation Methods

- (void)createAnnotations {
    
//    // create out annotations array (in this example only 3)
//    self.mapAnnotations = [[NSMutableArray alloc] initWithCapacity:2];
    
    self.mapAnnotations = [[NSMutableArray alloc] init];
    
//    // Annotation for Event.
//    EventAnnotation *eventAnnotation = [[EventAnnotation alloc] init];
//    [self.mapAnnotations addObject:eventAnnotation];
    
//    for (int i = 0; i < self.eventsArray.count; i++) {
//        Event *event = self.eventsArray[i];
//        EventAnnotation *eventAnnotation = [[EventAnnotation alloc] initWithEvent:event];
//        [self.mapAnnotations addObject:eventAnnotation];
//    }
    
    // Create annotations with eventsSoretedByLocation.
    for (int i = 0; i < self.eventsSortedByLocation.count; i++) {
        NSArray *eventsAtLocation = self.eventsSortedByLocation[i];
        EventAnnotation *locationAnnotation = [[EventAnnotation alloc] initWithEvents:eventsAtLocation];
        [self.mapAnnotations addObject:locationAnnotation];
    }

    
    
    
    // Add annotations in map view.
    [self.mapView addAnnotations:self.mapAnnotations];
}

#pragma mark - Annotation Delegate Methods

- (MKAnnotationView *)mapView:(MKMapView *)theMapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    MKAnnotationView *returnedAnnotationView = nil;
    
    // in case it's the user location, we already have an annotation, so just return nil
    if (![annotation isKindOfClass:[MKUserLocation class]])
    {
        
        if ([annotation isKindOfClass:[EventAnnotation class]]) // for Event.
        {
            returnedAnnotationView = [EventAnnotation createViewAnnotationForMapView:self.mapView annotation:annotation];
            
            // add a detail disclosure button to the callout which will open a new view controller page or a popover
            //
            // note: when the detail disclosure button is tapped, we respond to it via:
            //       calloutAccessoryControlTapped delegate method
            //
            // by using "calloutAccessoryControlTapped", it's a convenient way to find out which annotation was tapped
            //
            UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            [rightButton addTarget:nil action:nil forControlEvents:UIControlEventTouchUpInside];
            ((MKPinAnnotationView *)returnedAnnotationView).rightCalloutAccessoryView = rightButton;
        }
    }
    
    return returnedAnnotationView;
}

#pragma mark - MKMapView Delegate Methods

//- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
//{
//    view.annotation;
//}

// user tapped the disclosure button in the event callout
//
- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    // here we illustrate how to detect which annotation type was clicked on for its callout
    id <MKAnnotation> annotation = [view annotation];
    if ([annotation isKindOfClass:[EventAnnotation class]])
    {
        NSLog(@"clicked an event annotation");
        
        EventDetailViewController *eventDetailVC = [[self storyboard] instantiateViewControllerWithIdentifier:@"EventDetailViewController"];
        EventAnnotation *eventAnnotation = (EventAnnotation *)view.annotation;
        Event *event = eventAnnotation.event;
        eventDetailVC.eventDetail = event;
        
//        eventDetailVC.eventDetail =
        
//        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
//        {
//            // for iPad, we use a popover
//            if (self.bridgePopoverController == nil)
//            {
//                _bridgePopoverController = [[UIPopoverController alloc] initWithContentViewController:detailViewController];
//            }
//            [self.bridgePopoverController presentPopoverFromRect:control.bounds
//                                                          inView:control
//                                        permittedArrowDirections:UIPopoverArrowDirectionLeft
//                                                        animated:YES];
//        }
//        else
//        {
            // for iPhone we navigate to a detail view controller using UINavigationController
        
        
            [self.navigationController pushViewController:eventDetailVC animated:YES];
        NSLog(@"pushed pushed pushed");
//        }
    }
}

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
