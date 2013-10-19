//
//  DataBaseHelper.h
//  KBT Appen
//
//  Created by Gopal on 18/10/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import <Foundation/Foundation.h>


@class Events,NewRegistrering;

@interface DataBaseHelper : NSObject

@property (nonatomic, strong) NSString *databasePath;

+ (DataBaseHelper *)sharedDatasource;
- (BOOL)createDB;
- (BOOL)saveDBstart:(NSString*)startDate end:(NSString *)endDate curDate:(NSString *)currentDate checked:(NSString*)checked;
- (BOOL)saveDBEventDate:(NSString*)date start:(NSString *)startDate end:(NSString*)endDate stus:(NSString*)status dayDate:(NSString*)dayDate desc:(NSString*)eventDescription newRI:(int)rowId;
- (BOOL)updateDBEventDate:(NSString*)date start:(NSString *)startDate end:(NSString*)endDate stus:(NSString*)status dayDate:(NSString*)dayDate desc:(NSString*)eventDescription newRI:(int)newRowId where:(int)rowId;
- (BOOL)deleteDBEvent:(int)rowID;
- (BOOL)findEvents:(int)rowId;
- (NSArray *)findEvents;
- (int)newRowId;
- (NSArray *)getnewRegisVecka;
- (NSArray *)findEventsFromNewRegis:(int)newRowId;

@end
