    //
//  CalendarViewController.m
//  Välkommen till TFH-appen
//
//  Created by Chandrika on 12/07/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import "RegiDinaveckarCalendarViewController.h"
#import "SettingRegistViewController.h"
#import "ASDepthModalViewController.h"
#import "RegiDinaveckarDayCalendarViewController.h"

#import "DataBaseHelper.h"
#import "Events.h"
#import "NewRegistrering.h"


#define kStartDate @"startDate"
#define kEndDate   @"endDate"
#define kStatus    @"status"
#define kDayTime   @"dayTime"
#define kEventDes  @"eventDes"
#define kSub1Id    @"Sub1Id"

//SUB1TOTAL
#define kTSub1Id @"TSub1Id"
#define kTDate @"TDate"
#define kTTotal @"TTotal"

#define DATE_COMPONENTS (NSYearCalendarUnit| NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekCalendarUnit |  NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSWeekdayCalendarUnit | NSWeekdayOrdinalCalendarUnit)
#define CURRENT_CALENDAR [NSCalendar currentCalendar]

static const unsigned int DAYS_IN_WEEK                        = 7;


@interface RegiDinaveckarCalendarViewController ()

@property (nonatomic, strong) NSString *currentStatuBtn;


@end

@implementation RegiDinaveckarCalendarViewController
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
@synthesize slider,sliderLabel;
//@synthesize isEventNotify,isTotalNotify;

/////////////////////////***************************///////////

@synthesize buttonString;
@synthesize editIndexValue;
@synthesize raderaBtn;
@synthesize totalDataArray;
@synthesize totalBtnTag;
@synthesize regiDinaDayCalendarVC;

@synthesize registreringObj;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark UITextView Delegate Methods
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


-(NSString*)yearStringFromDate:(NSDate*)date{
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormatter setDateFormat:@"yyyy"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}


-(NSString*)monthStringFromDate:(NSDate*)date{
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormatter setDateFormat:@"d/M"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"%@",registreringObj);
    
    NSString *titleStrin = @"Dina veckar";
    
    /*NSString *yearLabel1 = [self yearStringFromDate:[selectedDictionary valueForKey:kStartDate]];
    NSString *yearLabel2 = [self yearStringFromDate:[selectedDictionary valueForKey:kEndDate]];
    if([yearLabel1 isEqualToString:yearLabel2]){
       titleStrin  = [NSString stringWithFormat:@"%@ - %@ (%@)",[self monthStringFromDate:[selectedDictionary valueForKey:kStartDate]],[self monthStringFromDate:[selectedDictionary valueForKey:kEndDate]],yearLabel1];
    }else{
        titleStrin  = [NSString stringWithFormat:@"%@ (%@) - %@ (%@)",[self monthStringFromDate:[selectedDictionary valueForKey:kStartDate]],yearLabel1,[self monthStringFromDate:[selectedDictionary valueForKey:kEndDate]],yearLabel2];
    }*/
    
    self.navigationItem.title = titleStrin;
    
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
    
    raderaBtn.enabled = NO;
    
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
    
}


-(void)viewWillAppear:(BOOL)animated {
    
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc]init];
    [dateformatter setDateFormat:@"yyyy-MM-dd"];
    [self week:[dateformatter dateFromString:registreringObj.startDate]];
    
    if (!self.dataArray) {
        self.dataArray = [[NSMutableArray alloc] init];
    }
    
    self.totalDataArray = [[NSMutableArray alloc] init];
    
    //[self displayButton];
    [self getDataSub1Events];
    [self getDataSub1Total];
    
}

-(void)viewDidAppear:(BOOL)animated {
 
}

-(void)viewDidDisappear:(BOOL)animated{
    self.dataArray = nil;
}

-(void)viewWillDisappear:(BOOL)animated{
 
 // self.dataArray = nil;
    self.totalDataArray = nil;
}


