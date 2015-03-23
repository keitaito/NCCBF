//
//  StageTableViewController.h
//  NCCBF
//
//  Created by Keita on 3/14/15.
//  Copyright (c) 2015 Keita Ito. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StageTableViewController : UITableViewController

@property (nonatomic, strong) NSArray *eventsArray;
@property (nonatomic, copy) NSString *locationName;

@end
