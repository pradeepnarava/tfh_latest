    //
//  CalendarViewController.m
//  Välkommen till TFH-appen
//
//  Created by Chandrika on 12/07/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import "CalendarViewController.h"
#import "SettingRegistViewController.h"
#import "ASDepthModalViewController.h"

#define kStartDate @"startDate"
#define kEndDate   @"endDate"
#define kStatus    @"status"
#define kDayTime   @"dayTime"
#define kEventDes  @"eventDes"
#define kSub1Id    @"Sub1Id"

#define DATE_COMPONENTS (NSYearCalendarUnit| NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekCalendarUnit |  NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSWeekdayCalendarUnit | NSWeekdayOrdinalCalendarUnit)
#define CURRENT_CALENDAR [NSCalendar currentCalendar]

static const unsigned int DAYS_IN_WEEK                        = 7;




@interface CalendarViewController ()

@property (nonatomic, strong) NSString *currentStatuBtn;
@property (nonatomic, strong) NSString *tabValue;




@end

@implementation CalendarViewController
@synthesize dayView;
@synthesize scrollView;
@synthesize settingRegViewCntrl;
//@synthesize monLabel1,tueLabel2,wedLabel3,thrLabel4,friLabel5,satLabel6,sunLabel7;
@synthesize monButton1,tueButton2,wedButton3,thrButton4,friButton5,satButton6,sunButton7;
@synthesize dataArray,weekdays,week;
//@synthesize mainWeekLabel;
@synthesize popupView,totalView;
@synthesize hoursTextField1,hoursTextField2;
@synthesize mintsTextField1,mintsTextField2;
@synthesize eventDesTextView;
@synthesize currentStatuBtn;
@synthesize tabValue;
@synthesize slider,sliderLabel;
@synthesize isEventNotify,isTotalNotify;

/////////////////////////***************************///////////
@synthesize buttonString;
@synthesize editIndexValue;




- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.scrollView setContentSize:CGSizeMake(320, 699)];
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
    
    [self week:[NSDate date]];
    
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
        const char *sql_stmt = "CREATE TABLE IF NOT EXISTS SUB1EVENT (id INTEGER PRIMARY KEY AUTOINCREMENT,subId TEXT,date TEXT,startDate TEXT,endDate TEXT,status TEXT,dayDate TEXT,eventDescription TEXT)";
        const char *sql_stmt1 = "CREATE TABLE IF NOT EXISTS sub1total (id INTEGER PRIMARY KEY AUTOINCREMENT,date TEXT,total TEXT)";
        
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
    
    self.dataArray = [[NSMutableArray alloc]init];
    
    [self getData];
    
    [self displayButton];
    
    if (isEventNotify) {
        tabValue = @"0";
    }
    if (isTotalNotify) {
        tabValue = @"0";
    }
}




