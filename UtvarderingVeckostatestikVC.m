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
@synthesize selectedArray,sub1EventsArray,totalArray;
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
    for (int k=0; k<[selectedArray count]; k++) {
        NSMutableDictionary *dict = [selectedArray objectAtIndex:k];
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
    }
    int firstTot =0,secondTot=0,thirdTot=0,fourthTot=0,fifthTot=0;
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    for (int m=0; m<[totalArray count]; m++) {
        NSDictionary *dict = [totalArray objectAtIndex:m];
        NSDate *totalDate = [formatter dateFromString:[dict valueForKey:@"date"]];
        
    }
    
}

-(void)backButon {
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)Ilabel:(id)sender{
    [MTPopupWindow showWindowWithHTMLFile:@"￼￼Utvardering.html" insideView:self.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
