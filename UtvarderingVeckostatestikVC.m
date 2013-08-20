//
//  UtvärderingVeckostatestikVC.m
//  Välkommen till TFH-appen
//
//  Created by Chandrika on 04/08/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import "UtvarderingVeckostatestikVC.h"

@interface UtvarderingVeckostatestikVC ()

@end
#define kStartDate @"startDate"
#define kEndDate   @"endDate"
#define kStatus    @"status"
#define kDayTime   @"dayTime"
#define kEventDes  @"eventDes"
#define kSub2Id    @"Sub2Id"
#define kSub1Id    @"Sub1Id"
#define kWeek @"week"
@implementation UtvarderingVeckostatestikVC
@synthesize firstView,secondView,thirdView,fourthView,fifthView,desView,bottomView;
@synthesize firstLabel,firstTotal,secondLabel,secondTotal,thirdLabel,thirdTotal,fourthLabel,fourthTotal,fifthLabel,fifthTotal,firstPlus,secondPlus,thirdPlus,fourthPlus,fifthPlus;
@synthesize descriptionView;
@synthesize selectedArray,sub1EventsArray,totalArray,sub1TotalArray,sub2EventsArray;
@synthesize scrView;
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
	// Do any additional setup after loading the view.
    
    self.navigationItem.title=@"Utvärdering";
    
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
}

-(void)viewWillAppear:(BOOL)animated{
    totalArray = [[NSMutableArray alloc]init];
    sub1EventsArray = [[NSMutableArray alloc]init];
    sub1TotalArray = [[NSMutableArray alloc]init];
    sub2EventsArray = [[NSMutableArray alloc]init];
    [self getData];
    [super viewWillAppear:YES];
}

