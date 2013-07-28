//
//  PlusveckaDinaveckarView.m
//  Välkommen till TFH-appen
//
//  Created by Brilliance Tech Sols on 7/21/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import "PlusveckaDinaveckarView.h"

@interface PlusveckaDinaveckarView ()
@property (nonatomic, strong) NSString *currentDateBtn,*tabValue;
@property (nonatomic, strong) NSString *currentStatuBtn;
@end
#define kStartDate @"startDate"
#define kEndDate   @"endDate"
#define kStatus    @"status"
#define kDayTime   @"dayTime"
#define kEventDes  @"eventDes"
#define kSub2Id    @"Sub2Id"
@implementation PlusveckaDinaveckarView
@synthesize settingsView;
@synthesize dayView;
@synthesize scrollView;
@synthesize dateArray,weekdays,sub1EventsArray;
@synthesize week;
@synthesize monButton1,tueButton2,wedButton3,thrButton4,friButton5,satButton6,sunButton7;
@synthesize currentDateBtn;
@synthesize tabValue;
@synthesize popupView,totalView;
@synthesize currentStatuBtn;
@synthesize hoursTextField1,hoursTextField2;
@synthesize mintsTextField1,mintsTextField2;
@synthesize eventDesTextView;
@synthesize slider,sliderLabel;
@synthesize dataArray;
@synthesize editIndexValue,buttonString;
@synthesize selectedDictionary;
@synthesize totalArray;
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
    [super viewDidLoad];
    [self.scrollView setContentSize:CGSizeMake(320, 699)];
    self.navigationItem.title=@"Plusvecka";
    
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
    UIImage *image = [UIImage imageNamed:@"setting_alarm_button.png"];
    UIButton *okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [okBtn setFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
    [okBtn setBackgroundImage:image forState:UIControlStateNormal];
    [okBtn addTarget:self action:@selector(settButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem =  [[UIBarButtonItem alloc] initWithCustomView:okBtn];
    self.popupView.layer.cornerRadius = 12;
    self.popupView.layer.shadowOpacity = 0.7;
    self.popupView.layer.shadowOffset = CGSizeMake(6, 6);
    self.popupView.layer.shouldRasterize = YES;
    self.popupView.layer.rasterizationScale = [[UIScreen mainScreen] scale];
    self.totalView.layer.cornerRadius = 12;
    self.totalView.layer.shadowOpacity = 0.7;
    self.totalView.layer.shadowOffset = CGSizeMake(6, 6);
    self.totalView.layer.shouldRasterize = YES;
    self.totalView.layer.rasterizationScale = [[UIScreen mainScreen] scale];
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
        const char *sql_stmt = "CREATE TABLE IF NOT EXISTS sub2event (id INTEGER PRIMARY KEY AUTOINCREMENT,sub2Id TEXT,date TEXT,startDate TEXT,endDate TEXT,status TEXT,dayDate TEXT,eventDescription TEXT)";
        const char *sql_stmt1 = "CREATE TABLE IF NOT EXISTS sub2total (id INTEGER PRIMARY KEY AUTOINCREMENT,date TEXT,total TEXT)";
        
        if (sqlite3_exec(exerciseDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
        {
            NSLog(@"Failed to create database");
        }
        if (sqlite3_exec(exerciseDB, sql_stmt1, NULL, NULL, &errMsg)!=SQLITE_OK) {
            NSLog(@"Failed to create total database");
        }
        
        sqlite3_close(exerciseDB);
        
    } else {
        NSLog(@"Failed to open/create database");
    }
    

    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated{
    self.dataArray = [[NSMutableArray alloc]init];
    self.totalArray = [[NSMutableArray alloc]init];
    for (int i =0; i <[[self.scrollView subviews] count]; i++) {
        
        UIButton *btn = [[self.scrollView subviews] objectAtIndex:i];
        if ([btn isKindOfClass:[UIButton class]]) {
            [btn setTitle:@"" forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageNamed:@"kalendar_cell_empty.png"] forState:UIControlStateNormal];
        }
    }
    [self week:[selectedDictionary valueForKey:@"start"]];
    [self getData];
    [self displayButton];
    [super viewWillAppear:YES];
}

-(void)displayButton {
    
    for (int i =0; i <[[self.scrollView subviews] count]; i++) {
        
        UIButton *btn = [[self.scrollView subviews] objectAtIndex:i];
        if ([btn isKindOfClass:[UIButton class]]) {
            
            NSString *statusString = nil;
            NSDate *date=nil;
            NSString *btag = [NSString stringWithFormat:@"%i",btn.tag];
            NSString *subString1 =  [btag substringFromIndex:1];
            NSString *subString = [subString1 substringToIndex:subString1.length-1];
            NSString *whichString = [subString1 substringFromIndex:subString1.length-1];
            
            NSString *s = [NSString stringWithFormat:@"%c",[btag characterAtIndex:0]];
            if ([s intValue] == 1) {
                date = [self.weekdays objectAtIndex:0];
                
            }else if ([s intValue] == 2) {
                date = [self.weekdays objectAtIndex:1];
                
            }else if ([s intValue] == 3){
                date = [self.weekdays objectAtIndex:2];
                
            }else if ([s intValue] == 4) {
                date = [self.weekdays objectAtIndex:3];
                
            }else if ([s intValue] == 5) {
                date = [self.weekdays objectAtIndex:4];
                
            }else if ([s intValue] == 6) {
                date = [self.weekdays objectAtIndex:5];
                
            }else if ([s intValue] == 7) {
                date = [self.weekdays objectAtIndex:6];
            }
            
            NSArray *tm = [[self dateFromString:date] componentsSeparatedByString:@" "];
            if ([whichString isEqualToString:@"1"]) {
                for (int g =0; g<[sub1EventsArray count]; g++) {
                    NSMutableDictionary *tempDict = [sub1EventsArray objectAtIndex:g];
                    if ([[tempDict valueForKey:kDayTime] isEqualToString:[NSString stringWithFormat:@"%@ %i",[tm objectAtIndex:0],[subString intValue]]]){
                        
                        if ([[tempDict valueForKey:kStatus] isEqualToString:@"+"]){
                            statusString = @"+";
                        }else if ([[tempDict valueForKey:kStatus] isEqualToString:@"-"]){
                            statusString = @"-";
                        }else if ([[tempDict valueForKey:kStatus] isEqualToString:@"N"]){
                            statusString = @"N";
                        }
                        
                        [btn setTitle:[tempDict valueForKey:kEventDes] forState:UIControlStateNormal];
                    }
                }
            }else{
                for (int g =0; g<[dataArray count]; g++) {
                    NSMutableDictionary *tempDict = [dataArray objectAtIndex:g];
                    if ([[tempDict valueForKey:kDayTime] isEqualToString:[NSString stringWithFormat:@"%@ %i",[tm objectAtIndex:0],[subString intValue]]]){
                        
                        if ([[tempDict valueForKey:kStatus] isEqualToString:@"+"]){
                            statusString = @"+";
                        }else if ([[tempDict valueForKey:kStatus] isEqualToString:@"-"]){
                            statusString = @"-";
                        }else if ([[tempDict valueForKey:kStatus] isEqualToString:@"N"]){
                            statusString = @"N";
                        }
                        
                        [btn setTitle:[tempDict valueForKey:kEventDes] forState:UIControlStateNormal];
                    }
                }
            }
            if ([statusString isEqualToString:@"+"]) {
                [btn setBackgroundImage:[UIImage imageNamed:@"kalendar_cell_positive.png"] forState:UIControlStateNormal];
            }else if ([statusString isEqualToString:@"-"]){
                [btn setBackgroundImage:[UIImage imageNamed:@"kalendar_cell_negative.png"] forState:UIControlStateNormal];
            }else if ([statusString isEqualToString:@"N"]){
                [btn setBackgroundImage:[UIImage imageNamed:@"kalendar_cell_emptycell_neutral.png"] forState:UIControlStateNormal];
            }else {
                //[btn setBackgroundImage:[UIImage imageNamed:@"kalendar_cell_empty.png"] forState:UIControlStateNormal];
                //[btn setTitle:@"" forState:UIControlStateNormal];
            }
        }
    }
}

-(void)getData{
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &exerciseDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat: @"SELECT * FROM SUB2EVENT"];
        
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(exerciseDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            
            while  (sqlite3_step(statement) == SQLITE_ROW) {
                NSString *subId = [NSString stringWithFormat:@"%s",sqlite3_column_text(statement,1)];
                NSString *startDate = [NSString stringWithFormat:@"%s",sqlite3_column_text(statement, 3)];
                NSString *endDate = [NSString stringWithFormat:@"%s",sqlite3_column_text(statement, 4)];
                NSString *status = [NSString stringWithFormat:@"%s",sqlite3_column_text(statement, 5)];
                NSString *daytime = [NSString stringWithFormat:@"%s",sqlite3_column_text(statement, 6)];
                NSString *eventDescription = [NSString stringWithFormat:@"%s",sqlite3_column_text(statement, 7)];
                
                NSMutableDictionary *itemDict = [[NSMutableDictionary alloc]init];
                [itemDict setValue:subId forKey:kSub2Id];
                [itemDict setValue:startDate forKey:kStartDate];
                [itemDict setValue:endDate forKey:kEndDate];
                [itemDict setValue:status forKey:kStatus];
                [itemDict setValue:daytime forKey:kDayTime];
                [itemDict setValue:eventDescription forKey:kEventDes];
                
                [dataArray addObject:itemDict];
            }
        }
        sqlite3_finalize(statement);
    }
    sqlite3_close(exerciseDB);
    [self getTotal];
}

-(void)getTotal{
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &exerciseDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat: @"SELECT * FROM SUB2TOTAL"];
        
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(exerciseDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            
            while  (sqlite3_step(statement) == SQLITE_ROW) {
                NSString *totalid = [NSString stringWithFormat:@"%d",sqlite3_column_int(statement,0)];
                NSString *date = [NSString stringWithFormat:@"%s",sqlite3_column_text(statement, 1)];
                NSString *total = [NSString stringWithFormat:@"%s",sqlite3_column_text(statement, 2)];
                
                NSMutableDictionary *itemDict = [[NSMutableDictionary alloc]init];
                [itemDict setValue:totalid forKey:@"id"];
                [itemDict setValue:date forKey:@"date"];
                [itemDict setValue:total forKey:@"total"];
                
                [totalArray addObject:itemDict];
            }
        }
        sqlite3_finalize(statement);
    }
    sqlite3_close(exerciseDB);
}

