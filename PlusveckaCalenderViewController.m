//
//  PlusveckaCalander.m
//  Välkommen till TFH-appen
//
//  Created by Brilliance Tech Sols on 7/18/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import "PlusveckaCalenderViewController.h"
#import "ASDepthModalViewController.h"

@interface PlusveckaCalenderViewController ()
@property (nonatomic, strong) NSString *currentDateBtn,*tabValue;
@property (nonatomic, strong) NSString *currentStatuBtn;
@end

@interface CustomButton1 : UIButton

@property (nonatomic, strong) NSString *currentDateString,*tabValue;

@end

@implementation CustomButton1
@synthesize currentDateString,tabValue;



@end
@implementation PlusveckaCalenderViewController
@synthesize settingsView;
@synthesize dayView;
@synthesize scrollView;
@synthesize dateArray,weekdays;
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
        const char *sql_stmt = "CREATE TABLE IF NOT EXISTS sub2event (id INTEGER PRIMARY KEY AUTOINCREMENT,date TEXT,startDate TEXT,endDate TEXT,status TEXT,dayDate TEXT,eventDescription TEXT)";
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
    self.dataArray = [[NSMutableArray alloc]init];
    [self getData];

    [self createButton];
    // Do any additional setup after loading the view from its nib.
}

-(void)getData{
    sqlite3_stmt *statement1;
    NSString *query = @"select sub2event.date,sub2event.startDate,sub2event.endDate,sub2event.status,sub2event.eventDescription,sub2total.total from sub2event inner join exercise6sub2total on sub2event.date=sub2total.date";
    if (sqlite3_prepare_v2(exerciseDB, [query UTF8String], -1, &statement1, nil)!=SQLITE_OK) {
        NSLog(@"Error occured while getting data in sub2 calander view");
    }
    else{
        while (sqlite3_step(statement1)==SQLITE_ROW) {
            NSString *date = [NSString stringWithFormat:@"%s",sqlite3_column_text(statement1, 0)];
            NSString *startDate = [NSString stringWithFormat:@"%s",sqlite3_column_text(statement1, 1)];
            NSString *endDate = [NSString stringWithFormat:@"%s",sqlite3_column_text(statement1, 2)];
            NSString *status = [NSString stringWithFormat:@"%s",sqlite3_column_text(statement1, 3)];
            NSString *eventDescription = [NSString stringWithFormat:@"%s",sqlite3_column_text(statement1, 4)];
            NSString *total = [NSString stringWithFormat:@"%s",sqlite3_column_text(statement1, 5)];
            NSMutableDictionary *itemDict = [[NSMutableDictionary alloc]init];
            [itemDict setValue:date forKey:@"date"];
            [itemDict setValue:startDate forKey:@"startDate"];
            [itemDict setValue:endDate forKey:@"endDate"];
            [itemDict setValue:status forKey:@"status"];
            [itemDict setValue:eventDescription forKey:@"eventDescription"];
            [itemDict setValue:total forKey:@"total"];
            [dataArray addObject:itemDict];
        }
        sqlite3_finalize(statement);
    }
    sqlite3_close(exerciseDB);
}

