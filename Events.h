//
//  NewRegist.h
//  KBT Appen
//
//  Created by Gopal on 19/10/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Events : NSObject

@property (nonatomic, assign)int rowId;
@property (nonatomic, copy) NSString *startDate;
@property (nonatomic, copy) NSString *endDate;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *dayTime;
@property (nonatomic, copy) NSString *eventDes;
@property (nonatomic, assign)int  newRowId;



@end