-(void)getData{
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
        NSString *querySQL2 = [NSString stringWithFormat: @"SELECT * FROM SUB1TOTAL"];
        
        const char *query_stmt2 = [querySQL2 UTF8String];
        
        if (sqlite3_prepare_v2(exerciseDB, query_stmt2, -1, &statement, NULL) == SQLITE_OK)
        {
            
            while  (sqlite3_step(statement) == SQLITE_ROW) {
                NSString *totalid = [NSString stringWithFormat:@"%d",sqlite3_column_int(statement,0)];
                NSString *date = [NSString stringWithFormat:@"%s",sqlite3_column_text(statement, 2)];
                NSString *total = [NSString stringWithFormat:@"%s",sqlite3_column_text(statement, 3)];
                
                NSMutableDictionary *itemDict = [[NSMutableDictionary alloc]init];
                [itemDict setValue:totalid forKey:@"id"];
                [itemDict setValue:date forKey:@"date"];
                [itemDict setValue:total forKey:@"total"];
                
                [sub1TotalArray addObject:itemDict];
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
        
        NSString *querySQL3 = [NSString stringWithFormat: @"SELECT * FROM SUB2EVENT"];
        
        const char *query_stmt3 = [querySQL3 UTF8String];
        
        if (sqlite3_prepare_v2(exerciseDB, query_stmt3, -1, &statement, NULL) == SQLITE_OK)
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
                
                [sub2EventsArray addObject:itemDict];
            }
        }
        sqlite3_finalize(statement);
    }
    sqlite3_close(exerciseDB);
    if ([selectedArray count]==1) {
        firstView.hidden = NO;
        secondView.hidden = YES;
        thirdView.hidden = YES;
        fourthView.hidden = YES;
        fifthView.hidden = YES;
        desView.frame = CGRectMake(desView.frame.origin.x, 180, desView.frame.size.width, desView.frame.size.height);
        bottomView.frame = CGRectMake(bottomView.frame.origin.x, 440, bottomView.frame.size.width, bottomView.frame.size.height);
        scrView.contentSize = CGSizeMake(320, 549);
        
    }else if([selectedArray count]==2){
        firstView.hidden = NO;
        secondView.hidden = NO;
        thirdView.hidden = YES;
        fourthView.hidden = YES;
        fifthView.hidden = YES;
        desView.frame = CGRectMake(desView.frame.origin.x, 260, desView.frame.size.width, desView.frame.size.height);
        bottomView.frame = CGRectMake(bottomView.frame.origin.x, 520, bottomView.frame.size.width, bottomView.frame.size.height);
        scrView.contentSize = CGSizeMake(320, 629);
    }else if([selectedArray count]==3){
        firstView.hidden = NO;
        secondView.hidden = NO;
        thirdView.hidden = NO;
        fourthView.hidden = YES;
        fifthView.hidden = YES;
        desView.frame = CGRectMake(desView.frame.origin.x, 340, desView.frame.size.width, desView.frame.size.height);
        bottomView.frame = CGRectMake(bottomView.frame.origin.x, 600, bottomView.frame.size.width, bottomView.frame.size.height);
        scrView.contentSize = CGSizeMake(320, 709);
    }else if([selectedArray count]==4){
        firstView.hidden = NO;
        secondView.hidden = NO;
        thirdView.hidden = NO;
        fourthView.hidden = NO;
        fifthView.hidden = YES;
        desView.frame = CGRectMake(desView.frame.origin.x, 420, desView.frame.size.width, desView.frame.size.height);
        bottomView.frame = CGRectMake(bottomView.frame.origin.x, 680, bottomView.frame.size.width, bottomView.frame.size.height);
        scrView.contentSize = CGSizeMake(320, 789);
    }else if([selectedArray count]==5){
        firstView.hidden = NO;
        secondView.hidden = NO;
        thirdView.hidden = NO;
        fourthView.hidden = NO;
        fifthView.hidden = NO;
        desView.frame = CGRectMake(desView.frame.origin.x, 500, desView.frame.size.width, desView.frame.size.height);
        bottomView.frame = CGRectMake(bottomView.frame.origin.x, 760, bottomView.frame.size.width, bottomView.frame.size.height);
        scrView.contentSize = CGSizeMake(320, 869);
    }
    int firstTot =0,secondTot=0,thirdTot=0,fourthTot=0,fifthTot=0,firstMin=0,firstPlu=0,secondMin=0,secondPlu=0,thirdMin=0,thirdPlu=0,fourthMin=0,fourthPlu=0,fifthMin=0,fifthPlu=0;
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    for (int k=0; k<[selectedArray count]; k++) {
        NSMutableDictionary *dict = [selectedArray objectAtIndex:k];
        NSMutableArray *tttArray;
        if ([[dict valueForKey:@"type"] isEqualToString:@"sub1"]) {
            tttArray = sub1TotalArray;
        }else{
            tttArray = totalArray;
        }
        if (k==0) {
            firstLabel.text = [dict valueForKey:kWeek];
        }else if(k==1){
            secondLabel.text = [dict valueForKey:kWeek];
        }else if(k==2){
            thirdLabel.text = [dict valueForKey:kWeek];
        }else if(k==3){
            fourthLabel.text = [dict valueForKey:kWeek];
        }else if(k==4){
            fifthLabel.text = [dict valueForKey:kWeek];
        }
        for (int m=0; m<[tttArray count]; m++) {
            NSDictionary *dict1 = [tttArray objectAtIndex:m];
            NSDate *totalDate = [formatter dateFromString:[dict1 valueForKey:@"date"]];
                if ([totalDate compare:[dict valueForKey:kStartDate]]==NSOrderedSame||[totalDate compare:[dict valueForKey:kEndDate]]==NSOrderedSame||([totalDate compare:[dict valueForKey:kStartDate]]==NSOrderedDescending&&[totalDate compare:[dict valueForKey:kEndDate]]==NSOrderedAscending)) {
                    if (k==0) {
                        firstTot = firstTot +[[dict1 valueForKey:@"total"]intValue];
                    }else if(k==1){
                        secondTot = secondTot +[[dict1 valueForKey:@"total"]intValue];
                    }else if(k==2){
                        thirdTot = thirdTot +[[dict1 valueForKey:@"total"]intValue];
                    }else if(k==3){
                        fourthTot = fourthTot +[[dict1 valueForKey:@"total"]intValue];
                    }else if(k==4){
                        fifthTot = fifthTot +[[dict1 valueForKey:@"total"]intValue];
                    }
                }
        }
    }
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    for (int k=0; k<[selectedArray count]; k++) {
        NSMutableDictionary *dict = [selectedArray objectAtIndex:k];
        NSMutableArray *tttArray;
        if ([[dict valueForKey:@"type"] isEqualToString:@"sub1"]) {
            tttArray = sub1EventsArray;
        }else{
            tttArray = sub2EventsArray;
        }
        for (int m=0; m<[tttArray count]; m++) {
            NSDictionary *dict1 = [tttArray objectAtIndex:m];
            NSArray *arr = [[dict1 valueForKey:kDayTime] componentsSeparatedByString:@" "];
            NSString *dateStr = [NSString stringWithFormat:@"%@ %@",[arr objectAtIndex:0],[dict1 valueForKey:kStartDate]];
            NSDate *totalDate = [formatter dateFromString:dateStr];
            if ([totalDate compare:[dict valueForKey:kStartDate]]==NSOrderedSame||[totalDate compare:[dict valueForKey:kEndDate]]==NSOrderedSame||([totalDate compare:[dict valueForKey:kStartDate]]==NSOrderedDescending&&[totalDate compare:[dict valueForKey:kEndDate]]==NSOrderedAscending)) {
                if (k==0) {
                    if ([[dict1 valueForKey:kStatus] isEqualToString:@"+"]) {
                        firstPlu = firstPlu+1;
                    }else if([[dict1 valueForKey:kStatus] isEqualToString:@"-"]){
                        firstMin = firstMin+1;
                    }
                }else if(k==1){
                    if ([[dict1 valueForKey:kStatus] isEqualToString:@"+"]) {
                        secondPlu = secondPlu+1;
                    }else if([[dict1 valueForKey:kStatus] isEqualToString:@"-"]){
                        secondMin = secondMin+1;
                    }
                }else if(k==2){
                    if ([[dict1 valueForKey:kStatus] isEqualToString:@"+"]) {
                        thirdPlu = thirdPlu+1;
                    }else if([[dict1 valueForKey:kStatus] isEqualToString:@"-"]){
                        thirdMin = thirdMin+1;
                    }
                }else if(k==3){
                    if ([[dict1 valueForKey:kStatus] isEqualToString:@"+"]) {
                        fourthPlu = fourthPlu+1;
                    }else if([[dict1 valueForKey:kStatus] isEqualToString:@"-"]){
                        fourthMin = fourthMin+1;
                    }
                }else if(k==4){
                    if ([[dict1 valueForKey:kStatus] isEqualToString:@"+"]) {
                        fifthPlu = fifthPlu+1;
                    }else if([[dict1 valueForKey:kStatus] isEqualToString:@"-"]){
                        fifthMin = fifthMin+1;
                    }
                }
            }
        }
    }
    firstTotal.text = [NSString stringWithFormat:@"%d",firstTot/7];
    secondTotal.text = [NSString stringWithFormat:@"%d",secondTot/7];
    thirdTotal.text = [NSString stringWithFormat:@"%d",thirdTot/7];
    fourthTotal.text = [NSString stringWithFormat:@"%d",fourthTot/7];
    fifthTotal.text = [NSString stringWithFormat:@"%d",fifthTot/7];
    
    firstPlus.text = [NSString stringWithFormat:@"%d",firstPlu-firstMin];
    secondPlus.text = [NSString stringWithFormat:@"%d",secondPlu-secondMin];
    thirdPlus.text = [NSString stringWithFormat:@"%d",thirdPlu-thirdMin];
    fourthPlus.text = [NSString stringWithFormat:@"%d",fourthPlu-fourthMin];
    fifthPlus.text = [NSString stringWithFormat:@"%d",fifthPlu-fifthMin];
}

-(void)backButon {
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)Ilabel:(id)sender{
    [MTPopupWindow showWindowWithHTMLFile:@"￼￼Utvardering.html" insideView:self.view];
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
