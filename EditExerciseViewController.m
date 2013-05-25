//
//  EditExerciseViewController.m
//  Välkommen till TFH-appen
//
//  Created by Mohammed Abdul Majeed on 4/29/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import "EditExerciseViewController.h"

#define AlertViewOne 1
@interface EditExerciseViewController ()

@end

@implementation EditExerciseViewController
@synthesize listexercise1,Selectedrow,tableView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title=@"Tidigare Formulär";
    listexercise1=[[NSMutableArray alloc]init];
    [listexercise1 removeAllObjects];
    Selectedrow=[[NSString alloc]init];

    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                                                   style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;
    
   
    
    
    NSString *docsDir;
    NSArray *dirPaths;
    
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    
    // Build the path to the database file
   databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"exerciseDB.db"]];
    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt    *statement;
   
    if (sqlite3_open(dbpath, &exerciseDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT date FROM EXERCISEONE"
                              ];
        
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(exerciseDB,
                               query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW) {
                
                char* date = (char*) sqlite3_column_text(statement,0);
                NSString *tmp;
                if (date != NULL){
                    tmp = [NSString stringWithUTF8String:date];
                    NSLog(@"value form db :%@",tmp);
                    [listexercise1 addObject:tmp];
                }
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(exerciseDB);
    }

    // Do any additional setup after loading the view from its nib.
}
-(IBAction)deletedata:(id)sender{
    NSLog(@"delete");
}

// This will tell your UITableView how many rows you wish to have in each section.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.listexercise1 count];
}

// This will tell your UITableView what data to put in which cells in your table.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifer = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifer];
    
    // Using a cell identifier will allow your app to reuse cells as they come and go from the screen.
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifer];
    }
    
    // Deciding which data to put into this particular cell.
    // If it the first row, the data input will be "Data1" from the array.
    NSUInteger row = [indexPath row];
    cell.textLabel.text = [listexercise1 objectAtIndex:row];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	// Upon selecting an event, create an EKEventViewController to display the event.
	NSDictionary *dictionary = [self.listexercise1 objectAtIndex:indexPath.row];
    NSLog(@"%@",dictionary);
  NSString *SelectedDate=[NSString stringWithFormat:@"%@", dictionary];
    NSLog(@"%@",SelectedDate);
    Selectedrow=SelectedDate;
    NSLog(@"Selectedrow%@",Selectedrow);
    eoec=[[ExerciseOneEditController alloc]init];
          eoec.selectedate=[[NSString alloc]init];
    eoec.selectedate=SelectedDate;
    NSLog(@"zzzz%@",eoec.selectedate);
    [self.navigationController pushViewController:eoec animated:YES];

      /* UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Alert message" message:@"Please Enter the text above fields"
                                    delegate:self
                           cancelButtonTitle:@"Edit"
                           otherButtonTitles:@"Delete", nil];
    alert.tag=AlertViewOne;
    [alert show];
    [alert release];*/
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
                    
            
            
        if (buttonIndex == 1) {
            
            
                      sqlite3_stmt    *statement;
        

            if( sqlite3_open([databasePath UTF8String], &exerciseDB) == SQLITE_OK )
            {
                // Create Query String.
                NSString* sqlStatement = [NSString stringWithFormat:@"DELETE FROM \"EXERCISEONE\" WHERE date='%@'", Selectedrow];
                NSLog(@"ok%@",sqlStatement);

                sqlite3_prepare_v2(exerciseDB,  [sqlStatement UTF8String], -1, & statement, NULL);
                    if (sqlite3_step(statement) == SQLITE_DONE)
                    {
                        NSLog(@"ssss");
                    } else {
                        NSLog(@"nnnnn");
                    }
                    sqlite3_finalize(statement);
                    sqlite3_close(exerciseDB);

            
            }
            else
            {
                NSLog( @"DeleteFromDataBase: Error While opening database. Error: %s\n", sqlite3_errmsg(exerciseDB) );
            }

        }
        else{
            
        }
   
}

- (void)dealloc {
	[Selectedrow release];
	[listexercise1 release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
