//
//  RegistreringDinaveckarViewController.m
//  Välkommen till TFH-appen
//
//  Created by Chandrika on 22/07/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import "RegistreringDinaveckarViewController.h"

@interface RegistreringDinaveckarViewController ()

@end
#define kStartDate @"startDate"
#define kEndDate   @"endDate"
#define kStatus    @"status"
#define kDayTime   @"dayTime"
#define kEventDes  @"eventDes"
#define kSub1Id    @"Sub1Id"
@implementation RegistreringDinaveckarViewController
@synthesize dataArray,table;
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
     self.navigationItem.title=@"Dinaveckar";
    
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
	// Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    dataArray = [[NSMutableArray alloc]init];
    [self getData];
    [super viewWillAppear:YES];
}

-(void)getData {
    NSMutableArray *sub1Array = [[NSMutableArray alloc]init];
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
                
                [sub1Array addObject:itemDict];
            }
        }
        sqlite3_finalize(statement);
    }
    sqlite3_close(exerciseDB);
    NSDate *earlierDate = nil;
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc]init];
    NSDateFormatter *formatter2 = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    for (int k=0; k<[sub1Array count]; k++) {
        NSString *dayTime = [[sub1Array objectAtIndex:k]valueForKey:@"dayTime"];
        NSArray *array = [dayTime componentsSeparatedByString:@" "];
        NSString *dateString = [array objectAtIndex:0];
        NSDate *date = [formatter dateFromString:dateString];
        if (!earlierDate || [earlierDate compare:date]==NSOrderedDescending) {
            earlierDate = date;
        }
    }
    NSString *currentDate = [formatter stringFromDate:[NSDate date]];
    NSDate *currDate=[formatter dateFromString:currentDate];
    [formatter2 setDateFormat:@"d/M"];
    [formatter1 setDateFormat:@"yyyy"];
    while ([earlierDate compare:currDate]==NSOrderedAscending||[earlierDate compare:currDate]==NSOrderedSame) {
        NSDate *nextDay = [earlierDate dateByAddingTimeInterval:6*60*60*24];
        NSString *week;
        if ([earlierDate compare:currDate]==NSOrderedAscending && [nextDay compare:currDate]==NSOrderedDescending) {
            
            if ([[formatter1 stringFromDate:earlierDate] isEqualToString:[formatter1 stringFromDate:nextDay]]) {
                week =[NSString stringWithFormat:@"%@ - %@ (%@)",[formatter2 stringFromDate:earlierDate],[formatter2 stringFromDate:nextDay],[formatter1 stringFromDate:earlierDate]];
            }
            else{
                week =[NSString stringWithFormat:@"%@ (%@) - %@ (%@)",[formatter2 stringFromDate:earlierDate],[formatter1 stringFromDate:earlierDate],[formatter2 stringFromDate:nextDay],[formatter1 stringFromDate:nextDay]];
            }
        }
        else if ([[formatter1 stringFromDate:earlierDate] isEqualToString:[formatter1 stringFromDate:nextDay]]) {
            week =[NSString stringWithFormat:@"%@ - %@ (%@)",[formatter2 stringFromDate:earlierDate],[formatter2 stringFromDate:nextDay],[formatter1 stringFromDate:earlierDate]];
        }
        else{
            week =[NSString stringWithFormat:@"%@ (%@) - %@ (%@)",[formatter2 stringFromDate:earlierDate],[formatter1 stringFromDate:earlierDate],[formatter2 stringFromDate:nextDay],[formatter1 stringFromDate:nextDay]];
        }
        BOOL isExist = NO;
        for (int m=0; m<[sub1Array count]; m++) {
            NSString *dayTime = [[sub1Array objectAtIndex:m]valueForKey:@"dayTime"];
            NSArray *array = [dayTime componentsSeparatedByString:@" "];
            NSString *dateString = [array objectAtIndex:0];
            NSDate *date = [formatter dateFromString:dateString];
            if ([date compare:earlierDate]==NSOrderedSame||[date compare:nextDay]==NSOrderedSame||([date compare:earlierDate]==NSOrderedDescending && [date compare:nextDay]==NSOrderedAscending) ) {
                isExist = YES;
                break;
            }
        }
        if (isExist) {
            NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
            [dict setValue:week forKey:@"week"];
            [dict setValue:@"F" forKey:@"selected"];
            [dict setValue:earlierDate forKey:@"start"];
            [dict setValue:nextDay forKey:@"end"];
            [dataArray addObject:dict];
        }
        earlierDate = [earlierDate dateByAddingTimeInterval:7*24*60*60];
    }
    [table reloadData];
    
}

- (IBAction)submitButtonAction:(id)sender {
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifer = @"CellIdentifier";
    
    DinaveckarCell *cell = (DinaveckarCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifer];
    
    if (cell == nil) {
        NSArray *objects =[[NSBundle mainBundle] loadNibNamed:@"DinaveckarCell" owner:self options:nil];
        
        for (id object in objects) {
            if ([object isKindOfClass:[DinaveckarCell class]]) {
                
                cell = (DinaveckarCell*)object;
            }
        }
    }
    cell.cellBtn.tag = indexPath.row;
    NSMutableDictionary *dict = [dataArray objectAtIndex:indexPath.row];
    if ([[dict valueForKey:@"selected"] isEqualToString:@"T"]) {
        cell.cellBtn.backgroundColor = [UIColor blueColor];
    }
    else{
        cell.cellBtn.backgroundColor = [UIColor whiteColor];
    }
    
    [cell.cellBtn addTarget:self action:@selector(cellButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    cell.cellLabel.text = [dict valueForKey:@"week"];
    return cell;
}

-(void)cellButtonClicked:(id)sender{
    for (int j=0; j<[dataArray count]; j++) {
        NSMutableDictionary *dict = [dataArray objectAtIndex:j];
        if (j==[sender tag]) {
            [dict setValue:@"T" forKey:@"selected"];
        }else{
            [dict setValue:@"F" forKey:@"selected"];
        }
    }
    [table reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
     if ([[UIScreen mainScreen] bounds].size.height > 480) {
     if (!calanderView) {
     calanderView = [[PlusveckaCalenderViewController alloc]initWithNibName:@"PlusveckaCalenderView" bundle:nil];
     }
     }else{
     if (!calanderView) {
     calanderView = [[PlusveckaCalenderViewController alloc]initWithNibName:@"PlusveckaCalenderView_iPhone4" bundle:nil];
     }
     }
     }
     else{
     if (!calanderView) {
     calanderView = [[PlusveckaCalenderViewController alloc]initWithNibName:@"PlusveckaCalenderView_iPad" bundle:nil];
     }
     }
     
     [self.navigationController pushViewController:calanderView animated:YES];*/
}


-(void)backButon {
    
    [self.navigationController popViewControllerAnimated:YES];
}


@end
