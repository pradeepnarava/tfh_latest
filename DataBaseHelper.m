//
//  DataBaseHelper.m
//  KBT Appen
//
//  Created by Gopal on 18/10/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import "DataBaseHelper.h"
#import "Events.h"
#import "NewRegistrering.h"

static DataBaseHelper *sharedInstance = nil;
static sqlite3 *database = nil;
static sqlite3_stmt *statement = nil;

@implementation DataBaseHelper
@synthesize databasePath;

-(id)init {
    if (self = [super init]) {
       
        NSString *sqliteString = [[NSBundle mainBundle] pathForResource:@"exercise6" ofType:@"sqlite"];
        
        NSArray *dirPath;
        NSString *docPath;
        dirPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        docPath = dirPath[0];
        NSString *_databasePath = [[NSString alloc] initWithString:[docPath stringByAppendingPathComponent:@"exercise6.sqlite"]];
        NSFileManager  *fileMag = [[NSFileManager alloc] init];
        if ([fileMag fileExistsAtPath:_databasePath]) {
        }else {
            [fileMag copyItemAtPath:sqliteString toPath:_databasePath error:nil];
        }
        
    }
    return self;
}



+ (DataBaseHelper *)sharedDatasource {
    
    if (!sharedInstance) {
        sharedInstance = [[DataBaseHelper alloc]init];
        [sharedInstance createDB];
    }
    return sharedInstance;
}

- (BOOL)createDB {
    
    NSArray *dirPath;
    NSString *docPath;
    dirPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docPath = dirPath[0];
    databasePath = [[NSString alloc] initWithString:[docPath stringByAppendingPathComponent:@"exercise6.sqlite"]];
    BOOL isSuccess = YES;
    
    NSFileManager  *fileMag = [[NSFileManager alloc] init];
    
    if ([fileMag fileExistsAtPath:databasePath])
    {
        const char *dbpath = [databasePath UTF8String];
        if (sqlite3_open(dbpath, &database) != SQLITE_OK)
        {
            isSuccess = NO;
            NSLog(@"Failed to open database");
        }
    }else {
        isSuccess = NO;
        NSLog(@"Failed to open/create database");
    }
    
    return isSuccess;
}


#pragma mark Saving New Registreringvecka for SUB1

- (BOOL)saveDBstart:(NSString*)startDate end:(NSString *)endDate curDate:(NSString *)currentDate checked:(NSString *)checked
{
    BOOL success;
    
    const char *dbPath = [databasePath UTF8String];
    
    if (sqlite3_open(dbPath, &database)==SQLITE_OK) {
        
        NSString *insertSQL = [NSString stringWithFormat:@"INSERT INTO newregister(startDate,endDate,currentDate,uncheck) values ('%@', '%@', '%@', '%@')",startDate,endDate,currentDate,checked];
        
        const char *insert_stmt = [insertSQL UTF8String];
        
        if (sqlite3_prepare_v2(database, insert_stmt,-1, &statement, NULL) == SQLITE_OK){
            
            if (sqlite3_step(statement) == SQLITE_DONE)
            {
                success = YES;
            }
            else {
                NSLog(@"%s",sqlite3_errmsg(database));
                success = NO;
            }
            sqlite3_finalize(statement);
        }else {
            NSLog(@"%s",sqlite3_errmsg(database));
            success = NO;
        }
    }else{
        success = NO;
    }
    
    return success;
}

- (int)newRowId {
    
   int rowId=0;
    NSString *querySQL = [NSString stringWithFormat:@"SELECT * FROM newregister"];
    
    const char *query_stmt = [querySQL UTF8String];
    
    if (sqlite3_prepare_v2(database,query_stmt, -1, &statement, NULL) == SQLITE_OK)
    {
        while(sqlite3_step(statement) == SQLITE_ROW)
        {
            rowId =  sqlite3_column_int(statement, 0);
            
        }
    }
    
    sqlite3_finalize(statement);
    
    return rowId;
}

