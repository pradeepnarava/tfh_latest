//
//  AktivitetsplanenViewController.m
//  Välkommen till TFH-appen
//
//  Created by Mohammed Abdul Majeed on 5/18/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import "AktivitetsplanenViewController.h"

@interface AktivitetsplanenViewController ()

@end

@implementation AktivitetsplanenViewController
@synthesize appDelegate;

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
    // Do any additional setup after loading the view from its nib.
    
    text=@"";
    appDelegate = (Va_lkommenAppDelegate *)[[UIApplication sharedApplication]delegate];
    timeslotArray = [[NSMutableArray alloc]initWithObjects:@"01", @"02", @"03", @"04", @"05", @"06", @"07", @"08", @"09", @"10", @"11", @"12", @"13", @"14", @"15", @"16", @"17", @"18", @"19", @"20", @"21", @"22", @"23", @"24",nil];
listofallidentifier= [[NSMutableArray alloc]init];
    listofallevents= [[NSMutableArray alloc]init];
    arrayEvents = [[NSMutableArray alloc]init];
    arrayShowEvents = [[NSMutableArray alloc]init];
    scrollview=[[UIScrollView alloc]init];
    scrollview.delegate=self;
    [self.view addSubview:scrollview];
    //scrollview.hidden=YES;
    scrollview.backgroundColor=[UIColor whiteColor];
    
    [self.view addSubview:settingView];
    settingView.hidden = YES;
    
    
    if(deviceIdiom==iPhone)
    {
        scrollview.frame=CGRectMake(0 , 100, 320, 330);
        scrollview.contentSize=CGSizeMake(320,1450);
        
        pickerOne = [[UIDatePicker alloc] initWithFrame:CGRectMake(185, 85, 100, 100)];
        pickerOne.datePickerMode=UIDatePickerModeTime;
        pickerOne.transform = CGAffineTransformMake(0.5, 0, 0, 0.5, -90, 0);
        pickerOne.backgroundColor = [UIColor clearColor];
        [scrollSetting addSubview:pickerOne];
        pickerOne.hidden=YES;
        
        pickerTwo = [[UIDatePicker alloc] initWithFrame:CGRectMake(10, 340, 100, 100)];
        pickerTwo.datePickerMode=UIDatePickerModeTime;
        pickerTwo.transform = CGAffineTransformMake(0.5, 0, 0, 0.5, -90, 0);
        [scrollSetting addSubview:pickerTwo];
         pickerTwo.hidden=YES;
        
        pickerThree = [[UIDatePicker alloc] initWithFrame:CGRectMake(185, 340, 100, 100)];
        pickerThree.datePickerMode=UIDatePickerModeTime;
        pickerThree.transform = CGAffineTransformMake(0.5, 0, 0, 0.5, -90, 0);
        [scrollSetting addSubview:pickerThree];
        pickerThree.hidden=YES;
        
        pickerFour = [[UIDatePicker alloc] initWithFrame:CGRectMake(185, 590, 100, 100)];
        pickerFour.datePickerMode=UIDatePickerModeTime;
        pickerFour.transform = CGAffineTransformMake(0.5, 0, 0, 0.5, -90, 0);
        [scrollSetting addSubview:pickerFour];
        pickerFour.hidden=YES;
        scrollSetting.contentSize=CGSizeMake(320,950);
        
    }else
    {
        scrollview.frame=CGRectMake(0 , 100, 768, 820);
        scrollview.contentSize=CGSizeMake(320,1450);
        
    }
    
    [scrollSetting setScrollEnabled:YES];
    
    
    int k=0;
    
    for(int i=0;i<[timeslotArray count];i++)
    {
        
        UIImageView *lineImageview= [[UIImageView alloc] init];//WithFrame:CGRectMake(46,30*i, 320, 30)];
        lineImageview.backgroundColor = [UIColor clearColor];
        lineImageview.image = [UIImage imageNamed:@"Agenda.png"];
        [scrollview addSubview:lineImageview];
        
        UILabel *slotlbl=[[UILabel alloc]init];//WithFrame:CGRectMake(10,20+30*i-1,70,20)];
        slotlbl.backgroundColor=[UIColor clearColor];
        slotlbl.font=[UIFont fontWithName:@"HelveticaNeue" size:14.0];
        slotlbl.text=[timeslotArray objectAtIndex:i];
        [scrollview addSubview:slotlbl];
        
        if (deviceIdiom == iPhone) {
            lineImageview.frame = CGRectMake(25,60*i, 320, 60);
            slotlbl.frame = CGRectMake(2,50+60*i-1,70,20);
            //eventBtn.frame = CGRectMake(30,30*i+5, 320, 20);
            
            
        } else {
            lineImageview.frame = CGRectMake(46,60*i, 768, 60);
            slotlbl.frame = CGRectMake(10,20+60*i-1,70,20);
            //popupView1.frame = CGRectMake(0, 0, 768, 1004);
            //eventBtn.frame = CGRectMake(50,60*i+5, 768, 50);
            
        }
        
        int sum=25;
        for (int j=0; j<8; j++) {
            
            UIView *lineView1 = [[UIView alloc] init];//WithFrame:CGRectMake(25, 0, 1, 1442)];
            lineView1.backgroundColor = [UIColor blackColor];
            [scrollview addSubview:lineView1];
            
            lineView1.frame = CGRectMake(sum, 60*i, 1, 60);
            
            
            //            UIButton *eventBtn= [[UIButton alloc] initWithFrame:CGRectMake(sum,60*i-1, 39, 60-1)];
            //            eventBtn.backgroundColor = [UIColor lightGrayColor];
            //            [eventBtn addTarget:self action:@selector(addEventTouchupInside:) forControlEvents:UIControlEventTouchUpInside];
            //            eventBtn.tag = k;
            //            [scrollview addSubview:eventBtn];
            //
            sum = sum+40;
            
            k = k+1;
            
        }
        
        
        
    }
    
    UITapGestureRecognizer *tapScroll = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapped:)];
    //tapScroll.cancelsTouchesInView = NO;
    [scrollview addGestureRecognizer:tapScroll];
    
    [self.view addSubview:popupView1];
    popupView1.hidden=YES;
    
    [self.view addSubview:popupView2];
    popupView2.hidden=YES;
    
    [slider setMinimumValue:1];
    [slider setMaximumValue:100];
    [slider setValue:75];
    
    
    appDelegate.dateSelected = [NSDate date];
    
    
    NSDate *today = [NSDate date];
    
      
    NSCalendar *gregorian = [[NSCalendar alloc]
                             
                             initWithCalendarIdentifier:NSGregorianCalendar];
    
    
    
    // Get the weekday component of the current date
    
    NSDateComponents *weekdayComponents = [gregorian components:NSWeekdayCalendarUnit
                                           
                                                       fromDate:today];
    
    
    
    /*
     
     Create a date components to represent the number of days to subtract from the current date.
     
     The weekday value for Sunday in the Gregorian calendar is 1, so subtract 1 from the number of days to subtract from the date in question.  (If today is Sunday, subtract 0 days.)
     
     */
    
    NSDateComponents *componentsToSubtract = [[NSDateComponents alloc] init];
    
    [componentsToSubtract setDay: 0 - ([weekdayComponents weekday] - 2)];
    
    NSDate *beginningOfWeek = [gregorian dateByAddingComponents:componentsToSubtract
                               
                                                         toDate:today options:0];
    
    
    
    /*
     
     Optional step:
     
     beginningOfWeek now has the same hour, minute, and second as the original date (today).
     
     To normalize to midnight, extract the year, month, and day components and create a new date from those components.
     
     */
    
    NSDateComponents *components =
    
    [gregorian components:(NSYearCalendarUnit | NSMonthCalendarUnit |
                           
                           NSDayCalendarUnit) fromDate: beginningOfWeek];
    
    beginningOfWeek = [gregorian dateFromComponents:components];
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MMM yyyy"]; //yyyy-MM-dd HH:mm:ss zzz
    NSString* dateString = [dateFormatter stringFromDate:[NSDate date]];
    //NSLog(@"Date/Time is %@ %d", dateString,[self getnewdates]);
    //[Week_weekBarBtn setTitle:dateString forState:UIControlStateNormal];
    Week_weekBarLbl.text = dateString;
    event = [[UIEvent alloc]init];
    
    arraWeek = [[NSMutableArray alloc]init];
    arraWeek2 = [[NSMutableArray alloc]init];
    
    NSString *docsDir;
    NSArray *dirPaths;
    
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    
    // Build the path to the database file
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"exerciseDB.db"]];
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    if ([filemgr fileExistsAtPath: databasePath ] == YES)
    {
		const char *dbpath = [databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &exerciseDB) == SQLITE_OK)
        {
            char *errMsg;
            const char *sql_stmt = "CREATE TABLE IF NOT EXISTS EXERCISE7 (ID INTEGER PRIMARY KEY AUTOINCREMENT, DATE TEXT,TIME TEXT,NOTE TEXT, VALUE TEXT)";
            
            if (sqlite3_exec(exerciseDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
            {
                NSLog(@"Failed to create database");
            }
            
            sqlite3_close(exerciseDB);
            
        } else {
            //status.text = @"Failed to open/create database";
        }
    }
    
    [filemgr release];

    [self setDates];
    
    
    
    [self refreshEventsLoad];
    
    
    [self refreshEventsLoad];
}


