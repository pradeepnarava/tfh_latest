//
//  PlusveckaDinaveckarView.m
//  Välkommen till TFH-appen
//
//  Created by Brilliance Tech Sols on 7/21/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import "PlusveckaDinaveckarView.h"



#define kStartDate @"startDate"
#define kEndDate   @"endDate"
#define kStatus    @"status"
#define kDayTime   @"dayTime"
#define kEventDes  @"eventDes"
#define kSub2Id    @"Sub2Id"
#define kSub1Id    @"Sub1Id"

@interface PlusveckaDinaveckarView ()
@property (nonatomic, strong) NSString *currentDateBtn,*tabValue;
@property (nonatomic, strong) NSString *currentStatuBtn;
@end



@implementation PlusveckaDinaveckarView
@synthesize settingsView;
@synthesize dayView,raderaBtn;
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
@synthesize slider,sliderLabel,sub2Settings;
@synthesize dataArray;
@synthesize editIndexValue,buttonString;
@synthesize selectedDictionary;
@synthesize totalArray,dateIndexValue,editTotalValue,forslagController,tidigeraController;
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
    self.navigationItem.title=@"Planera en plusvecka";
    
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
    if (isPopup) {
        isPopup = NO;
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        eventDesTextView.text = [defaults valueForKey:@"eventDes"];
        [defaults removeObjectForKey:@"eventDes"];
        [defaults synchronize];
        ASDepthModalOptions style = ASDepthModalOptionAnimationGrow;
        [ASDepthModalViewController presentView:self.popupView
                                backgroundColor:nil
                                        options:style
                              completionHandler:^{
                                  NSLog(@"Modal view closed.");
                              }];
    }else{
    self.dataArray = [[NSMutableArray alloc]init];
    self.sub1EventsArray = [[NSMutableArray alloc]init];
    self.totalArray = [[NSMutableArray alloc]init];
   /* for (int i =0; i <[[self.scrollView subviews] count]; i++) {
        
        UIButton *btn = [[self.scrollView subviews] objectAtIndex:i];
        if ([btn isKindOfClass:[UIButton class]]) {
            [btn setTitle:@"" forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageNamed:@"kalendar_cell_empty.png"] forState:UIControlStateNormal];
        }
    }*/
    [self week:[selectedDictionary valueForKey:kStartDate]];
    [self getData];
    [self displayButton];
    [self getSub2SettingsData];
    }
    [super viewWillAppear:YES];
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
            }
        }
        sqlite3_finalize(statement);
    }
    sqlite3_close(exerciseDB);
}

