//
//  Event.h
//  NCCBF
//
//  Created by Keita on 2/12/15.
//  Copyright (c) 2015 Keita Ito. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Event : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) NSString *location;
@property (nonatomic, strong) NSString *imageString;
@property (nonatomic, strong) NSString *eventDescription;

- (instancetype)initWithEventDictionary:(NSDictionary *)dictionary;
- (id)initWithEventTitle:(NSString *)title;

@end
