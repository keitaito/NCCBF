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

@property (nonatomic, strong) NSArray *eventsArray;
@property (nonatomic, strong) NSArray *eventsTmpArray;

@property (nonatomic, strong) NSDictionary *DataDict;


@end

@implementation EventTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUIItems];
    
    // Load data file from documents directory. If there is no file, a file in main bundle gets copied there.
    [self loadDataFromDocDir];
    
    ///////////////////////////////////

    // Fetch events data JSON file from online.
    
    // Before using block in NSURLConnection, create weakSelf to prevent strong reference cycle.
    __weak EventTableViewController *weakSelf = self;
    
    // Create url and request.
//    NSString *urlString = @"http://keitaito.com/sampleNCCBF/document.json";
    NSString *urlString = @"http://sfjapantown.org/smartphone_app/document.json";
    
    // For test
//    urlString = nil;
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // Create NSURLConnection and fetch JSON file.
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                               
                               // Create innerSelf to keep weakSelf, to prevent deallocating it.
                               EventTableViewController *innerSelf = weakSelf;
                               
                               // Check if the data is downloaded and error.
                               if ([data length] > 0 && connectionError == nil) {
                                   // Store the data object in tmp array.
                                   NSLog(@"SUCCESS!!!!! Events data is downloaded.");
                                   
                                   // Parse JSON file to a dictionary object.
                                   id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                    NSLog(@"%@", object);
                                   
                                   // Store JSON data into temp array property.
                                   innerSelf.eventsTmpArray = object[@"Events"];
                                   
                                   // Save the latest Events data from online in local Documents Directory.
                                   NSLog(@"Will save the latest events data in documents directory.");
                                   [innerSelf saveData:object];
                                   
                               } else if ([data length] == 0 && connectionError == nil) {
                                   NSLog(@"nothing was downloaded.");
                                   
//                                   // Create events with Events.plist
//                                   // Create path for plist.
//                                   NSString *path = [[NSBundle mainBundle] pathForResource:@"Events" ofType:@"plist"];
//                                   // Create dictionary to store plist's root dictionary.
//                                   NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
//                                   // Store Events Array in events property
//                                   innerSelf.eventsTmpArray = dict[@"Events"];
                                   innerSelf.eventsTmpArray = innerSelf.DataDict[@"Events"];
                                   NSLog(@"Will load events data from documents directory.");
                                   
                               } else if (connectionError != nil) {
                                   NSLog(@"Couldn't connect.");
                                   NSLog(@"Error = %@", connectionError);
                                   
//                                   // Create events with Events.plist
//                                   // Create path for plist.
//                                   NSString *path = [[NSBundle mainBundle] pathForResource:@"Events" ofType:@"plist"];
//                                   // Create dictionary to store plist's root dictionary.
//                                   NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
//                                   // Store Events Array in events property
//                                   innerSelf.eventsTmpArray = dict[@"Events"];
                                   innerSelf.eventsTmpArray = innerSelf.DataDict[@"Events"];
                                   NSLog(@"Will load events data from documents directory.");

                               }
                               
                               // temporary array for iterate.
                               NSMutableArray *arrayForIterate = [[NSMutableArray alloc] init];
                               
                               // Iterate creating event model with Events data.
                               for (int i = 0; i < innerSelf.eventsTmpArray.count; i++) {
                                   
                                   // Create Event model objects with Events data.
                                   Event *eventModel = [[Event alloc] initWithEventDictionary:innerSelf.eventsTmpArray[i]];
                                   // Add an eventModel in array.
                                   [arrayForIterate addObject:eventModel];
                                   
//                                   // Create
//                                   if (!innerSelf.eventsArray) {
//                                       innerSelf.eventsArray = [[NSMutableArray alloc] init];
//                                   }
//                                   // Store event model in eventsArray.
//                                   [innerSelf.eventsArray addObject:eventModel];
                               }
                               
                               self.eventsArray = [NSArray arrayWithArray:arrayForIterate];
                               
                               // Reload table view.
                               [innerSelf.tableView reloadData];
                               
                               NSLog(@"event model objects in eventsArray --> \n%@", innerSelf.eventsArray);
                            
                           }];
    

    

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

#pragma mark - Load and Save methods

- (void)loadDataFromDocDir {
    
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
    
    if (resultDictionary) {
        // Store resultDictionary in DataDict.
        self.DataDict = resultDictionary;

    } else {
        NSLog(@"WARNING: Couldn't create dictionary from Events.plist at Documents Dicretory! Default values will be used!");
    }

}

- (void)saveData:(id)object {
    
    // Get path to Events.plist.
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths firstObject];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"Events.plist"];
    
    // Create dictionary from plist file in documetns directory.
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    
    // Save object data.
    [dict setObject:object[@"Events"] forKey:@"Events"];
    
    // writing to Events.plist
    [dict writeToFile:path atomically:YES];
    
    NSDictionary *resultDictionary = [NSDictionary dictionaryWithContentsOfFile:path];
    NSLog(@"Saved Events.plist file in Documents Direcotry --> \n%@", [resultDictionary description]);
    
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
    EventTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EventTableViewCell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    // Get event name string from events property
    // 1. get an event
    Event *anEvent = self.eventsArray[indexPath.row];

    // Set a title label.
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
        Event *eventDetail = self.eventsArray[indexPath.row];
//        // 2. get name string
//        __unused NSString *eventTitle = eventDictionary[@"name"];

//        Event *eventDetail = [[Event alloc] initWithEventTitle:eventTitle];
//        Event *eventDetail = [[Event alloc] initWithEventDictionary:eventDictionary];
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
