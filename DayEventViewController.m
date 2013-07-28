//
//  DayEventViewController.m
//  Välkommen till TFH-appen
//
//  Created by AppDev on 19/05/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import "DayEventViewController.h"

@interface DayEventViewController ()

@end

@implementation DayEventViewController
@synthesize lblTitle;

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
    
    self.navigationController.navigationBar.hidden = NO;
    
    
    popupView2.hidden=YES;
    appDelegate = (Va_lkommenAppDelegate *)[[UIApplication sharedApplication]delegate];
    timeslotsArray = [[NSMutableArray alloc]initWithObjects:@"01", @"02", @"03", @"04", @"05", @"06", @"07", @"08", @"09", @"10", @"11", @"12", @"13", @"14", @"15", @"16", @"17", @"18", @"19", @"20", @"21", @"22", @"23", @"24",nil];
    [dayBtn setTitle:lblTitle forState:UIControlStateNormal];
    
    arrayEvents = [[NSMutableArray alloc]init];
    arrayShowEvents = [[NSMutableArray alloc]init];
    scrollView=[[UIScrollView alloc]init];
    scrollView.delegate=self;
    [self.view addSubview:scrollView];
    //scrollview.hidden=YES;
//    scrollsview.backgroundColor=[UIColor whiteColor];
//    
//    [self.view addSubview:settingView];
//    settingView.hidden = YES;
    
    if(deviceIdiom==iPhone)
    {
        scrollView.frame=CGRectMake(0 , 60, 320, 370);
        scrollView.contentSize=CGSizeMake(320,1450);
        
        
    }else
    {
        scrollView.frame=CGRectMake(0 , 80, 768, 820);
        scrollView.contentSize=CGSizeMake(320,1450);
        
    }
    
    
    
    
    for(int i=0;i<[timeslotsArray count];i++)
    {
        
        UIImageView *lineImageview= [[UIImageView alloc] init];//WithFrame:CGRectMake(46,30*i, 320, 30)];
        lineImageview.backgroundColor = [UIColor clearColor];
        lineImageview.image = [UIImage imageNamed:@"Agenda.png"];
        [scrollView addSubview:lineImageview];
        
        UILabel *slotlbl=[[UILabel alloc]init];//WithFrame:CGRectMake(10,20+30*i-1,70,20)];
        slotlbl.backgroundColor=[UIColor clearColor];
        slotlbl.font=[UIFont fontWithName:@"HelveticaNeue" size:14.0];
       slotlbl.text=[timeslotsArray objectAtIndex:i];
        UITapGestureRecognizer *tapGesture3 =
        [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tabellenalert:)] autorelease];
        [slotlbl addGestureRecognizer:tapGesture3];

        [scrollView addSubview:slotlbl];
        
        if (deviceIdiom == iPhone) {
            lineImageview.frame = CGRectMake(25,60*i, 320, 60);
            slotlbl.frame = CGRectMake(2,50+60*i-1,180,40);
            //eventBtn.frame = CGRectMake(30,30*i+5, 320, 20);
            
            
        } else {
            lineImageview.frame = CGRectMake(46,60*i, 768, 60);
            slotlbl.frame = CGRectMake(10,20+60*i-1,70,20);
            //popupView1.frame = CGRectMake(0, 0, 768, 1004);
            //eventBtn.frame = CGRectMake(50,60*i+5, 768, 50);
            
        }
        
       
        
        
    }
    
  //  UITapGestureRecognizer *tapScroll = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapped:)];
    //tapScroll.cancelsTouchesInView = NO;
 //   [scrollView addGestureRecognizer:tapScroll];
    
//    [self.view addSubview:popupView1];
//    popupView1.hidden=YES;
//    
//    [self.view addSubview:popupView2];
//    popupView2.hidden=YES;
//    
//    [slider setMinimumValue:1];
//    [slider setMaximumValue:100];
//    [slider setValue:75];
    
    
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
    //NSString* dateString = [dateFormatter stringFromDate:[NSDate date]];
    //NSLog(@"Date/Time is %@ %d", dateString,[self getnewdates]);
    //[Week_weekBarBtn setTitle:dateString forState:UIControlStateNormal];
    //Week_weekBarLbl.text = dateString;
    //event = [[UIEvent alloc]init];
    
    //arrayWeek = [[NSMutableArray alloc]init];
    //arrayWeek2 = [[NSMutableArray alloc]init];
    
    
    //[self setDates];
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM dd,  yyy"];
    NSDate *Day = [formatter dateFromString:lblTitle];
    [arrayEvents addObjectsFromArray:[self fetchEventsForToday:Day]];
    
    [self refreshEventsLoad];
    
    
   
}

- (void)refreshEventsLoad
{
    [arrayShowEvents removeAllObjects];
    
    for (int i = 0 ; i<[arrayEvents count]; i++) {
        ShowEventsBO *obj = [[ShowEventsBO alloc]init];
        
        EKEventStore *eventStore = [[EKEventStore alloc] init];
        EKEvent *events = [EKEvent eventWithEventStore:eventStore];
        events  = [arrayEvents objectAtIndex:i];
        NSLog(@" sdf sdf :%@ : %@  :%@  :%@ %@",events.title , events.location ,events.startDate,events.endDate,events.notes);
        
        obj.title = events.title;
        obj.location = events.location;
        obj.startDate = events.startDate;
        obj.endDate = events.endDate;
        obj.notes = events.notes;
        
        [arrayShowEvents addObject:obj];
        
        
    }
    
    
    [self loadScheduleView];
}


-(void)loadScheduleView
{
    
    //scrollview.frame=CGRectMake(0 , 100, 320, 290);
    //[self.view addSubview:scrollview];
    
    for(UIView *subview in [scrollView subviews])
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
        int eventXPoint=25; // = ([xpoint intValue]*40)+25;
        
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
        
        
                
        
        
        UIButton *view1 = [[UIButton alloc]initWithFrame:CGRectMake(eventXPoint, eventYPoint, 300, 59)];
        view1.backgroundColor = [UIColor grayColor];
        [scrollView addSubview:view1];
        
        
        UILabel *lbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 3, 180, 55)];
        lbl.text = obj.notes;
        lbl.numberOfLines = 0;
        lbl.textColor = [UIColor blackColor];
        lbl.font = [UIFont systemFontOfSize:10];
        lbl.backgroundColor = [UIColor clearColor];
        [view1 addSubview:lbl];
        
        
        
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


- (NSArray *)fetchEventsForToday : (NSDate *)startDate {
    
    EKEventStore *eventStore = [[EKEventStore alloc] init];
    //EKEvent *events = [EKEvent eventWithEventStore:eventStore];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    //NSArray *calendarArray = [NSArray arrayWithObject:calendar];
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
- (void)tapped:(UITapGestureRecognizer *)gesture
{
       
    [self.view bringSubviewToFront:popupView2];
    popupView2.hidden = NO;
    [UIView beginAnimations:@"curlInView" context:nil];
    [UIView setAnimationDuration:3.0];
    [UIView commitAnimations];
    
   
}
-(IBAction)tabellenalert:(id)sender{
    [self.view bringSubviewToFront:popupView2];
    popupView2.hidden = NO;
    [UIView beginAnimations:@"curlInView" context:nil];
    [UIView setAnimationDuration:3.0];
    [UIView commitAnimations];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