-(IBAction)Week_CalendarActionEvents:(id)sender {
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    NSDate *nextDate;
    
    if(sender==Week_prevBarBtn)  // Previous button events
        [offsetComponents setDay:-7];
    else if(sender==Week_nextBarBtn) // next button events
        [offsetComponents setDay:7];
    
    nextDate = [gregorian dateByAddingComponents:offsetComponents toDate:appDelegate.dateSelected options:0];
    
    appDelegate.dateSelected = nextDate;
    
    NSDateComponents *components = [gregorian components:NSWeekCalendarUnit fromDate:appDelegate.dateSelected];
    NSInteger week = [components week];
    NSInteger day = [components day];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMMM YYYY"];
    NSString *stringFromDate = [formatter stringFromDate:appDelegate.dateSelected];
    //[Week_weekBarBtn setTitle:[NSString stringWithFormat:@"%@,Week %d",stringFromDate,week] forState:UIControlStateNormal];
    //[Week_weekBarBtn setTitle:[NSString stringWithFormat:@"%@,Week %d",stringFromDate,week]];
    Week_weekBarLbl.text = [NSString stringWithFormat:@"%@,Week %d",stringFromDate,week];
    
    [arraWeek removeAllObjects];
    [arraWeek2 removeAllObjects];
    
    NSArray *arr = [self lastSevenDays];
    
    [arraWeek addObjectsFromArray:arr];
    NSLog(@"  arraWeeks %@", arraWeek);
    
    
    for (int i = 0; i<[arr count]; i++) {
        
        NSString *strDate = [arr objectAtIndex:i];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MMM dd,  yyy"];//EEE,  dd
        NSDate *eventDate = [formatter dateFromString:strDate];
        
        [formatter setDateFormat:@"EEE    dd"];
        
        NSString *stringFromDate = [formatter stringFromDate:eventDate];
        
        [arraWeek2 addObject:stringFromDate];
        
        
    }
    
    
    [MonBtn setTitle:[arraWeek2 objectAtIndex:0] forState:UIControlStateNormal];
    [TueBtn setTitle:[arraWeek2 objectAtIndex:1] forState:UIControlStateNormal];
    [WedBtn setTitle:[arraWeek2 objectAtIndex:2] forState:UIControlStateNormal];
    [ThurBtn setTitle:[arraWeek2 objectAtIndex:3] forState:UIControlStateNormal];
    [FriBtn setTitle:[arraWeek2 objectAtIndex:4] forState:UIControlStateNormal];
    [SatBtn setTitle:[arraWeek2 objectAtIndex:5] forState:UIControlStateNormal];
    [SunBtn setTitle:[arraWeek2 objectAtIndex:6] forState:UIControlStateNormal];
    
    
    /*[NSTimer scheduledTimerWithTimeInterval:1.0
     target:self
     selector:@selector(refreshEventsLoad)
     userInfo:nil
     repeats:NO];*/
    
    [self refreshEventsLoad];
}


