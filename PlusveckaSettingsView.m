//
//  PlusveckaSettingsView.m
//  Välkommen till TFH-appen
//
//  Created by Brilliance Tech Sols on 7/21/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import "PlusveckaSettingsView.h"

@interface PlusveckaSettingsView ()

@end

@implementation PlusveckaSettingsView
@synthesize scrollVie,sub2Settings;
@synthesize oneHour,twoHour,threeHour,fourHour,whichHour,sub1EventsArray;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        
        UIImage *image = [UIImage imageNamed:@"tillbaka1.png"];
        UIButton *okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [okBtn setFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
        [okBtn setImage:image forState:UIControlStateNormal];
        [okBtn addTarget:self action:@selector(backButon) forControlEvents:UIControlEventTouchUpInside];
        
        self.navigationItem.leftBarButtonItem =  [[UIBarButtonItem alloc] initWithCustomView:okBtn];
        
    }
    else {
        UIImage *image = [UIImage imageNamed:@"tillbaka1.png"];
        UIButton *okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [okBtn setFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
        [okBtn setBackgroundImage:image forState:UIControlStateNormal];
        [okBtn addTarget:self action:@selector(backButon) forControlEvents:UIControlEventTouchUpInside];
        
        self.navigationItem.leftBarButtonItem =  [[UIBarButtonItem alloc] initWithCustomView:okBtn];
    }
    NSString *docsDir;
    NSArray *dirPaths;
    
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    
    // Build the path to the database file
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"exerciseDB.db"]];
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &exerciseDB) == SQLITE_OK)
    {
        char *errMsg;
        const char *sql_stmt3 = "CREATE TABLE IF NOT EXISTS SUB2SETTINGS (id INTEGER PRIMARY KEY AUTOINCREMENT,value TEXT)";
        if (sqlite3_exec(exerciseDB, sql_stmt3, NULL, NULL, &errMsg)!=SQLITE_OK) {
            NSLog(@"Failed to create total database");
        }
        sqlite3_close(exerciseDB);
        
    } else {
        NSLog(@"Failed to open/create database");
    }

    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated{
    [self getSub2SettingsData];
    [super viewWillAppear:YES];
}

-(IBAction)hourSelected:(id)sender {
    
    UIButton *btn = (UIButton *)sender;
    for (UIButton *radioButton in [self.scrollVie  subviews]) {
        if (radioButton.tag != btn.tag && [radioButton isKindOfClass:[UIButton class]]) {
            if ((radioButton.tag == 21 || radioButton.tag == 22 || radioButton.tag == 23 || radioButton.tag == 24 )) {
                [radioButton setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
            }
            
        }
    }
    NSString *tagString = [NSString stringWithFormat:@"%d",btn.tag];
    whichHour = [[tagString substringFromIndex:tagString.length-1]retain];
    [btn setImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateNormal];
}

-(IBAction)okAction:(id)sender{
    if (whichHour) {
        if ([sub2Settings objectForKey:@"id"]) {
            [self updateSettings];
        }
        else{
            [self insertSettings];
        }
    }
}

-(void)updateSettings {
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &exerciseDB) == SQLITE_OK)
    {
        NSString *query=[NSString stringWithFormat:@"UPDATE SUB2SETTINGS SET value='%@' WHERE id='%d'",whichHour, [[sub2Settings valueForKey:@"id"]intValue]];
        
        const char *del_stmt = [query UTF8String];
        
        sqlite3_prepare_v2(exerciseDB, del_stmt, -1, &statement, NULL);
        
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            [sub2Settings setValue:whichHour forKey:@"value"];
            [self setNotifications];
            NSLog(@"Updated");
            
        }else {
            NSLog(@"Failed to Update");
            if(SQLITE_DONE != sqlite3_step(statement))
                NSLog(@"Error while updating. %s", sqlite3_errmsg(exerciseDB));
        }
        
        sqlite3_finalize(statement);
        
    }
    sqlite3_close(exerciseDB);
}

-(void)deleteNotifications{
    NSArray *notifications = [[UIApplication sharedApplication]scheduledLocalNotifications];
    for (int k=0; k<[notifications count]; k++) {
        UILocalNotification *ntf = [notifications objectAtIndex:k];
        NSDictionary *userIn = ntf.userInfo;
        if ([userIn objectForKey:@"type"]) {
            [[UIApplication sharedApplication]cancelLocalNotification:ntf];
        }
    }
}

