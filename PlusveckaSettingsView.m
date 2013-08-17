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
@synthesize klarButton,whichHour,sub2EventsArray,eventPicker,totalPicker,background,totalHour,eventView,totalView,totalView1,totalArray;
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
    self.navigationItem.title=@"Påminnelser";
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
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"da_US"];
    eventPicker.layer.backgroundColor = [UIColor whiteColor].CGColor;
   // [[eventPicker.subviews objectAtIndex:0] removeFromSuperview];
    [eventPicker setBackgroundColor:[UIColor clearColor]];
    [totalPicker setBackgroundColor:[UIColor clearColor]];
    eventPicker.frame = CGRectMake(eventPicker.frame.origin.x, eventPicker.frame.origin.y, eventPicker.frame.size.width, 140);
    totalPicker.frame = CGRectMake(totalPicker.frame.origin.x, totalPicker.frame.origin.y, totalPicker.frame.size.width, 140);
    [eventPicker setLocale:locale];
    [totalPicker setLocale:locale];
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
        const char *sql_stmt3 = "CREATE TABLE IF NOT EXISTS SUB2SETTINGS (id INTEGER PRIMARY KEY AUTOINCREMENT,eventvalue TEXT,totalvalue TEXT)";
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

-(IBAction)eventValueChanged:(id)sender{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"HH:mm"];
    whichHour = [[formatter stringFromDate:eventPicker.date]retain];
}

-(IBAction)totalValueChanged:(id)sender{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"HH:mm"];
    totalHour = [[formatter stringFromDate:totalPicker.date]retain];
}

-(IBAction)okAction:(id)sender{
    if (![whichHour isEqualToString:@"00:00"]&&![totalHour isEqualToString:@"00:00"]) {
        if ([sub2Settings objectForKey:@"id"]) {
            [self updateSettings];
        }
        else{
            [self insertSettings];
        }
    }else{
        if ([sub2Settings objectForKey:@"id"]) {
            [self deleteSettings];
        }
    }
}

-(void)updateSettings {
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &exerciseDB) == SQLITE_OK)
    {
        NSString *query=[NSString stringWithFormat:@"UPDATE SUB2SETTINGS SET eventvalue='%@',totalvalue='%@' WHERE id='%d'",whichHour,totalHour, [[sub2Settings valueForKey:@"id"]intValue]];
        
        const char *del_stmt = [query UTF8String];
        
        sqlite3_prepare_v2(exerciseDB, del_stmt, -1, &statement, NULL);
        
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            [sub2Settings setValue:whichHour forKey:@"eventvalue"];
            [sub2Settings setValue:totalHour forKey:@"totalvalue"];
            //[self setNotifications];
            NSLog(@"Updated");
            
        }else {
            NSLog(@"Failed to Update");
            if(SQLITE_DONE != sqlite3_step(statement))
                NSLog(@"Error while updating. %s", sqlite3_errmsg(exerciseDB));
        }
        
        sqlite3_finalize(statement);
        
    }
    sqlite3_close(exerciseDB);
    [self setEventNotifications];
    [self setTotalNotifications];
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

