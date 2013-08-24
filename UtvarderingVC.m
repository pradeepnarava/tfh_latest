//
//  UtvarderingVC.m
//  Välkommen till TFH-appen
//
//  Created by Chandrika on 04/08/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import "UtvarderingVC.h"
#import "UtvarderingVeckostatestikVC.h"
#import "UtvarderingCell.h"


#define kStartDate @"startDate"
#define kEndDate   @"endDate"
#define kCurrentDate  @"currentDate"
#define kId    @"id"
#define kSelected @"selected"
#define kType @"type"
#define kWeek @"week"

@interface UtvarderingVC ()

@end

@implementation UtvarderingVC
@synthesize dataArray,table;
@synthesize utvarderingVeckosVC;



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
    dataArray = [[NSMutableArray alloc]init];

    [self getDataFromSub1Event];
    //[self getDataFromSub2Event];
    [super viewWillAppear:YES];
}

-(IBAction)Ilabel:(id)sender{
    [MTPopupWindow showWindowWithHTMLFile:@"￼￼Utvardering.html" insideView:self.view];
}

-(void)viewWillDisappear:(BOOL)animated{
    //self.dataArray = nil;
}


-(void)dealloc {
    [dataArray release];
    [super dealloc];
}


-(void)getDataFromSub1Event {
    NSMutableArray *totalArray = [[NSMutableArray alloc]init];
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &exerciseDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat: @"SELECT * FROM SUB1DINAVECKOR"];
        
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(exerciseDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            
            while  (sqlite3_step(statement) == SQLITE_ROW) {
                NSString *weekId = [NSString stringWithFormat:@"%s",sqlite3_column_text(statement,0)];
                NSString *startDate = [NSString stringWithFormat:@"%s",sqlite3_column_text(statement, 1)];
                NSString *endDate = [NSString stringWithFormat:@"%s",sqlite3_column_text(statement, 2)];
                NSString *currentDate = [NSString stringWithFormat:@"%s",sqlite3_column_text(statement, 3)];
                
                NSDate *startDat = [self dateFromString:startDate];
                NSDate *endDat = [self dateFromString:endDate];
                NSString *week =[NSString stringWithFormat:@"Registeringsvecka: (%@ %@ - %@ %@)",[self yearStringFromDate:startDat],[self monthStringFromDate:startDat],[self yearStringFromDate:endDat],[self monthStringFromDate:endDat]];
                NSMutableDictionary *itemDict = [[NSMutableDictionary alloc]init];
                [itemDict setValue:weekId forKey:kId];
                [itemDict setValue:week forKey:kWeek];
                [itemDict setValue:startDat forKey:kStartDate];
                [itemDict setValue:endDat forKey:kEndDate];
                [itemDict setValue:currentDate forKey:kCurrentDate];
                [itemDict setValue:@"F" forKey:kSelected];
                [itemDict setValue:@"sub1" forKey:kType];
                [totalArray addObject:itemDict];
            }
        }
        
        NSString *querySQL1 = [NSString stringWithFormat: @"SELECT * FROM SUB1DINAVECKOR"];
        
        const char *query_stmt1 = [querySQL1 UTF8String];
        
        if (sqlite3_prepare_v2(exerciseDB, query_stmt1, -1, &statement, NULL) == SQLITE_OK)
        {
            
            while  (sqlite3_step(statement) == SQLITE_ROW) {
                NSString *weekId = [NSString stringWithFormat:@"%s",sqlite3_column_text(statement,0)];
                NSString *startDate = [NSString stringWithFormat:@"%s",sqlite3_column_text(statement, 1)];
                NSString *endDate = [NSString stringWithFormat:@"%s",sqlite3_column_text(statement, 2)];
                NSString *currentDate = [NSString stringWithFormat:@"%s",sqlite3_column_text(statement, 3)];
                
                NSDate *startDat = [self dateFromString:startDate];
                NSDate *endDat = [self dateFromString:endDate];
                NSString *week =[NSString stringWithFormat:@"Plusvecka: (%@ %@ - %@ %@)",[self yearStringFromDate:startDat],[self monthStringFromDate:startDat],[self yearStringFromDate:endDat],[self monthStringFromDate:endDat]];
                NSMutableDictionary *itemDict = [[NSMutableDictionary alloc]init];
                [itemDict setValue:weekId forKey:kId];
                [itemDict setValue:week forKey:kWeek];
                [itemDict setValue:startDat forKey:kStartDate];
                [itemDict setValue:endDat forKey:kEndDate];
                [itemDict setValue:currentDate forKey:kCurrentDate];
                [itemDict setValue:@"F" forKey:kSelected];
                [itemDict setValue:@"sub2" forKey:kType];
                [totalArray addObject:itemDict];
            }
        }
        sqlite3_finalize(statement);
    }
    sqlite3_close(exerciseDB);
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]initWithKey:kStartDate ascending:YES];
    NSArray *sortDesArray = [NSArray arrayWithObject:sortDescriptor];
    dataArray = [[totalArray sortedArrayUsingDescriptors:sortDesArray] mutableCopy];
    [table reloadData];
}

-(NSDate*)dateFromString:(NSString*)date {
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *dateString = [dateFormatter dateFromString:date];
    return dateString;
}