- (NSArray*)getnewRegisVecka {
    
    NSMutableArray *temp = [[NSMutableArray alloc]init];
    
    NSString *querySQL = [NSString stringWithFormat:@"SELECT * FROM newregister"];
    
    const char *query_stmt = [querySQL UTF8String];
    
    if (sqlite3_prepare_v2(database,query_stmt, -1, &statement, NULL) == SQLITE_OK)
    {
        while(sqlite3_step(statement) == SQLITE_ROW)
        {
            int rowId = sqlite3_column_int(statement, 0);
            char *startDateChar = (char *)sqlite3_column_text(statement, 1);
            char *endDateChar = (char *)sqlite3_column_text(statement, 2);
            char *currentDateChar = (char*)sqlite3_column_text(statement, 3);
            char *checkChar = (char *)sqlite3_column_text(statement, 4);
            
            NSString *startDate = [NSString stringWithUTF8String:startDateChar];
            NSString *endDate = [NSString stringWithUTF8String:endDateChar];
            NSString *currentDate = [NSString stringWithUTF8String:currentDateChar];
            NSString *check = [NSString stringWithUTF8String:checkChar];
            
            NewRegistrering *newReg = [[NewRegistrering alloc] init];
            newReg.rowId = rowId;
            newReg.startDate = startDate;
            newReg.endDate = endDate;
            newReg.currentDate = currentDate;
            newReg.uncheck = check;
            
            [temp addObject:newReg];
        }
    }
    sqlite3_finalize(statement);
    
    return temp;
}


#pragma mark Saving Events for SUB1


- (BOOL)saveDBEventDate:(NSString*)date start:(NSString *)startDate end:(NSString*)endDate stus:(NSString*)status dayDate:(NSString*)dayDate desc:(NSString*)eventDescription newRI:(int)rowId {
    
    BOOL success;
    
    
    NSString *insertSQL = [NSString stringWithFormat:@"INSERT INTO events(date, startDate,endDate,status,dayDate,eventDescription,newRowID) values ('%@', '%@', '%@', '%@', '%@', '%@', '%d')",date,startDate,endDate,status,dayDate,eventDescription,rowId];
    
    const char *insert_stmt = [insertSQL UTF8String];
    
    sqlite3_prepare_v2(database, insert_stmt,-1, &statement, NULL);
    
    if (sqlite3_step(statement) == SQLITE_DONE)
    {
        success = YES;
    }
    else {
        success = NO;
    }
    sqlite3_finalize(statement);
    
    
    return success;
}

- (BOOL)updateDBEventDate:(NSString*)date start:(NSString *)startDate end:(NSString*)endDate stus:(NSString*)status dayDate:(NSString*)dayDate desc:(NSString*)eventDescription newRI:(int)newRowId where:(int)rowId
{
    NSString *query=[NSString stringWithFormat:@"UPDATE events SET date='%@', startDate='%@', endDate='%@', status='%@', dayDate='%@', eventDescription='%@' newRowID='%d' WHERE rowId='%d'",@"", startDate,endDate,status,dayDate,eventDescription,newRowId,rowId];
    
    const char *update_stmt = [query UTF8String];
    
    sqlite3_prepare_v2(database, update_stmt, -1, &statement, NULL);
    
    if (sqlite3_step(statement) == SQLITE_DONE)
    {
        NSLog(@"Updated");
        return YES;
    }else {
        NSLog(@"Failed to Update");
        return NO;
        if(SQLITE_DONE != sqlite3_step(statement))
            NSLog(@"Error while updating. %s", sqlite3_errmsg(database));
    }
    
    sqlite3_finalize(statement);
    
    return NO;
}


- (BOOL)deleteDBEvent:(int)rowID {
    BOOL success;
    NSString *sql = [NSString stringWithFormat: @"DELETE FROM events WHERE rowId='%d'",rowID];
    const char *del_stmt = [sql UTF8String];
    sqlite3_prepare_v2(database, del_stmt, -1, & statement, NULL);
    if (sqlite3_step(statement) == SQLITE_ROW) {
        NSLog(@"sss");
        success = YES;
    }else {
        success = NO;
    }
    sqlite3_finalize(statement);
    
    return success ;
}