- (void)week:(NSDate *)_date {
    self.week = _date;
    
    self.weekdays = [[NSMutableArray alloc] init];
    
    for (int i =0; i < 7; i++)
    {
        NSDateComponents *comps1 = [[NSDateComponents alloc] init];
        [comps1 setMonth:0];
        [comps1 setDay:+i];
        [comps1 setHour:0];
        NSCalendar *calendar1 = [NSCalendar currentCalendar];
        NSDate *newDate1 = [calendar1 dateByAddingComponents:comps1 toDate:_date options:0];
        [self.weekdays addObject:newDate1];
    }
	[self updateScreens];
    //self.mainWeekLabel.text = [self titleText];
}
-(void)backButon {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark SettingViewController
-(void)settButtonClicked {
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
     if ([[UIScreen mainScreen] bounds].size.height > 480) {
     if (!settingsView) {
         settingsView = [[PlusveckaSettingsView alloc] initWithNibName:@"PlusveckaSettingsView" bundle:nil];
     }
     }else{
     if (!settingsView) {
         settingsView = [[PlusveckaSettingsView alloc] initWithNibName:@"PlusveckaSettingsView_iPhone4" bundle:nil];
     }
     }
     }
     else{
     if (!settingsView) {
         settingsView = [[PlusveckaSettingsView alloc] initWithNibName:@"PlusveckaSettingsView_iPad" bundle:nil];
     }
     }
     
     [self.navigationController pushViewController:settingsView animated:YES];
}




