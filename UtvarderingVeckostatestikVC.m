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
@synthesize plusButton,totalButton;
@synthesize utvarderingController;
@synthesize raderaButton,skickaButton;
@synthesize selectedArray,sub1EventsArray,totalArray,sub1TotalArray,sub2EventsArray,valuesArray,selectedValuesArray;
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
    
    // code added by malkit to make the navigatoin appear and work like the other views
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
    raderaButton.enabled = NO;
    skickaButton.enabled = NO;
    
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
        const char *sql_stmt = "CREATE TABLE IF NOT EXISTS sub3table (id INTEGER PRIMARY KEY AUTOINCREMENT,date TEXT,week TEXT,total TEXT,plus TEXT,description TEXT)";
        
        if (sqlite3_exec(exerciseDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
        {
            NSLog(@"Failed to create database");
        }
        
        sqlite3_close(exerciseDB);
        
    } else {
        NSLog(@"Failed to open/create database");
    }
    totalArray = [[NSMutableArray alloc]init];
    valuesArray = [[NSMutableArray alloc]init];
    sub1EventsArray = [[NSMutableArray alloc]init];
    sub1TotalArray = [[NSMutableArray alloc]init];
    sub2EventsArray = [[NSMutableArray alloc]init];
    [self getData];
}

-(IBAction)totalGraphAction:(id)sender{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
       // if ([[UIScreen mainScreen] bounds].size.height > 480) {
            // if (!utvarderingVeckosVC) {
            utvarderingController=[[DinUtvardering alloc]initWithNibName:@"DinUtvardering" bundle:nil];
            //  }
       // }else{
            // if (!utvarderingVeckosVC) {
       //     utvarderingController=[[DinUtvardering alloc]initWithNibName:@"UtvarderingVeckostatestikView_iPhone4" bundle:nil];
            // }
       // }
    }
    else{
        // if (!utvarderingVeckosVC) {
        utvarderingController=[[DinUtvardering alloc]initWithNibName:@"DinUtvardering_iPad" bundle:nil];
        // }
    }
    if (dateOfCurrentItem) {
        utvarderingController.datesArray = [selectedValuesArray valueForKey:@"week"];
        utvarderingController.averageArray = [selectedValuesArray valueForKey:@"total"];
    }else{
        utvarderingController.datesArray = [valuesArray valueForKey:@"week"];
        utvarderingController.averageArray = [valuesArray valueForKey:@"total"];
    }
    [self.navigationController pushViewController:utvarderingController animated:YES];
}