-(void)dealloc {
    [dataArray release];
    [totalDataArray release];
    [super dealloc];
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



-(void)displayButton {
    
    for (id button in self.scrollView.subviews) {
        if ([button isKindOfClass:[UIButton class]]) {
            UIButton *btn = button;
            if (btn.layer.name) {
                btn.layer.name = nil;
            }
        }
    }
    NSMutableArray *array = [self.scrollView.layer.sublayers mutableCopy];
    for (CALayer *layer in array) {
        if (layer.name) {
            [layer removeFromSuperlayer];
        }
    }
    
    for (id sub in self.scrollView.subviews) {
        
        if ([sub isKindOfClass:[UIButton class]]) {
            UIButton *btn = sub;
            
            [btn addTarget:self action:@selector(touchBegan:withEvent:) forControlEvents:UIControlEventTouchUpInside];
            btn.layer.borderColor = [UIColor clearColor].CGColor;
            btn.layer.borderWidth = 1.0f;
            
            UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
            
            longPressGesture.minimumPressDuration = 1.0;
            [btn addGestureRecognizer:longPressGesture];
            
            
            NSString *index = [[NSString stringWithFormat:@"%d",btn.tag] substringToIndex:1];
            NSString *tag = [[NSString stringWithFormat:@"%d",btn.tag] substringFromIndex:1];
            
            for (int p=0; p < [dataArray count]; p++) {
                
                Events *dict = [dataArray objectAtIndex:p];
                
                NSString *dayTime = dict.dayTime;
                NSArray *array = [dayTime componentsSeparatedByString:@" "];
                NSString *date = [array objectAtIndex:0];
                
                NSArray *tm = [[self dateFromStringCal:[weekdays objectAtIndex:[index intValue]-1]] componentsSeparatedByString:@" "];
                
                if ([[tm objectAtIndex:0] isEqualToString:date]) {
                    
                    NSArray *startArray = [dict.startDate componentsSeparatedByString:@":"];
                    NSArray *endArray = [dict.endDate componentsSeparatedByString:@":"];
    
                    if ([tag intValue] == [[array objectAtIndex:1] intValue]) {
                        CALayer *layer = [CALayer layer];
                        
                        if ([dict.status isEqualToString:@"+"]) {
                            layer.backgroundColor = [UIColor greenColor].CGColor;
                           // layer.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"kalendar_cell_positive.png"]].CGColor;
                        }else if ([dict.status isEqualToString:@"-"]) {
                            layer.backgroundColor = [UIColor redColor].CGColor;
                           // layer.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"kalendar_cell_negative.png"]].CGColor;
                        }else if ([dict.status isEqualToString:@"Neutral"]){
                            layer.backgroundColor = [UIColor darkGrayColor].CGColor;
                            //layer.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"kalendar_cell_emptycell_neutral.png"]].CGColor;
                        }
                        
                        NSString *lastTag = nil;
                        int firstTa = [[startArray objectAtIndex:0] intValue];
                        int secondTa = [[endArray objectAtIndex:0] intValue];
                        
                        if (firstTa != secondTa) {
                            
                            lastTag = [NSString stringWithFormat:@"%@%d",index,secondTa+1];
                        }else {
                            lastTag = [NSString stringWithFormat:@"%@%@",index,[array objectAtIndex:1]];
                        }
                        UIButton *lastBtn = (UIButton *)[self.scrollView viewWithTag:[lastTag intValue]];
                        CGRect frame = CGRectMake(btn.frame.origin.x, btn.frame.origin.y+([[startArray objectAtIndex:1] intValue]/2), btn.frame.size.width,(lastBtn.frame.origin.y - btn.frame.origin.y - btn.frame.size.height)+([[endArray objectAtIndex:1] intValue]/2)+(btn.frame.size.height-([[startArray objectAtIndex:1] intValue]/2)));
                        
                        
                        layer.frame = frame;
                        layer.zPosition  = 100;
                        NSMutableArray *tagsArray = [[NSMutableArray alloc] init];
                        int c = [tag intValue] +1;
                        while (c < [[array objectAtIndex:1] intValue] && c > [tag intValue]) {
                            [tagsArray addObject:[NSString stringWithFormat:@"%@%d",index,c]];
                            c++;
                        }
                        for (int z= 0; z < [tagsArray count]; z++) {
                            UIButton *middleButton = (UIButton *)[self.scrollView viewWithTag:[[tagsArray objectAtIndex:z] intValue]];
                            middleButton.layer.name = dayTime;
                        }
                        CATextLayer *label = [[CATextLayer alloc] init];
                        [label setFont:@"Helvetica"];
                        [label setFontSize:12];
                        [label setFrame:CGRectMake(0, (frame.size.height/2)-10, frame.size.width, 20)];
                        [label setString:dict.eventDes];
                        [label setAlignmentMode:kCAAlignmentCenter];
                        [label setForegroundColor:[[UIColor blackColor] CGColor]];
                        layer.name = [NSString stringWithFormat:@"%d",p];
                        [layer addSublayer:label];
                        [self.scrollView.layer insertSublayer:layer atIndex:0];
                    }
                }
                
            }
        }
    }
}


-(void)touchBegan:(UIControl*)c withEvent:(UIEvent*)ev {
    
    UIButton *btn = (UIButton*)c;
    UITouch *touch = [[ev allTouches] anyObject];
    BOOL isExist = NO;
    NSDate *date=nil;
    
    NSString *btag = [NSString stringWithFormat:@"%i",btn.tag];
    NSString *subString =  [btag substringFromIndex:1];
    
    NSLog(@"-----$$$$$ %i",[[btag substringToIndex:1] intValue]);
    
    date = [self.weekdays objectAtIndex:[[btag substringToIndex:1] intValue]-1];
    
    NSArray *tm = [[self dateFromStringCal:date] componentsSeparatedByString:@" "];
    
    buttonString = [[tm objectAtIndex:0] retain];
    
    CGPoint touchPoint = [touch locationInView:self.scrollView];
    for (CALayer *layer in self.scrollView.layer.sublayers) {
        if ([layer containsPoint:[self.scrollView.layer convertPoint:touchPoint toLayer:layer]] && btn.layer != layer) {
            NSLog(@"data ---%d",[layer.name intValue]);
            Events *temp = [dataArray objectAtIndex:[layer.name intValue]];
            
            editIndexValue = [[NSString stringWithFormat:@"%i",[layer.name intValue]] retain];
            currentStatuBtn = temp.status;
            NSArray *sDA = [temp.startDate componentsSeparatedByString:@":"];
            NSArray *eDA = [temp.endDate componentsSeparatedByString:@":"];
            eventDesTextView.text = temp.eventDes;
            
            hoursTextField1.text = [NSString stringWithFormat:@"%.2i",[[sDA objectAtIndex:0] intValue]];
            
            
            hoursTextField2.text = [NSString stringWithFormat:@"%.2i",[[eDA objectAtIndex:0] intValue]];
            
            
            
            raderaBtn.enabled =YES;
            
            isExist = YES;
        }
    }
    if (!isExist) {
        NSLog(@"not -----$$$$$ %@",btn.layer.name);
        eventDesTextView.text = @"";
        
        hoursTextField1.text = [NSString stringWithFormat:@"%.2i",[subString intValue]-1];
        
        hoursTextField2.text = [NSString stringWithFormat:@"%.2i",[hoursTextField1.text intValue]+1];
        
        raderaBtn.enabled = NO;
        editIndexValue= nil;
    }
    ASDepthModalOptions style = ASDepthModalOptionAnimationGrow;
    [ASDepthModalViewController presentView:self.popupView
                            backgroundColor:nil
                                    options:style
                          completionHandler:^{
                              NSLog(@"Modal view closed.");
                          }];
}



- (void)longPress:(UIGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateBegan)
    {
        UIButton *btn = (UIButton*)[gesture view];
        BOOL isExist = NO;
        NSString *btag = [NSString stringWithFormat:@"%i",btn.tag];
        //NSString *subString =  [btag substringFromIndex:1];
        NSDate *date = [self.weekdays objectAtIndex:[[btag substringToIndex:1] intValue]-1];
        NSArray *tm = [[self dateFromStringCal:date] componentsSeparatedByString:@" "];
        buttonString = [[tm objectAtIndex:0] retain];
        CGPoint touchPoint = [gesture locationInView:self.scrollView];
        for (CALayer *layer in self.scrollView.layer.sublayers) {
            if ([layer containsPoint:[self.scrollView.layer convertPoint:touchPoint toLayer:layer]] && btn.layer != layer) {
                editIndexValue = [[NSString stringWithFormat:@"%i",[layer.name intValue]] retain];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"KBT" message:@"Är du säker på att du vill radera aktiviteten?" delegate:self cancelButtonTitle:@"Avbryt" otherButtonTitles:@"Radera",nil];
                [alert show];
                [alert release];
                break;
                isExist = YES;
            }
        }
        if (!isExist) {
            NSLog(@"not -----$$$$$ %@",btn.layer.name);
            /*eventDesTextView.text = @"";
             hoursTextField1.text = [NSString stringWithFormat:@"%.2i",[subString intValue]-1];
             hoursTextField2.text = [NSString stringWithFormat:@"%.2i",[hoursTextField1.text intValue]+1];
             raderaBtn.enabled = NO;
             editIndexValue= nil;*/
        }
    }
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        
    }else {
        [self raderaClicked:nil];
        [self displayButton];
    }
}



