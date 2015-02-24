//
//  EventTableViewController.m
//  NCCBF
//
//  Created by Keita on 2/12/15.
//  Copyright (c) 2015 Keita Ito. All rights reserved.
//

#import "EventTableViewController.h"
#import "EventTableViewCell.h"
#import "EventDetailViewController.h"
#import "Event.h"

@interface EventTableViewController ()

@property (nonatomic, strong) NSArray *events;
@property (nonatomic, strong) NSArray *eventsJSON;
@property (nonatomic, strong) NSMutableArray *eventModelArray;


@end

@implementation EventTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Create events with Event.plist
    
    // Create path for plist.
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Event" ofType:@"plist"];
    // Create dictionary to store plist's root dictionary.
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    // Store Events Array in events property
    self.events = dict[@"Events"];
    
    ///////////////////////////////////

    // Fetch events data JSON file from online.
    
    // Create url and request.
    NSString *urlString = @"http://keitaito.com/sampleNCCBF/document.json";
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    // Create NSURLConnection and fetch JSON file.
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                               // Parse JSON file to a dictionary object.
                               id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                               
                               // Store JSON data into eventsJSON property.
                               self.eventsJSON = object[@"Events"];
                               
                               // Iterate creating event model with JSON data.
                               for (int i = 0; i < self.eventsJSON.count; i++) {
                                   Event *eventModel = [[Event alloc] initWithEventDictionary:self.eventsJSON[i]];
                                   
                                   if (!self.eventModelArray) {
                                       self.eventModelArray = [[NSMutableArray alloc] init];
                                   }
                                   // Store event model in eventModelArray.
                                   [self.eventModelArray addObject:eventModel];
                               }
                               
                               // Reload table view.
                               [self.tableView reloadData];
                               
                               NSLog(@"%@", object);
                               NSLog(@"%@", self.eventModelArray);
                           }];
    

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
//    return [self.events count];
//    return [self.eventsJSON count];
    return [self.eventModelArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EventTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EventTableViewCell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    // Get event name string from events property
    // 1. get an event
//    NSDictionary *anEvent = self.events[indexPath.row];
//    NSDictionary *anEvent = self.eventsJSON[indexPath.row];
    Event *anEvent = self.eventModelArray[indexPath.row];

//    // 2. get name string
//    NSString *eventName = anEvent[@"name"];
    // Set title label.
    cell.titleLabel.text = anEvent.name;
    
    // Set poster view.
//    NSString *pathForImage = [[NSBundle mainBundle] pathForResource:@"sample-image" ofType:@"jpg"];
//    UIImage *poster = [UIImage imageWithContentsOfFile:pathForImage];
//    NSString *imageName = anEvent[@"image_name"];
    NSString *imageName = anEvent.imageString;
    UIImage *poster = [UIImage imageNamed:imageName];
    cell.posterView.image = poster;
    
    return cell;
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([[segue identifier] isEqualToString:@"showEventDetailView"]) {
        NSLog(@"showEventDetailView");
        
        EventDetailViewController *eventDetailViewController = [segue destinationViewController];
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        // Get event title string from events property
        // 1. get an event
//        NSDictionary *eventDictionary = self.events[indexPath.row];
        NSDictionary *eventDictionary = self.eventsJSON[indexPath.row];
        // 2. get name string
        __unused NSString *eventTitle = eventDictionary[@"name"];

//        Event *eventDetail = [[Event alloc] initWithEventTitle:eventTitle];
        Event *eventDetail = [[Event alloc] initWithEventDictionary:eventDictionary];
        eventDetailViewController.eventDetail = eventDetail;
    }
}













#pragma mark - memory warning

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
        // Create a new instance of the appropriate class, insert it in the array, and add a new row to the table view
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