-(IBAction)plusGraphAction:(id)sender{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
       // if ([[UIScreen mainScreen] bounds].size.height > 480) {
            // if (!utvarderingVeckosVC) {
            utvarderingController=[[DinUtvardering alloc]initWithNibName:@"DinUtvardering" bundle:nil];
            //  }
       // }else{
            // if (!utvarderingVeckosVC) {
        //    utvarderingController=[[UtvarderingVeckostatestikVC alloc]initWithNibName:@"UtvarderingVeckostatestikView_iPhone4" bundle:nil];
            // }
       // }
    }
    else{
        // if (!utvarderingVeckosVC) {
        utvarderingController=[[DinUtvardering alloc]initWithNibName:@"DinUtvardering_iPad" bundle:nil];
        // }
    }
    if (dateOfCurrentItem) {
        utvarderingController.datesArray = [selectedValuesArray valueForKey:@"week"];
        utvarderingController.averageArray = [selectedValuesArray valueForKey:@"plus"];
        
    }else{
        utvarderingController.datesArray = [valuesArray valueForKey:@"week"];
        utvarderingController.averageArray = [valuesArray valueForKey:@"plus"];
    }
    [self.navigationController pushViewController:utvarderingController animated:YES];
}
-(void)setValues{
    NSMutableArray *array;
    if (dateOfCurrentItem) {
        raderaButton.enabled = YES;
        skickaButton.enabled = YES;
        array = selectedValuesArray;
    }else{
        raderaButton.enabled = NO;
        skickaButton.enabled = NO;
        array = valuesArray;
    }
    if ([array count]==1) {
        firstView.hidden = NO;
        secondView.hidden = YES;
        thirdView.hidden = YES;
        fourthView.hidden = YES;
        fifthView.hidden = YES;
        plusButton.frame = CGRectMake(120, 229, plusButton.frame.size.width, plusButton.frame.size.height);
        totalButton.frame = CGRectMake(220, 229, totalButton.frame.size.width, totalButton.frame.size.height);
        desView.frame = CGRectMake(desView.frame.origin.x, 275, desView.frame.size.width, desView.frame.size.height);
        bottomView.frame = CGRectMake(bottomView.frame.origin.x, 489, bottomView.frame.size.width, bottomView.frame.size.height);
        scrView.contentSize = CGSizeMake(320, 597);
        
    }else if([array count]==2){
        firstView.hidden = NO;
        secondView.hidden = NO;
        thirdView.hidden = YES;
        fourthView.hidden = YES;
        fifthView.hidden = YES;
        plusButton.frame = CGRectMake(120, 309, plusButton.frame.size.width, plusButton.frame.size.height);
        totalButton.frame = CGRectMake(220, 309, totalButton.frame.size.width, totalButton.frame.size.height);
        desView.frame = CGRectMake(desView.frame.origin.x, 355, desView.frame.size.width, desView.frame.size.height);
        bottomView.frame = CGRectMake(bottomView.frame.origin.x, 569, bottomView.frame.size.width, bottomView.frame.size.height);
        scrView.contentSize = CGSizeMake(320, 677);
    }else if([array count]==3){
        firstView.hidden = NO;
        secondView.hidden = NO;
        thirdView.hidden = NO;
        fourthView.hidden = YES;
        fifthView.hidden = YES;
        plusButton.frame = CGRectMake(120,389, plusButton.frame.size.width, plusButton.frame.size.height);
        totalButton.frame = CGRectMake(220, 389, totalButton.frame.size.width, totalButton.frame.size.height);
        desView.frame = CGRectMake(desView.frame.origin.x, 435, desView.frame.size.width, desView.frame.size.height);
        bottomView.frame = CGRectMake(bottomView.frame.origin.x, 649, bottomView.frame.size.width, bottomView.frame.size.height);
        scrView.contentSize = CGSizeMake(320, 758);
    }else if([array count]==4){
        firstView.hidden = NO;
        secondView.hidden = NO;
        thirdView.hidden = NO;
        fourthView.hidden = NO;
        fifthView.hidden = YES;
        plusButton.frame = CGRectMake(120, 469, plusButton.frame.size.width, plusButton.frame.size.height);
        totalButton.frame = CGRectMake(220, 469, totalButton.frame.size.width, totalButton.frame.size.height);
        desView.frame = CGRectMake(desView.frame.origin.x, 515, desView.frame.size.width, desView.frame.size.height);
        bottomView.frame = CGRectMake(bottomView.frame.origin.x, 729, bottomView.frame.size.width, bottomView.frame.size.height);
        scrView.contentSize = CGSizeMake(320, 738);
    }else if([array count]==5){
        firstView.hidden = NO;
        secondView.hidden = NO;
        thirdView.hidden = NO;
        fourthView.hidden = NO;
        fifthView.hidden = NO;
        plusButton.frame = CGRectMake(120, 549, plusButton.frame.size.width, plusButton.frame.size.height);
        totalButton.frame = CGRectMake(220, 549, totalButton.frame.size.width, totalButton.frame.size.height);
        desView.frame = CGRectMake(desView.frame.origin.x, 595, desView.frame.size.width, desView.frame.size.height);
        bottomView.frame = CGRectMake(bottomView.frame.origin.x, 809, bottomView.frame.size.width, bottomView.frame.size.height);
        scrView.contentSize = CGSizeMake(320, 918);
    }
    for (int m=0; m<[array count]; m++) {
        NSDictionary *dict = [array objectAtIndex:m];
        if (m==0) {
            firstLabel.text = [dict valueForKey:@"week"];
            firstTotal.text = [dict valueForKey:@"total"];
            firstPlus.text = [dict valueForKey:@"plus"];
        }else if(m==1){
            secondLabel.text = [dict valueForKey:@"week"];
            secondTotal.text = [dict valueForKey:@"total"];
            secondPlus.text = [dict valueForKey:@"plus"];
        }else if(m==2){
            thirdLabel.text = [dict valueForKey:@"week"];
            thirdTotal.text = [dict valueForKey:@"total"];
            thirdPlus.text = [dict valueForKey:@"plus"];
        }else if(m==3){
            fourthLabel.text = [dict valueForKey:@"week"];
            fourthTotal.text = [dict valueForKey:@"total"];
            fourthPlus.text = [dict valueForKey:@"plus"];
        }else if(m==4){
            fifthLabel.text = [dict valueForKey:@"week"];
            fifthTotal.text = [dict valueForKey:@"total"];
            fifthPlus.text = [dict valueForKey:@"plus"];
        }
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self setValues];
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
    for (int k=0; k<[selectedArray count]; k++) {
        NSDictionary *dt = [selectedArray objectAtIndex:k];
        NSMutableDictionary *dd = [[NSMutableDictionary alloc]init];
        if (k==0) {
            [dd setValue:[NSString stringWithFormat:@"%d",firstTot/7] forKey:@"total"];
            [dd setValue:[dt valueForKey:kWeek] forKey:@"week"];
            [dd setValue:[NSString stringWithFormat:@"%d",firstPlu-firstMin] forKey:@"plus"];
        }else if(k==1){
            [dd setValue:[NSString stringWithFormat:@"%d",secondTot/7] forKey:@"total"];
            [dd setValue:[dt valueForKey:kWeek] forKey:@"week"];
            [dd setValue:[NSString stringWithFormat:@"%d",secondPlu-secondMin] forKey:@"plus"];
        }else if(k==2){
            [dd setValue:[NSString stringWithFormat:@"%d",thirdTot/7] forKey:@"total"];
            [dd setValue:[dt valueForKey:kWeek] forKey:@"week"];
            [dd setValue:[NSString stringWithFormat:@"%d",thirdPlu-thirdMin] forKey:@"plus"];
        }else if(k==3){
            [dd setValue:[NSString stringWithFormat:@"%d",fourthTot/7] forKey:@"total"];
            [dd setValue:[dt valueForKey:kWeek] forKey:@"week"];
            [dd setValue:[NSString stringWithFormat:@"%d",fourthPlu-fourthMin] forKey:@"plus"];
        }else if(k==4){
            [dd setValue:[NSString stringWithFormat:@"%d",fifthTot/7] forKey:@"total"];
            [dd setValue:[dt valueForKey:kWeek] forKey:@"week"];
            [dd setValue:[NSString stringWithFormat:@"%d",fifthPlu-fifthMin] forKey:@"plus"];
        }
        [valuesArray addObject:dd];
    }
}

