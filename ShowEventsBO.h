//
//  ShowEventsBO.h
//  NewApp
//
//  Created by Mac on 17/05/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShowEventsBO : NSObject

@property(nonatomic, retain)NSString *title;
@property(nonatomic, retain)NSString *location;
@property(nonatomic, retain)NSDate *startDate;
@property(nonatomic, retain)NSDate *endDate;
@property(nonatomic, retain)NSString *notes;

@end
