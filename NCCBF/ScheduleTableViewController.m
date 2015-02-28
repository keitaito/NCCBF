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

@interface ScheduleTableViewController ()

@property (nonatomic, strong) NSMutableArray *eventsArray;
@property (nonatomic, strong) NSArray *eventsPlistArray;
@property (nonatomic, strong) NSMutableArray *allEventsArray;

@property (weak, nonatomic) IBOutlet UISegmentedControl *dateSegment;

@property (nonatomic, strong) NSDate *apr11;
@property (nonatomic, strong) NSDate *apr12;
@property (nonatomic, strong) NSDate *apr18;
@property (nonatomic, strong) NSDate *apr19;

@end

@implementation ScheduleTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        
    // Create path for plist.
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Events" ofType:@"plist"];
    // Create dictionary to store plist's root dictionary.
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    // Store Events Array into events property
    self.eventsPlistArray = dict[@"Events"];
    
    // Iterate creating event model with JSON data.
    for (int i = 0; i < self.eventsPlistArray.count; i++) {
        
        Event *eventModel = [[Event alloc] initWithEventDictionary:self.eventsPlistArray[i]];
        
        if (!self.eventsArray) {
            self.eventsArray = [[NSMutableArray alloc] init];
        }
        // Store event model in eventsArray.
        [self.eventsArray addObject:eventModel];
        
        // Log date with PDT
        NSLocale* currentLoc = [NSLocale currentLocale];
        NSLog(@"%@",[eventModel.date descriptionWithLocale:currentLoc]);
        
        //Create the dateformatter object
        NSDateFormatter* formatter = [[NSDateFormatter alloc] init] ;
        
        //Set the required date format
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:SS"];
        
        //Get the string date
        NSString* str = [formatter stringFromDate:eventModel.date];
        
        //Display on the console
        NSLog(@"%@", str);
    }
    
    self.allEventsArray = [NSMutableArray arrayWithArray:self.eventsArray];

    
    NSString *apr11String = @"2015-04-11 00:00:00";
    NSString *apr12String = @"2015-04-12 00:00:00";
    NSString *apr18String = @"2015-04-18 00:00:00";
    NSString *apr19String = @"2015-04-19 00:00:00";
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    NSTimeZone *tz = [NSTimeZone timeZoneWithName:@"America/Los_Angeles"];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    [dateFormatter setTimeZone:tz];
    
    self.apr11 = [dateFormatter dateFromString:apr11String];
    self.apr12 = [dateFormatter dateFromString:apr12String];
    self.apr18 = [dateFormatter dateFromString:apr18String];
    self.apr19 = [dateFormatter dateFromString:apr19String];
    
    NSMutableArray *apr11EventsArray = [[NSMutableArray alloc] init];
    
    for (Event *event in self.allEventsArray) {
        if ([event.date laterDate:self.apr11] == event.date && [event.date earlierDate:self.apr12] == event.date) {
            [apr11EventsArray addObject:event];
        }
    }
//    NSLog(@"apr 11 events: \n%@", apr11Events);
    
    
    // Sort Apr 11 events array by date and time with sortDescriptor. date property has time.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:YES];
    NSArray *orderedApr11Array = [apr11EventsArray sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    // Convert NSArray to NSMutableArray.
    self.eventsArray = [orderedApr11Array mutableCopy];
    
    
    
    
    
    
    
    
    
    
    // Reload table view.
    [self.tableView reloadData];
    
//    NSLog(@"%@", self.eventsArray);

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    
    // get date from anEvent dictionary.
    NSDate *eventDate = anEvent.date;
    // Instantiate NSDateFormatter
    NSDateFormatter *startTimeFormatter = [[NSDateFormatter alloc] init];
    // set dateFormat.
    [startTimeFormatter setDateFormat:@"h:mm a"];
    // create date string from eventDate with dateFormatter.
    NSString *eventStartTimeString = [startTimeFormatter stringFromDate:eventDate];
    
    NSLog(@"%@", eventStartTimeString);
    
    // Set event time label.
    cell.timeLabel.text = eventStartTimeString;
    
    
    // End time
    
    
    
    
    
    return cell;
}

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
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:YES];
        NSArray *orderedApr11Array = [apr11EventsArray sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
        // Convert NSArray to NSMutableArray.
        self.eventsArray = [orderedApr11Array mutableCopy];
        
//        self.eventsArray = apr11EventsArray;
        

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
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:YES];
        NSArray *orderedApr12Array = [apr12EventsArray sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
        // Convert NSArray to NSMutableArray.
        self.eventsArray = [orderedApr12Array mutableCopy];
        
//        self.eventsArray = apr12EventsArray;
        
        
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
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:YES];
        NSArray *orderedApr18Array = [apr18EventsArray sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
        // Convert NSArray to NSMutableArray.
        self.eventsArray = [orderedApr18Array mutableCopy];
        
//        self.eventsArray = apr18EventsArray;
        
        
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
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:YES];
        NSArray *orderedApr19Array = [apr19EventsArray sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
        // Convert NSArray to NSMutableArray.
        self.eventsArray = [orderedApr19Array mutableCopy];
        
//        self.eventsArray = apr19EventsArray;
        
    }
    
    [self.tableView reloadData];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