-(IBAction)raderaButtonClicked:(id)sender {
    [ASDepthModalViewController dismiss];
    [self raderaClicked:nil];
    
}


-(void)raderaClicked:(id)sender {
    
    if (editIndexValue) {
        Events *deleDict = [dataArray objectAtIndex:[editIndexValue intValue]];
        [dataArray removeObject:deleDict];
        BOOL success = [[DataBaseHelper sharedDatasource] deleteDBEvent:deleDict.rowId];
        NSLog(@"event delete successfully %d",success);
    }
    editIndexValue = nil;
}


-(void)getDataSub1Events {
    
    dataArray = [[[DataBaseHelper sharedDatasource] findEventsFromNewRegis:registreringObj.rowId] mutableCopy];
    
    [self displayButton];
}


-(void)getDataSub1Total
{
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &exerciseDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat: @"SELECT * FROM SUB1TOTAL"];
        
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(exerciseDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            
            while  (sqlite3_step(statement) == SQLITE_ROW) {
                NSString *subTId = [NSString stringWithFormat:@"%s",sqlite3_column_text(statement,1)];
                NSString *dayDate = [NSString stringWithFormat:@"%s",sqlite3_column_text(statement,2)];
                NSString *total = [NSString stringWithFormat:@"%s",sqlite3_column_text(statement, 3)];
                
                NSMutableDictionary *itemDict = [[NSMutableDictionary alloc]init];
                [itemDict setValue:subTId forKey:kTSub1Id];
                [itemDict setValue:dayDate forKey:kTDate];
                [itemDict setValue:total forKey:kTTotal];
                
                [totalDataArray addObject:itemDict];
            }
        }
        sqlite3_finalize(statement);
    }
    sqlite3_close(exerciseDB);
    
}


