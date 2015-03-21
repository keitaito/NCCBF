//
//  ScheduleTableViewController.m
//  NCCBF
//
//  Created by Keita on 2/14/15.
//  Copyright (c) 2015 Keita Ito. All rights reserved.
//

#import "ScheduleTableViewController.h"
#import "ScheduleTableViewCell.h"
#import "Event.h"
#import "EventDetailViewController.h"

@interface ScheduleTableViewController ()

@property (nonatomic, strong) NSArray *eventsArray;
@property (nonatomic, strong) NSArray *eventsPlistArray;
@property (nonatomic, strong) NSArray *allEventsArray;

@property (weak, nonatomic) IBOutlet UISegmentedControl *dateSegment;

@property (nonatomic, strong) NSDate *apr11;
@property (nonatomic, strong) NSDate *apr12;
@property (nonatomic, strong) NSDate *apr18;
@property (nonatomic, strong) NSDate *apr19;

@end

@implementation ScheduleTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUIItems];
        
    // Create path for plist.
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Events" ofType:@"plist"];
    // Create dictionary to store plist's root dictionary.
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    // Store Events Array into events property
    self.eventsPlistArray = dict[@"Events"];
    
    NSDictionary *dataDict = [self loadDataFromDocDir];
    NSArray *arrayFromDataDict = dataDict[@"Events"];

    // Prepare mutable array for iterate.
    NSMutableArray *tmpArray = [[NSMutableArray alloc] init];
    // Iterate creating event model with JSON data.
    for (int i = 0; i < arrayFromDataDict.count; i++) {
        
        Event *eventModel = [[Event alloc] initWithEventDictionary:arrayFromDataDict[i]];
        
//        if (!self.eventsArray) {
//            self.eventsArray = [[NSMutableArray alloc] init];
//        }
        // Store event model in eventsArray.
//        [self.eventsArray addObject:eventModel];
        [tmpArray addObject:eventModel];
        
        // Log date with PDT
        NSLocale* currentLoc = [NSLocale currentLocale];
        NSLog(@"%@",[eventModel.date descriptionWithLocale:currentLoc]);
        
//        //Create the dateformatter object
//        NSDateFormatter* parseFormatter = [[NSDateFormatter alloc] init] ;
//        
//        //Set the required date format
//        [parseFormatter setDateFormat:@"MMM dd, yyyy, HH:mm:ss a"];
//        
//        //Get the string date
//        NSString* str = [parseFormatter stringFromDate:eventModel.date];
//        
//        //Display on the console
//        NSLog(@"%@", str);
    }
    
    // Store all events.
    self.allEventsArray = [NSArray arrayWithArray:tmpArray];
    
    [self setupSchedule];

    
    // Reload table view.
    [self.tableView reloadData];
    
//    NSLog(@"%@", self.eventsArray);

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma mark - UI set up methods

- (void)setUpUIItems {
    
    // Set tint color of nav bar back button arrow white.
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    //    self.tabBarController.tabBar.tintColor
    
}

- (void)setupSchedule {

    // Prepare dateFormatter.
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //    NSTimeZone *tz = [NSTimeZone timeZoneWithName:@"America/Los_Angeles"];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //    [dateFormatter setTimeZone:tz];
    
    // Create date strings to make date objects.
    NSString *apr11String = @"2015-04-11 00:00:00";
    NSString *apr12String = @"2015-04-12 00:00:00";
    NSString *apr18String = @"2015-04-18 00:00:00";
    NSString *apr19String = @"2015-04-19 00:00:00";
    
    // Create date objects and store these in properties.
    self.apr11 = [dateFormatter dateFromString:apr11String];
    self.apr12 = [dateFormatter dateFromString:apr12String];
    self.apr18 = [dateFormatter dateFromString:apr18String];
    self.apr19 = [dateFormatter dateFromString:apr19String];
    
    // default date
    NSMutableArray *apr11EventsArray = [[NSMutableArray alloc] init];
    
    // Check events in allEventsArray pick only Apr 11 events.
    for (Event *event in self.allEventsArray) {
        if ([event.date laterDate:self.apr11] == event.date && [event.date earlierDate:self.apr12] == event.date) {
            [apr11EventsArray addObject:event];
        }
    }
    //    NSLog(@"apr 11 events: \n%@", apr11Events);
    
    // Sort Apr 11 events array by date and time with sortDescriptor. date property has time.
    NSSortDescriptor *sortDescriptorByDate = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:YES];
    NSSortDescriptor *sortDescriptorByEndTime = [[NSSortDescriptor alloc] initWithKey:@"endTime" ascending:YES];
    NSArray *orderedApr11Array = [apr11EventsArray sortedArrayUsingDescriptors:@[sortDescriptorByDate, sortDescriptorByEndTime]];
    
    // store Apr 11 events in events array.
    self.eventsArray = orderedApr11Array;
}