-(NSString *)changeformate_string24hr:(NSString *)date
{
    
    NSDateFormatter* df = [[NSDateFormatter alloc]init];
    
    [df setTimeZone:[NSTimeZone systemTimeZone]];
    
    [df setDateFormat:@"MM-dd-yyyy HH:mm:ss"];
    
    NSDate* wakeTime = [df dateFromString:date];
    
    [df setDateFormat:@"HH:mm:ss"];
    
    
    return [df stringFromDate:wakeTime];
    
}

- (void)refreshEventsLoad
{
    [arrayShowEvents removeAllObjects];
    [listofallidentifier removeAllObjects];
    [listofallevents removeAllObjects];
    for (int i = 0 ; i<[arrayEvents count]; i++) {
        ShowEventsBO *obj = [[ShowEventsBO alloc]init];
        
        EKEventStore *eventStore = [[EKEventStore alloc] init];
        EKEvent *events = [EKEvent eventWithEventStore:eventStore];
        events  = [arrayEvents objectAtIndex:i];
           [listofallidentifier addObject:events.eventIdentifier];
        NSLog(@" sdf sdf :%@ : %@  :%@  :%@ %@",events.title , events.location ,events.startDate,events.endDate,events.notes);
        
        obj.title = events.title;
        obj.location = events.location;
        obj.startDate = events.startDate;
        obj.endDate = events.endDate;
        obj.notes = events.notes;
        [listofallevents addObject:events.notes];

        [arrayShowEvents addObject:obj];
        
        
    }
    
    
    [self loadScheduleView];
}


-(void)loadScheduleView
{
    
    //scrollview.frame=CGRectMake(0 , 100, 320, 290);
    //[self.view addSubview:scrollview];
    
    for(UIView *subview in [scrollview subviews])
    {
        if([subview isKindOfClass:[UIButton class]])
            [subview removeFromSuperview];
        
    }
    
    //int count=1;
    for(int i=0;i<[arrayShowEvents count];i++)
    {
        ShowEventsBO *obj = [[ShowEventsBO alloc]init];
        obj = [arrayShowEvents objectAtIndex:i];
        NSLog(@"schedule time is %@",obj.startDate);
        
        NSArray *locatin = [obj.location componentsSeparatedByString:@"-"];
        NSString *strtTime = [locatin objectAtIndex:0];
        //NSString *endTime = [locatin objectAtIndex:1];
        NSArray *arr1 = [strtTime componentsSeparatedByString:@":"];
        //NSArray *arr2 = [endTime componentsSeparatedByString:@":"];
        
        //        NSString *xpoint = [arr1 objectAtIndex:0];
        int eventXPoint=0; // = ([xpoint intValue]*40)+25;
        
        NSString *ypoint = [arr1 objectAtIndex:0];
        int eventYPoint = [ypoint intValue]*60;
        NSLog(@"%d ",eventYPoint);
        
        
        
        /*NSString *lower = [NSString stringWithFormat:@"%@",obj.startDate];
         NSArray *att = [lower componentsSeparatedByString:@" "];
         
         NSString *strdt = [att objectAtIndex:0];
         
         NSDateFormatter* f = [[NSDateFormatter alloc] init] ;
         [f setDateFormat:@"yyyy-MM-dd"];
         NSDate* dateString = [f dateFromString:strdt];
         
         NSDateFormatter *Dateformat = [[NSDateFormatter alloc]init];
         [Dateformat setDateFormat:@"EEE   dd"];
         
         NSString *sss = [Dateformat stringFromDate:dateString];
         
         
         NSLog(@"%@",sss);*/
        
        
        NSDateFormatter* f = [[NSDateFormatter alloc] init] ;
        [f setDateFormat:@"yyyy-MM-dd"];
        NSString *dateString = [f stringFromDate:obj.startDate];
        
        [f setDateFormat:@"yyyy-MM-dd"];
        NSDate *dateStr = [f dateFromString:dateString];
        
        NSDateFormatter *Dateformat = [[NSDateFormatter alloc]init];
        [Dateformat setDateFormat:@"EEE    dd"];
        
        NSString *sss = [Dateformat stringFromDate:dateStr];
        
        NSLog(@"%@",sss);
        
        
        
        if ([sss isEqualToString:MonBtn.titleLabel.text]) {
            
            eventXPoint = MonBtn.frame.origin.x-10;
            
        }
        else if ([sss isEqualToString:TueBtn.titleLabel.text]) {
            
            eventXPoint = TueBtn.frame.origin.x-10;
            
        }
        else if ([sss isEqualToString:WedBtn.titleLabel.text]) {
            
            eventXPoint = WedBtn.frame.origin.x-10;
            
        }
        else if ([sss isEqualToString:ThurBtn.titleLabel.text]) {
            
            eventXPoint = ThurBtn.frame.origin.x-10;
            
        }
        else if ([sss isEqualToString:FriBtn.titleLabel.text]) {
            
            eventXPoint = FriBtn.frame.origin.x-10;
            
        }
        else if ([sss isEqualToString:SatBtn.titleLabel.text]) {
            
            eventXPoint = SatBtn.frame.origin.x-10;
            
        }
        else if ([sss isEqualToString:SunBtn.titleLabel.text]) {
            
            eventXPoint = SunBtn.frame.origin.x-10;
            
        } else {
            
            eventXPoint = MonBtn.frame.origin.x-10;
        }
        
        
        
       view1 = [[UIButton alloc]initWithFrame:CGRectMake(eventXPoint, eventYPoint, 39, 59)];
        view1.backgroundColor = [UIColor grayColor];
        [view1 setTitle:obj.notes forState:UIControlStateNormal];
        view1.titleLabel.font = [UIFont systemFontOfSize:10];
        [view1 addTarget:self action:@selector(SelectEvent:) forControlEvents:UIControlEventTouchUpInside];

        [scrollview addSubview:view1];
        
        
//        UILabel *lbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 3, 40, 55)];
//        lbl.text = obj.notes;
//        lbl.numberOfLines = 0;
//        lbl.textColor = [UIColor blackColor];
//        lbl.font = [UIFont systemFontOfSize:10];
//        lbl.backgroundColor = [UIColor clearColor];
//        [view1 addSubview:lbl];
        
        
        
        /*UIButton *slotbtn=[UIButton buttonWithType:UIButtonTypeCustom];
         slotbtn.backgroundColor=[UIColor redColor];
         slotbtn.tag=count-1;
         //[slotbtn addTarget:self action:@selector(slotbtnTapped:) forControlEvents:UIControlEventTouchUpInside];
         [slotbtn setTitle:bo.Subject forState:UIControlStateNormal];
         slotbtn.titleLabel.font=[UIFont systemFontOfSize:12.0];
         [slotbtn setBackgroundColor:[UIColor colorWithRed:0.439 green:0.812 blue:0.243 alpha:1]];
         [slotbtn.layer setCornerRadius:2.0f];
         
         NSLog(@"height is %i %i",(int)[d3 timeIntervalSinceDate:d2],(int)[d2 timeIntervalSinceDate:d1]/60);
         slotbtn.frame=CGRectMake(0,( (int)[d2 timeIntervalSinceDate:d1]/60),75,((int)[d3 timeIntervalSinceDate:d2]/60));
         [scrollview addSubview:slotbtn];
         count++;*/
        
        
    }
    
    
    /*NSMutableArray *subviewsArray=[[NSMutableArray alloc]init];
     
     for(UIView *subview in [scrollview subviews])
     {
     if([subview isKindOfClass:[UIButton class]])
     [subviewsArray addObject:subview];
     }
     
     if([subviewsArray count]>0)
     {
     NSMutableArray *slotssegmentArray=[[NSMutableArray alloc]init];
     NSMutableArray *subsegmentArray=[[NSMutableArray alloc]init];
     UIButton *sbtn=(UIButton*)[subviewsArray objectAtIndex:0];
     [subsegmentArray addObject:sbtn];
     [slotssegmentArray addObject:subsegmentArray];
     
     for(int i=1;i<[subviewsArray count];i++)
     {
     UIButton *sbtn1=(UIButton*)[subviewsArray objectAtIndex:i];
     BOOL intersect=NO;
     for(int j=0;j<[slotssegmentArray count];j++)
     {
     NSMutableArray *subslotarray=[slotssegmentArray objectAtIndex:j];
     for(int k=0;k<[subslotarray count];k++)
     {
     UIButton *cmpbtn=(UIButton*)[subslotarray objectAtIndex:k];
     if(CGRectIntersectsRect(sbtn1.frame,cmpbtn.frame))
     {
     [subslotarray addObject:sbtn1];
     intersect=YES;
     break;
     }
     }
     if(intersect)
     break;
     
     }
     if(!intersect)
     {
     NSMutableArray *subsegmentArray=[[NSMutableArray alloc]init];
     [subsegmentArray addObject:sbtn1];
     [slotssegmentArray addObject:subsegmentArray];
     [subsegmentArray release];
     }
     }
     
     for(int i=0;i<[slotssegmentArray count];i++)
     {
     NSMutableArray *subslotarray=[slotssegmentArray objectAtIndex:i];
     int buttoncount=[subslotarray count];
     NSLog(@"btn count per row is %i",buttoncount);
     for(int j=0;j<buttoncount;j++)
     {
     UIButton *scrollbtn=[subslotarray objectAtIndex:j];
     CGRect rect=scrollbtn.frame;
     scrollbtn.frame=CGRectMake(49+((260/buttoncount+5)*j),rect.origin.y,260/buttoncount,rect.size.height);
     }
     }
     [slotssegmentArray release];
     [subviewsArray release];
     }*/
}

