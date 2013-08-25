//
//  SelectRegistreringsveckaViewController.m
//  Välkommen till TFH-appen
//
//  Created by Brilliance Tech Sols on 7/18/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import "SelectRegistreringsveckaViewController.h"

@interface SelectRegistreringsveckaViewController ()

@end

#define kStartDate @"startDate"
#define kEndDate   @"endDate"
#define kCurrentDate  @"currentDate"
#define kId    @"id"

@implementation SelectRegistreringsveckaViewController
@synthesize table;
@synthesize dataArray;
@synthesize calanderView;

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
    self.navigationItem.title=@"Ny Plusvecka";
    
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
    table.separatorColor = [UIColor clearColor];
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
    dataArray = [[NSMutableArray alloc]init];
    [self getData];
    [super viewWillAppear:YES];
}

-(void)getData {
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
                NSMutableDictionary *itemDict = [[NSMutableDictionary alloc]init];
                [itemDict setValue:weekId forKey:kId];
                [itemDict setValue:startDat forKey:kStartDate];
                [itemDict setValue:endDat forKey:kEndDate];
                [itemDict setValue:currentDate forKey:kCurrentDate];
                [dataArray addObject:itemDict];
            }
        }
        sqlite3_finalize(statement);
    }
    sqlite3_close(exerciseDB);
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
-(void)backButon {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 38.0f;
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
    cell.selectedBackgroundView = [[UIView alloc]init];
    cell.cellBtn.hidden = YES;
    NSMutableDictionary *dict = [dataArray objectAtIndex:indexPath.row];
    cell.background.frame = CGRectMake(6, cell.background.frame.origin.y, 288, cell.background.frame.size.height);
    cell.cellLabel.frame = CGRectMake(19, cell.background.frame.origin.y, 262, cell.background.frame.size.height);
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        if ([[UIScreen mainScreen] bounds].size.height > 480) {
           // if (!calanderView) {
                calanderView = [[PlusveckaCalenderViewController alloc]initWithNibName:@"PlusveckaCalenderView" bundle:nil];
           // }
        }else{
           // if (!calanderView) {
                calanderView = [[PlusveckaCalenderViewController alloc]initWithNibName:@"PlusveckaCalenderView_iPhone4" bundle:nil];
           // }
        }
    }
    else{
        //if (!calanderView) {
            calanderView = [[PlusveckaCalenderViewController alloc]initWithNibName:@"PlusveckaCalenderView_iPad" bundle:nil];
        //}
    }
    calanderView.selectedDictionary = [dataArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:calanderView animated:YES];
}



@end
