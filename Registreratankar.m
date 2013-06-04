//
//  Registreratankar.m
//  Välkommen till TFH-appen
//
//  Created by Mohammed Abdul Majeed on 4/29/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import "Registreratankar.h"
#import "MTPopupWindow.h"
int s=0;
#define kAlertViewOne 1
#define kAlertViewTwo 2
//NSMutableString *firstString;
@interface Registreratankar ()

@end

@implementation Registreratankar
@synthesize flykt,tanke,tabellen,nat;
@synthesize negative,situation,beteenden,overiga;
@synthesize listexercise1,tableView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text isEqualToString:@"\n"])
        [textView resignFirstResponder];
    return YES;
}
- (void)viewDidLoad
{
    
    self.navigationItem.title=@"Registrera tankar";
   // eevc=[[EditExerciseViewController alloc]initWithNibName:@"EditExerciseViewController" bundle:nil];
    UIBarButtonItem *bButton = [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                                                style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = bButton;
    
    kanslor.allstrings=[[NSString alloc]init];
      listexercise1=[[NSMutableArray alloc]init];
    [listexercise1 addObject:@"Null" ];
    raderabutton.hidden=YES;
    
    nat.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture2 =
    [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(natalert:)] autorelease];
    [nat addGestureRecognizer:tapGesture2];
    
    tabellen.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture3 =
    [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tabellenalert:)] autorelease];
    [tabellen addGestureRecognizer:tapGesture3];
    
    tanke.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture4 =
    [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tankealert:)] autorelease];
    [tanke addGestureRecognizer:tapGesture4];
    
    flykt.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture5 =
    [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(flyktalert:)] autorelease];
    [flykt addGestureRecognizer:tapGesture5];
    
    NSString *docsDir;
    NSArray *dirPaths;
    
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    
    // Build the path to the database file
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"exerciseDB.db"]];
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    if ([filemgr fileExistsAtPath: databasePath ] == YES)
    {
		const char *dbpath = [databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &exerciseDB) == SQLITE_OK)
        {
            char *errMsg;
            const char *sql_stmt = "CREATE TABLE IF NOT EXISTS EXERCISEONE (ID INTEGER PRIMARY KEY AUTOINCREMENT, DATE TEXT,  NEGATIVE TEXT ,SITUATION TEXT,BETEENDEN TEXT, OVERIGA TEXT)";
            
            if (sqlite3_exec(exerciseDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
            {
                NSLog(@"Failed to create database");
            }
            
            sqlite3_close(exerciseDB);
            
        } else {
            //status.text = @"Failed to open/create database";
        }
    }
    
    [filemgr release];

    [self.view addSubview:listofdates];
    listofdates.hidden=YES;
    [self.view addSubview:PopupView1];
    PopupView1.hidden=YES;
    [self.view addSubview:PopupView2];
    PopupView2.hidden=YES;
    
    [self.view addSubview:PopupView4];
    PopupView4.hidden=YES;
    scroll.scrollEnabled = YES;
    [scroll setContentSize:CGSizeMake(320, 1100)];
    
   scroll2.scrollEnabled = YES;
[scroll2 setContentSize:CGSizeMake(768, 1200)];
    
    //scroll1.scrollEnabled = YES;
   // [scroll1 setContentSize:CGSizeMake(320, 700)];
    [super viewDidLoad]; 
    // Do any additional setup after loading the view from its nib.
}
-(IBAction)mainlabelalert:(id)sender{
     [MTPopupWindow showWindowWithHTMLFile:@"Registreratankar.html" insideView:self.view];
}

-(IBAction)natalert:(id)sender{
  
    
    [self.view bringSubviewToFront:PopupView2];
    PopupView2.hidden = NO;
    [UIView beginAnimations:@"curlInView" context:nil];
    [UIView setAnimationDuration:1.0];
    [UIView commitAnimations];
}
-(IBAction)tabellenalert:(id)sender{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
       
               kanslor=[[KanslorViewController alloc]initWithNibName:@"KanslorViewController" bundle:nil];
       
    }
    else{
         kanslor=[[KanslorViewController alloc]initWithNibName:@"KanslorViewController_iPad" bundle:nil];
    }
   

    [self. navigationController pushViewController:kanslor animated:YES];

}
-(IBAction)tankealert:(id)sender{
    
   
    [self.view bringSubviewToFront:PopupView1];
    PopupView1.hidden = NO;
    [UIView beginAnimations:@"curlInView" context:nil];
    [UIView setAnimationDuration:1.0];
    [UIView commitAnimations];
}
-(IBAction)flyktalert:(id)sender{
   
    
    [self.view bringSubviewToFront:PopupView4];
    PopupView4.hidden = NO;
    [UIView beginAnimations:@"curlInView" context:nil];
    [UIView setAnimationDuration:1.0];
    [UIView commitAnimations];
}