- (void)SelectEvent:(id)sender
{
    UIButton *butn = (UIButton *)sender;
    //NSString *Xpoint = [NSString stringWithFormat:@"%.1f",(point.x-25)/40];
    //NSArray *arrPointX = [Xpoint componentsSeparatedByString:@"."];
    xAxies = butn.frame.origin.x;
    
    
    //NSString *Ypoint = [NSString stringWithFormat:@"%.1f",point.y/60];
    //NSArray *arrPointY = [Ypoint componentsSeparatedByString:@"."];
    yAxies = butn.frame.origin.y;
    
    NSLog(@"x : %d, y :%d , xpostion :%.1f, thuesdayxpostion :%.1f",xAxies,yAxies,MonBtn.frame.origin.x-10,TueBtn.frame.origin.x-10);
    
    int eventXPoint = xAxies;
    
    NSString *strpoint = [NSString stringWithFormat:@"%d",yAxies];
    NSArray *arr = [strpoint componentsSeparatedByString:@"."];
    //NSLog(@"%@",arr);
    
    
    if (eventXPoint == (MonBtn.frame.origin.x-10)) {
        
        strDate = [arraWeek objectAtIndex:MonBtn.tag];
        
        
        NSLog(@" Date :%@ ", strDate);
        
    }
    else if (eventXPoint == (TueBtn.frame.origin.x-10)) {
        
        strDate = [arraWeek objectAtIndex:TueBtn.tag];
        
        NSLog(@" Date :%@", strDate);
        
    }
    else if (eventXPoint == (WedBtn.frame.origin.x-10)) {
        
        strDate = [arraWeek objectAtIndex:WedBtn.tag];
        
        NSLog(@" Date :%@", strDate);
        
    }
    else if (eventXPoint == (ThurBtn.frame.origin.x-10)) {
        
        strDate = [arraWeek objectAtIndex:ThurBtn.tag];
        
        NSLog(@" Date :%@", strDate);
        
    }
    else if (eventXPoint == (FriBtn.frame.origin.x-10)) {
        
        strDate = [arraWeek objectAtIndex:FriBtn.tag];
        
        NSLog(@" Date :%@", strDate);
        
    }
    else if (eventXPoint == (SatBtn.frame.origin.x-10)) {
        
        strDate = [arraWeek objectAtIndex:SatBtn.tag];
        
        NSLog(@" Date :%@", strDate);
        
    }
    else if (eventXPoint == (SunBtn.frame.origin.x-10)) {
        
        strDate = [arraWeek objectAtIndex:SunBtn.tag];
        
        NSLog(@" Date :%@", strDate);
        
    }
    
    
    
    
    
    
    
    [self.view bringSubviewToFront:popupView2];
    popupView2.hidden = NO;
    [UIView beginAnimations:@"curlInView" context:nil];
    [UIView setAnimationDuration:3.0];
    [UIView commitAnimations];
    
    txtLbl1.text = [arr objectAtIndex:0];
    txtLbl2.text = @"00";
    txtLbl3.text = [arr objectAtIndex:0];
    txtLbl4.text = @"59";
    
    arr = nil;
    messageEventTxtView.text = butn.titleLabel.text;
    for (int k=0; k< [listofallevents count]; k++) {
        NSString *eventname = [listofallevents objectAtIndex:k];
        NSLog(@"%@",eventname);
        NSLog(@"%@",butn.titleLabel.text);
        if([eventname isEqualToString:butn.titleLabel.text]){
            NSLog(@"%@",eventname);
            EKEventStore* store = [[[EKEventStore alloc] init] autorelease];
            EKEvent* event2 = [store eventWithIdentifier:[listofallidentifier objectAtIndex:k]];
            NSLog(@"%@",event2);
            if (event2 != nil) {
                NSError* error = nil;
                [store removeEvent:event2 span:EKSpanThisEvent error:&error];
            }
        }
    }
    sqlite3_stmt    *statement;
    if (sqlite3_open([databasePath UTF8String], &exerciseDB) == SQLITE_OK) {
        
        NSString *sql = [NSString stringWithFormat: @"DELETE FROM EXERCISE7 WHERE text='%@'", messageEventTxtView.text];
        
        const char *del_stmt = [sql UTF8String];
        
        sqlite3_prepare_v2(exerciseDB, del_stmt, -1, & statement, NULL);
        if (sqlite3_step(statement) == SQLITE_ROW) {
            
            NSLog(@"sss");
        }
        
        sqlite3_finalize(statement);
        sqlite3_close(exerciseDB);
        
        
    }

}