- (BOOL)findEvents:(int)rowId {

    NSString *querySQL = [NSString stringWithFormat: @"SELECT rowId FROM events WHERE rowId='%d'", rowId];
    const char *query_stmt = [querySQL UTF8String];
    if (sqlite3_prepare_v2(database, query_stmt, -1, &statement, NULL) == SQLITE_OK)
    {
        if (sqlite3_step(statement) == SQLITE_ROW)
        {
            return YES;
        }

    }
    sqlite3_finalize(statement);
    
    return NO;
}

- (NSArray *)findEvents {

    NSMutableArray *tempEvent = [[NSMutableArray alloc] init];

    NSString *querySQL = [NSString stringWithFormat: @"SELECT * FROM events"];
    
    const char *query_stmt = [querySQL UTF8String];
    
    if (sqlite3_prepare_v2(database, query_stmt, -1, &statement, NULL) == SQLITE_OK)
    {
        while  (sqlite3_step(statement) == SQLITE_ROW) {
            int rowId = sqlite3_column_int(statement, 0);
            char *startDateChar = (char *)sqlite3_column_text(statement, 2);
            char *endDateChar = (char *)sqlite3_column_text(statement, 3);
            char *statusChar = (char *)sqlite3_column_text(statement, 4);
            char *dayTimeChar = (char *)sqlite3_column_text(statement, 5);
            char *eventDesChar = (char *)sqlite3_column_text(statement, 6);
            int newRowId = sqlite3_column_int(statement, 7);
            
            NSString *startDate = [NSString stringWithUTF8String:startDateChar];
            NSString *endDate = [NSString stringWithUTF8String:endDateChar];
            NSString *status = [NSString stringWithUTF8String:statusChar];
            NSString *dayTime = [NSString stringWithUTF8String:dayTimeChar];
            NSString *eventDescription = [NSString stringWithUTF8String:eventDesChar];
            
            Events *event = [[Events alloc]init];
            event.rowId = rowId;
            event.startDate = startDate;
            event.endDate = endDate;
            event.status = status;
            event.dayTime = dayTime;
            event.eventDes = eventDescription;
            event.newRowId = newRowId;
            
            [tempEvent addObject:event];
        }
    }
    
    sqlite3_finalize(statement);

    return tempEvent;
}


- (NSArray *)findEventsFromNewRegis:(int)newRowId {
    
    NSString *querySQL = [NSString stringWithFormat:@"SELECT * FROM events WHERE newRowID='%d'",newRowId];
    
    const char *query_stmt = [querySQL UTF8String];
    
    NSMutableArray *resultArray = [[NSMutableArray alloc]init];
    
    if (sqlite3_prepare_v2(database,query_stmt, -1, &statement, NULL) == SQLITE_OK)
    {
        while(sqlite3_step(statement) == SQLITE_ROW)
        {
            int rowId = sqlite3_column_int(statement, 0);
            char *startDateChar = (char *)sqlite3_column_text(statement, 2);
            char *endDateChar = (char *)sqlite3_column_text(statement, 3);
            char *statusChar = (char *)sqlite3_column_text(statement, 4);
            char *dayTimeChar = (char *)sqlite3_column_text(statement, 5);
            char *eventDesChar = (char *)sqlite3_column_text(statement, 6);
            int newRowId = sqlite3_column_int(statement, 7);
            
            NSString *startDate = [NSString stringWithUTF8String:startDateChar];
            NSString *endDate = [NSString stringWithUTF8String:endDateChar];
            NSString *status = [NSString stringWithUTF8String:statusChar];
            NSString *dayTime = [NSString stringWithUTF8String:dayTimeChar];
            NSString *eventDescription = [NSString stringWithUTF8String:eventDesChar];
            
            Events *event = [[Events alloc]init];
            event.rowId = rowId;
            event.startDate = startDate;
            event.endDate = endDate;
            event.status = status;
            event.dayTime = dayTime;
            event.eventDes = eventDescription;
            event.newRowId = newRowId;
            
            [resultArray addObject:event];
        }
        
        sqlite3_reset(statement);
    }
    
    return  resultArray;
}



-(void)dealloc {
    [super dealloc];
    //sqlite3_close(database);
}





@end