- (void)week:(NSDate *)_date {
    
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
    NSLog(@"%@",self.weekdays);
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

-(void)createButton {
    int p=0;
    for (int i = 0; i < 14; i++) {
        if (i==2||i==4||i==6||i==8||i==10||i==12) {
            p++;
        }
        NSDate *date = [self.weekdays objectAtIndex:p];
        NSArray *tm = [[self dateFromString:date] componentsSeparatedByString:@" "];
        
        for (int j =0; j < 24 ; j++) {
            NSString *hStr = [NSString stringWithFormat:@"%i",j];
            CustomButton1 *but = [[CustomButton1 alloc] initWithFrame:CGRectMake((i*21)+ 25, j*29, 21, 29)];
            but.titleLabel.textAlignment = UITextAlignmentCenter;
            [but setBackgroundImage:[UIImage imageNamed:@"kalendar_cell_empty.png"] forState:UIControlStateNormal];
            [but setTabValue:[NSString stringWithFormat:@"%d",i]];
            [but addTarget:self action:@selector(emptyCell:) forControlEvents:UIControlEventTouchUpInside];
            [but setCurrentDateString:[NSString stringWithFormat:@"%@ %@",[tm objectAtIndex:0],hStr]];
            NSString *strin = [NSString stringWithFormat:@"%d%d",j,i];
            NSLog(@"$$$$ $$$ %i",[strin intValue]);
            [but setTag:[strin intValue]];
            [but setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [self.scrollView addSubview:but];
        }
    }
    
    [self.scrollView setContentSize:CGSizeMake(self.scrollView.frame.size.width, 24*29)];
}

-(NSString*)dateFromString:(NSDate*)date {
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}

-(void)emptyCell:(CustomButton1 *)sender {
    //currentButtonStatus = sender;
    currentDateBtn = sender.currentDateString;
    tabValue = sender.tabValue;
    
    ASDepthModalOptions style = ASDepthModalOptionAnimationGrow;
    [ASDepthModalViewController presentView:self.popupView
                            backgroundColor:nil
                                    options:style
                          completionHandler:^{
                              NSLog(@"Modal view closed.");
                             // [self refresh];
                          }];
}

-(IBAction)closeButtonClicked:(id)sender
{
   [ASDepthModalViewController dismiss]; 
}

-(IBAction)okButtonClicked:(id)sender
{
    [ASDepthModalViewController dismiss];
    [self insertDataIntoDatabase];
    
}

-(IBAction)totalOkButtonAction:(id)sender{
    [ASDepthModalViewController dismiss];
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

-(IBAction)sliderValueChanged:(UISlider*)sender{
    sliderLabel.text = [NSString stringWithFormat:@"%.0f",[sender value]];
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
    dayView.isDinackar = NO;
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

#pragma mark UITextField Delegate Methods

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    [self.popupView setFrame:CGRectMake(self.popupView.frame.origin.x, self.popupView.frame.origin.y - 120, self.popupView.frame.size.width, self.popupView.frame.size.height)];
}


-(void)textFieldDidEndEditing:(UITextField *)textField {
    [self.popupView setFrame:CGRectMake(self.popupView.frame.origin.x, self.popupView.frame.origin.y + 120, self.popupView.frame.size.width, self.popupView.frame.size.height)];
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

#pragma mark Calendar Empty Cell


-(void)refresh {
    
    
    NSString *_tabValue = [NSString stringWithFormat:@"%d%d",[hoursTextField1.text intValue],[tabValue intValue]];
    
    CustomButton1 *but = (CustomButton1 *)[self.scrollView viewWithTag:[_tabValue intValue]];
    
    if ([currentStatuBtn isEqualToString:@"+"]) {
        [but setBackgroundImage:[UIImage imageNamed:@"kalendar_cell_positive.png"] forState:UIControlStateNormal];
    }else if ([currentStatuBtn isEqualToString:@"-"]){
        [but setBackgroundImage:[UIImage imageNamed:@"kalendar_cell_negative.png"] forState:UIControlStateNormal];
    }else if ([currentStatuBtn isEqualToString:@"N"]){
        [but setBackgroundImage:[UIImage imageNamed:@"kalendar_cell_emptycell_neutral.png"] forState:UIControlStateNormal];
    }
    [but setTitle:eventDesTextView.text forState:UIControlStateNormal];
    
    
    /*NSArray *em = [currentDateBtn componentsSeparatedByString:@" "];
     
     for (int i = 0; i < 7; i++) {
     NSDate *date = [self.weekdays objectAtIndex:i];
     
     NSArray *tm = [[self dateFromString:date] componentsSeparatedByString:@" "];
     
     for (int j =0; j < 24 ; j++) {
     NSString *hStr = [NSString stringWithFormat:@"%i",j];
     NSString *mainStrin = [NSString stringWithFormat:@"%@ %@",[tm objectAtIndex:0],hStr];
     CustomButton *but = [[CustomButton alloc] initWithFrame:CGRectMake((i*42)+ 25, j*29, 42, 29)];
     
     if ([[em objectAtIndex:0] isEqualToString:[tm objectAtIndex:0]]) {
     
     if ([hStr isEqualToString:hoursTextField1.text]) {
     
     if ([currentStatuBtn isEqualToString:@"+"]) {
     [but setBackgroundImage:[UIImage imageNamed:@"kalendar_cell_positive.png"] forState:UIControlStateNormal];
     }else if ([currentStatuBtn isEqualToString:@"-"]){
     [but setBackgroundImage:[UIImage imageNamed:@"kalendar_cell_negative.png"] forState:UIControlStateNormal];
     }else if ([currentStatuBtn isEqualToString:@"N"]){
     [but setBackgroundImage:[UIImage imageNamed:@"kalendar_cell_emptycell_neutral.png"] forState:UIControlStateNormal];
     }
     [but setTitle:eventDesTextView.text forState:UIControlStateNormal];
     }
     else {
     [but setBackgroundImage:[UIImage imageNamed:@"kalendar_cell_empty.png"] forState:UIControlStateNormal];
     }
     
     }else {
     [but setBackgroundImage:[UIImage imageNamed:@"kalendar_cell_empty.png"] forState:UIControlStateNormal];
     }
     [but setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
     [but addTarget:self action:@selector(emptyCell:) forControlEvents:UIControlEventTouchUpInside];
     [but setCurrentDateString:mainStrin];
     [self.scrollView addSubview:but];
     }
     }
     
     [self.scrollView setContentSize:CGSizeMake(self.scrollView.frame.size.width, 24*29)];*/
    
}

-(void)insertDataIntoDatabase {
    
    /*NSDateFormatter* formatter = [[[NSDateFormatter alloc] init] autorelease];
    [formatter setDateFormat:@"MMM d YYYY HH:mm:ss"];
    NSString* str = [formatter stringFromDate:[NSDate date]];
    
    
    NSString *startDate = [NSString stringWithFormat:@"%@:%@",hoursTextField1.text,mintsTextField1.text];
    NSString *endDate =[NSString stringWithFormat:@"%@:%@",hoursTextField2.text,mintsTextField2.text];
    
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &exerciseDB) == SQLITE_OK)
    {
        NSString *insertSQL = [NSString stringWithFormat: @"INSERT INTO EXERCISE6 (date,startdate,enddate,status,daydate,eventdes) VALUES (\"%@\", \"%@\", \"%@\" ,\"%@\",\"%@\",\"%@\")",str,startDate,endDate,currentStatuBtn,currentDateBtn,eventDesTextView.text];
        
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
    
    sqlite3_close(exerciseDB);*/
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