-(NSString*)yearStringFromDate:(NSDate*)date{
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormatter setDateFormat:@"EEE"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}
-(NSString*)monthStringFromDate:(NSDate*)date{
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormatter setDateFormat:@"d/M"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)backButon {
    
    [self.navigationController popViewControllerAnimated:YES];
}



-(IBAction)buttonClicked:(id)sender {
    int count = 0;
    for (int j=0; j<[dataArray count]; j++) {
        NSMutableDictionary *dict = [dataArray objectAtIndex:j];
        if ([[dict valueForKey:kSelected] isEqualToString:@"T"]) {
            count++;
        }
    }
    if (count==0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Utvardering"
                                                        message:@"Please select atleast one"
                                                       delegate:self cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }else{
        NSMutableArray *array = [[NSMutableArray alloc]init];
        for (int j=0; j<[dataArray count]; j++) {
            NSMutableDictionary *dict = [dataArray objectAtIndex:j];
                if ([[dict valueForKey:kSelected] isEqualToString:@"T"]) {
                    [array addObject:dict];
                }
        }
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            if ([[UIScreen mainScreen] bounds].size.height > 480) {
                if (!utvarderingVeckosVC) {
                    utvarderingVeckosVC=[[UtvarderingVeckostatestikVC alloc]initWithNibName:@"UtvarderingVeckostatestikView" bundle:nil];
                }
            }else{
                if (!utvarderingVeckosVC) {
                    utvarderingVeckosVC=[[UtvarderingVeckostatestikVC alloc]initWithNibName:@"UtvarderingVeckostatestikView_iPhone4" bundle:nil];
                }
            }
        }
        else{
            if (!utvarderingVeckosVC) {
                utvarderingVeckosVC=[[UtvarderingVeckostatestikVC alloc]initWithNibName:@"UtvarderingVeckostatestikView_iPad" bundle:nil];
            }
        }
        utvarderingVeckosVC.selectedArray = array;
        [self.navigationController pushViewController:utvarderingVeckosVC animated:YES];
    }
}



#pragma mark UITableViewDataSource 


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 23.0f;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifer = @"CellIdentifier";
    
    UtvarderingCell *cell = (UtvarderingCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifer];
    
    if (cell == nil) {
        NSArray *objects =[[NSBundle mainBundle] loadNibNamed:@"UtvarderingCell" owner:self options:nil];
        
        for (id object in objects) {
            if ([object isKindOfClass:[UtvarderingCell class]]) {
                
                cell = (UtvarderingCell*)object;
            }
        }
    }
    cell.selectedBackgroundView = [[UIView alloc]init];
    cell.cellBtn.tag = indexPath.row;
    NSMutableDictionary *dict = [dataArray objectAtIndex:indexPath.row];
    if ([[dict valueForKey:kSelected] isEqualToString:@"T"]) {
        [cell.cellBtn setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
        //cell.cellBtn.backgroundColor = [UIColor blueColor];
    }
    else{
        [cell.cellBtn setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
        //cell.cellBtn.backgroundColor = [UIColor whiteColor];
    }
    [cell.cellBtn addTarget:self action:@selector(cellButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    cell.cellLabel.text = [dict valueForKey:kWeek];
    return cell;
}



-(void)cellButtonClicked:(id)sender{
    int count = 0;
    for (int j=0; j<[dataArray count]; j++) {
        NSMutableDictionary *dict = [dataArray objectAtIndex:j];
        if ([[dict valueForKey:kSelected] isEqualToString:@"T"]) {
            count++;
        }
        if (j==[sender tag]) {
            if ([[dict valueForKey:kSelected] isEqualToString:@"T"]) {
                count--;
            }
        }
    }
    if (count>=5) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Utvardering"
                                                        message:@"You have to select maximum five only"
                                                       delegate:self cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }else{
        for (int j=0; j<[dataArray count]; j++) {
            NSMutableDictionary *dict = [dataArray objectAtIndex:j];
            if (j==[sender tag]) {
                if ([[dict valueForKey:kSelected] isEqualToString:@"T"]) {
                    [dict setValue:@"F" forKey:kSelected];
                }else{
                    [dict setValue:@"T" forKey:kSelected];
                }
            }
        }
    }
    [table reloadData];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    /*if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        if ([[UIScreen mainScreen] bounds].size.height > 480) {
            if (!regiDinaCalVC) {
                regiDinaCalVC = [[RegiDinaveckarCalendarViewController alloc]initWithNibName:@"RegiDinaveckarCalendarView" bundle:nil];
            }
        }else{
            if (!regiDinaCalVC) {
                regiDinaCalVC = [[RegiDinaveckarCalendarViewController alloc]initWithNibName:@"RegiDinaveckarCalendarView_iPhone4" bundle:nil];
            }
        }
    }
    else{
        if (!regiDinaCalVC) {
            regiDinaCalVC = [[RegiDinaveckarCalendarViewController alloc]initWithNibName:@"RegiDinaveckarCalendarView_iPad" bundle:nil];
        }
    }
    //regiDinaCalVC.dataArray = sub1EventsArray;
    regiDinaCalVC.selectedDictionary = [dataArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:regiDinaCalVC animated:YES];*/
    
    
}



@end