-(void)updateScreens {
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init]autorelease];
    NSArray *weekdaySymbols = [dateFormatter shortWeekdaySymbols];
    
	for (int i =0; i < [self.weekdays count]; i++) {
        
        NSDate *date = [self.weekdays objectAtIndex:i];
		
        NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateComponents *weekdayComponents =[gregorian components:NSWeekdayCalendarUnit fromDate:date];
        NSInteger weekday = [weekdayComponents weekday];
        [gregorian release];
        NSString *weeday =[weekdaySymbols objectAtIndex:weekday-1];
        
        switch (i) {
            case 0:
                [monButton1 setTitle:weeday forState:UIControlStateNormal];
                break;
            case 1:
                [tueButton2 setTitle:weeday forState:UIControlStateNormal];
                break;
            case 2:
                [wedButton3 setTitle:weeday forState:UIControlStateNormal];
                break;
            case 3:
                [thrButton4 setTitle:weeday forState:UIControlStateNormal];
                break;
            case 4:
                [friButton5 setTitle:weeday forState:UIControlStateNormal];
                break;
            case 5:
                [satButton6 setTitle:weeday forState:UIControlStateNormal];
                break;
            case 6:
                [sunButton7 setTitle:weeday forState:UIControlStateNormal];
                break;
            default:
                break;
        }
    }
}


