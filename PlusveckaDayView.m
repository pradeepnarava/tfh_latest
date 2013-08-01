//
//  PlusveckaDayView.m
//  Välkommen till TFH-appen
//
//  Created by Brilliance Tech Sols on 7/21/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import "PlusveckaDayView.h"

@interface PlusveckaDayView ()
@property (nonatomic, strong) NSString *currentDateBtn,*tabValue;
@property (nonatomic, strong) NSString *currentStatuBtn;
@end
#define kStartDate @"startDate"
#define kEndDate   @"endDate"
#define kStatus    @"status"
#define kDayTime   @"dayTime"
#define kEventDes  @"eventDes"
#define kSub2Id    @"Sub2Id"
@implementation PlusveckaDayView
@synthesize currentDateBtn,currentStatuBtn,tabValue;
@synthesize scrollView,raderaBtn;
@synthesize hoursTextField1,hoursTextField2,mintsTextField1,mintsTextField2;
@synthesize eventDesTextView,slider,sliderLabel;
@synthesize popupView,totalView;
@synthesize isDinackar;
@synthesize sub1EventsArray,dataArray;
@synthesize selectedDate;
@synthesize dateButton;
@synthesize buttonString,editIndexValue,editTotalValue,dateIndexValue,totalArray;
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
    NSString *docsDir;
    NSArray *dirPaths;
    
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    
    // Build the path to the database file
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"exerciseDB.db"]];

    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated{
    for (int i =0; i <[[self.scrollView subviews] count]; i++) {
        
        UIButton *btn = [[self.scrollView subviews] objectAtIndex:i];
        if ([btn isKindOfClass:[UIButton class]]) {
            [btn setTitle:@"" forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageNamed:@"kalendar_cell_empty.png"] forState:UIControlStateNormal];
        }
    }
    [self displayButton];
    [self updateScreens];
    [super viewWillAppear:YES];
}

-(void)displayButton {
    
    for (int i =0; i <[[self.scrollView subviews] count]; i++) {
        
        UIButton *btn = [[self.scrollView subviews] objectAtIndex:i];
        if ([btn isKindOfClass:[UIButton class]]) {
            
            NSString *statusString = nil;
            NSString *btag = [NSString stringWithFormat:@"%i",btn.tag];
            NSString *subString1 =  [btag substringFromIndex:1];
            NSString *subString = [subString1 substringToIndex:subString1.length-1];
            NSString *whichString = [subString1 substringFromIndex:subString1.length-1];
            
            NSArray *tm = [[self dateFromString:selectedDate] componentsSeparatedByString:@" "];
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

-(void)backButon {
    [self.navigationController popViewControllerAnimated:YES];
}




-(void)updateScreens {
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init]autorelease];
    NSArray *weekdaySymbols = [dateFormatter weekdaySymbols];

		
        NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateComponents *weekdayComponents =[gregorian components:NSWeekdayCalendarUnit fromDate:selectedDate];
        NSInteger weekday = [weekdayComponents weekday];
        [gregorian release];
        NSString *weeday =[weekdaySymbols objectAtIndex:weekday-1];
       [dateButton setTitle:weeday forState:UIControlStateNormal];
       self.navigationItem.title=weeday;
}


-(NSString*)dateFromString:(NSDate*)date {
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}

-(IBAction)emptyCell:(id)sender {
    UIButton *btn = (UIButton*)sender;
    NSString *btag = [NSString stringWithFormat:@"%i",btn.tag];
    NSString *subString1 =  [btag substringFromIndex:1];
    NSString *subString = [subString1 substringToIndex:subString1.length-1];
    NSString *whichString = [subString1 substringFromIndex:subString1.length-1];
    NSArray *tm = [[self dateFromString:selectedDate] componentsSeparatedByString:@" "];
    buttonString = [[tm objectAtIndex:0] retain];
    BOOL isExit = NO;
    if ([whichString isEqualToString:@"1"]) {
        isSub2 = NO;
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
        isSub2 = YES;
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
        currentStatuBtn=@"N";
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
    if (isSub2 && !isDinackar) {
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
}

-(IBAction)raderaButtonClicked:(id)sender {
    
    [ASDepthModalViewController dismiss];
    if (editIndexValue&&isSub2&& !isDinackar) {
        NSDictionary *deleDict = [dataArray objectAtIndex:[editIndexValue intValue]];
        [dataArray removeObject:deleDict];
        [self deleteRecord:deleDict];
    }
    editIndexValue = nil;
    [self displayButton];
    
}

-(IBAction)totalOkButtonAction:(id)sender{
    [ASDepthModalViewController dismiss];
    if (!isDinackar) {
        if (editTotalValue) {
            NSMutableDictionary *temp = [totalArray objectAtIndex:[editTotalValue intValue]];
            [temp setValue:[NSString stringWithFormat:@"%.0f",slider.value] forKey:@"total"];
            [self databaseUpdateTotal:temp];
        }else {
            NSMutableDictionary *temp = [[NSMutableDictionary alloc] init];
            [temp setValue:[NSString stringWithFormat:@"%d",[totalArray count]+1] forKey:@"id"];
            [temp setValue:dateIndexValue forKey:@"date"];
            [temp setValue:[NSString stringWithFormat:@"%.0f",slider.value] forKey:@"total"];
            [totalArray addObject:temp];
            [self databaseInsertTotal:temp];
        }
        editTotalValue = nil;
        dateIndexValue = nil;
    }
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
    NSString *str = [self dateFromString:selectedDate];
    NSArray *array =[str componentsSeparatedByString:@" "];
    NSString *dateStr =[array objectAtIndex:0];
    dateIndexValue = [dateStr retain];
    BOOL isExist = NO;
    for (int k=0; k<[totalArray count]; k++) {
        NSDictionary *dict = [totalArray objectAtIndex:k];
        if ([[dict valueForKey:@"date"] isEqualToString:dateStr]) {
            isExist = YES;
            slider.value = [[dict valueForKey:@"total"]intValue];
            sliderLabel.text=[dict valueForKey:@"total"];
            editTotalValue = [[NSString stringWithFormat:@"%d",k]retain];
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