-(IBAction)listofvalues:(id)sender
{
    int rows = 0;
    NSString *docsDir;
    NSArray *dirPaths;
    
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    
    // Build the path to the database file
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"exerciseDB.db"]];
    // const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open([databasePath UTF8String], &exerciseDB) == SQLITE_OK)
    {
        
        NSString *sql = [NSString stringWithFormat: @"SELECT COUNT(*) FROM sub3table"];
        
        const char *query_stmt = [sql UTF8String];
        
        if (sqlite3_prepare_v2(exerciseDB,
                               query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                rows = sqlite3_column_int(statement, 0);
            }
        }
        
        NSLog(@"SQLite Rows: %i", rows);
        
        sqlite3_finalize(statement);
        sqlite3_close(exerciseDB);
    }
    
    if (rows > 0)
    {
        tableImageView = [[[UIImageView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 280, self.view.frame.size.width, 280)] autorelease];
        [tableImageView setImage:[UIImage imageNamed:@"scrollbottom.png"]];
        //        lok = [[ListOfKompass alloc]initWithNibName:@"ListOfKompass" bundle:nil];
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
        {
            lok = [[ListOfUtvardering alloc]initWithNibName:@"ListOfUtvardering" bundle:nil];
        }else
        {
            lok = [[ListOfUtvardering alloc]initWithNibName:@"ListOfUtvardering_iPad" bundle:nil];
        }
        
        lok.delegate = self;
        //    [self.navigationController pushViewController:lok animated:YES];
        //        lok.tableView.layer.cornerRadius = 10;
        //        lok.tableView.layer.borderColor = [UIColor blueColor].CGColor;
        //        lok.tableView.layer.borderWidth = 3;
        
        lok.tableView.frame = CGRectMake(10, tableImageView.frame.origin.y + 10, self.view.frame.size.width - 20, 210);
        
        closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        closeButton.frame = CGRectMake((self.view.frame.size.width / 2) - 130, tableImageView.frame.origin.y + 230, 260, 31);
        [closeButton setBackgroundImage:[UIImage imageNamed:@"blargebutton.png"] forState:UIControlStateNormal];
        [closeButton addTarget:self action:@selector(removeTableSubviews) forControlEvents:UIControlEventTouchUpInside];
        [closeButton setTitle:@"Avbryt" forState:UIControlStateNormal];
        closeButton.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        [closeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        //        [self.view addSubview:lok.tableView];
        [self.view addSubview:tableImageView];
        [self.view addSubview:lok.tableView];
        [self.view addSubview:closeButton];
    }
    else
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Alert message" message:@"There are no saved entries."
                                                     delegate:self
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
}