-(NSString*)dateFromString:(NSDate*)date {
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}

-(IBAction)emptyCell:(id)sender {
    UIButton *btn = (UIButton*)sender;
    NSDate *date=nil;
    NSString *btag = [NSString stringWithFormat:@"%i",btn.tag];
    NSString *subString1 =  [btag substringFromIndex:1];
    NSString *subString = [subString1 substringToIndex:subString1.length-1];
    NSString *whichString = [subString1 substringFromIndex:subString1.length-1];
    
    
    NSString *s = [NSString stringWithFormat:@"%c",[btag characterAtIndex:0]];
    if ([s intValue] == 1) {
        date = [self.weekdays objectAtIndex:0];
        
    }else if ([s intValue] == 2) {
        date = [self.weekdays objectAtIndex:1];
        
    }else if ([s intValue] == 3){
        date = [self.weekdays objectAtIndex:2];
        
    }else if ([s intValue] == 4) {
        date = [self.weekdays objectAtIndex:3];
        
    }else if ([s intValue] == 5) {
        date = [self.weekdays objectAtIndex:4];
        
    }else if ([s intValue] == 6) {
        date = [self.weekdays objectAtIndex:5];
        
    }else if ([s intValue] == 7) {
        date = [self.weekdays objectAtIndex:6];
    }
    NSArray *tm = [[self dateFromString:date] componentsSeparatedByString:@" "];
    buttonString = [[tm objectAtIndex:0] retain];
    BOOL isExit = NO;
    if ([whichString isEqualToString:@"1"]) {
        for (int g =0; g<[sub1EventsArray count]; g++) {
            NSMutableDictionary *temp = [sub1EventsArray objectAtIndex:g];
            if ([[temp valueForKey:kDayTime] isEqualToString:[NSString stringWithFormat:@"%@ %i",[tm objectAtIndex:0],[subString intValue]]]) {
                editIndexValue = [[NSString stringWithFormat:@"%i",g] retain];
                NSArray *sDA = [[temp valueForKey:kStartDate] componentsSeparatedByString:@":"];
                NSArray *eDA = [[temp valueForKey:kEndDate] componentsSeparatedByString:@":"];
                eventDesTextView.text = [temp valueForKey:kEventDes];
                hoursTextField1.text = [NSString stringWithFormat:@"%i",[[sDA objectAtIndex:0] intValue]];
                hoursTextField2.text = [NSString stringWithFormat:@"%i",[[eDA objectAtIndex:0] intValue]];
                mintsTextField1.text = [NSString stringWithFormat:@"%@",[sDA objectAtIndex:1]];
                mintsTextField2.text = [NSString stringWithFormat:@"%@",[eDA objectAtIndex:1]];
                isExit = YES;
            }
            //            else {
            //                isExit = NO;
            //            }
        }
    }else{
        for (int q= 0; q<[dataArray count]; q++) {
            NSMutableDictionary *temp = [dataArray objectAtIndex:q];
            if ([[temp valueForKey:kDayTime] isEqualToString:[NSString stringWithFormat:@"%@ %i",[tm objectAtIndex:0],[subString intValue]]]) {
                editIndexValue = [[NSString stringWithFormat:@"%i",q] retain];
                NSArray *sDA = [[temp valueForKey:kStartDate] componentsSeparatedByString:@":"];
                NSArray *eDA = [[temp valueForKey:kEndDate] componentsSeparatedByString:@":"];
                eventDesTextView.text = [temp valueForKey:kEventDes];
                hoursTextField1.text = [NSString stringWithFormat:@"%i",[[sDA objectAtIndex:0] intValue]];
                hoursTextField2.text = [NSString stringWithFormat:@"%i",[[eDA objectAtIndex:0] intValue]];
                mintsTextField1.text = [NSString stringWithFormat:@"%@",[sDA objectAtIndex:1]];
                mintsTextField2.text = [NSString stringWithFormat:@"%@",[eDA objectAtIndex:1]];
                isExit = YES;
            }
            //        else {
            //            isExit = NO;
            //        }
        }
    }
    if (!isExit) {
        eventDesTextView.text = @"";
        hoursTextField1.text = [NSString stringWithFormat:@"%i",[subString intValue]-1];
        hoursTextField2.text = [NSString stringWithFormat:@"%i",[hoursTextField1.text intValue]+1];
        mintsTextField1.text = [NSString stringWithFormat:@"00"];
        mintsTextField2.text = [NSString stringWithFormat:@"00"];
    }
    ASDepthModalOptions style = ASDepthModalOptionAnimationGrow;
    [ASDepthModalViewController presentView:self.popupView
                            backgroundColor:nil
                                    options:style
                          completionHandler:^{
                              NSLog(@"Modal view closed.");
                          }];
}