#pragma mark - load data

- (NSDictionary *)loadDataFromDocDir {
    
    // create path to Events.plist in documents directory.
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths firstObject];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"Events.plist"];
    NSLog(@"path to plist file in documents directory --> \n%@", path);
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    // check if file exists.
    if (![fileManager fileExistsAtPath:path]) {
        // If it doesn't, copy it from the default file in main bundle.
        NSLog(@"path does not exist. plist file will be copied to the path from main bundle.");
        // create path to Events.plist in main bundle.
        NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"Events" ofType:@"plist"];
        if (bundlePath) {
            NSLog(@"file exists in the main bundle.");
            NSDictionary *resultDictionary = [NSDictionary dictionaryWithContentsOfFile:bundlePath];
            NSLog(@"Bundle Events.plist file is --> \n%@", [resultDictionary description]);
            
            // copy dictionary from main bundle to document directory path.
            [fileManager copyItemAtPath:bundlePath toPath:path error:nil];
            NSLog(@"plist file is copied from main bundle to document directory");
        } else {
            NSLog(@"Events.plist not found in main bundle. Please, make sure it is part of the bundle.");
        }
        // use this to delete file from documents directory
        // [fileManager removeItemAtPath:path error:nil];
    }
    
    // store plist file which is in documents directory to dictionary.
    NSDictionary *resultDictionary = [NSDictionary dictionaryWithContentsOfFile:path];
    NSLog(@"Loaded Events.plist file at Documents Directory is --> \n%@", [resultDictionary description]);
    
    if (!resultDictionary) {
        NSLog(@"WARNING: Couldn't create dictionary from Events.plist at Documents Dicretory! Default values will be used!");
    }
    
    return resultDictionary;
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.eventsArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ScheduleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ScheduleTableViewCell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    
    // Event name
    // Get event name string from events property
    // Get an event.
    Event *anEvent = self.eventsArray[indexPath.row];

    // Set title label.
    cell.titleLabel.text = anEvent.name;
    
    
    // Start time

    // Get date from anEvent dictionary.
    NSDate *eventDate = anEvent.date;
    // End time.
    NSDate *endTime = anEvent.endTime;
    
    // Instantiate NSDateFormatter
    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
    // set dateFormat.
    [timeFormatter setDateFormat:@"h:mm a"];
    // create date string from eventDate with dateFormatter.
    NSString *eventStartTimeString = [timeFormatter stringFromDate:eventDate];
    NSString *eventEndTimeString = [timeFormatter stringFromDate:endTime];
    
//    NSLog(@"%@", eventStartTimeString);
    
    // Set event time label.
    cell.startTimeLabel.text = [NSString stringWithFormat:@"%@", eventStartTimeString];
    cell.EndTimeLabel.text = [NSString stringWithFormat:@"%@", eventEndTimeString];
    
    return cell;
}



#pragma mark - Switch dates method