- (void)tapped:(UITapGestureRecognizer *)gesture
{
    point = [gesture locationInView:scrollview];
    //NSLog(@"x :%.1f, y :%.1f ",(point.x-25)/40,point.y/60);
    
    NSString *Xpoint = [NSString stringWithFormat:@"%.1f",(point.x-25)/40];
    NSArray *arrPointX = [Xpoint componentsSeparatedByString:@"."];
    xAxies = [[arrPointX objectAtIndex:0] intValue];
    
    
    NSString *Ypoint = [NSString stringWithFormat:@"%.1f",point.y/60];
    NSArray *arrPointY = [Ypoint componentsSeparatedByString:@"."];
    yAxies = [[arrPointY objectAtIndex:0] intValue];
    
    NSLog(@"x : %d, y :%d , xpostion :%.1f, thuesdayxpostion :%.1f",(xAxies*40)+25,yAxies*60,MonBtn.frame.origin.x-10,TueBtn.frame.origin.x-10);
    
    int eventXPoint = (xAxies*40)+25;
    
    NSString *strpoint = [NSString stringWithFormat:@"%.1f",point.y/60];
    NSArray *arr = [strpoint componentsSeparatedByString:@"."];
    //NSLog(@"%@",arr);
    
    
    if (eventXPoint == (MonBtn.frame.origin.x-10)) {
        
        strDate = [arraWeek objectAtIndex:MonBtn.tag];
        
        
        NSLog(@" Date :%@ ", strDate);
        
    }
    else if (eventXPoint == (TueBtn.frame.origin.x-10)) {
        
        strDate = [arraWeek objectAtIndex:TueBtn.tag];
        
        NSLog(@" Date :%@", strDate);
        
    }
    else if (eventXPoint == (WedBtn.frame.origin.x-10)) {
        
        strDate = [arraWeek objectAtIndex:WedBtn.tag];
        
        NSLog(@" Date :%@", strDate);
        
    }
    else if (eventXPoint == (ThurBtn.frame.origin.x-10)) {
        
        strDate = [arraWeek objectAtIndex:ThurBtn.tag];
        
        NSLog(@" Date :%@", strDate);
        
    }
    else if (eventXPoint == (FriBtn.frame.origin.x-10)) {
        
        strDate = [arraWeek objectAtIndex:FriBtn.tag];
        
        NSLog(@" Date :%@", strDate);
        
    }
    else if (eventXPoint == (SatBtn.frame.origin.x-10)) {
        
        strDate = [arraWeek objectAtIndex:SatBtn.tag];
        
        NSLog(@" Date :%@", strDate);
        
    }
    else if (eventXPoint == (SunBtn.frame.origin.x-10)) {
        
        strDate = [arraWeek objectAtIndex:SunBtn.tag];
        
        NSLog(@" Date :%@", strDate);
        
    }
    
    
    
    
    
    
    
    [self.view bringSubviewToFront:popupView2];
    popupView2.hidden = NO;
    [UIView beginAnimations:@"curlInView" context:nil];
    [UIView setAnimationDuration:3.0];
    [UIView commitAnimations];
    
    txtLbl1.text = [arr objectAtIndex:0];
    txtLbl2.text = @"00";
    txtLbl3.text = [arr objectAtIndex:0];
    txtLbl4.text = @"59";
    
    arr = nil;
    messageEventTxtView.text = @"";
}