-(IBAction)closeButtonClicked:(id)sender
{
    [ASDepthModalViewController dismiss];
}

-(IBAction)okButtonClicked:(id)sender
{
    [ASDepthModalViewController dismiss];
    /*
    if (editIndexValue) {
        NSMutableDictionary *temp = [dataArray objectAtIndex:[editIndexValue intValue]];
        NSString *startDate = [NSString stringWithFormat:@"%@:%@",hoursTextField1.text,mintsTextField1.text];
        NSString *endDate =[NSString stringWithFormat:@"%@:%@",hoursTextField2.text,mintsTextField2.text];
        NSString *dayTime = [NSString stringWithFormat:@"%@ %i",buttonString,[hoursTextField1.text intValue]+1];
        
        if(!currentStatuBtn)
            currentStatuBtn = [temp valueForKey:kStatus];
        [temp setValue:eventDesTextView.text forKey:kEventDes];
        [temp setValue:startDate forKey:kStartDate];
        [temp setValue:endDate forKey:kEndDate];
        [temp setValue:dayTime forKey:kDayTime];
        [temp setValue:currentStatuBtn forKey:kStatus];
    }else {
        NSMutableDictionary *temp = [[NSMutableDictionary alloc] init];
        NSString *startDate = [NSString stringWithFormat:@"%@:%@",hoursTextField1.text,mintsTextField1.text];
        NSString *endDate =[NSString stringWithFormat:@"%@:%@",hoursTextField2.text,mintsTextField2.text];
        NSString *dayTime = [NSString stringWithFormat:@"%@ %i",buttonString,[hoursTextField1.text intValue]+1];
        [temp setValue:[NSNumber numberWithInt:[dataArray count]+1] forKey:kSub2Id];
        [temp setValue:eventDesTextView.text forKey:kEventDes];
        [temp setValue:startDate forKey:kStartDate];
        [temp setValue:endDate forKey:kEndDate];
        [temp setValue:dayTime forKey:kDayTime];
        [temp setValue:currentStatuBtn forKey:kStatus];
        [dataArray addObject:temp];
    }
    editIndexValue = nil;
    
    [self displayButton];
    
    [self  databaseInsert];*/
    
}

