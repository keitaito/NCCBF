//
//  SocialViewCell.h
//  NCCBF
//
//  Created by Keita on 2/17/15.
//  Copyright (c) 2015 Keita Ito. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SocialViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) NSString *urlString;

@end