-(NSString*)dateFromStringCal:(NSDate*)date {
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}



-(void)backButon  {
    
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark SettingViewController

/*-(void)settButtonClicked {
    
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
}*/



-(BOOL)findSameTime {
    
    BOOL isTime;
    
    NSString *startDate = [NSString stringWithFormat:@"%@:%@",hoursTextField1.text,mintsTextField1.text];
    for (int i = 0; i < [dataArray count]; i++) {
        Events *tem = [dataArray objectAtIndex:i];
        if ([tem.startDate isEqualToString:startDate]){
            isTime =  YES;
        }else {
            isTime = NO;
        }
    }
    
    return isTime;
}


-(IBAction)okButtonClicked:(id)sender
{
    
    if ([self findSameTime]  && [editIndexValue length] == 0 && editIndexValue == nil) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"KBT Appen" message:@"Already Exits" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
        [alert show];
    }
    else {
        [ASDepthModalViewController dismiss];
        
        if (editIndexValue) {
            Events *temp = [dataArray objectAtIndex:[editIndexValue intValue]];
            NSString *startDate = [NSString stringWithFormat:@"%@:%@",hoursTextField1.text,mintsTextField1.text];
            NSString *endDate =[NSString stringWithFormat:@"%@:%@",hoursTextField2.text,mintsTextField2.text];
            NSString *dayTime = [NSString stringWithFormat:@"%@ %i",buttonString,[hoursTextField1.text intValue]+1];
            temp.eventDes = eventDesTextView.text;
            temp.startDate = startDate;
            temp.endDate = endDate;
            temp.dayTime = dayTime;
            temp.status = currentStatuBtn;
            temp.newRowId = registreringObj.rowId;
        }else {
            Events *temp = [[Events alloc] init];
            NSString *startDate = [NSString stringWithFormat:@"%@:%@",hoursTextField1.text,mintsTextField1.text];
            NSString *endDate =[NSString stringWithFormat:@"%@:%@",hoursTextField2.text,mintsTextField2.text];
            NSString *dayTime = [NSString stringWithFormat:@"%@ %i",buttonString,[hoursTextField1.text intValue]+1];
            
            if (!currentStatuBtn)
                currentStatuBtn = @"Neutral";
            
            temp.eventDes = eventDesTextView.text;
            temp.startDate = startDate;
            temp.endDate = endDate;
            temp.dayTime = dayTime;
            temp.status = currentStatuBtn;
            temp.newRowId = registreringObj.rowId;
            [dataArray addObject:temp];
        }
        editIndexValue = nil;
        [self displayButton];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            // The user has granted access to their Calendar; let's populate our UI with all events occuring in the next 24 hours.
            [self  databaseInsert];
        });
    }
}