-(void)setEventNotifications{
    NSArray *notifications = [[UIApplication sharedApplication]scheduledLocalNotifications];
    for (int m=0; m<[sub2EventsArray count]; m++) {
        BOOL isExist=NO;
        NSDictionary *event =[sub2EventsArray objectAtIndex:m];
        for (int k=0; k<[notifications count]; k++) {
            UILocalNotification *ntf = [notifications objectAtIndex:k];
            NSDictionary *userIn = ntf.userInfo;
            if ([userIn objectForKey:@"type"]) {
                if ([[userIn valueForKey:@"dayTime"] isEqualToString:[event valueForKey:@"dayTime"]]) {
                    UILocalNotification *notifi = [[UILocalNotification alloc]init];
                    NSDate *dte = [userIn valueForKey:@"date"];
                    notifi.alertBody = [event valueForKey:@"eventDescription"];
                    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
                    [dict setValue:dte forKey:@"date"];
                    NSString *eventValue = [sub2Settings valueForKey:@"eventvalue"];
                    NSArray *hrsArray = [eventValue componentsSeparatedByString:@":"];
                    int hours = [[hrsArray objectAtIndex:0]intValue];
                    int minutes = [[hrsArray objectAtIndex:1]intValue];
                    int totalMinutes = (hours*60)+minutes;
                    [dict setValue:eventValue forKey:@"eventvalue"];
                    [dict setValue:@"event" forKey:@"type"];
                    [dict setValue:[userIn valueForKey:@"dayTime"] forKey:@"dayTime"];
                    [dict setValue:[dte dateByAddingTimeInterval:-(totalMinutes*60)] forKey:@"fire"];
                    notifi.fireDate = [dte dateByAddingTimeInterval:-(totalMinutes*60)];
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
            notification.alertBody = [event valueForKey:@"eventDescription"];
            NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
            [dict setValue:date forKey:@"date"];
            NSString *eventValue = [sub2Settings valueForKey:@"eventvalue"];
            NSArray *hrsArray = [eventValue componentsSeparatedByString:@":"];
            int hours = [[hrsArray objectAtIndex:0]intValue];
            int minutes = [[hrsArray objectAtIndex:1]intValue];
            int totalMinutes = (hours*60)+minutes;
            [dict setValue:eventValue forKey:@"eventvalue"];
            [dict setValue:@"sub2event" forKey:@"type"];
            [dict setValue:dayTime forKey:@"dayTime"];
            [dict setValue:[date dateByAddingTimeInterval:-(totalMinutes*60)] forKey:@"fire"];
            notification.fireDate = [date dateByAddingTimeInterval:-(totalMinutes*60)];
            notification.userInfo = dict;
            [[UIApplication sharedApplication]scheduleLocalNotification:notification];
        }
    }
    
}

-(void)setTotalNotifications{
    NSArray *notifications = [[UIApplication sharedApplication]scheduledLocalNotifications];
    for (int m=0; m<[totalArray count]; m++) {
        BOOL isExist=NO;
        NSDictionary *event =[totalArray objectAtIndex:m];
        for (int k=0; k<[notifications count]; k++) {
            UILocalNotification *ntf = [notifications objectAtIndex:k];
            NSDictionary *userIn = ntf.userInfo;
            if ([userIn objectForKey:@"type"]) {
                if ([[userIn valueForKey:@"dayTime"] isEqualToString:[event valueForKey:@"date"]]) {
                    UILocalNotification *notifi = [[UILocalNotification alloc]init];
                    NSDateFormatter *fmtr = [[NSDateFormatter alloc]init];
                    [fmtr setDateFormat:@"yyyy-MM-dd HH:mm"];
                    NSDate *date = [fmtr dateFromString:[NSString stringWithFormat:@"%@ %@",[userIn valueForKey:@"dayTime"],[sub2Settings valueForKey:@"totalvalue"]]];
                    notifi.alertBody = [event valueForKey:@"total"];
                    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
                    [dict setValue:date forKey:@"date"];
                    NSString *eventValue = [sub2Settings valueForKey:@"totalvalue"];
                    [dict setValue:eventValue forKey:@"totalvalue"];
                    [dict setValue:@"sub2total" forKey:@"type"];
                    [dict setValue:[userIn valueForKey:@"dayTime"] forKey:@"dayTime"];
                    [dict setValue:date forKey:@"fire"];
                    notifi.fireDate = date;
                    notifi.userInfo = dict;
                    [[UIApplication sharedApplication] scheduleLocalNotification:notifi];
                    [[UIApplication sharedApplication]cancelLocalNotification:ntf];
                    isExist = YES;
                    break;
                }
            }
        }
        if (!isExist) {
            NSDateFormatter *fmtr = [[NSDateFormatter alloc]init];
            [fmtr setDateFormat:@"yyyy-MM-dd HH:mm"];
            NSDate *date = [fmtr dateFromString:[NSString stringWithFormat:@"%@ %@",[event valueForKey:@"date"],[sub2Settings valueForKey:@"totalvalue"]]];
            UILocalNotification *notification = [[UILocalNotification alloc]init];
            notification.alertBody = [event valueForKey:@"total"];
            NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
            [dict setValue:[event valueForKey:@"date"] forKey:@"dayTime"];
            [dict setValue:date forKey:@"date"];
            NSString *eventValue = [sub2Settings valueForKey:@"totalvalue"];
            [dict setValue:eventValue forKey:@"totalvalue"];
            [dict setValue:@"sub2total" forKey:@"type"];
            [dict setValue:date forKey:@"fire"];
            notification.fireDate = date;
            notification.userInfo = dict;
            [[UIApplication sharedApplication]scheduleLocalNotification:notification];
        }
    }
}



-(void)insertSettings {
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &exerciseDB) == SQLITE_OK)
    {
        NSString *insertSQL = [NSString stringWithFormat: @"INSERT INTO SUB2SETTINGS (eventvalue,totalvalue) VALUES (\"%@\",\"%@\")",whichHour,totalHour];
        
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
    [self setEventNotifications];
    [self setTotalNotifications];
}

-(IBAction)eventOnOff:(id)sender{
    if ([sender tag]==0) {
        eventView.hidden = YES;
        whichHour=[@"00:00" retain];
        totalView1.frame = CGRectMake(totalView1.frame.origin.x, 85, totalView1.frame.size.width, totalView1.frame.size.height);
        if (totalView.isHidden) {
            klarButton.frame = CGRectMake(klarButton.frame.origin.x, 185, klarButton.frame.size.width, klarButton.frame.size.height);
            background.frame = CGRectMake(background.frame.origin.x, background.frame.origin.y, background.frame.size.width, 225);
            [scrollVie setContentSize:CGSizeMake(320, 230)];
        }else{
            klarButton.frame = CGRectMake(klarButton.frame.origin.x, 385, klarButton.frame.size.width, klarButton.frame.size.height);
            totalView.frame = CGRectMake(totalView.frame.origin.x, 185, totalView.frame.size.width, totalView.frame.size.height);
            background.frame = CGRectMake(background.frame.origin.x, background.frame.origin.y, background.frame.size.width, 425);
            [scrollVie setContentSize:CGSizeMake(320, 445)];
        }
    }else{
        eventView.hidden = NO;
        totalView1.frame = CGRectMake(totalView1.frame.origin.x, 331, totalView1.frame.size.width, totalView1.frame.size.height);
        if (totalView.isHidden) {
            klarButton.frame = CGRectMake(klarButton.frame.origin.x, 425, klarButton.frame.size.width, klarButton.frame.size.height);
            background.frame = CGRectMake(background.frame.origin.x, background.frame.origin.y, background.frame.size.width, 460);
            [scrollVie setContentSize:CGSizeMake(320, 480)];
        }else{
            totalView.frame = CGRectMake(totalView.frame.origin.x, 421, totalView.frame.size.width, totalView.frame.size.height);
            klarButton.frame = CGRectMake(klarButton.frame.origin.x, 625, klarButton.frame.size.width, klarButton.frame.size.height);
            background.frame = CGRectMake(background.frame.origin.x, background.frame.origin.y, background.frame.size.width, 660);
            [scrollVie setContentSize:CGSizeMake(320, 680)];
        }
    }
}

-(IBAction)totalOnOff:(id)sender{
    if ([sender tag]==0) {
        totalView.hidden = YES;
        totalHour=[@"00:00" retain];
        if (eventView.isHidden) {
            totalView1.frame = CGRectMake(totalView1.frame.origin.x, 85, totalView1.frame.size.width, totalView1.frame.size.height);
            klarButton.frame = CGRectMake(klarButton.frame.origin.x, 185, klarButton.frame.size.width, klarButton.frame.size.height);
            background.frame = CGRectMake(background.frame.origin.x, background.frame.origin.y, background.frame.size.width, 225);
            [scrollVie setContentSize:CGSizeMake(320, 245)];
        }else{
            totalView1.frame = CGRectMake(totalView1.frame.origin.x, 331, totalView1.frame.size.width, totalView1.frame.size.height);
            klarButton.frame = CGRectMake(klarButton.frame.origin.x, 430, klarButton.frame.size.width, klarButton.frame.size.height);
            background.frame = CGRectMake(background.frame.origin.x, background.frame.origin.y, background.frame.size.width, 470);
            [scrollVie setContentSize:CGSizeMake(320, 490)];
        }
    }else{
        totalView.hidden = NO;
        if (eventView.isHidden) {
            totalView1.frame = CGRectMake(totalView1.frame.origin.x, 85, totalView1.frame.size.width, totalView1.frame.size.height);
            totalView.frame = CGRectMake(totalView.frame.origin.x, 185, totalView.frame.size.width, totalView.frame.size.height);
            klarButton.frame = CGRectMake(klarButton.frame.origin.x, 385, klarButton.frame.size.width, klarButton.frame.size.height);
            background.frame = CGRectMake(background.frame.origin.x, background.frame.origin.y, background.frame.size.width, 425);
            [scrollVie setContentSize:CGSizeMake(320, 445)];
        }else{
            totalView1.frame = CGRectMake(totalView1.frame.origin.x, 331, totalView1.frame.size.width, totalView1.frame.size.height);
            totalView.frame = CGRectMake(totalView.frame.origin.x, 430, totalView.frame.size.width, totalView.frame.size.height);
            klarButton.frame = CGRectMake(klarButton.frame.origin.x, 630, klarButton.frame.size.width, klarButton.frame.size.height);
            background.frame = CGRectMake(background.frame.origin.x, background.frame.origin.y, background.frame.size.width, 665);
            [scrollVie setContentSize:CGSizeMake(320, 685)];
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
                NSString *totalValue = [NSString stringWithFormat:@"%s",sqlite3_column_text(statement, 2)];
                sub2Settings = [[NSMutableDictionary alloc]init];
                [sub2Settings setValue:Id  forKey:@"id"];
                [sub2Settings setValue:value forKey:@"value"];
                [sub2Settings setValue:totalValue forKey:@"totalvalue"];
                whichHour = [value retain];
                totalHour = [totalValue retain];
            }
        }
        sqlite3_finalize(statement);
    }
    sqlite3_close(exerciseDB);
    if (![sub2Settings objectForKey:@"id"]) {
        whichHour = [@"00:00" retain];
        totalHour = [@"00:00" retain];
        eventView.hidden = YES;
        totalView.hidden = YES;
        totalView1.frame = CGRectMake(totalView1.frame.origin.x, 85, totalView1.frame.size.width, totalView1.frame.size.height);
        klarButton.frame = CGRectMake(klarButton.frame.origin.x, 185, klarButton.frame.size.width, klarButton.frame.size.height);
        background.frame = CGRectMake(background.frame.origin.x, background.frame.origin.y, background.frame.size.width, 225);
        scrollVie.contentSize = CGSizeMake(320, 230);
    }else{
        if ([whichHour isEqualToString:@"00:00"]) {
            eventView.hidden = YES;
            if ([totalHour isEqualToString:@"00:00"]) {
                totalView.hidden = YES;
                totalView1.frame = CGRectMake(totalView1.frame.origin.x, 85, totalView1.frame.size.width, totalView1.frame.size.height);
                klarButton.frame = CGRectMake(klarButton.frame.origin.x, 185, klarButton.frame.size.width, klarButton.frame.size.height);
                background.frame = CGRectMake(background.frame.origin.x, background.frame.origin.y, background.frame.size.width, 225);
                [scrollVie setContentSize:CGSizeMake(320, 245)];
            }else{
                totalView.hidden = NO;
                totalView1.frame = CGRectMake(totalView1.frame.origin.x, 85, totalView1.frame.size.width, totalView1.frame.size.height);
                totalView.frame = CGRectMake(totalView.frame.origin.x, 185, totalView.frame.size.width, totalView.frame.size.height);
                klarButton.frame = CGRectMake(klarButton.frame.origin.x, 385, klarButton.frame.size.width, klarButton.frame.size.height);
                background.frame = CGRectMake(background.frame.origin.x, background.frame.origin.y, background.frame.size.width, 425);
                [scrollVie setContentSize:CGSizeMake(320, 445)];
            }
        }else{
            eventView.hidden = NO;
            totalView1.frame = CGRectMake(totalView1.frame.origin.x, 331, totalView1.frame.size.width, totalView1.frame.size.height);
            if ([totalHour isEqualToString:@"00:00"]) {
                totalView.hidden = YES;
                klarButton.frame = CGRectMake(klarButton.frame.origin.x, 425, klarButton.frame.size.width, klarButton.frame.size.height);
                background.frame = CGRectMake(background.frame.origin.x, background.frame.origin.y, background.frame.size.width, 460);
                [scrollVie setContentSize:CGSizeMake(320, 480)];
            }else{
                totalView.hidden = NO;
                totalView.frame = CGRectMake(totalView.frame.origin.x, 421, totalView.frame.size.width, totalView.frame.size.height);
                klarButton.frame = CGRectMake(klarButton.frame.origin.x, 625, klarButton.frame.size.width, klarButton.frame.size.height);
                background.frame = CGRectMake(background.frame.origin.x, background.frame.origin.y, background.frame.size.width, 660);
                [scrollVie setContentSize:CGSizeMake(320, 680)];
            }
        }
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"HH:mm"];
    [eventPicker setDate:[formatter dateFromString:whichHour]];
    [totalPicker setDate:[formatter dateFromString:totalHour]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
