//
//  DayCalendarViewController.m
//  Välkommen till TFH-appen
//
//  Created by Chandrika on 27/07/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import "DayCalendarViewController.h"
#import "ASDepthModalViewController.h"


//SUB1EVENTS
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


@interface DayCalendarViewController ()

@end

@implementation DayCalendarViewController
@synthesize dayButton;
@synthesize dayTimenTag;
@synthesize dayScrollView;
@synthesize dataArray;

@synthesize popupView,totalView;
@synthesize hoursTextField1,hoursTextField2;
@synthesize mintsTextField1,mintsTextField2;
@synthesize eventDesTextView;
@synthesize currentStatuBtn;
@synthesize slider,sliderLabel;


/////////////////////////***************************///////////
@synthesize buttonString;
@synthesize editIndexValue;
@synthesize raderaBtn;
@synthesize totalDataArray;
@synthesize totalBtnTag;


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
    NSLog(@"current String is %@",dayTimenTag);
    self.navigationItem.title=@"Day Calendar";
    [self.dayScrollView setContentSize:CGSizeMake(320, 699)];
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
        const char *sql_stmt1 = "CREATE TABLE IF NOT EXISTS SUB1TOTAL (id INTEGER PRIMARY KEY AUTOINCREMENT,subTId TEXT,date TEXT,total TEXT)";
        
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
}


-(void)viewWillAppear:(BOOL)animated {
   
    self.dataArray = [[NSMutableArray alloc]init];
    self.totalDataArray = [[NSMutableArray alloc] init];
    [self getDataSub1Events];
    [self getDataSub1Total];
}

-(void)viewDidAppear:(BOOL)animated {
    
}

-(void)viewDidDisappear:(BOOL)animated{
    
    
}

-(void)viewWillDisappear:(BOOL)animated{
    
    self.dataArray = nil;
    self.totalDataArray = nil;
}


-(void)dealloc {
    [dataArray release];
    [totalDataArray release];
    [super dealloc];
}