-(IBAction)totalOkButtonClicked:(id)sender {
    
    [ASDepthModalViewController dismiss];
    NSLog(@"%@",editIndexValue);
    if (editIndexValue) {
        NSString *dayTime = [NSString stringWithFormat:@"%@ %@",buttonString,totalBtnTag];
        NSMutableDictionary *teDic = [self.totalDataArray objectAtIndex:[editIndexValue intValue]];
        [teDic setValue:dayTime forKey:kTDate];
        [teDic setValue:sliderLabel.text forKey:kTTotal];
        
    }else {
        NSMutableDictionary *teDic = [[NSMutableDictionary alloc] init];
        NSString *dayTime = [NSString stringWithFormat:@"%@ %@",buttonString,totalBtnTag];
        [teDic setValue:[NSNumber numberWithInt:[self.totalDataArray count]+1] forKey:kTSub1Id];
        [teDic setValue:dayTime forKey:kTDate];
        [teDic setValue:sliderLabel.text forKey:kTTotal];
        [self.totalDataArray addObject:teDic];
    }
    editIndexValue = nil;
    NSLog(@"totalArray is %@",self.totalDataArray);
    [self databaseInsertTotal];
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
    UIButton *btn = (UIButton *)sender;
    
    NSDate *date=nil;
    NSString *btag = [NSString stringWithFormat:@"%i",btn.tag];
    NSString *subString =  [btag substringFromIndex:1];
    totalBtnTag = [subString retain];
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
    
    NSArray *tm = [[self dateFromStringCal:date] componentsSeparatedByString:@" "];
    buttonString = [[tm objectAtIndex:0] retain];
    BOOL isExit = NO;
    for (int y=0; y<[self.totalDataArray count]; y++) {
        NSDictionary *tempDict = [self.totalDataArray objectAtIndex:y];
        if ([[tempDict valueForKey:kTDate] isEqualToString:[NSString stringWithFormat:@"%@ %i",[tm objectAtIndex:0],[subString intValue]]]){
            editIndexValue = [[NSString stringWithFormat:@"%i",y] retain];
            [sliderLabel setText:[tempDict valueForKey:kTTotal]];
            NSInteger myInt = [[tempDict valueForKey:kTTotal] intValue];
            [slider setValue:myInt animated:YES];
            isExit = YES;
        }
    }
    if (!isExit){
        [sliderLabel setText:@"0"];
        NSInteger myInt = [sliderLabel.text intValue];
        [slider setValue:myInt animated:YES];
        editIndexValue= nil;
    }
    
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
    UIButton *btn = (UIButton *)sender;
    
    NSDate *date=nil;

    if ([btn tag] == 1) {
        date = [self.weekdays objectAtIndex:0];
        
    }else if ([btn tag] == 2) {
        date = [self.weekdays objectAtIndex:1];
        
    }else if ([btn tag] == 3){
        date = [self.weekdays objectAtIndex:2];
        
    }else if ([btn tag] == 4) {
        date = [self.weekdays objectAtIndex:3];
        
    }else if ([btn tag] == 5) {
        date = [self.weekdays objectAtIndex:4];
        
    }else if ([btn tag] == 6) {
        date = [self.weekdays objectAtIndex:5];
        
    }else if ([btn tag] == 7) {
        date = [self.weekdays objectAtIndex:6];
    }
    
    NSArray *tm = [[self dateFromStringCal:date] componentsSeparatedByString:@" "];
    
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        if ([[UIScreen mainScreen] bounds].size.height > 480) {
            if (!regiDinaDayCalendarVC) {
                regiDinaDayCalendarVC = [[RegiDinaveckarDayCalendarViewController alloc]initWithNibName:@"RegiDinaveckarDayCalendarView" bundle:nil];
            }
        }else{
            if (!regiDinaDayCalendarVC) {
                regiDinaDayCalendarVC = [[RegiDinaveckarDayCalendarViewController alloc]initWithNibName:@"RegiDinaveckarDayCalendarView_iPhone4" bundle:nil];
            }
        }
    }
    else{
        if (!regiDinaDayCalendarVC) {
            regiDinaDayCalendarVC = [[RegiDinaveckarDayCalendarViewController alloc]initWithNibName:@"RegiDinaveckarDayCalendarView_iPad" bundle:nil];
        }
    }
    
    regiDinaDayCalendarVC.dayTimenTag =[NSString stringWithFormat:@"%@ %i",[tm objectAtIndex:0],[btn tag]];
    
    [self.navigationController pushViewController:regiDinaDayCalendarVC animated:YES];
}


