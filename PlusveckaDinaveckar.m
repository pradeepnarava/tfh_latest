//
//  PlusveckaDinaveckar.m
//  Välkommen till TFH-appen
//
//  Created by Brilliance Tech Sols on 7/19/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import "PlusveckaDinaveckar.h"

#define kStartDate @"startDate"
#define kEndDate   @"endDate"
#define kCurrentDate  @"currentDate"
#define kId    @"id"
#define kSelected @"selected"
#define kStatus @"status"
#define kSub2Id @"sub2Id"
#define kEventDes @"eventDescription"
#define kDayTime @"dayTime"
@interface PlusveckaDinaveckar ()

@end


@implementation PlusveckaDinaveckar
@synthesize table;
@synthesize dataArray;
@synthesize calanderView,sub2EventsArray;

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
    self.navigationItem.title=@"Dina veckor";
    
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
    
    table.separatorColor = [UIColor clearColor];
    //[self getData];
    // Do any additional setup after loading the view from its nib.
}


-(void)viewWillAppear:(BOOL)animated{
    dataArray = [[NSMutableArray alloc]init];
    self.sub2EventsArray = [[NSMutableArray alloc]init];
    [self getData];
    [super viewWillAppear:YES];
}

-(void)getSub2events{
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &exerciseDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat: @"SELECT * FROM SUB2EVENT"];
        
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
                [itemDict setValue:subId forKey:kSub2Id];
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
}


-(void)getData {
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &exerciseDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat: @"SELECT * FROM SUB2DINAVECKOR"];
        
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
                NSMutableDictionary *itemDict = [[NSMutableDictionary alloc]init];
                [itemDict setValue:weekId forKey:kId];
                [itemDict setValue:startDat forKey:kStartDate];
                [itemDict setValue:endDat forKey:kEndDate];
                [itemDict setValue:currentDate forKey:kCurrentDate];
                [itemDict setValue:@"F" forKey:kSelected];
                [dataArray addObject:itemDict];
            }
        }
        [table reloadData];
        sqlite3_finalize(statement);
    }
    sqlite3_close(exerciseDB);
      
    [self getSub2events];
}

-(void)backButon {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)submitButtonAction:(id)sender {
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSMutableDictionary *selectedDict = [[NSMutableDictionary alloc]init];
    for (int k=0; k<[dataArray count]; k++) {
        NSMutableDictionary *dict = [dataArray objectAtIndex:k];
        if ([[dict valueForKey:@"selected"] isEqualToString:@"T"]) {
            selectedDict = dict;
            [self deleteDinaveckorRecord:selectedDict];
            break;
        }
    }
    BOOL isExist = NO;
    for (int p=0; p<[dataArray count]; p++) {
        NSMutableDictionary *dict = [dataArray objectAtIndex:p];
        if (dict!=selectedDict&&[[formatter stringFromDate:[dict valueForKey:kStartDate]] isEqualToString:[formatter stringFromDate:[selectedDict valueForKey:kStartDate]]]&&[[formatter stringFromDate:[dict valueForKey:kEndDate]] isEqualToString:[formatter stringFromDate:[selectedDict valueForKey:kEndDate]]]) {
            isExist = YES;
        }
    }
    [dataArray removeObject:selectedDict];
    /*if (!isExist) {
        for (int m=0; m<[sub2EventsArray count]; m++) {
            NSString *dayTime = [[sub2EventsArray objectAtIndex:m]valueForKey:kDayTime];
            NSArray *array = [dayTime componentsSeparatedByString:@" "];
            NSString *dateString = [array objectAtIndex:0];
            NSDate *date = [formatter dateFromString:dateString];
            if ([date compare:[selectedDict valueForKey:kStartDate]]==NSOrderedSame||[date compare:[selectedDict valueForKey:kEndDate]]==NSOrderedSame||([date compare:[selectedDict valueForKey:kStartDate]]==NSOrderedDescending && [date compare:[selectedDict valueForKey:kEndDate]]==NSOrderedAscending) ) {
                [self deleteRecord:[sub2EventsArray objectAtIndex:m]];
            }
        }
    }*/
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

-(void)deleteDinaveckorRecord:(NSDictionary*)deleDic {
    
    if (sqlite3_open([databasePath UTF8String], &exerciseDB) == SQLITE_OK) {
        
        NSInteger subId = [[deleDic valueForKey:kId] integerValue];
        
        NSString *sql = [NSString stringWithFormat: @"DELETE FROM SUB2DINAVECKOR WHERE id='%d'",subId];
        
        const char *del_stmt = [sql UTF8String];
        
        sqlite3_prepare_v2(exerciseDB, del_stmt, -1, & statement, NULL);
        
        if (sqlite3_step(statement) == SQLITE_ROW) {
            
            NSLog(@"sss");
            
        }
        sqlite3_finalize(statement);
    }
    sqlite3_close(exerciseDB);
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 38.0f;
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
    cell.selectedBackgroundView = [[UIView alloc]init];
    cell.cellBtn.tag = indexPath.row;
    NSMutableDictionary *dict = [dataArray objectAtIndex:indexPath.row];
    if ([[dict valueForKey:@"selected"] isEqualToString:@"T"]) {
        [cell.cellBtn setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
        //cell.cellBtn.backgroundColor = [UIColor blueColor];
    }
    else{
        [cell.cellBtn setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
        //cell.cellBtn.backgroundColor = [UIColor whiteColor];
    }
    [cell.cellBtn addTarget:self action:@selector(cellButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    NSString *yearLabel1 = [self yearStringFromDate:[dict valueForKey:kStartDate]];
    NSString *yearLabel2 = [self yearStringFromDate:[dict valueForKey:kEndDate]];
    if([yearLabel1 isEqualToString:yearLabel2]){
        cell.cellLabel.text = [NSString stringWithFormat:@"%@ - %@ (%@)",[self monthStringFromDate:[dict valueForKey:kStartDate]],[self monthStringFromDate:[dict valueForKey:kEndDate]],yearLabel1];
    }else{
        cell.cellLabel.text = [NSString stringWithFormat:@"%@ (%@) - %@ (%@)",[self monthStringFromDate:[dict valueForKey:kStartDate]],yearLabel1,[self monthStringFromDate:[dict valueForKey:kEndDate]],yearLabel2];
    }
    cell.cellLabel.highlightedTextColor = [UIColor darkGrayColor];
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
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        if ([[UIScreen mainScreen] bounds].size.height > 480) {
            if (!calanderView) {
                calanderView = [[PlusveckaDinaveckarView alloc]initWithNibName:@"PlusveckaDinaveckarView" bundle:nil];
            }
        }else{
            if (!calanderView) {
                calanderView = [[PlusveckaDinaveckarView alloc]initWithNibName:@"PlusveckaDinaveckarView_iPhone4" bundle:nil];
            }
        }
    }
    else{
        if (!calanderView) {
            calanderView = [[PlusveckaDinaveckarView alloc]initWithNibName:@"PlusveckaDinaveckarView_iPad" bundle:nil];
        }
    }
   // calanderView.sub1EventsArray = sub1EventsArray;
    calanderView.selectedDictionary = [dataArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:calanderView animated:YES];
}

@end