-(void)displayButton {
    
    for (int i =0; i <[[self.scrollView subviews] count]; i++) {
        
        UIButton *btn = [[self.scrollView subviews] objectAtIndex:i];
        if ([btn isKindOfClass:[UIButton class]]) {
            NSMutableArray *layArray = [btn.layer.sublayers mutableCopy];
            for (CALayer *sublay in layArray) {
                if ([sublay.name isEqualToString:@"sub2"]) {
                    [sublay removeFromSuperlayer];
                }
            }
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
                        }else if ([[tempDict valueForKey:kStatus] isEqualToString:@"Neutral"]){
                            statusString = @"Neutral";
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
                        }else if ([[tempDict valueForKey:kStatus] isEqualToString:@"Neutral"]){
                            statusString = @"Neutral";
                        }
                        
                        [btn setTitle:[tempDict valueForKey:kEventDes] forState:UIControlStateNormal];
                    }
                }
            }
            CALayer *layer =[CALayer layer];
            CALayer *layer1 = [CALayer layer];
            layer.name = @"sub2";
            layer1.name = @"sub2";
            layer.backgroundColor = [UIColor colorWithRed:168.0f/255.0f green:168.0f/255.0f blue:168.0f/255.0f alpha:1.0].CGColor;
            layer.frame = CGRectMake(0, 0, 1, btn.frame.size.height);
            layer1.backgroundColor = [UIColor colorWithRed:168.0f/255.0f green:168.0f/255.0f blue:168.0f/255.0f alpha:1.0].CGColor;
            layer1.frame = CGRectMake(btn.frame.size.width-1, 0, 1, btn.frame.size.height);
            [btn.layer addSublayer:layer];
            [btn.layer addSublayer:layer1];
            if ([statusString isEqualToString:@"+"]) {
                [btn setBackgroundImage:[UIImage imageNamed:@"kalendar_cell_positive.png"] forState:UIControlStateNormal];
            }else if ([statusString isEqualToString:@"-"]){
                [btn setBackgroundImage:[UIImage imageNamed:@"kalendar_cell_negative.png"] forState:UIControlStateNormal];
            }else if ([statusString isEqualToString:@"Neutral"]){
                [btn setBackgroundImage:[UIImage imageNamed:@"kalendar_cell_emptycell_neutral.png"] forState:UIControlStateNormal];
            }else {
                [btn setBackgroundImage:[UIImage imageNamed:@"kalendar_cell_empty.png"] forState:UIControlStateNormal];
                [btn setTitle:@"" forState:UIControlStateNormal];
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
        
        NSString *querySQL1 = [NSString stringWithFormat: @"SELECT * FROM SUB1EVENT"];
        
        const char *query_stmt1 = [querySQL1 UTF8String];
        
        if (sqlite3_prepare_v2(exerciseDB, query_stmt1, -1, &statement, NULL) == SQLITE_OK)
        {
            
            while  (sqlite3_step(statement) == SQLITE_ROW) {
                NSString *subId = [NSString stringWithFormat:@"%s",sqlite3_column_text(statement,1)];
                NSString *startDate = [NSString stringWithFormat:@"%s",sqlite3_column_text(statement, 3)];
                NSString *endDate = [NSString stringWithFormat:@"%s",sqlite3_column_text(statement, 4)];
                NSString *status = [NSString stringWithFormat:@"%s",sqlite3_column_text(statement, 5)];
                NSString *daytime = [NSString stringWithFormat:@"%s",sqlite3_column_text(statement, 6)];
                NSString *eventDescription = [NSString stringWithFormat:@"%s",sqlite3_column_text(statement, 7)];
                
                NSMutableDictionary *itemDict = [[NSMutableDictionary alloc]init];
                [itemDict setValue:subId forKey:kSub1Id];
                [itemDict setValue:startDate forKey:kStartDate];
                [itemDict setValue:endDate forKey:kEndDate];
                [itemDict setValue:status forKey:kStatus];
                [itemDict setValue:daytime forKey:kDayTime];
                [itemDict setValue:eventDescription forKey:kEventDes];
                
                [sub1EventsArray addObject:itemDict];
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

-(IBAction)franTidigareAction:(id)sender{
    [ASDepthModalViewController dismiss];
    isPopup = YES;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        if ([[UIScreen mainScreen] bounds].size.height > 480) {
           // if (!tidigeraController) {
                tidigeraController = [[PlusveckaTidigeraViewController alloc] initWithNibName:@"PlusveckaTidigeraViewController" bundle:nil];
           // }
        }else{
           // if (!tidigeraController) {
                tidigeraController = [[PlusveckaTidigeraViewController alloc] initWithNibName:@"PlusveckaTidigeraViewController_iPhone4" bundle:nil];
           // }
        }
    }
    else{
       // if (!tidigeraController) {
            tidigeraController = [[PlusveckaTidigeraViewController alloc] initWithNibName:@"PlusveckaTidigeraViewController_iPad" bundle:nil];
       // }
    }
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:eventDesTextView.text forKey:@"eventDes"];
    [defaults synchronize];
    [self.navigationController pushViewController:tidigeraController animated:YES];
}

-(IBAction)franForslagAction:(id)sender{
    [ASDepthModalViewController dismiss];
    isPopup = YES;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        if ([[UIScreen mainScreen] bounds].size.height > 480) {
            //if (!forslagController) {
                forslagController = [[PlusveckaForslagViewController alloc] initWithNibName:@"PlusveckaForslagViewController" bundle:nil];
            //}
        }else{
            //if (!forslagController) {
                forslagController = [[PlusveckaForslagViewController alloc] initWithNibName:@"PlusveckaForslagViewController_iPhone4" bundle:nil];
            //}
        }
    }
    else{
        //if (!forslagController) {
            forslagController = [[PlusveckaForslagViewController alloc] initWithNibName:@"PlusveckaForslagViewController_iPad" bundle:nil];
        //}
    }
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:eventDesTextView.text forKey:@"eventDes"];
    [defaults synchronize];
    [self.navigationController pushViewController:forslagController animated:YES];
}