- (IBAction)switchDate:(id)sender
{
    NSInteger selectedSegment = self.dateSegment.selectedSegmentIndex;
    
    if (selectedSegment == 0) {
        NSLog(@"Apr 11 schedule");
        
        NSMutableArray *apr11EventsArray = [[NSMutableArray alloc] init];
        
        for (Event *event in self.allEventsArray) {
            if ([event.date laterDate:self.apr11] == event.date && [event.date earlierDate:self.apr12] == event.date) {
                [apr11EventsArray addObject:event];
            }
        }
        NSLog(@"apr 11 events: \n%@", apr11EventsArray);
        
        // Sort Apr 11 events array by date and time with sortDescriptor. date property has time.
        NSSortDescriptor *sortDescriptorByDate = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:YES];
        NSSortDescriptor *sortDescriptorByEndTime = [[NSSortDescriptor alloc] initWithKey:@"endTime" ascending:YES];
        NSArray *orderedApr11Array = [apr11EventsArray sortedArrayUsingDescriptors:@[sortDescriptorByDate, sortDescriptorByEndTime]];
        // Store in events array.
        self.eventsArray = orderedApr11Array;


    } else if (selectedSegment == 1) {
        NSLog(@"Apr 12 schedule");
        
        NSMutableArray *apr12EventsArray = [[NSMutableArray alloc] init];
        
        for (Event *event in self.allEventsArray) {
            if ([event.date laterDate:self.apr12] == event.date && [event.date earlierDate:self.apr18] == event.date) {
                [apr12EventsArray addObject:event];
            }
        }
        NSLog(@"apr 12 events: \n%@", apr12EventsArray);
        
        // Sort Apr 12 events array by date and time with sortDescriptor. date property has time.
        NSSortDescriptor *sortDescriptorByDate = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:YES];
        NSSortDescriptor *sortDescriptorByEndTime = [[NSSortDescriptor alloc] initWithKey:@"endTime" ascending:YES];
        NSArray *orderedApr12Array = [apr12EventsArray sortedArrayUsingDescriptors:@[sortDescriptorByDate, sortDescriptorByEndTime]];
        // Store in events array.
        self.eventsArray = orderedApr12Array;
        
        
    } else if (selectedSegment == 2) {
        NSLog(@"Apr 18 schedule");
        
        NSMutableArray *apr18EventsArray = [[NSMutableArray alloc] init];
        
        for (Event *event in self.allEventsArray) {
            if ([event.date laterDate:self.apr18] == event.date && [event.date earlierDate:self.apr19] == event.date) {
                [apr18EventsArray addObject:event];
            }
        }
        NSLog(@"apr 18 events: \n%@", apr18EventsArray);
        
        // Sort Apr 18 events array by date and time with sortDescriptor. date property has time.
        NSSortDescriptor *sortDescriptorByDate = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:YES];
        NSSortDescriptor *sortDescriptorByEndTime = [[NSSortDescriptor alloc] initWithKey:@"endTime" ascending:YES];
        NSArray *orderedApr18Array = [apr18EventsArray sortedArrayUsingDescriptors:@[sortDescriptorByDate, sortDescriptorByEndTime]];
        // Store in events array.
        self.eventsArray = orderedApr18Array;
        
        
    } else if (selectedSegment == 3) {
        NSLog(@"Apr 19 schedule");
        
        NSMutableArray *apr19EventsArray = [[NSMutableArray alloc] init];
        
        for (Event *event in self.allEventsArray) {
            if ([event.date laterDate:self.apr19] == event.date) {
                [apr19EventsArray addObject:event];
            }
        }
        NSLog(@"apr 19 events: \n%@", apr19EventsArray);
        
        // Sort Apr 19 events array by date and time with sortDescriptor. date property has time.
        NSSortDescriptor *sortDescriptorByDate = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:YES];
        NSSortDescriptor *sortDescriptorByEndTime = [[NSSortDescriptor alloc] initWithKey:@"endTime" ascending:YES];
        NSArray *orderedApr19Array = [apr19EventsArray sortedArrayUsingDescriptors:@[sortDescriptorByDate, sortDescriptorByEndTime]];
        // Store in events array.
        self.eventsArray = orderedApr19Array;

    }
    
    [self.tableView reloadData];
}



#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([[segue identifier] isEqualToString:@"showEventDetailView"]) {
        NSLog(@"showEventDetailView");
        
        EventDetailViewController *eventDetailViewController = [segue destinationViewController];
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        // Get an event.
        Event *eventDetail = self.eventsArray[indexPath.row];
        // Pass event to event detail view conroller.
        eventDetailViewController.eventDetail = eventDetail;
    }
}












- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}






/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

@end