-(void) viewWillAppear: (BOOL) animated {
   
    if(kanslor.allstrings==NULL){
       
       
    }else{
        NSLog(@"%@",kanslor.allstrings);
        beteenden.text=kanslor.allstrings;
    }
    [super viewWillAppear:animated];
    
}
-(IBAction)Sparabutton:(id)sender{
    NSDate* date = [NSDate date];
    
    //Create the dateformatter object
    
    NSDateFormatter* formatter = [[[NSDateFormatter alloc] init] autorelease];
    
    //Set the required date format
    
    [formatter setDateFormat:@"MMM d YYYY HH:mm:ss"];
    
    //Get the string date
    
    NSString* str = [formatter stringFromDate:date];
    
    NSLog(@"date%@",str);
    
    if([negative.text isEqualToString:@""] &&[situation.text isEqualToString:@""] &&[beteenden.text isEqualToString:@""] && [overiga.text isEqualToString:@""]){
       
        alert=[[UIAlertView alloc] initWithTitle:@"Alert message" message:@"Please Enter the text above fields"
                                        delegate:self
                               cancelButtonTitle:@"Cancel"
                               otherButtonTitles:nil, nil];
      
        [alert show];
        [alert release];
    }
       
  else{
        NSLog(@"yes");
   
        
        const char *dbpath = [databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &exerciseDB) == SQLITE_OK)
        {
            //NSLog(@"%@",[listexercise1 objectAtIndex:s] );
               if([[listexercise1 objectAtIndex:s] isEqualToString:@"Null"]){
            NSString *insertSQL = [NSString stringWithFormat: @"INSERT INTO EXERCISEONE (date,negative,situation,beteenden,overiga) VALUES (\"%@\", \"%@\", \"%@\" ,\"%@\",\"%@\")", str, negative.text,situation.text, beteenden.text , overiga.text];
            
            const char *insert_stmt = [insertSQL UTF8String];
            
            sqlite3_prepare_v2(exerciseDB, insert_stmt, -1, &statement, NULL);
            if (sqlite3_step(statement) == SQLITE_DONE)
            {
             
                situation.text = @"";
                negative.text = @"";
                overiga.text = @"";
                beteenden.text=@"";
                
                
            } else {
                NSLog(@"no");
            }
            sqlite3_finalize(statement);
            sqlite3_close(exerciseDB);
               }else{
                   
                   NSString *query=[NSString stringWithFormat:@"UPDATE EXERCISEONE SET negative='%@', situation='%@' , beteenden='%@', overiga='%@' WHERE date='%@' ",negative.text,situation.text, beteenden.text,overiga.text, [listexercise1 objectAtIndex:s]];
                   const char *del_stmt = [query UTF8String];
                   
                   if (sqlite3_prepare_v2(exerciseDB, del_stmt, -1, & statement, NULL)==SQLITE_OK){
                       if(SQLITE_DONE != sqlite3_step(statement))
                           NSLog(@"Error while updating. %s", sqlite3_errmsg(exerciseDB));
                       NSLog(@"sss");
                       situation.text = @"";
                       negative.text = @"";
                       overiga.text = @"";
                       beteenden.text=@"";
                   }
                   
                   
                   sqlite3_finalize(statement);
                   sqlite3_close(exerciseDB);
                   
                   
                   
                   
               }


      }  }

    
}