#pragma mark SettingViewController
-(void)settButtonClicked {
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
     if ([[UIScreen mainScreen] bounds].size.height > 480) {
     //if (!settingsView) {
         settingsView = [[PlusveckaSettingsView alloc] initWithNibName:@"PlusveckaSettingsView" bundle:nil];
     //}
     }else{
     //if (!settingsView) {
         settingsView = [[PlusveckaSettingsView alloc] initWithNibName:@"PlusveckaSettingsView_iPhone4" bundle:nil];
     //}
     }
     }
     else{
    // if (!settingsView) {
         settingsView = [[PlusveckaSettingsView alloc] initWithNibName:@"PlusveckaSettingsView_iPad" bundle:nil];
    // }
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
                raderaBtn.enabled = YES;
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
                raderaBtn.enabled = YES;
            }
            //        else {
            //            isExit = NO;
            //        }
        }
    }
    if (!isExit) {
        currentStatuBtn=@"Neutral";
        eventDesTextView.text = @"";
        hoursTextField1.text = [NSString stringWithFormat:@"%i",[subString intValue]-1];
        hoursTextField2.text = [NSString stringWithFormat:@"%i",[hoursTextField1.text intValue]+1];
        mintsTextField1.text = [NSString stringWithFormat:@"00"];
        mintsTextField2.text = [NSString stringWithFormat:@"00"];
        raderaBtn.enabled = NO;
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
    
    [self  databaseInsert];
    
}

-(IBAction)raderaButtonClicked:(id)sender {
    
    [ASDepthModalViewController dismiss];
    if (editIndexValue) {
        NSDictionary *deleDict = [dataArray objectAtIndex:[editIndexValue intValue]];
        [dataArray removeObject:deleDict];
        [self deleteRecord:deleDict];
    }
    editIndexValue = nil;
    [self displayButton];
    
}

-(IBAction)totalOkButtonAction:(id)sender{
    [ASDepthModalViewController dismiss];
    if (editTotalValue) {
        NSMutableDictionary *temp = [totalArray objectAtIndex:[editTotalValue intValue]];
        [temp setValue:[NSString stringWithFormat:@"%.0f",slider.value] forKey:@"total"];
        if ([sub2Settings objectForKey:@"id"]) {
            NSMutableArray *notifications = [[[UIApplication sharedApplication]scheduledLocalNotifications]mutableCopy];
            for (int k=0; k<[notifications count]; k++) {
                UILocalNotification *ntf = [notifications objectAtIndex:k];
                NSDictionary *userIn = ntf.userInfo;
                if ([userIn objectForKey:@"type"]) {
                    if ([[userIn valueForKey:@"dayTime"] isEqualToString:[temp valueForKey:@"date"]]) {
                        UILocalNotification *notifi = [[UILocalNotification alloc]init];
                        NSDateFormatter *fmtr = [[NSDateFormatter alloc]init];
                        [fmtr setDateFormat:@"yyyy-MM-dd HH:mm"];
                        NSDate *date = [fmtr dateFromString:[NSString stringWithFormat:@"%@ %@",[userIn valueForKey:@"dayTime"],[sub2Settings valueForKey:@"totalvalue"]]];
                        notifi.alertBody = [NSString stringWithFormat:@"%.0f",slider.value];
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
                        break;
                    }
                }
            }
        }
        [self databaseUpdateTotal:temp];
    }else {
        NSMutableDictionary *temp = [[NSMutableDictionary alloc] init];
        [temp setValue:[NSString stringWithFormat:@"%d",[totalArray count]+1] forKey:@"id"];
        [temp setValue:dateIndexValue forKey:@"date"];
        [temp setValue:[NSString stringWithFormat:@"%.0f",slider.value] forKey:@"total"];
        [totalArray addObject:temp];
        if ([sub2Settings objectForKey:@"id"]) {
            NSDateFormatter *fmtr = [[NSDateFormatter alloc]init];
            [fmtr setDateFormat:@"yyyy-MM-dd HH:mm"];
            NSDate *date = [fmtr dateFromString:[NSString stringWithFormat:@"%@ %@",dateIndexValue,[sub2Settings valueForKey:@"totalvalue"]]];
            UILocalNotification *notification = [[UILocalNotification alloc]init];
            notification.alertBody = [NSString stringWithFormat:@"%.0f",slider.value];
            NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
            [dict setValue:dateIndexValue forKey:@"dayTime"];
            [dict setValue:date forKey:@"date"];
            NSString *eventValue = [sub2Settings valueForKey:@"totalvalue"];
            [dict setValue:eventValue forKey:@"totalvalue"];
            [dict setValue:@"sub2total" forKey:@"type"];
            [dict setValue:date forKey:@"fire"];
            notification.fireDate = date;
            notification.userInfo = dict;
            [[UIApplication sharedApplication]scheduleLocalNotification:notification];
        }
        [self databaseInsertTotal:temp];
    }
    editTotalValue = nil;
    dateIndexValue = nil;
}

