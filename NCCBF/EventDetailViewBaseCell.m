//
//  EventDetailViewBaseCell.m
//  NCCBF
//
//  Created by Keita on 3/22/15.
//  Copyright (c) 2015 Keita Ito. All rights reserved.
//

#import "EventDetailViewBaseCell.h"
#import "Event.h"

@implementation EventDetailViewBaseCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setupWithModel:(Event *)event {
    NSLog(@"Called setupWithModel method");
}

@end

// Subclasses of EventDetailViewBaseCell

@implementation EventImageCell

- (void)setupWithModel:(Event *)event
{
    NSString *string = event.imageString;
    self.detailPosterView.image = [UIImage imageNamed:string];
}

@end

@implementation EventNameCell

- (void)setupWithModel:(Event *)event
{
    self.titleLabel.text = event.name;
}

@end

@implementation EventDescriptionCell

- (void)setupWithModel:(Event *)event
{
    self.eventDescriptionLabel.text = event.eventDescription;
}

@end

@implementation EventLocationCell

- (void)setupWithModel:(Event *)event
{
    self.eventLocationLabel.text = event.location;
}

@end