-(IBAction)totalOkButtonAction:(id)sender{
    [ASDepthModalViewController dismiss];
    
}

#pragma mark -- DataBase Methods

- (BOOL)findContact:(NSNumber*)questionId
{
    const char *dbpath = [databasePath UTF8String];
    
    BOOL isFind = NO;
    
    if (sqlite3_open(dbpath, &exerciseDB) == SQLITE_OK)
    {
        
        NSInteger sub2ID = [questionId integerValue];
        
        NSString *querySQL = [NSString stringWithFormat: @"SELECT sub2Id FROM SUB2EVENT WHERE subId=\"%d\"", sub2ID];
        
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(exerciseDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                isFind  = YES;
                
            } else {
                isFind  =  NO;
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(exerciseDB);
    }
    
    return isFind;
}

-(void)updateIntDatabase:(NSDictionary*)recordsDic {
    
    NSDateFormatter* formatter = [[[NSDateFormatter alloc] init] autorelease];
    [formatter setDateFormat:@"MMM d YYYY HH:mm:ss"];
    NSString* str = [formatter stringFromDate:[NSDate date]];
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &exerciseDB) == SQLITE_OK)
    {
        NSInteger subId = [[recordsDic valueForKey:kSub2Id] integerValue];
        
        NSString *query=[NSString stringWithFormat:@"UPDATE SUB2EVENT SET date='%@', startDate='%@', endDate='%@', status='%@', dayDate='%@', eventDescription='%@' WHERE sub2Id='%d'",str, [recordsDic valueForKey:kStartDate],[recordsDic valueForKey:kEndDate],[recordsDic valueForKey:kStatus],[recordsDic valueForKey:kDayTime],[recordsDic valueForKey:kEventDes],subId];
        
        const char *del_stmt = [query UTF8String];
        
        sqlite3_prepare_v2(exerciseDB, del_stmt, -1, &statement, NULL);
        
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
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



-(void)insertIntoDatabase:(NSDictionary*)recordDic {
    
    NSDateFormatter* formatter = [[[NSDateFormatter alloc] init] autorelease];
    [formatter setDateFormat:@"MMM d YYYY HH:mm:ss"];
    NSString* str = [formatter stringFromDate:[NSDate date]];
    
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &exerciseDB) == SQLITE_OK)
    {
        NSInteger subId = [[recordDic valueForKey:kSub2Id] integerValue];
        
        NSString *insertSQL = [NSString stringWithFormat: @"INSERT INTO SUB2EVENT (sub2Id,date,startDate,endDate,status,dayDate,eventDescription) VALUES (\"%d\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\")",subId,str,[recordDic valueForKey:kStartDate],[recordDic valueForKey:kEndDate],[recordDic valueForKey:kStatus],[recordDic valueForKey:kDayTime],[recordDic valueForKey:kEventDes]];
        
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
}



-(void)databaseInsert {
    
    for (int i = 0; i < [dataArray count]; i++) {
        
        NSDictionary *dataDic = [dataArray objectAtIndex:i];
        
        if ([self findContact:[dataDic valueForKey:kSub2Id]]) {
            NSLog(@"Updating");
            [self updateIntDatabase:dataDic];
        }else {
            NSLog(@"New Record");
            [self insertIntoDatabase:dataDic];
        }
    }
}