-(void)databaseInsertTotal:(NSDictionary *)dict{
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &exerciseDB) == SQLITE_OK)
    {
        NSString *insertSQL = [NSString stringWithFormat: @"INSERT INTO SUB2TOTAL (date,total) VALUES (\"%@\", \"%@\")",[dict valueForKey:@"date"],[dict valueForKey:@"total"]];
        
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
-(void)databaseUpdateTotal:(NSDictionary *)dict{
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &exerciseDB) == SQLITE_OK)
    {
        NSString *query=[NSString stringWithFormat:@"UPDATE SUB2TOTAL SET total='%@' WHERE id='%d'",[dict valueForKey:@"total"],[[dict valueForKey:@"id"]intValue]];
        
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

-(void)deleteRecord:(NSDictionary*)deleDic {
    
    if (sqlite3_open([databasePath UTF8String], &exerciseDB) == SQLITE_OK) {
        
        NSInteger subId = [[deleDic valueForKey:kSub2Id] integerValue];
        
        NSString *sql = [NSString stringWithFormat: @"DELETE FROM SUB2EVENT WHERE sub2Id='%d'",subId];
        
        const char *del_stmt = [sql UTF8String];
        
        sqlite3_prepare_v2(exerciseDB, del_stmt, -1, & statement, NULL);
        
        if (sqlite3_step(statement) == SQLITE_ROW) {
            
            NSLog(@"sss");
            
        }
        sqlite3_finalize(statement);
    }
    sqlite3_close(exerciseDB);
    
    NSArray *notifications = [[UIApplication sharedApplication]scheduledLocalNotifications];
    for (int k=0; k<[notifications count]; k++) {
        UILocalNotification *ntf = [notifications objectAtIndex:k];
        NSDictionary *userIn = ntf.userInfo;
        if ([userIn objectForKey:@"type"]) {
            if ([[userIn valueForKey:@"dayTime"] isEqualToString:[deleDic valueForKey:@"dayTime"]]) {
                [[UIApplication sharedApplication]cancelLocalNotification:ntf];
                break;
            }
        }
    }
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
            if ([sub2Settings objectForKey:@"id"]) {
                NSArray *notifications = [[UIApplication sharedApplication]scheduledLocalNotifications];
                for (int k=0; k<[notifications count]; k++) {
                    UILocalNotification *ntf = [notifications objectAtIndex:k];
                    NSDictionary *userIn = ntf.userInfo;
                    if ([userIn objectForKey:@"type"]) {
                        if ([[userIn valueForKey:@"dayTime"] isEqualToString:[dataDic valueForKey:@"dayTime"]]) {
                            UILocalNotification *notifi = [[UILocalNotification alloc]init];
                            NSDate *dte = [userIn valueForKey:@"date"];
                            notifi.alertBody = [dataDic valueForKey:@"eventDescription"];
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
                            break;
                        }
                    }
                }
            }
            [self updateIntDatabase:dataDic];
        }else {
            if ([sub2Settings objectForKey:@"id"]) {
                NSString *startDate = [dataDic valueForKey:@"startDate"];
                NSString *dayTime = [dataDic valueForKey:@"dayTime"];
                NSArray *arrr = [dayTime componentsSeparatedByString:@" "];
                NSString *buttonString1 = [NSString stringWithFormat:@"%@",[arrr objectAtIndex:0]];
                NSString *dateString = [NSString stringWithFormat:@"%@ %@",buttonString1,startDate];
                NSDateFormatter *fmtr = [[NSDateFormatter alloc]init];
                [fmtr setDateFormat:@"yyyy-MM-dd HH:mm"];
                NSDate *date = [fmtr dateFromString:dateString];
                UILocalNotification *notification = [[UILocalNotification alloc]init];
                notification.alertBody = [dataDic valueForKey:@"eventDescription"];
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
            //if (!dayView) {
                dayView = [[PlusveckaDayView alloc]initWithNibName:@"PlusveckaDayView" bundle:nil];
            //}
        }else{
            //if (!dayView) {
                dayView = [[PlusveckaDayView alloc]initWithNibName:@"PlusveckaDayView_iPhone4" bundle:nil];
            //}
        }
    }
    else{
        //if (!dayView) {
            dayView = [[PlusveckaDayView alloc]initWithNibName:@"PlusveckaDayView_iPad" bundle:nil];
        //}
    }
    dayView.sub2Settings = sub2Settings;
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
            currentStatuBtn = btn.currentTitle;
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