-(void)displayButton {
    
    NSLog(@"%@",dataArray);
    for (int i =0; i <[[self.scrollView subviews] count]; i++) {
        
        UIButton *btn = [[self.scrollView subviews] objectAtIndex:i];
        if ([btn isKindOfClass:[UIButton class]]) {
            
            NSString *statusString = nil;
            NSDate *date=nil;
            NSString *btag = [NSString stringWithFormat:@"%i",btn.tag];
            NSString *subString =  [btag substringFromIndex:1];

            NSString *s = [NSString stringWithFormat:@"%c",[btag characterAtIndex:0]];
           
            NSLog(@"s is %@ jlkhlkjhlk  **********  %@",s,subString);
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
            //NSLog(@"DISPLAY BUTTONS IS %@",dataArray);
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



-(IBAction)empty:(id)sender {
    
    
    UIButton *btn = (UIButton*)sender;
    NSDate *date=nil;
    date = [self.weekdays objectAtIndex:0];
    
    NSString *btag = [NSString stringWithFormat:@"%i",btn.tag];
    NSString *subString =  [btag substringFromIndex:1];
    
    NSArray *tm = [[self dateFromString:date] componentsSeparatedByString:@" "];
    
    buttonString = [[tm objectAtIndex:0] retain];
    BOOL isExit;
    for (int q= 0; q<[dataArray count]; q++) {
        NSMutableDictionary *temp = [dataArray objectAtIndex:q];
        NSLog(@"tempDict %@ date %@ tag is %i",[temp valueForKey:kDayTime],[tm objectAtIndex:0],[btn tag]);
        if ([[temp valueForKey:kDayTime] isEqualToString:[NSString stringWithFormat:@"%@ %i",[tm objectAtIndex:0],[subString intValue]]]) {
            editIndexValue = [[NSString stringWithFormat:@"%i",q] retain];
            NSArray *sDA = [[temp valueForKey:kStartDate] componentsSeparatedByString:@":"];
            NSArray *eDA = [[temp valueForKey:kEndDate] componentsSeparatedByString:@":"];
            eventDesTextView.text = [temp valueForKey:kEventDes];
            hoursTextField1.text = [NSString stringWithFormat:@"%i",[[sDA objectAtIndex:0] intValue]];
            hoursTextField2.text = [NSString stringWithFormat:@"%i",[[eDA objectAtIndex:0] intValue]];
            isExit = YES;
        }
        else {
            isExit = NO;
        }
    }
    if (!isExit) {
        eventDesTextView.text = @"";
        hoursTextField1.text = [NSString stringWithFormat:@"%i",[subString intValue]-1];
        hoursTextField2.text = [NSString stringWithFormat:@"%i",[hoursTextField1.text intValue]+1];
    }
    ASDepthModalOptions style = ASDepthModalOptionAnimationGrow;
    [ASDepthModalViewController presentView:self.popupView
                            backgroundColor:nil
                                    options:style
                          completionHandler:^{
                              NSLog(@"Modal view closed.");
                          }];
    
}

-(IBAction)empty1:(id)sender {
    
    UIButton *btn = (UIButton*)sender;
    NSDate *date=nil;
    date = [self.weekdays objectAtIndex:1];
    
    NSString *btag = [NSString stringWithFormat:@"%i",btn.tag];
    NSString *subString =  [btag substringFromIndex:1];
    
    
    NSArray *tm = [[self dateFromString:date] componentsSeparatedByString:@" "];
    
    buttonString = [[tm objectAtIndex:0] retain];
    BOOL isExit;
    for (int q= 0; q<[dataArray count]; q++) {
        NSMutableDictionary *temp = [dataArray objectAtIndex:q];
        NSLog(@"tempDict %@ date %@ tag is %i",[temp valueForKey:kDayTime],[tm objectAtIndex:0],[subString intValue]);
        if ([[temp valueForKey:kDayTime] isEqualToString:[NSString stringWithFormat:@"%@ %i",[tm objectAtIndex:0],[subString intValue]]]) {
            editIndexValue = [[NSString stringWithFormat:@"%i",q] retain];
            NSArray *sDA = [[temp valueForKey:kStartDate] componentsSeparatedByString:@":"];
            NSArray *eDA = [[temp valueForKey:kEndDate] componentsSeparatedByString:@":"];
            eventDesTextView.text = [temp valueForKey:kEventDes];
            hoursTextField1.text = [NSString stringWithFormat:@"%i",[[sDA objectAtIndex:0] intValue]];
            hoursTextField2.text = [NSString stringWithFormat:@"%i",[[eDA objectAtIndex:0] intValue]];
            isExit = YES;
        }else {
            isExit = NO;
        }
    }
    if (!isExit) {
        eventDesTextView.text = @"";
        hoursTextField1.text = [NSString stringWithFormat:@"%i",[subString intValue]-1];
        hoursTextField2.text = [NSString stringWithFormat:@"%i",[hoursTextField1.text intValue]+1];
    }
    ASDepthModalOptions style = ASDepthModalOptionAnimationGrow;
    [ASDepthModalViewController presentView:self.popupView
                            backgroundColor:nil
                                    options:style
                          completionHandler:^{
                              NSLog(@"Modal view closed.");
                          }];
    
}


-(IBAction)empty2:(id)sender {
    UIButton *btn = (UIButton*)sender;
    NSDate *date=nil;
    date = [self.weekdays objectAtIndex:2];
    
    NSString *btag = [NSString stringWithFormat:@"%i",btn.tag];
    NSString *subString =  [btag substringFromIndex:1];
    
    NSArray *tm = [[self dateFromString:date] componentsSeparatedByString:@" "];
    
    buttonString = [[tm objectAtIndex:0] retain];
    BOOL isExit;
    for (int q= 0; q<[dataArray count]; q++) {
        NSMutableDictionary *temp = [dataArray objectAtIndex:q];
        NSLog(@"tempDict %@ date %@ tag is %i",[temp valueForKey:kDayTime],[tm objectAtIndex:0],[btn tag]);
        if ([[temp valueForKey:kDayTime] isEqualToString:[NSString stringWithFormat:@"%@ %i",[tm objectAtIndex:0],[subString intValue]]]) {
            editIndexValue = [[NSString stringWithFormat:@"%i",q] retain];
            NSArray *sDA = [[temp valueForKey:kStartDate] componentsSeparatedByString:@":"];
            NSArray *eDA = [[temp valueForKey:kEndDate] componentsSeparatedByString:@":"];
            eventDesTextView.text = [temp valueForKey:kEventDes];
            hoursTextField1.text = [NSString stringWithFormat:@"%i",[[sDA objectAtIndex:0] intValue]];
            hoursTextField2.text = [NSString stringWithFormat:@"%i",[[eDA objectAtIndex:0] intValue]];
            isExit = YES;
        }else {
            isExit = NO;
        }
    }
    if (!isExit) {
        eventDesTextView.text = @"";
        hoursTextField1.text = [NSString stringWithFormat:@"%i",[subString intValue]-1];
        hoursTextField2.text = [NSString stringWithFormat:@"%i",[hoursTextField1.text intValue]+1];
    }
    ASDepthModalOptions style = ASDepthModalOptionAnimationGrow;
    [ASDepthModalViewController presentView:self.popupView
                            backgroundColor:nil
                                    options:style
                          completionHandler:^{
                              NSLog(@"Modal view closed.");
                          }];
    
}


-(IBAction)empty3:(id)sender {
    UIButton *btn = (UIButton*)sender;
    NSDate *date=nil;
    
    date = [self.weekdays objectAtIndex:3];
    
    NSString *btag = [NSString stringWithFormat:@"%i",btn.tag];
    NSString *subString =  [btag substringFromIndex:1];
    
    NSArray *tm = [[self dateFromString:date] componentsSeparatedByString:@" "];
    
    buttonString = [[tm objectAtIndex:0] retain];
    BOOL isExit;
    for (int q= 0; q<[dataArray count]; q++) {
        NSMutableDictionary *temp = [dataArray objectAtIndex:q];
        NSLog(@"tempDict %@ date %@ tag is %i",[temp valueForKey:kDayTime],[tm objectAtIndex:0],[subString intValue]);
        if ([[temp valueForKey:kDayTime] isEqualToString:[NSString stringWithFormat:@"%@ %i",[tm objectAtIndex:0],[subString intValue]]]) {
            editIndexValue = [[NSString stringWithFormat:@"%i",q] retain];
            NSArray *sDA = [[temp valueForKey:kStartDate] componentsSeparatedByString:@":"];
            NSArray *eDA = [[temp valueForKey:kEndDate] componentsSeparatedByString:@":"];
            eventDesTextView.text = [temp valueForKey:kEventDes];
            hoursTextField1.text = [NSString stringWithFormat:@"%i",[[sDA objectAtIndex:0] intValue]];
            hoursTextField2.text = [NSString stringWithFormat:@"%i",[[eDA objectAtIndex:0] intValue]];
            isExit = YES;
        }else {
            isExit = NO;
        }
    }
    if (!isExit) {
        eventDesTextView.text = @"";
        hoursTextField1.text = [NSString stringWithFormat:@"%i",[subString intValue]-1];
        hoursTextField2.text = [NSString stringWithFormat:@"%i",[hoursTextField1.text intValue]+1];
    }
    ASDepthModalOptions style = ASDepthModalOptionAnimationGrow;
    [ASDepthModalViewController presentView:self.popupView
                            backgroundColor:nil
                                    options:style
                          completionHandler:^{
                              NSLog(@"Modal view closed.");
                          }];
    
}
-(IBAction)empty4:(id)sender {
    UIButton *btn = (UIButton*)sender;
    NSDate *date=nil;
    date = [self.weekdays objectAtIndex:4];
    NSString *btag = [NSString stringWithFormat:@"%i",btn.tag];
    NSString *subString =  [btag substringFromIndex:1];
    
    NSArray *tm = [[self dateFromString:date] componentsSeparatedByString:@" "];
    
    buttonString = [[tm objectAtIndex:0] retain];
    BOOL isExit;
    for (int q= 0; q<[dataArray count]; q++) {
        NSMutableDictionary *temp = [dataArray objectAtIndex:q];
        NSLog(@"tempDict %@ date %@ tag is %i",[temp valueForKey:kDayTime],[tm objectAtIndex:0],[btn tag]);
        if ([[temp valueForKey:kDayTime] isEqualToString:[NSString stringWithFormat:@"%@ %i",[tm objectAtIndex:0],[subString intValue]]]) {
            editIndexValue = [[NSString stringWithFormat:@"%i",q] retain];
            NSArray *sDA = [[temp valueForKey:kStartDate] componentsSeparatedByString:@":"];
            NSArray *eDA = [[temp valueForKey:kEndDate] componentsSeparatedByString:@":"];
            eventDesTextView.text = [temp valueForKey:kEventDes];
            hoursTextField1.text = [NSString stringWithFormat:@"%i",[[sDA objectAtIndex:0] intValue]];
            hoursTextField2.text = [NSString stringWithFormat:@"%i",[[eDA objectAtIndex:0] intValue]];
            isExit = YES;
        }else {
            isExit = NO;
        }
    }
    if (!isExit) {
        eventDesTextView.text = @"";
        hoursTextField1.text = [NSString stringWithFormat:@"%i",[subString intValue]-1];
        hoursTextField2.text = [NSString stringWithFormat:@"%i",[hoursTextField1.text intValue]+1];
    }
    ASDepthModalOptions style = ASDepthModalOptionAnimationGrow;
    [ASDepthModalViewController presentView:self.popupView
                            backgroundColor:nil
                                    options:style
                          completionHandler:^{
                              NSLog(@"Modal view closed.");
                          }];
    
}


-(IBAction)empty5:(id)sender {
    UIButton *btn = (UIButton*)sender;
    NSDate *date=nil;
    date = [self.weekdays objectAtIndex:5];
    
    NSString *btag = [NSString stringWithFormat:@"%i",btn.tag];
    NSString *subString =  [btag substringFromIndex:1];
    
    NSArray *tm = [[self dateFromString:date] componentsSeparatedByString:@" "];
    
    buttonString = [[tm objectAtIndex:0] retain];
    BOOL isExit;
    for (int q= 0; q<[dataArray count]; q++) {
        NSMutableDictionary *temp = [dataArray objectAtIndex:q];
        NSLog(@"tempDict %@ date %@ tag is %i",[temp valueForKey:kDayTime],[tm objectAtIndex:0],[subString intValue]);
        if ([[temp valueForKey:kDayTime] isEqualToString:[NSString stringWithFormat:@"%@ %i",[tm objectAtIndex:0],[subString intValue]]]) {
            editIndexValue = [[NSString stringWithFormat:@"%i",q] retain];
            NSArray *sDA = [[temp valueForKey:kStartDate] componentsSeparatedByString:@":"];
            NSArray *eDA = [[temp valueForKey:kEndDate] componentsSeparatedByString:@":"];
            eventDesTextView.text = [temp valueForKey:kEventDes];
            hoursTextField1.text = [NSString stringWithFormat:@"%i",[[sDA objectAtIndex:0] intValue]];
            hoursTextField2.text = [NSString stringWithFormat:@"%i",[[eDA objectAtIndex:0] intValue]];
            isExit = YES;
        }else {
            isExit = NO;
        }
    }
    if (!isExit) {
        eventDesTextView.text = @"";
        hoursTextField1.text = [NSString stringWithFormat:@"%i",[subString intValue]-1];
        hoursTextField2.text = [NSString stringWithFormat:@"%i",[hoursTextField1.text intValue]+1];
    }
    ASDepthModalOptions style = ASDepthModalOptionAnimationGrow;
    [ASDepthModalViewController presentView:self.popupView
                            backgroundColor:nil
                                    options:style
                          completionHandler:^{
                              NSLog(@"Modal view closed.");
                          }];
    
}


-(IBAction)empty6:(id)sender {
    UIButton *btn = (UIButton*)sender;
    NSDate *date=nil;
    date = [self.weekdays objectAtIndex:6];
    
    NSString *btag = [NSString stringWithFormat:@"%i",btn.tag];
    NSString *subString =  [btag substringFromIndex:1];
    
    NSArray *tm = [[self dateFromString:date] componentsSeparatedByString:@" "];
    
    buttonString = [[tm objectAtIndex:0] retain];
    BOOL isExit;
    for (int q= 0; q<[dataArray count]; q++) {
        NSMutableDictionary *temp = [dataArray objectAtIndex:q];
        NSLog(@"tempDict %@ date %@ tag is %i",[temp valueForKey:kDayTime],[tm objectAtIndex:0],[btn tag]);
        if ([[temp valueForKey:kDayTime] isEqualToString:[NSString stringWithFormat:@"%@ %i",[tm objectAtIndex:0],[subString intValue]]]) {
            editIndexValue = [[NSString stringWithFormat:@"%i",q] retain];
            NSArray *sDA = [[temp valueForKey:kStartDate] componentsSeparatedByString:@":"];
            NSArray *eDA = [[temp valueForKey:kEndDate] componentsSeparatedByString:@":"];
            eventDesTextView.text = [temp valueForKey:kEventDes];
            hoursTextField1.text = [NSString stringWithFormat:@"%i",[[sDA objectAtIndex:0] intValue]];
            hoursTextField2.text = [NSString stringWithFormat:@"%i",[[eDA objectAtIndex:0] intValue]];
            isExit = YES;
        }else {
            isExit = NO;
        }
    }
    if (!isExit) {
        NSLog(@"%i",[subString intValue]);
        eventDesTextView.text = @"";
        hoursTextField1.text = [NSString stringWithFormat:@"%i",[subString intValue]-1];
        hoursTextField2.text = [NSString stringWithFormat:@"%i",[hoursTextField1.text intValue]+1];
    }
    ASDepthModalOptions style = ASDepthModalOptionAnimationGrow;
    [ASDepthModalViewController presentView:self.popupView
                            backgroundColor:nil
                                    options:style
                          completionHandler:^{
                              NSLog(@"Modal view closed.");
                          }];
    
}



-(void)getData {
    
    const char *dbpath = [databasePath UTF8String];

    if (sqlite3_open(dbpath, &exerciseDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat: @"SELECT * FROM SUB1EVENT"];
        
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
                [itemDict setValue:subId forKey:kSub1Id];
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
}


-(NSString*)dateFromString:(NSDate*)date {
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}



-(void)backButon  {
    
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark SettingViewController

-(void)settButtonClicked {
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        if ([[UIScreen mainScreen] bounds].size.height > 480) {
            if (!settingRegViewCntrl) {
                settingRegViewCntrl = [[SettingRegistViewController alloc] initWithNibName:@"SettingRegistView" bundle:nil];
            }
        }else{
            if (!settingRegViewCntrl) {
                settingRegViewCntrl = [[SettingRegistViewController alloc] initWithNibName:@"SettingRegistView_iPhone4" bundle:nil];
            }
        }
    }
    else{
        if (!settingRegViewCntrl) {
            settingRegViewCntrl = [[SettingRegistViewController alloc] initWithNibName:@"SettingRegistView_iPad" bundle:nil];
        }
    }
    
    [self.navigationController pushViewController:settingRegViewCntrl animated:YES];
}





-(IBAction)okButtonClicked:(id)sender
{
    [ASDepthModalViewController dismiss];
    NSLog(@"kasjfk  %@",editIndexValue);
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
        NSLog(@"%@",currentStatuBtn);
        [temp setValue:[NSNumber numberWithInt:[dataArray count]+1] forKey:kSub1Id];
        [temp setValue:eventDesTextView.text forKey:kEventDes];
        [temp setValue:startDate forKey:kStartDate];
        [temp setValue:endDate forKey:kEndDate];
        [temp setValue:dayTime forKey:kDayTime];
        [temp setValue:currentStatuBtn forKey:kStatus];
        [dataArray addObject:temp];
    }
    editIndexValue = nil;
    NSLog(@"okButton Clicked############## %@",dataArray);
    
    [self displayButton];
    
    [self  databaseInsert];
}


-(IBAction)totalOkButtonClicked:(id)sender {
    
    [ASDepthModalViewController dismiss];
    [self insertDataIntoTotalDatabase:[sender tag]];
    
}

-(void)insertDataIntoTotalDatabase:(int)tagValue {
    
    NSDate *date = [self.weekdays objectAtIndex:tagValue];
    
    NSArray *tm = [[self dateFromString:date] componentsSeparatedByString:@" "];
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &exerciseDB) == SQLITE_OK)
    {
        NSString *insertSQL = [NSString stringWithFormat: @"INSERT INTO sub1total (date,total) VALUES (\"%@\", \"%@\")",[tm objectAtIndex:0],sliderLabel.text];
        
        const char *insert_stmt = [insertSQL UTF8String];
        
        sqlite3_prepare_v2(exerciseDB, insert_stmt, -1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            NSLog(@"YES");
        } else {
            if(SQLITE_DONE != sqlite3_step(statement))
                NSLog(@"Error while updating. %s", sqlite3_errmsg(exerciseDB));
            NSLog(@"NO");
        }
        sqlite3_finalize(statement);
    }
    
    sqlite3_close(exerciseDB);
}

-(IBAction)closeButtonAction:(id)sender{
    [ASDepthModalViewController dismiss];
}

-(IBAction)sliderValueChanged:(UISlider*)sender{
    sliderLabel.text = [NSString stringWithFormat:@"%.0f",[sender value]];
}


#pragma mark TotalButtonClicked 

-(IBAction)totalButtonClicked:(id)sender
{
    ASDepthModalOptions style = ASDepthModalOptionAnimationGrow;
    [ASDepthModalViewController presentView:self.totalView
                            backgroundColor:nil
                                    options:style
                          completionHandler:^{

                          }];
}

#pragma mark Calendar Day Button Clicked

-(IBAction)calendarDayCellClicked:(id)sender
{
    
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
    dayView.isDinackar = YES;
    [self.navigationController pushViewController:dayView animated:YES];
    
}


-(IBAction)statusButtonClicked:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    NSLog(@"%i",btn.tag);
    
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

#pragma mark Calendar 

- (NSDate *)firstDayOfWeekFromDate:(NSDate *)date {
	CFCalendarRef currentCalendar = CFCalendarCopyCurrent();
	NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:date];
	[components setDay:([components day] - ([components weekday] - CFCalendarGetFirstWeekday(currentCalendar)))];
	[components setHour:0];
	[components setMinute:0];
	[components setSecond:0];
	CFRelease(currentCalendar);
	return [CURRENT_CALENDAR dateFromComponents:components];
}



