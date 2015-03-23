//
//  EventDetailViewBaseCell.h
//  NCCBF
//
//  Created by Keita on 3/22/15.
//  Copyright (c) 2015 Keita Ito. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Event;

@interface EventDetailViewBaseCell : UITableViewCell

- (void)setupWithModel:(Event *)event;

@end



// Subclasses of EventDetailViewBaseCell

@interface EventImageCell : EventDetailViewBaseCell
@property (weak, nonatomic) IBOutlet UIImageView *detailPosterView;
@end

@interface EventNameCell : EventDetailViewBaseCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@end

@interface EventDescriptionCell : EventDetailViewBaseCell
@property (weak, nonatomic) IBOutlet UILabel *eventDescriptionLabel;
@end

@interface EventLocationCell : EventDetailViewBaseCell
@property (weak, nonatomic) IBOutlet UILabel *eventLocationLabel;
@end