#pragma mark Status Button

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
            currentStatuBtn = @"Neutral";
            break;
    }
}

#pragma mark Calendar 

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
}

#define ksSunDay @"Sön"  //Sunday
#define ksMonDay @"Män"  //Monday
#define ksTueDay @"Tis"  //Tuesday
#define ksWedDay @"Ons"  //Wendesday
#define ksThuDay @"Tors" //Thursday
#define ksFriDay @"Fre"  //Friday
#define ksSatDay @"Lör"  //Saturday


#define keSunDay @"Sun"  //Sunday
#define keMonDay @"Mon"  //Monday
#define keTueDay @"Tue"  //Tuesday
#define keWedDay @"Wed"  //Wendesday
#define keThuDay @"Thu" //Thursday
#define keFriDay @"Fri"  //Friday
#define keSatDay @"Sat"  //Saturday


-(NSString *)weekdayString:(NSString*)indexString {
    NSString *sDayString = nil;
    
    if ([indexString isEqualToString:keSunDay]) {
        sDayString = ksSunDay;
    }else if ([indexString isEqualToString:keMonDay]) {
        sDayString = ksMonDay;
    }else if ([indexString isEqualToString:keTueDay]) {
        sDayString = ksTueDay;
    }else if ([indexString isEqualToString:keWedDay]) {
        sDayString = ksWedDay;
    }else if ([indexString isEqualToString:keThuDay]) {
        sDayString = ksThuDay;
    }else if ([indexString isEqualToString:keFriDay]) {
        sDayString = ksFriDay;
    }else if ([indexString isEqualToString:keSatDay]) {
        sDayString = ksSatDay;
    }
    
    return sDayString;
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
                
                [monButton1 setTitle:[self weekdayString:weeday] forState:UIControlStateNormal];
                break;
            case 1:
                [tueButton2 setTitle:[self weekdayString:weeday] forState:UIControlStateNormal];
                break;
            case 2:
                [wedButton3 setTitle:[self weekdayString:weeday] forState:UIControlStateNormal];
                break;
            case 3:
                [thrButton4 setTitle:[self weekdayString:weeday] forState:UIControlStateNormal];
                break;
            case 4:
                [friButton5 setTitle:[self weekdayString:weeday] forState:UIControlStateNormal];
                break;
            case 5:
                [satButton6 setTitle:[self weekdayString:weeday] forState:UIControlStateNormal];
                break;
            case 6:
                [sunButton7 setTitle:[self weekdayString:weeday] forState:UIControlStateNormal];
                break;
            default:
                break;
        }
    }
}


