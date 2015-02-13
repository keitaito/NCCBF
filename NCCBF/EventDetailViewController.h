//
//  EventDetailViewController.h
//  NCCBF
//
//  Created by Keita on 2/12/15.
//  Copyright (c) 2015 Keita Ito. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *detailPosterView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *eventDetailLabel;
@end
