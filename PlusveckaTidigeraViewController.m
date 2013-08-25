//
//  PlusveckaTidigeraViewController.m
//  Välkommen till TFH-appen
//
//  Created by Brilliance Tech Sols on 8/16/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import "PlusveckaTidigeraViewController.h"

@interface PlusveckaTidigeraViewController ()

@end
#define kSelected @"selected"
#define kEventDes  @"eventDes"
@implementation PlusveckaTidigeraViewController
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
    self.navigationItem.title=@"Välj från tidigare aktiviteter";
    
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

-(void)backButon {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    self.dataArray = [[NSMutableArray alloc]init];
    [self getData];
    [super viewWillAppear:YES];
}

-(void)getData {
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &exerciseDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat: @"SELECT * FROM SUB1EVENT"];
        
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(exerciseDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            
            while  (sqlite3_step(statement) == SQLITE_ROW) {
                NSString *status = [NSString stringWithFormat:@"%s",sqlite3_column_text(statement,5)];
                NSString *eventDes = [NSString stringWithFormat:@"%s",sqlite3_column_text(statement, 7)];
                if ([status isEqualToString:@"+"]) {
                    NSMutableDictionary *itemDict = [[NSMutableDictionary alloc]init];
                    [itemDict setValue:eventDes forKey:kEventDes];
                    [itemDict setValue:@"F" forKey:kSelected];
                    [dataArray addObject:itemDict];
                }
            }
        }
        sqlite3_finalize(statement);
    }
    sqlite3_close(exerciseDB);
    [table reloadData];
}

- (IBAction)submitButtonAction:(id)sender {
    NSMutableString *string = [[NSMutableString alloc]init];
    NSMutableArray *array = [[NSMutableArray alloc]init];
    BOOL isSelected=NO;
    for (NSDictionary *dict in dataArray) {
        if ([[dict valueForKey:kSelected] isEqualToString:@"T"]) {
            isSelected = YES;
            [array addObject:dict];
        }
    }
    if (isSelected) {
        for (int p=0; p<[array count]; p++) {
            NSDictionary *dict = [array objectAtIndex:p];
            if (p==[array count]-1) {
                [string appendFormat:@"%@",[dict valueForKey:kEventDes]];
            }else{
                [string appendFormat:@"%@,",[dict valueForKey:kEventDes]];
            }
        }
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setValue:string forKey:@"eventDes"];
        [defaults synchronize];
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30.0f;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifer = @"CellIdentifier";
    
    TidigeraCell *cell = (TidigeraCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifer];
    
    if (cell == nil) {
        NSArray *objects =[[NSBundle mainBundle] loadNibNamed:@"TidigeraCell" owner:self options:nil];
        
        for (id object in objects) {
            if ([object isKindOfClass:[TidigeraCell class]]) {
                
                cell = (TidigeraCell*)object;
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
    cell.cellLabel.text=[dict valueForKey:kEventDes];
    cell.cellLabel.highlightedTextColor = [UIColor darkGrayColor];
    return cell;
}




-(void)cellButtonClicked:(id)sender{
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
    [table reloadData];
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    for (int j=0; j<[dataArray count]; j++) {
        NSMutableDictionary *dict = [dataArray objectAtIndex:j];
        if (j==indexPath.row) {
            [dict setValue:@"T" forKey:kSelected];
        }else{
            [dict setValue:@"F" forKey:kSelected];
        }
    }
    [table reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