#pragma mark -- DataBase Methods

-(void)databaseInsert {
    for (int i = 0; i < [dataArray count]; i++) {
        Events *dataDic = [dataArray objectAtIndex:i];
        BOOL success = [[DataBaseHelper sharedDatasource] updateDBEventDate:@"" start:dataDic.startDate end:dataDic.endDate stus:dataDic.status dayDate:dataDic.dayTime desc:dataDic.eventDes newRI:registreringObj.rowId where:dataDic.rowId];
        NSLog(@"updated record %d",success);
    }
}


#pragma mark SUB1TOTAL DATA BASE METHODS

- (BOOL)findContactTotal:(NSNumber*)questionId {
    
    const char *dbpath = [databasePath UTF8String];
    
    BOOL isFind = NO;
    
    if (sqlite3_open(dbpath, &exerciseDB) == SQLITE_OK)
    {
        NSInteger sub1TID = [questionId integerValue];
        
        NSString *querySQL = [NSString stringWithFormat: @"SELECT subTId FROM SUB1TOTAL WHERE subTId=\"%d\"", sub1TID];
        
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

-(void)updateIntDatabaseT:(NSDictionary*)updateDic {
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &exerciseDB) == SQLITE_OK)
    {
        NSInteger subTId = [[updateDic valueForKey:kTSub1Id] integerValue];
        
        NSString *query=[NSString stringWithFormat:@"UPDATE SUB1TOTAL SET date='%@', total='%@' WHERE subTId='%d'",[updateDic valueForKey:kTDate], [updateDic valueForKey:kTTotal],subTId];
        
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

-(void)insertIntoDatabaseT:(NSDictionary*)recordDic
{
   
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &exerciseDB) == SQLITE_OK)
    {
        NSInteger subId = [[recordDic valueForKey:kTSub1Id] integerValue];
        
        NSString *insertSQL = [NSString stringWithFormat: @"INSERT INTO SUB1TOTAL (subTId,date,total) VALUES (\"%d\", \"%@\", \"%@\")",subId,[recordDic valueForKey:kTDate],[recordDic valueForKey:kTTotal]];
        
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

-(void)deleteRecordT:(NSDictionary*)deleDic {
    
}


-(void)databaseInsertTotal {
    NSLog(@"%@",self.totalDataArray);
    for (int i = 0; i < [self.totalDataArray count]; i++) {
        
        NSDictionary *dataDic = [self.totalDataArray objectAtIndex:i];
        
        if ([self findContactTotal:[dataDic valueForKey:kTSub1Id]]) {
            NSLog(@"Updating");
            [self updateIntDatabaseT:dataDic];
        }else {
            NSLog(@"New Record");
            [self insertIntoDatabaseT:dataDic];
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
        if ([textField.text integerValue] >= 24) {
            hoursTextField2.text = @"00";
        }
        else {
            int h1 = [textField.text integerValue];
            h1 += 1;
            hoursTextField2.text = [NSString stringWithFormat:@"%.2i",h1];
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