-(void)displayButton {
    
    NSLog(@"display Buttons is %@",self.dataArray);
    
    NSArray *stA = [dayTimenTag componentsSeparatedByString:@" "];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSArray *weekdaySymbols = [dateFormatter shortWeekdaySymbols];
    NSDate *date = [dateFormatter dateFromString:[stA  objectAtIndex:0]];
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *weekdayComponents =[gregorian components:NSWeekdayCalendarUnit fromDate:date];
    NSInteger weekday = [weekdayComponents weekday];
    [gregorian release];
    NSString *weeday =[weekdaySymbols objectAtIndex:weekday-1];
    
    [dayButton setTitle:weeday forState:UIControlStateNormal];
    
    for (int j =0; j < 24 ; j++) {
        UIButton *but = [[UIButton alloc] initWithFrame:CGRectMake(37, j*29,274, 29)];
        but.titleLabel.textAlignment = UITextAlignmentCenter;
        but.layer.borderColor = [UIColor clearColor].CGColor;
        but.layer.borderWidth = 1.0f;
        NSString *strin = [NSString stringWithFormat:@"%@%d",[stA objectAtIndex:1],(j+1)];
        [but setTag:[strin intValue]];
        [but setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [but setBackgroundImage:[UIImage imageNamed:@"kalendar_cell_empty.png"] forState:UIControlStateNormal];
        [self.dayScrollView addSubview:but];
        [self.dayScrollView setContentSize:CGSizeMake(self.dayScrollView.frame.size.width, 24*29)];
    }
    
    for (id button in self.dayScrollView.subviews) {
        if ([button isKindOfClass:[UIButton class]]) {
            UIButton *btn = button;
            if (btn.layer.name) {
                btn.layer.name = nil;
            }
        }
    }
    NSMutableArray *array = [self.dayScrollView.layer.sublayers mutableCopy];
    for (CALayer *layer in array) {
        if (layer.name) {
            [layer removeFromSuperlayer];
        }
    }
    
    for (id sub in self.dayScrollView.subviews) {
        
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
                NSMutableDictionary *dict = [dataArray objectAtIndex:p];
                NSString *dayTime = [dict objectForKey:kDayTime];
                NSArray *array = [dayTime componentsSeparatedByString:@" "];
                NSString *date = [array objectAtIndex:0];
                
                
                if ([[stA objectAtIndex:0] isEqualToString:date]) {
                    
                    NSArray *startArray = [[dict objectForKey:kStartDate] componentsSeparatedByString:@":"];
                    NSArray *endArray = [[dict objectForKey:kEndDate] componentsSeparatedByString:@":"];
                    
                    
                    if ([tag intValue] == [[array objectAtIndex:1] intValue]) {
                        
                        CALayer *layer = [CALayer layer];
                        
                        if ([[dict objectForKey:kStatus] isEqualToString:@"+"]) {
                            layer.backgroundColor = [UIColor greenColor].CGColor;
                        }else if ([[dict objectForKey:kStatus ] isEqualToString:@"-"]) {
                            layer.backgroundColor = [UIColor redColor].CGColor;
                        }else if ([[dict objectForKey:kStatus] isEqualToString:@"Neutral"]){
                            layer.backgroundColor = [UIColor darkGrayColor].CGColor;
                        }else {
                            [btn setBackgroundImage:[UIImage imageNamed:@"kalendar_cell_empty.png"] forState:UIControlStateNormal];
                            [btn setTitle:@"" forState:UIControlStateNormal];
                        }
                        
                        NSString *lastTag = nil;
                        int firstTa = [[startArray objectAtIndex:0] intValue];
                        int secondTa = [[endArray objectAtIndex:0] intValue];
                        
                        if (firstTa != secondTa) {
                            
                            lastTag = [NSString stringWithFormat:@"%@%d",index,secondTa+1];
                        }else {
                            lastTag = [NSString stringWithFormat:@"%@%@",index,[array objectAtIndex:1]];
                        }
                        UIButton *lastBtn = (UIButton *)[self.dayScrollView viewWithTag:[lastTag intValue]];
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
                            UIButton *middleButton = (UIButton *)[self.dayScrollView viewWithTag:[[tagsArray objectAtIndex:z] intValue]];
                            middleButton.layer.name = dayTime;
                        }
                        CATextLayer *label = [[CATextLayer alloc] init];
                        [label setFont:@"Helvetica"];
                        [label setFontSize:12];
                        [label setFrame:CGRectMake(0, (frame.size.height/2)-10, frame.size.width, 20)];
                        [label setString:[dict objectForKey:kEventDes]];
                        [label setAlignmentMode:kCAAlignmentCenter];
                        [label setForegroundColor:[[UIColor blackColor] CGColor]];
                        layer.name = [NSString stringWithFormat:@"%d",p];
                        [layer addSublayer:label];
                        [self.dayScrollView.layer insertSublayer:layer atIndex:0];
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
    NSArray *tm = [dayTimenTag componentsSeparatedByString:@" "];
    
    NSString *btag = [NSString stringWithFormat:@"%i",btn.tag];
    NSString *subString =  [btag substringFromIndex:1];
    

    buttonString = [[tm objectAtIndex:0] retain];
    
    CGPoint touchPoint = [touch locationInView:self.dayScrollView];
    
    for (CALayer *layer in self.dayScrollView.layer.sublayers) {
        if ([layer containsPoint:[self.dayScrollView.layer convertPoint:touchPoint toLayer:layer]] && btn.layer != layer) {
            NSLog(@"data ---%d",[layer.name intValue]);
            NSMutableDictionary *temp = [dataArray objectAtIndex:[layer.name intValue]];
            
            editIndexValue = [[NSString stringWithFormat:@"%i",[layer.name intValue]] retain];
            currentStatuBtn = [temp valueForKey:kStatus];
            NSArray *sDA = [[temp valueForKey:kStartDate] componentsSeparatedByString:@":"];
            NSArray *eDA = [[temp valueForKey:kEndDate] componentsSeparatedByString:@":"];
            eventDesTextView.text = [temp valueForKey:kEventDes];
            
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
        editIndexValue = nil;
        
        
    }
    ASDepthModalOptions style = ASDepthModalOptionAnimationGrow;
    [ASDepthModalViewController presentView:self.popupView
                            backgroundColor:nil
                                    options:style
                          completionHandler:^{
                              NSLog(@"Modal view closed.");
                          }];
}



- (void)longPress:(UIGestureRecognizer *)gesture{
    
    if (gesture.state == UIGestureRecognizerStateBegan)
    {
        
        UIButton *btn = (UIButton*)[gesture view];
        
        NSArray *tm = [dayTimenTag componentsSeparatedByString:@" "];
        
        buttonString = [[tm objectAtIndex:0] retain];
        

        BOOL isExist = NO;
        
        CGPoint touchPoint = [gesture locationInView:self.dayScrollView];
        for (CALayer *layer in self.dayScrollView.layer.sublayers) {
            if ([layer containsPoint:[self.dayScrollView.layer convertPoint:touchPoint toLayer:layer]] && btn.layer != layer) {
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

/*- (void)longPress:(UIGestureRecognizer *)gesture{
    
    if (gesture.state == UIGestureRecognizerStateBegan)
    {
        
        UIButton *btn = (UIButton*)[gesture view];
        
        NSArray *stA = [dayTimenTag componentsSeparatedByString:@" "];
        
        NSString *btag = [NSString stringWithFormat:@"%i",btn.tag];
        NSString *subString =  [btag substringFromIndex:1];
        
        buttonString = [[stA objectAtIndex:0] retain];
        
        for (int q= 0; q<[dataArray count]; q++) {
            NSMutableDictionary *temp = [dataArray objectAtIndex:q];
            
            if ([[temp valueForKey:kDayTime] isEqualToString:[NSString stringWithFormat:@"%@ %i",[stA objectAtIndex:0],[subString intValue]]]) {
                editIndexValue = [[NSString stringWithFormat:@"%i",q] retain];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Delete" message:[temp valueForKey:kEventDes] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Radera",nil];
                
                [alert show];
                [alert release];
                break;
            }
        }
        
    }
}*/

/*-(void)emptyCell:(id)sender {
    
    UIButton *btn = (UIButton*)sender;
    
    NSArray *tm = [dayTimenTag componentsSeparatedByString:@" "];
    
    NSString *btag = [NSString stringWithFormat:@"%i",btn.tag];
    NSString *subString =  [btag substringFromIndex:1];
    
    buttonString = [[tm objectAtIndex:0] retain];
    BOOL isExit=NO;
    for (int q= 0; q<[dataArray count]; q++) {
        NSMutableDictionary *temp = [dataArray objectAtIndex:q];
        
        if ([[temp valueForKey:kDayTime] isEqualToString:[NSString stringWithFormat:@"%@ %i",[tm objectAtIndex:0],[subString intValue]]]) {
            editIndexValue = [[NSString stringWithFormat:@"%i",q] retain];
            currentStatuBtn = [temp valueForKey:kStatus];
            NSArray *sDA = [[temp valueForKey:kStartDate] componentsSeparatedByString:@":"];
            NSArray *eDA = [[temp valueForKey:kEndDate] componentsSeparatedByString:@":"];
            eventDesTextView.text = [temp valueForKey:kEventDes];
            
            hoursTextField1.text = [NSString stringWithFormat:@"%.2i",[[sDA objectAtIndex:0] intValue]];
            hoursTextField2.text = [NSString stringWithFormat:@"%.2i",[[eDA objectAtIndex:0] intValue]];
            isExit = YES;
            raderaBtn.enabled =YES;
        }
    }
    if (!isExit) {
        eventDesTextView.text = @"";
        
        hoursTextField1.text = [NSString stringWithFormat:@"%.2i",[subString intValue]-1];
        hoursTextField2.text = [NSString stringWithFormat:@"%.2i",[hoursTextField1.text intValue]+1];
        
        raderaBtn.enabled = NO;
        editIndexValue = nil;
    }
    ASDepthModalOptions style = ASDepthModalOptionAnimationGrow;
    [ASDepthModalViewController presentView:self.popupView
                            backgroundColor:nil
                                    options:style
                          completionHandler:^{
                              NSLog(@"Modal view closed.");
                          }];
}*/


-(void)getDataSub1Events {
    
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
                
                [self.dataArray addObject:itemDict];
            }
        }
        sqlite3_finalize(statement);
    }
    sqlite3_close(exerciseDB);
    
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


-(NSString*)dateFromString:(NSDate*)date {
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}



-(void)backButon  {
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(BOOL)findSameTime {
    
    BOOL isTime;
    
    NSString *startDate = [NSString stringWithFormat:@"%@:%@",hoursTextField1.text,mintsTextField1.text];
    for (int i = 0; i < [dataArray count]; i++) {
        NSDictionary *tem = [dataArray objectAtIndex:i];
        if ([[tem valueForKey:kStartDate] isEqualToString:startDate]){
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
        
    }else {
        
        [ASDepthModalViewController dismiss];
        
        if (editIndexValue) {
            NSMutableDictionary *temp = [self.dataArray objectAtIndex:[editIndexValue intValue]];
            NSString *startDate = [NSString stringWithFormat:@"%@:%@",hoursTextField1.text,mintsTextField1.text];
            NSString *endDate =[NSString stringWithFormat:@"%@:%@",hoursTextField2.text,mintsTextField2.text];
            NSString *dayTime = [NSString stringWithFormat:@"%@ %i",buttonString,[hoursTextField1.text intValue]+1];
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
            
            if (!currentStatuBtn)
                currentStatuBtn = @"Neutral";
            
            [temp setValue:[NSNumber numberWithInt:[self.dataArray count]+1] forKey:kSub1Id];
            [temp setValue:eventDesTextView.text forKey:kEventDes];
            [temp setValue:startDate forKey:kStartDate];
            [temp setValue:endDate forKey:kEndDate];
            [temp setValue:dayTime forKey:kDayTime];
            [temp setValue:currentStatuBtn forKey:kStatus];
            [self.dataArray addObject:temp];
        }
        editIndexValue = nil;
        
        //[self displayButton];
        
        [self  databaseInsert];
    }
}


-(IBAction)totalOkButtonClicked:(id)sender {
    
    [ASDepthModalViewController dismiss];
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

    [self databaseInsertTotal];
}




#pragma mark TotalButtonClicked

-(IBAction)totalButtonClicked:(id)sender
{
    UIButton *btn = (UIButton *)sender;

    NSArray *tm = [dayTimenTag componentsSeparatedByString:@" "];

    NSString *btag = [NSString stringWithFormat:@"%i",btn.tag];
    totalBtnTag = [btag retain];
   
    buttonString = [[tm objectAtIndex:0] retain];
    BOOL isExit = NO;
    for (int y=0; y<[self.totalDataArray count]; y++) {
        NSDictionary *tempDict = [self.totalDataArray objectAtIndex:y];
        if ([[tempDict valueForKey:kTDate] isEqualToString:[NSString stringWithFormat:@"%@ %i",[tm objectAtIndex:0],[btn tag]]]){
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
        editIndexValue = nil;
        
    }
    
    ASDepthModalOptions style = ASDepthModalOptionAnimationGrow;
    [ASDepthModalViewController presentView:self.totalView
                            backgroundColor:nil
                                    options:style
                          completionHandler:^{
                          }];
}



-(IBAction)closeButtonAction:(id)sender{
    [ASDepthModalViewController dismiss];
}



-(IBAction)sliderValueChanged:(UISlider*)sender{
    sliderLabel.text = [NSString stringWithFormat:@"%.0f",[sender value]];
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
        NSDictionary *deleDict = [self.dataArray objectAtIndex:[editIndexValue intValue]];
        [self.dataArray removeObject:deleDict];
        [self deleteRecord:deleDict];
    }
    editIndexValue = nil;
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


-(void)deleteRecord:(NSDictionary*)deleDic {
    
    if (sqlite3_open([databasePath UTF8String], &exerciseDB) == SQLITE_OK) {
        
        NSInteger subId = [[deleDic valueForKey:kSub1Id] integerValue];
        
        NSString *sql = [NSString stringWithFormat: @"DELETE FROM SUB1EVENT WHERE subId='%d'",subId];
        
        const char *del_stmt = [sql UTF8String];
        
        sqlite3_prepare_v2(exerciseDB, del_stmt, -1, & statement, NULL);
        
        if (sqlite3_step(statement) == SQLITE_ROW) {
            
            NSLog(@"sss");
            
        }
        sqlite3_finalize(statement);
    }
    sqlite3_close(exerciseDB);
}



-(void)databaseInsert {
    
    for (int i = 0; i < [self.dataArray count]; i++) {
        
        NSDictionary *dataDic = [self.dataArray objectAtIndex:i];
        
        if ([self findContact:[dataDic valueForKey:kSub1Id]]) {
            NSLog(@"Updating");
            [self updateIntDatabase:dataDic];
        }else {
            NSLog(@"New Record");
            [self insertIntoDatabase:dataDic];
        }
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
        if ([textField.text length] > 24) {
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
    // Dispose of any resources that can be recreated.
}

@end