- (void)setDates
{
    
    [arraWeek removeAllObjects];
    [arraWeek2 removeAllObjects];
    
    NSArray *arr = [self lastSevenDays];
    
    [arraWeek addObjectsFromArray:arr];
    
    for (int i = 0; i<[arr count]; i++) {
        
        NSString *strDates = [arr objectAtIndex:i];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MMM dd,  yyy"];//EEE,  dd
        NSDate *eventDate = [formatter dateFromString:strDates];
        
        [formatter setDateFormat:@"EEE    dd"];
        
        NSString *stringFromDate = [formatter stringFromDate:eventDate];
        NSLog(@"  stringFromDate %@", stringFromDate);
        
        [arraWeek2 addObject:stringFromDate];
        
        
    }
    
    
    [MonBtn setTitle:[arraWeek2 objectAtIndex:0] forState:UIControlStateNormal];
    [TueBtn setTitle:[arraWeek2 objectAtIndex:1] forState:UIControlStateNormal];
    [WedBtn setTitle:[arraWeek2 objectAtIndex:2] forState:UIControlStateNormal];
    [ThurBtn setTitle:[arraWeek2 objectAtIndex:3] forState:UIControlStateNormal];
    [FriBtn setTitle:[arraWeek2 objectAtIndex:4] forState:UIControlStateNormal];
    [SatBtn setTitle:[arraWeek2 objectAtIndex:5] forState:UIControlStateNormal];
    [SunBtn setTitle:[arraWeek2 objectAtIndex:6] forState:UIControlStateNormal];
}

- (NSDate *)firstDayOfWeekFromDate:(NSDate *)date {
    
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* comps = [calendar components:NSYearForWeekOfYearCalendarUnit |NSYearCalendarUnit|NSMonthCalendarUnit|NSWeekCalendarUnit|NSWeekdayCalendarUnit fromDate:date];
    [comps setWeekday:2]; // 2: monday
    return [calendar dateFromComponents:comps];
}

- (NSInteger)getnewdates
{
    NSCalendar* cal = [NSCalendar currentCalendar];
    NSDateComponents* comp = [cal components:NSWeekdayCalendarUnit fromDate:[NSDate date]];
    return [comp weekday];
}

- (NSArray *)lastSevenDays {
    
    [arrayEvents removeAllObjects];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM dd,  yyy"];
    
    NSDate *date = appDelegate.dateSelected;
    NSMutableArray *weekDays = [[NSMutableArray alloc] initWithCapacity:7];
    for (int i = 0; i > -7; i--) {
        NSString *weekDay = [formatter stringFromDate:date];
        [weekDays addObject:weekDay];
        
        [arrayEvents addObjectsFromArray:[self fetchEventsForToday:date]];
        
        date = [self dateBySubtractingOneDayFromDate:date];
    }
    return weekDays;
}


- (NSDate *)dateBySubtractingOneDayFromDate:(NSDate *)date {
    NSCalendar *cal = [NSCalendar currentCalendar];
    
    NSDateComponents *minusOneDay = [[NSDateComponents alloc] init];
    [minusOneDay setDay:+1];
    NSDate *newDate = [cal dateByAddingComponents:minusOneDay
                                           toDate:date
                                          options:NSWrapCalendarComponents];
    
    
    
    return newDate;
}


- (NSArray *)fetchEventsForToday : (NSDate *)startDate {
    
    EKEventStore *eventStore = [[EKEventStore alloc] init];
    //EKEvent *events = [EKEvent eventWithEventStore:eventStore];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSArray *calendarArray = [NSArray arrayWithObject:calendar];
    NSDateComponents *oneDayAgoComponents = [[NSDateComponents alloc] init];
    oneDayAgoComponents.day = +1;
    NSDate *oneDayAgo = [calendar dateByAddingComponents:oneDayAgoComponents
                                                  toDate:startDate
                                                 options:0];
    NSPredicate *predicate = [eventStore predicateForEventsWithStartDate:startDate
                                                                 endDate:oneDayAgo
                                                               calendars:nil];
    // Fetch all events that match the predicate
    NSArray *eventsarr = [eventStore eventsMatchingPredicate:predicate];
    NSLog(@"Event array :%i",[eventsarr count]);
    
    return eventsarr;
}

//In the touch began code I have took the initialPoint from where the touch has began and saved it in the variable initialPoint



- (void)addEventTouchupInside:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    selectedBtnTag = btn.tag;
    NSLog(@"tag :%d frame x:%.f, y:%f",btn.tag,btn.frame.origin.x,btn.frame.origin.y);
    
    [self.view bringSubviewToFront:popupView2];
    popupView2.hidden = NO;
    [UIView beginAnimations:@"curlInView" context:nil];
    
    [UIView setAnimationDuration:3.0];
    
    [UIView commitAnimations];
    
    messageEventTxtView.text = @"";
    
}

- (IBAction)selectSennestBtn:(id)sender
{
    [self.view bringSubviewToFront:popupView1];
    popupView1.hidden = NO;
    
    lblSlide.text = [NSString stringWithFormat:@"%.1f",slider.value];
    
    [UIView beginAnimations:@"curlInView" context:nil];
    
    [UIView setAnimationDuration:3.0];
    
    [UIView commitAnimations];
    
}

