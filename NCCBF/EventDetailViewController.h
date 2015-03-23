//
//  EventDetailViewController.h
//  NCCBF
//
//  Created by Keita on 2/12/15.
//  Copyright (c) 2015 Keita Ito. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Event;

@interface EventDetailViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) Event *eventDetail;

@end
