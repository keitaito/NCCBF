//
//  ScheduleTableViewCell.h
//  NCCBF
//
//  Created by Keita on 2/14/15.
//  Copyright (c) 2015 Keita Ito. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScheduleTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@end