- (IBAction)closeBtn:(id)sender
{
    popupView1.hidden=YES;
    popupView2.hidden=YES;
    settingView.hidden = YES;
    NSString *locatin;
    BOOL isSuccess;
    if ([messageEventTxtView.text length]&&[strDate length]) {
        
        
        
      view1 = [[UIButton alloc]initWithFrame:CGRectMake((xAxies*40)+25, yAxies*60, 39, 59)];
        [view1 setTitle:messageEventTxtView.text forState:UIControlStateNormal];
    view1.backgroundColor = [UIColor grayColor];
        [view1 addTarget:self action:@selector(SelectEvent:) forControlEvents:UIControlEventTouchUpInside];

       [scrollview addSubview:view1];
        
        
      //UILabel *lbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 3, 40, 55)];
     //  lbl.text = messageEventTxtView.text;
     //  lbl.numberOfLines = 0;
    //   lbl.textColor = [UIColor blackColor];
    // lbl.font = [UIFont systemFontOfSize:10];
   // lbl.backgroundColor = [UIColor clearColor];
        
       // [view1 addSubview:lbl];
        //view1.frame=CGRectMake((xAxies*40)+25, yAxies*60, 39, 59);
       //  [view1 setTitle:messageEventTxtView.text forState:UIControlStateNormal];
       
        
        
        EKEventStore *eventStore = [[EKEventStore alloc] init];
        EKEvent *events = [EKEvent eventWithEventStore:eventStore];
        events.title=@"Din aktivit";
        events.notes = messageEventTxtView.text;
        
        
        if ([txtLbl1.text intValue] < 12) {
            
            locatin = [NSString stringWithFormat:@"%@:%@ AM - %@:%@ AM", txtLbl1.text,txtLbl2.text,txtLbl3.text,txtLbl4.text];
            
        } else {
            
            locatin = [NSString stringWithFormat:@"%@:%@ PM - %@:%@ PM", txtLbl1.text,txtLbl2.text,txtLbl3.text,txtLbl4.text];
            
        }
        
        events.location = locatin;
        
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        NSLocale *locale = [[NSLocale alloc]
                            initWithLocaleIdentifier:@"en_US"];
        [format setLocale:locale];
        
        [format setDateFormat:@"MMM dd,  yyy"];
        
        //        NSDate *ExportDate = [format dateFromString:strDate];
        //        [format setDateFormat:@"yyyy-MM-dd"];
        //        NSString *exportdt = [format stringFromDate:ExportDate];
        //
        
        events.startDate = [format dateFromString:strDate];
        events.endDate   = [[NSDate alloc] initWithTimeInterval:600 sinceDate:events.startDate];
        
        
        events.availability = EKEventAvailabilityFree;
        [events setCalendar:[eventStore defaultCalendarForNewEvents]];
        
        NSError *error;
        isSuccess=[eventStore saveEvent:events span:EKSpanThisEvent error:&error];
        [eventStore saveEvent:events span:EKSpanThisEvent error:&error];
        NSLog(@"Error From iCal : %@", [error description]);
        
        NSString *eventId = [[NSString alloc] initWithFormat:@"%@", events.eventIdentifier];
        NSLog(@"EventID : %@", eventId);
        
        if(isSuccess){
            sqlite3_stmt    *statement;
            
            const char *dbpath = [databasePath UTF8String];
            
            if (sqlite3_open(dbpath, &exerciseDB) == SQLITE_OK)
            {
                NSString *insertSQL = [NSString stringWithFormat: @"INSERT INTO EXERCISE7 (date,time,text,value) VALUES (\"%@\", \"%@\", \"%@\" ,\"%@\")", strDate,locatin,messageEventTxtView.text,selectedValue];
                
                const char *insert_stmt = [insertSQL UTF8String];
                
                sqlite3_prepare_v2(exerciseDB, insert_stmt, -1, &statement, NULL);
                if (sqlite3_step(statement) == SQLITE_DONE)
                {
                    
                     strDate =  @"";
                    
                    
                } else {
                    NSLog(@"no");
                }
                sqlite3_finalize(statement);
                sqlite3_close(exerciseDB);
            }

            UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"" message:@"Saved to calendar" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertview show];
        }
        else{
            UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"" message:@"Error" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertview show];
        }
        
        
    }
  //  [self setDates];
    
        

    
    [self refreshEventsLoad];
    
    
    //[self refreshEventsLoad];
   // [self Week_CalendarActionEvents:sender];
   
    
    
}


- (IBAction)close:(id)sender
{
    messageEventTxtView.text = @"";
    popupView1.hidden=YES;
    popupView2.hidden=YES;
    settingView.hidden = YES;
    
    [messageEventTxtView resignFirstResponder];
    if([text isEqualToString:@""]){
    }else{
        ShowEventsBO *obj = [[ShowEventsBO alloc]init];
        for (int k=0; k< [arrayShowEvents count]; k++) {
            obj = [arrayShowEvents objectAtIndex:k];
            NSLog(@"%@",obj.startDate);
            NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar];
            NSDate *pickerDate=[[NSDate alloc]init];;
            if ([text isEqualToString: @"Varje"]) {
                pickerDate =obj.startDate;
                NSLog(@"%@",pickerDate);
            }else if([text isEqualToString:@"Varannan"]){
                pickerDate= [obj.startDate dateByAddingTimeInterval:60*60*1];
                NSLog(@"%@",pickerDate);
            }else if([text isEqualToString:@"Var tredje"]){
                pickerDate= [obj.startDate dateByAddingTimeInterval:60*60*2];
                NSLog(@"%@",pickerDate);
            }else if([text isEqualToString:@"Var sjatte"]){
                pickerDate= [obj.startDate dateByAddingTimeInterval:60*60*3];
                NSLog(@"%@",pickerDate);
            }else{
                pickerDate= [obj.startDate dateByAddingTimeInterval:60*60*24*1];
                NSLog(@"%@",pickerDate);
            }
            
                      
            NSDateComponents *dateComponents = [calendar components:( NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit )
                                                           fromDate:pickerDate];
            
            NSDateComponents *timeComponents = [calendar components:( NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit )
                                                           fromDate:pickerDate];
            
            // Set up the fire time
            NSDateComponents *dateComps = [[NSDateComponents alloc] init];
            [dateComps setDay:[dateComponents day]];
            [dateComps setMonth:[dateComponents month]];
            [dateComps setYear:[dateComponents year]];
            [dateComps setHour:[timeComponents hour]];
            // Notification will fire in one minute
            [dateComps setMinute:[timeComponents minute]];
            [dateComps setSecond:[timeComponents second]];
            NSDate *itemDate = [calendar dateFromComponents:dateComps];
            NSLog(@"%@",itemDate);
            UILocalNotification *localNotif = [[UILocalNotification alloc] init];
            if (localNotif == nil)
                return;
            localNotif.fireDate = itemDate;
            localNotif.timeZone = [NSTimeZone defaultTimeZone];
            
            // Notification details
            localNotif.alertBody = [NSString stringWithFormat:NSLocalizedString(obj.notes, nil)];
            localNotif.alertAction = [NSString stringWithFormat:NSLocalizedString(@"%@", nil), @"Ok"];
            
            localNotif.soundName = [[NSBundle mainBundle] pathForResource:@"DTMF_08" ofType:@"wav"];
            //localNotif.applicationIconBadgeNumber = 1;
            
            // Specify custom data for the notification
            NSDictionary *infoDict = [NSDictionary dictionaryWithObject:@"someValue" forKey:@"someKey"];
            localNotif.userInfo = infoDict;
            
            // Schedule the notification
            [[UIApplication sharedApplication] scheduleLocalNotification:localNotif];
        }
        
    }
}