- (void)week:(NSDate *)_date {
    
    self.week = _date;
    
    self.weekdays = [[NSMutableArray alloc] init];
    
    for (int i =1; i <= 7; i++)
    {
        NSDateComponents *comps1 = [[NSDateComponents alloc] init];
        [comps1 setMonth:0];
        [comps1 setDay:+i];
        [comps1 setHour:0];
        NSCalendar *calendar1 = [NSCalendar currentCalendar];
        NSDate *newDate1 = [calendar1 dateByAddingComponents:comps1 toDate:[NSDate date] options:0];
        [self.weekdays addObject:newDate1];
    }

	[self updateScreens];
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


#pragma mark -- DataBase Methods 

- (BOOL)findContact:(NSNumber*)questionId
{
    const char *dbpath = [databasePath UTF8String];
    
    BOOL isFind = NO;
    
    if (sqlite3_open(dbpath, &exerciseDB) == SQLITE_OK)
    {
        
        NSInteger sub1ID = [questionId integerValue];
        
        NSString *querySQL = [NSString stringWithFormat: @"SELECT subId FROM SUB1EVENT WHERE subId=\"%d\"", sub1ID];
        
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
    
    NSLog(@"converted date string %@",str);
    
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &exerciseDB) == SQLITE_OK)
    {
        NSInteger subId = [[recordsDic valueForKey:kSub1Id] integerValue];
        
        NSString *query=[NSString stringWithFormat:@"UPDATE SUB1EVENT SET date='%@', startDate='%@', endDate='%@', status='%@', dayDate='%@', eventDescription='%@' WHERE subId='%d'",str, [recordsDic valueForKey:kStartDate],[recordsDic valueForKey:kEndDate],[recordsDic valueForKey:kStatus],[recordsDic valueForKey:kDayTime],[recordsDic valueForKey:kEventDes],subId];
        
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
    
    NSLog(@"converted date string %@",str);
    
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &exerciseDB) == SQLITE_OK)
    {
        NSInteger subId = [[recordDic valueForKey:kSub1Id] integerValue];
        
        NSString *insertSQL = [NSString stringWithFormat: @"INSERT INTO SUB1EVENT (subId,date,startDate,endDate,status,dayDate,eventDescription) VALUES (\"%d\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\")",subId,str,[recordDic valueForKey:kStartDate],[recordDic valueForKey:kEndDate],[recordDic valueForKey:kStatus],[recordDic valueForKey:kDayTime],[recordDic valueForKey:kEventDes]];
        
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
        
        if ([self findContact:[dataDic valueForKey:kSub1Id]]) {
            NSLog(@"Updating");
            [self updateIntDatabase:dataDic];
        }else {
            NSLog(@"New Record");
            [self insertIntoDatabase:dataDic];
        }
    }
}



#pragma mark UITextField Delegate Methods

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    [self.popupView setFrame:CGRectMake(self.popupView.frame.origin.x, self.popupView.frame.origin.y - 60, self.popupView.frame.size.width, self.popupView.frame.size.height)];
}


-(void)textFieldDidEndEditing:(UITextField *)textField {
    [self.popupView setFrame:CGRectMake(self.popupView.frame.origin.x, self.popupView.frame.origin.y + 60, self.popupView.frame.size.width, self.popupView.frame.size.height)];
}

-(void)textViewDidEndEditing:(UITextView *)textView {

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
}

@end