-(IBAction)nyttbutton:(id)sender{
    
    if([situation.text isEqualToString:@""] && [negative.text isEqualToString:@""] && [overiga.text isEqualToString:@""] && [beteenden.text isEqualToString:@""]){
   
    }else{
        alert=[[UIAlertView alloc] initWithTitle:@"Alert message" message:@"Please Enter the text above fields"
                                        delegate:self
                               cancelButtonTitle:@"Cancel"
                               otherButtonTitles:@"without saving", nil];
        alert.tag=kAlertViewOne;
        [alert show];
        [alert release];
    }
    
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
     NSLog(@"ok");
    if(alert.tag  == kAlertViewOne) {
        if (buttonIndex == 1) {
            NSLog(@"new form");
            situation.text = @"";
            negative.text = @"";
            overiga.text = @"";
            beteenden.text=@"";
            
        }else{
           
        }
    } else{
        
    }
}
-(IBAction)Editbutton:(id)sender{
    scroll.scrollEnabled = NO;
  
    [listexercise1 removeAllObjects];
    [self.view bringSubviewToFront:listofdates];
    listofdates.hidden = NO;
    [UIView beginAnimations:@"curlInView" context:nil];
    [UIView setAnimationDuration:1.0];
    [UIView commitAnimations];
    [self getlistofDates];
        //[self.navigationController pushViewController:eevc animated:YES];
}
-(void)getlistofDates{
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &exerciseDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT date FROM EXERCISEONE"
                              ];
        
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(exerciseDB,
                               query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            NSLog(@"%u",SQLITE_ROW);
            while (sqlite3_step(statement) == SQLITE_ROW) {
             
                char* date = (char*) sqlite3_column_text(statement,0);
                NSString *tmp;
                if (date != NULL){
                    tmp = [NSString stringWithUTF8String:date];
                    NSLog(@"value form db :%@",tmp);
                    [listexercise1 addObject:tmp];
                }
            }
            if (sqlite3_step(statement) != SQLITE_ROW) {
                NSLog(@"%u",listexercise1.count);
                if (listexercise1.count==0) {
                    listofdates.hidden = YES;
                    scroll.scrollEnabled=YES;
                }
               
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(exerciseDB);
    }
    
    [self.tableView reloadData];
    

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.listexercise1 count];
}

// This will tell your UITableView what data to put in which cells in your table.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifer = @"CellIdentifier";
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifer];
    
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
    s=indexPath.row;
    NSLog(@"ssss%u",s);
    SelectedDate=[NSString stringWithFormat:@"%@", dictionary];
    NSLog(@"%@",SelectedDate);
    raderabutton.hidden=NO;
    if (sqlite3_open([databasePath UTF8String], &exerciseDB) == SQLITE_OK) {
        
        NSString *sql = [NSString stringWithFormat: @"SELECT * FROM EXERCISEONE WHERE date='%@'", SelectedDate];
        
        const char *del_stmt = [sql UTF8String];
        
        sqlite3_prepare_v2(exerciseDB, del_stmt, -1, & statement, NULL);
        while (sqlite3_step(statement) == SQLITE_ROW) {
            
            char* c1 = (char*) sqlite3_column_text(statement,2);
            NSString *tmp1;
            if (c1 != NULL){
                tmp1 = [NSString stringWithUTF8String:c1];
                NSLog(@"value form db :%@",tmp1);
                negative.text=tmp1;
            }
            char* c2 = (char*) sqlite3_column_text(statement,3);
            NSString *tmp2;
            if (c2 != NULL){
                tmp2 = [NSString stringWithUTF8String:c2];
                NSLog(@"value form db :%@",tmp2);
                situation.text=tmp2;
            }
            
            char* c3 = (char*) sqlite3_column_text(statement,4);
            NSString *tmp3;
            if (c3!= NULL){
                tmp3= [NSString stringWithUTF8String:c3];
                NSLog(@"value form db :%@",tmp3);
                beteenden.text=tmp3;
            }
            
            char* c4 = (char*) sqlite3_column_text(statement,5);
            NSString *tmp4;
            if (c4 != NULL){
                tmp4= [NSString stringWithUTF8String:c4];
                NSLog(@"value form db :%@",tmp4);
                overiga.text=tmp4;
            }
            
        }
        
        sqlite3_finalize(statement);
        sqlite3_close(exerciseDB);
        
    }
}
-(IBAction)aMethod:(id)sender{
    
    
    
    
    if (sqlite3_open([databasePath UTF8String], &exerciseDB) == SQLITE_OK) {
        
        NSString *sql = [NSString stringWithFormat: @"DELETE FROM EXERCISEONE WHERE date='%@'", [listexercise1 objectAtIndex:s]];
        
        const char *del_stmt = [sql UTF8String];
        
        sqlite3_prepare_v2(exerciseDB, del_stmt, -1, & statement, NULL);
        if (sqlite3_step(statement) == SQLITE_ROW) {
            
            NSLog(@"sss");
            
        }
        raderabutton.hidden=YES;
        situation.text = @"";
        negative.text = @"";
        overiga.text = @"";
        beteenden.text=@"";
        sqlite3_finalize(statement);
        sqlite3_close(exerciseDB);
        
        
    }
    //[listexercise1 removeAllObjects];
   // [self getlistofDates];
    
     [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)Closelistofdates:(id)sender{
    listofdates.hidden = YES;
      scroll.scrollEnabled = YES;
    PopupView1.hidden=YES;
     PopupView4.hidden=YES;
     PopupView2.hidden=YES;
    NSLog(@"value of s%@",[listexercise1 objectAtIndex:s]);
}
@end