- (void)removeTableSubviews
{
    [closeButton removeFromSuperview];
    [lok.tableView removeFromSuperview];
    [tableImageView removeFromSuperview];
    dateOfCurrentItem = nil;
    descriptionView.text = @"";
    [self setValues];
}

- (void)didSelectDate:(NSString *)date{
    dateOfCurrentItem = [[NSString alloc]initWithString:date];
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &exerciseDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat: @"SELECT * FROM sub3table where date='%@'",dateOfCurrentItem];
        
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(exerciseDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            
            while  (sqlite3_step(statement) == SQLITE_ROW) {
                NSString *week = [NSString stringWithFormat:@"%s",sqlite3_column_text(statement, 2)];
                NSString *total = [NSString stringWithFormat:@"%s",sqlite3_column_text(statement, 3)];
                NSString *plus = [NSString stringWithFormat:@"%s",sqlite3_column_text(statement, 4)];
                NSString *description = [NSString stringWithFormat:@"%s",sqlite3_column_text(statement, 5)];
                NSArray *weekArray = [week componentsSeparatedByString:@"$"];
                NSArray *totalArray1 = [total componentsSeparatedByString:@" "];
                NSArray *plusArray = [plus componentsSeparatedByString:@" "];
                selectedValuesArray = [[NSMutableArray alloc]init];
                for (int k=0; k<[weekArray count]; k++) {
                    NSMutableDictionary *itemDict = [[NSMutableDictionary alloc]init];
                    [itemDict setValue:[weekArray objectAtIndex:k] forKey:@"week"];
                    [itemDict setValue:[plusArray objectAtIndex:k] forKey:@"plus"];
                    [itemDict setValue:[totalArray1 objectAtIndex:k] forKey:@"total"];
                    [selectedValuesArray addObject:itemDict];
                }
                descriptionView.text = description;
                [self setValues];
            }
        }
        
        sqlite3_finalize(statement);
    }
    [lok.tableView removeFromSuperview];
    [closeButton removeFromSuperview];
    [lok.tableView removeFromSuperview];
    [tableImageView removeFromSuperview];
}