- (IBAction)selectSettingButton:(id)sender
{
    
    [self.view bringSubviewToFront:settingView];
    settingView.hidden = NO;
    [UIView beginAnimations:@"curlInView" context:nil];
    [UIView setAnimationDuration:3.0];
    [UIView commitAnimations];
    
}
- (IBAction)selectSlider:(id)sender
{
    UISlider *sliderObj = (UISlider *)sender;
    lblSlide.text = [NSString stringWithFormat:@"%.f",sliderObj.value];
    
}

- (IBAction)selectOnWeekDay:(id)sender
{
        UIButton *btn = (UIButton *)sender;
        NSString *strNibname;
        if (deviceIdiom == iPhone) {
            strNibname = @"DayEventViewController";
        } else {
        strNibname = @"DayEventViewController";
        
       }
    DayEventViewController *dayObj = [[DayEventViewController alloc]initWithNibName:strNibname bundle:[NSBundle mainBundle]];
    dayObj.lblTitle= [arraWeek objectAtIndex:btn.tag];
    //[self presentViewController:dayObj animated:YES completion:nil];
    [self.navigationController pushViewController:dayObj animated:YES];
    
}


#pragma mark TextView delegate method

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}


- (BOOL)shouldAutorotate
{
    if (deviceIdiom == iPhone) {
        return NO;
    } else {
        return NO;
    }
}

-(IBAction)cleartext:(id)sender{
    messageEventTxtView.text=@"";
}

-(IBAction)selectremaindercheckbox:(id)sender{
    UIButton *btn = (UIButton *)sender;
    NSLog(@"%u",btn.tag);
    
    if (btn.tag == 1)
    {
        
        
        if(btn.currentImage==[UIImage imageNamed:@"uncheck.png"]){
            
            if ([OnrOff isEqualToString:@"On"]) {
                if ([text isEqualToString: @""]) {
                    [btn setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
                    text=@"Varje";
                    
                }
            }
        }else{
            [btn setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
            text=@"";
            
        }
        
    }
    else if (btn.tag == 2)
    {
        
        if(btn.currentImage==[UIImage imageNamed:@"uncheck.png"]){
            
            if ([OnrOff isEqualToString:@"On"]) {
                if ([text isEqualToString: @""]) {
                    [btn setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
                    text=@"Varannan";
                }
            }
        }else{
            [btn setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
            text=@"";
        }
        
    }
    else if (btn.tag == 3)
    {
        
        if(btn.currentImage==[UIImage imageNamed:@"uncheck.png"]){
            
            if ([OnrOff isEqualToString:@"On"]) {
                if ([text isEqualToString: @""]) {
                    [btn setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
                    text=@"Var tredje";
                }
            }
        }else{
            [btn setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
            text=@"";
            
        }
    }
    else if (btn.tag == 4)
    {
        
        if(btn.currentImage==[UIImage imageNamed:@"uncheck.png"]){
            
            if ([OnrOff isEqualToString:@"On"]) {
                if ([text isEqualToString: @""]) {
                    [btn setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
                    text=@"Var sjatte";
                }
            }
        }else{
            [btn setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
            text=@"";
            
        }
    }else{
        
        if(btn.currentImage==[UIImage imageNamed:@"uncheck.png"]){
            pickerOne.hidden=NO;
            if ([OnrOff isEqualToString:@"On"]) {
                if ([text isEqualToString: @""]) {
                    [btn setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
                    pickerOne.hidden=NO;
                    text=@"En gang om dagen kl";
                    
                }
            }
        }else{
            pickerOne.hidden=YES;
            [btn setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
            pickerOne.hidden=YES;
            text=@"";
        }
        
    }
}
-(IBAction)remainderON:(id)sender{
    OnrOff=@"On";
    //pickerOne.hidden=NO;
    pickerTwo.hidden=NO;
    pickerThree.hidden=NO;
   // pickerFour.hidden=NO;
}
-(IBAction)remainderOFF:(id)sender{
    
    if([text isEqualToString:@""]){
        OnrOff=@"Off";
        pickerOne.hidden=YES;
        pickerTwo.hidden=YES;
        pickerThree.hidden=YES;
        pickerFour.hidden=YES;
    }else{
        UIAlertView  *alert=[[UIAlertView alloc] initWithTitle:@"Alert message" message:@"Please clear all checkBoxes"
                                                      delegate:self
                                             cancelButtonTitle:@"Cancel"
                                             otherButtonTitles:nil, nil];
        
        [alert show];
        [alert release];
        
    }
}
-(IBAction)remainderDON:(id)sender{
    OnrOffD=@"OnD" ; 
      pickerFour.hidden=NO;
}
-(IBAction)remainderDOFF:(id)sender{
    OnrOffD=@"OffD";
    pickerFour.hidden=YES;
    
}
-(IBAction)SelectedButtontitle:(id)sender{
    UIButton *btn = (UIButton *)sender;
    NSLog(@"%u",btn.tag);
    
    if (btn.tag == 1)
    {
        selectedValue=@"-";
    }else if(btn.tag==2){
         selectedValue=@"Neutral";
    }else{
         selectedValue=@"+";
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