-(void)setNotifications{
    NSArray *notifications = [[UIApplication sharedApplication]scheduledLocalNotifications];
    for (int m=0; m<[sub1EventsArray count]; m++) {
        BOOL isExist=NO;
        NSDictionary *event =[sub1EventsArray objectAtIndex:m];
        for (int k=0; k<[notifications count]; k++) {
            UILocalNotification *ntf = [notifications objectAtIndex:k];
            NSDictionary *userIn = ntf.userInfo;
            if ([userIn objectForKey:@"type"]) {
                if ([[userIn valueForKey:@"dayTime"] isEqualToString:[event valueForKey:@"dayTime"]]) {
                    UILocalNotification *notifi = [[UILocalNotification alloc]init];
                    NSDate *dte = [userIn valueForKey:@"date"];
                    NSInteger hour = [[sub2Settings valueForKey:@"value"]intValue];
                    notifi.fireDate = [dte dateByAddingTimeInterval:-(hour*60*60)];
                    notifi.alertBody = [event valueForKey:@"eventDescription"];
                    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
                    [dict setValue:dte forKey:@"date"];
                    [dict setValue:[sub2Settings valueForKey:@"value"] forKey:@"settings"];
                    [dict setValue:@"event" forKey:@"type"];
                    [dict setValue:[userIn valueForKey:@"dayTime"] forKey:@"dayTime"];
                    [dict setValue:[dte dateByAddingTimeInterval:-(hour*60*60)] forKey:@"fire"];
                    notifi.userInfo = dict;
                    [[UIApplication sharedApplication] scheduleLocalNotification:notifi];
                    [[UIApplication sharedApplication]cancelLocalNotification:ntf];
                    isExist = YES;
                    break;
                }
            }
        }
        if (!isExist) {
            NSString *startDate = [event valueForKey:@"startDate"];
            NSString *dayTime = [event valueForKey:@"dayTime"];
            NSArray *arrr = [dayTime componentsSeparatedByString:@" "];
            NSString *buttonString = [NSString stringWithFormat:@"%@",[arrr objectAtIndex:0]];
            NSString *dateString = [NSString stringWithFormat:@"%@ %@",buttonString,startDate];
            NSDateFormatter *fmtr = [[NSDateFormatter alloc]init];
            [fmtr setDateFormat:@"yyyy-MM-dd HH:mm"];
            NSDate *date = [fmtr dateFromString:dateString];
            UILocalNotification *notification = [[UILocalNotification alloc]init];
            NSInteger hour = [[sub2Settings valueForKey:@"value"]intValue];
            notification.fireDate = [date dateByAddingTimeInterval:-(hour*60*60)];
            notification.alertBody = [event valueForKey:@"eventDescription"];
            NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
            [dict setValue:date forKey:@"date"];
            [dict setValue:[sub2Settings valueForKey:@"value"] forKey:@"settings"];
            [dict setValue:@"event" forKey:@"type"];
            [dict setValue:dayTime forKey:@"dayTime"];
            [dict setValue:[date dateByAddingTimeInterval:-(hour*60*60)] forKey:@"fire"];
            notification.userInfo = dict;
            [[UIApplication sharedApplication]scheduleLocalNotification:notification];
        }
    }
    
}



-(void)insertSettings {
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &exerciseDB) == SQLITE_OK)
    {
        NSString *insertSQL = [NSString stringWithFormat: @"INSERT INTO SUB2SETTINGS (value) VALUES (\"%@\")",whichHour];
        
        const char *insert_stmt = [insertSQL UTF8String];
        
        sqlite3_prepare_v2(exerciseDB, insert_stmt, -1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            NSLog(@"New Record Created");
            
            
        }
        else {
            if(SQLITE_DONE != sqlite3_step(statement))
                NSLog(@"Error while updating. %s", sqlite3_errmsg(exerciseDB));
            NSLog(@"error for insertig data into database NO");
        }
        sqlite3_finalize(statement);
    }
    sqlite3_close(exerciseDB);
    [self getSub2SettingsData];
    [self setNotifications];
}

-(IBAction)settingsOnOff:(id)sender{
    if ([sender tag]==0) {
        scrollVie.hidden = YES;
        whichHour = nil;
        if ([sub2Settings objectForKey:@"id"]) {
            [self deleteSettings];
        }
    
    }else{
        scrollVie.hidden = NO;
        for (UIButton *radioButton in [self.scrollVie  subviews]) {
            if ([radioButton isKindOfClass:[UIButton class]]) {
                if (radioButton.tag!=55) {
                    [radioButton setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
                }
            }
        }
    }
}

-(void)deleteSettings {
    
    if (sqlite3_open([databasePath UTF8String], &exerciseDB) == SQLITE_OK) {
        NSLog(@"--%d",[[sub2Settings valueForKey:@"id"]intValue]);
        NSString *sql = [NSString stringWithFormat: @"DELETE FROM SUB2SETTINGS WHERE id='%d'",[[sub2Settings valueForKey:@"id"]intValue]];
        
        const char *del_stmt = [sql UTF8String];
        
        sqlite3_prepare_v2(exerciseDB, del_stmt, -1, & statement, NULL);
        
        if (sqlite3_step(statement) == SQLITE_DONE) {
            
            NSLog(@"sss");
            [sub2Settings removeObjectForKey:@"id"];
            [sub2Settings removeObjectForKey:@"value"];
            [self deleteNotifications];
        }
        sqlite3_finalize(statement);
    }
    sqlite3_close(exerciseDB);
}

-(void)backButon {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)getSub2SettingsData{
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &exerciseDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat: @"SELECT * FROM SUB2SETTINGS"];
        
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(exerciseDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            
            while  (sqlite3_step(statement) == SQLITE_ROW) {
                NSString *Id = [NSString stringWithFormat:@"%d",sqlite3_column_int(statement,0)];
                NSString *value = [NSString stringWithFormat:@"%s",sqlite3_column_text(statement, 1)];
                sub2Settings = [[NSMutableDictionary alloc]init];
                [sub2Settings setValue:Id  forKey:@"id"];
                [sub2Settings setValue:value forKey:@"value"];
                whichHour = [value retain];
            }
        }
        sqlite3_finalize(statement);
    }
    sqlite3_close(exerciseDB);
    if ([sub2Settings objectForKey:@"id"]) {
        scrollVie.hidden = NO;
        for (UIButton *radioButton in [self.scrollVie  subviews]) {
            if ([radioButton isKindOfClass:[UIButton class]]) {
                NSString *tagString = [NSString stringWithFormat:@"%d",radioButton.tag];
                NSString *val = [tagString substringFromIndex:tagString.length-1];
                if (radioButton.tag!=55) {
                    if ([[sub2Settings valueForKey:@"value"] isEqualToString:val]) {
                        [radioButton setImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateNormal];
                    }
                    else{
                        [radioButton setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
                    }
                }
            }
        }
    }else{
        scrollVie.hidden = YES;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