-(void)backButon {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)skickaButtonClicked:(id)sender
{
   // if (dateOfCurrentItem)
   // {
        UIActionSheet *cameraActionSheet = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Download", @"Email", nil];
        cameraActionSheet.tag = 1;
        [cameraActionSheet showInView:self.view];
   // }
  //  else
   // {
    //    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please select a form to share" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    //    [alert show];
   // }
}

-(IBAction)SaveBtn:(id)sender
{
    
    NSDate* date = [NSDate date];
    
    //Create the dateformatter object
    
    NSDateFormatter* formatter = [[[NSDateFormatter alloc] init] autorelease];
    
    //Set the required date format
    
    [formatter setDateFormat:@"MMM d YYYY HH:mm:ss"];
    
    //Get the string date
    
    NSString* str = [formatter stringFromDate:date];
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &exerciseDB) == SQLITE_OK)
    {
        
        NSString *insertSQL;
        
        //        [formatter setDateFormat:@"MMM d YYYY HH:mm:ss"];
        //        str = [formatter stringFromDate:date];
        NSMutableString *totalString =[[NSMutableString alloc]init];
        NSMutableString *weekString = [[NSMutableString alloc]init];
        NSMutableString *plusString = [[NSMutableString alloc]init];
        NSMutableArray *array;
        if (dateOfCurrentItem) {
            array = selectedValuesArray;
        }else{
            array = valuesArray;
        }
        for (int m=0; m<[array count]; m++) {
            NSDictionary *dic = [array objectAtIndex:m];
            if (m==[array count]-1) {
                [totalString appendFormat:@"%@",[dic valueForKey:@"total"]];
                [weekString appendFormat:@"%@",[dic valueForKey:@"week"]];
                [plusString appendFormat:@"%@",[dic valueForKey:@"plus"]];
            }else{
                [totalString appendFormat:@"%@ ",[dic valueForKey:@"total"]];
                [weekString appendFormat:@"%@$",[dic valueForKey:@"week"]];
                [plusString appendFormat:@"%@ ",[dic valueForKey:@"plus"]];
            }
        }
        if (!dateOfCurrentItem)
        {
            insertSQL = [NSString stringWithFormat: @"INSERT INTO sub3table (date,week,total,plus,description) VALUES (\"%@\", \"%@\", \"%@\", \"%@\", \"%@\" )", str, weekString,totalString, plusString,descriptionView.text];
        }
        else
        {
            insertSQL = [NSString stringWithFormat: @"UPDATE sub3table SET date='%@',week='%@',total='%@',plus='%@',description='%@' WHERE date='%@'", str,weekString,totalString,plusString,descriptionView.text,dateOfCurrentItem];
        }
        
        const char *insert_stmt = [insertSQL UTF8String];
        
        sqlite3_prepare_v2(exerciseDB, insert_stmt, -1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            dateOfCurrentItem = nil;
            raderaButton.enabled = NO;
            skickaButton.enabled = NO;
            descriptionView.text=@"";
            [self setValues];
            
            //            if (rows == 0)
            //            {
            //                UIAlertView *insertAlert = [[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Sparat" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] autorelease];
            //                [insertAlert show];
            //            }
            //            else
            //            {
            UIAlertView *insertAlert = [[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Sparat" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] autorelease];
            [insertAlert show];
            //            }
            
            //            dateOfCurrentItem = [[NSString alloc] initWithString:str];
            
        } else {
            NSLog(@"no");
            NSLog(@"error: %s", sqlite3_errmsg(exerciseDB));
            UIAlertView *insertAlert = [[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Form Update/Save Failed" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] autorelease];
            [insertAlert show];
        }
        sqlite3_finalize(statement);
        sqlite3_close(exerciseDB);
    }
    
}


- (IBAction)deleteEntry:(id)sender
{
    if (dateOfCurrentItem)
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Alert message" message:@"Är du säker på att du vill radera formuläret?"
                                                     delegate:self
                                            cancelButtonTitle:nil
                                            otherButtonTitles:@"Radera", @"Avbryt", nil];
        alert.tag = 2;
        [alert show];
        [alert release];
    }
    else
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Alert message" message:@"This is not a saved entry to delete. This is a fresh page."                                                     delegate:self                                            cancelButtonTitle:@"OK"                                            otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"ok");
    
     if (buttonIndex == 0 && alertView.tag == 2)
    {
        if (sqlite3_open([databasePath UTF8String], &exerciseDB) == SQLITE_OK) {
            
            NSLog(@"Date of Item to be delete = %@", dateOfCurrentItem);
            NSString *sql = [NSString stringWithFormat: @"DELETE FROM sub3table WHERE date='%@'", dateOfCurrentItem];
            
            const char *del_stmt = [sql UTF8String];
            
            sqlite3_prepare_v2(exerciseDB, del_stmt, -1, & statement, NULL);
            if (sqlite3_step(statement) == SQLITE_DONE) {
                
                NSLog(@"Deleted");
                UIAlertView * alert1 = [[UIAlertView alloc] initWithTitle:nil message:@"Raderat" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok",nil];
                [alert1 show];
                [alert1 release];
                dateOfCurrentItem = nil;
                [self setValues];
            }
            
            sqlite3_finalize(statement);
            sqlite3_close(exerciseDB);
        }
    }
}

-(IBAction)Ilabel:(id)sender{
    [MTPopupWindow showWindowWithHTMLFile:@"￼￼Utvardering.html" insideView:self.view];
}

- (UIImage *)getFormImage
{
    UIImage *tempImage = nil;
    UIGraphicsBeginImageContext(scrView.contentSize);
    {
        CGPoint savedContentOffset = scrView.contentOffset;
        CGRect savedFrame = scrView.frame;
        
        scrView.contentOffset = CGPointZero;
        scrView.frame = CGRectMake(0, 0, scrView.contentSize.width, scrView.contentSize.height);
        
        [scrView.layer renderInContext: UIGraphicsGetCurrentContext()];
        tempImage = UIGraphicsGetImageFromCurrentImageContext();
        
        scrView.contentOffset = savedContentOffset;
        scrView.frame = savedFrame;
    }
    UIGraphicsEndImageContext();
    
    return tempImage;
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    
	if (buttonIndex == 0)
    {
        UIImage *image = [self getFormImage];
        if (image)
        {
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Image downloaded" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
        }
    }
    else if (buttonIndex == 1)
    {
        if ([MFMailComposeViewController canSendMail])
        {
            MFMailComposeViewController *emailDialog = [[MFMailComposeViewController alloc] init];
            emailDialog.mailComposeDelegate = self;
            NSMutableString *htmlMsg = [NSMutableString string];
            [htmlMsg appendString:@"<html><body><p>"];
            [htmlMsg appendString:[NSString stringWithFormat:@"Please find the attached form on %@",dateOfCurrentItem]];
            [htmlMsg appendString:@": </p></body></html>"];
            
            NSData *jpegData = UIImageJPEGRepresentation([self getFormImage], 1);
            
            NSString *fileName = [NSString stringWithFormat:@"%@",dateOfCurrentItem];
            fileName = [fileName stringByAppendingPathExtension:@"jpeg"];
            [emailDialog addAttachmentData:jpegData mimeType:@"image/jpeg" fileName:fileName];
            
            [emailDialog setSubject:@"Form"];
            [emailDialog setMessageBody:htmlMsg isHTML:YES];
            
            
            [self presentViewController:emailDialog animated:YES completion:nil];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Mail cannot be send now. Please check mail has been configured in your device and try again." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
        }
    }
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    // Notifies users about errors associated with the interface
    switch (result)
    {
            
        case MFMailComposeResultCancelled:
            break;
        case MFMailComposeResultSaved:
            break;
        case MFMailComposeResultSent:
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Mail sent successfully" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
        }
            break;
        case MFMailComposeResultFailed:
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Mail send failed" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
        }
            break;
        default:
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Mail was not sent." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
        }
            break;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
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