#pragma mark TotalButtonClicked

-(IBAction)totalButtonClicked:(id)sender
{
    NSString *str = [self dateFromString:[self.weekdays objectAtIndex:[sender tag]]];
    NSArray *array =[str componentsSeparatedByString:@" "];
    NSString *dateStr =[array objectAtIndex:0];
    BOOL isExist = NO;
    for (int k=0; k<[totalArray count]; k++) {
        NSDictionary *dict = [totalArray objectAtIndex:k];
        if ([[dict valueForKey:@"date"] isEqualToString:dateStr]) {
            isExist = YES;
            slider.value = [[dict valueForKey:@"total"]intValue];
            sliderLabel.text=[dict valueForKey:@"total"];
        }
    }
    if (!isExist) {
        slider.value = 0;
        sliderLabel.text=@"0";
    }
    ASDepthModalOptions style = ASDepthModalOptionAnimationGrow;
    [ASDepthModalViewController presentView:self.totalView
                            backgroundColor:nil
                                    options:style
                          completionHandler:^{
                              
                          }];
}

-(IBAction)sliderValueChanged:(UISlider*)sender{
    sliderLabel.text = [NSString stringWithFormat:@"%.0f",[sender value]];
}

#pragma mark Calendar Day Button Clicked
-(IBAction)calendarDayCellClicked:(id)sender
{
    NSString *btnTag = [NSString stringWithFormat:@"%d",[sender tag]];
    NSString *index = [btnTag substringFromIndex:btnTag.length-1];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        if ([[UIScreen mainScreen] bounds].size.height > 480) {
            if (!dayView) {
                dayView = [[PlusveckaDayView alloc]initWithNibName:@"PlusveckaDayView" bundle:nil];
            }
        }else{
            if (!dayView) {
                dayView = [[PlusveckaDayView alloc]initWithNibName:@"PlusveckaDayView_iPhone4" bundle:nil];
            }
        }
    }
    else{
        if (!dayView) {
            dayView = [[PlusveckaDayView alloc]initWithNibName:@"PlusveckaDayView_iPad" bundle:nil];
        }
    }
    dayView.sub1EventsArray = sub1EventsArray;
    dayView.dataArray = dataArray;
    dayView.totalArray = totalArray;
    dayView.selectedDate = [self.weekdays objectAtIndex:[index intValue]];
    dayView.isDinackar = YES;
    [self.navigationController pushViewController:dayView animated:YES];
    
}


-(IBAction)statusButtonClicked:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    switch (btn.tag) {
        case 1:
            currentStatuBtn = btn.currentTitle;
            break;
        case 2:
            currentStatuBtn = @"N";
            break;
        case 3:
            currentStatuBtn = btn.currentTitle;
            break;
        default:
            break;
    }
}

#pragma mark UITextField Delegate Methods

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    [self.popupView setFrame:CGRectMake(self.popupView.frame.origin.x, self.popupView.frame.origin.y - 120, self.popupView.frame.size.width, self.popupView.frame.size.height)];
}


-(void)textFieldDidEndEditing:(UITextField *)textField {
    [self.popupView setFrame:CGRectMake(self.popupView.frame.origin.x, self.popupView.frame.origin.y + 120, self.popupView.frame.size.width, self.popupView.frame.size.height)];
}

-(void)textViewDidEndEditing:(UITextView *)textView {
    
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
    }
    else {
        return YES;
    }
    return 0;
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    [textField addTarget:self action:@selector(changeText:) forControlEvents:UIControlEventEditingChanged];
    return YES;
}


-(void)changeText:(UITextField*)textField {
    
    if (textField == hoursTextField1) {
        if ([textField.text length] > 24) {
            hoursTextField2.text = @"";
        }
        else {
            int h1 = [textField.text integerValue];
            h1 += 1;
            hoursTextField2.text = [NSString stringWithFormat:@"%i",h1];
        }
    }
    if (textField == mintsTextField1) {
        mintsTextField2.text = mintsTextField1.text;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
