//
//  BeteendeexperimentController.m
//  Välkommen till TFH-appen
//
//  Created by Mohammed Abdul Majeed on 5/2/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import "BeteendeexperimentController.h"
#import "MTPopupWindow.h"
int c=0;
#define kAlertViewOne 1
#define kAlertViewTwo 2

@interface BeteendeexperimentController ()

@property (nonatomic) BOOL isSaved;

@end

@implementation BeteendeexperimentController
@synthesize label1,ex3c1,ex3c2,ex3c3,ex3c4,ex3c5,slabel1,slabel2,tableview,listexercise4,list_exercise4;
@synthesize isSaved;

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
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        
        [UIView animateWithDuration:0.5
                         animations:^{
                             self.view.frame = CGRectMake(self.view.frame.origin.x, 0, self.view.frame.size.width, self.view.frame.size.height);
                         }
                         completion:^(BOOL finished){
                             // whatever you need to do when animations are complete
                             
                         }];
    }
    else {
        return YES;
    }
    return 0;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    [UIView animateWithDuration:0.5
                     animations:^{
                         self.view.frame = CGRectMake(self.view.frame.origin.x, -170, self.view.frame.size.width, self.view.frame.size.height);
                     }
                     completion:^(BOOL finished){
                         // whatever you need to do when animations are complete
                         
                     }];
    
    return YES;
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [ex3c1 resignFirstResponder];
    //picker.hidden=YES;
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)aTextField{
    [ex3c1 resignFirstResponder];
    
    picker.hidden=NO;
    [picker addTarget:self action:@selector(dueDateChanged:) forControlEvents:UIControlEventValueChanged];
    //[self.view addSubview:picker];
    [picker release];

}
- (void)viewDidLoad
{
    self.navigationItem.title=@"Beteendeexperiment";
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;
    
    [self.view addSubview:listofdates];
    picker.hidden=YES;
    raderabutton.enabled=NO;
    listofdates.hidden=YES;
    scroll.scrollEnabled = YES;
    [scroll setContentSize:CGSizeMake(320, 1285)];
     list_exercise4=[[NSMutableArray alloc]init];
    [list_exercise4 addObject:@"Null"];

    
    label1.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture2 =
    [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(l1alert:)] autorelease];
    [label1 addGestureRecognizer:tapGesture2];
    
    
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
            const char *sql_stmt = "CREATE TABLE IF NOT EXISTS EXERCISE4 (ID INTEGER PRIMARY KEY AUTOINCREMENT, DATE TEXT,  DATUM TEXT ,EXPERIMENTET TEXT,FORUTSAGE TEXT,FORUTPRC TEXT, RESULTAT TEXT,LARDOMAR TEXT,LARDPRC TEXT)";
            
            if (sqlite3_exec(exerciseDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
            {
                NSLog(@"Failed to create database");
            }else{
                 NSLog(@"create database");
            }
            
            sqlite3_close(exerciseDB);
            
        } else {
            //status.text = @"Failed to open/create database";
        }
    
    

    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    isSaved = YES;
}


-(void) dueDateChanged:(UIDatePicker *)sender {
    NSDateFormatter* dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormatter setDateStyle:NSDateFormatterLongStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    picker.hidden=YES;
    //self.myLabel.text = [dateFormatter stringFromDate:[dueDatePickerView date]];
    NSLog(@"Picked the date %@", [dateFormatter stringFromDate:[sender date]]);
}


-(IBAction)mainlabelalert:(id)sender{
     [MTPopupWindow showWindowWithHTMLFile:@"Beteebdeexperiment.html" insideView:self.view];
}


-(IBAction)l1alert:(id)sender{
     [MTPopupWindow showWindowWithHTMLFile:@"tanke.html" insideView:self.view];
}


-(IBAction)changeSlider:(id)sender {
    
    NSString *sl1= [[NSString alloc] initWithFormat:@"%d%@", (int)slider.value,@"%"];
    NSLog(@"sl1%@",sl1);
    self.slabel1.text=sl1;
     NSLog(@"self.slabel1.text%@",self.slabel1.text);
    
}
-(IBAction)changeSlider1:(id)sender {
    
    NSString *sl2= [[NSString alloc] initWithFormat:@"%d%@", (int)slider1.value,@"%"];
    NSLog(@"str%@",sl2);
    self.slabel2.text=sl2;
     NSLog(@"self.slabel2.text%@",self.slabel2.text);
    
}


-(IBAction)saveButton:(id)sender {
    NSDate* date = [NSDate date];
    
    //Create the dateformatter object
    
    NSDateFormatter* formatter = [[[NSDateFormatter alloc] init] autorelease];
    
    //Set the required date format
    
    [formatter setDateFormat:@"MMM d YYYY HH:mm:ss"];
    
    //Get the string date
    
    NSString* str = [formatter stringFromDate:date];
    
    NSLog(@"date%@",str);
    raderabutton.enabled=NO;
    if ([ex3c1.text isEqualToString:@""] &&[ex3c2.text isEqualToString:@""]&&[ex3c3.text isEqualToString:@""]&&[ex3c4.text isEqualToString:@""]&&[ex3c5.text isEqualToString:@""]) {
        
    }else{
        
        //DATE TEXT,  DATUM TEXT ,EXPERIMENTET TEXT,FORUTSAGE TEXT, RESULTAT TEXT,LARDOMAR TEXT
        const char *dbpath = [databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &exerciseDB) == SQLITE_OK)
        {
            if([[list_exercise4 objectAtIndex:0]  isEqualToString:@"Null"]){
                NSString *insertSQL = [NSString stringWithFormat: @"INSERT INTO EXERCISE4 (date,datum,experimentet,forutsage,forutprc,resultat,lardomar,lardprc) VALUES (\"%@\", \"%@\", \"%@\" ,\"%@\",\"%@\",\"%@\",\"%@\",\"%@\")", str, ex3c1.text,ex3c2.text, ex3c3.text , slabel1.text, ex3c4.text,ex3c5.text,slabel2.text];
                
                const char *insert_stmt = [insertSQL UTF8String];
                
                
                sqlite3_prepare_v2(exerciseDB, insert_stmt, -1, &statement, NULL);
                if (sqlite3_step(statement) == SQLITE_DONE)
                {
                    
                    isSaved = NO;
                
                } else {
                    NSLog(@"no");
                }
                sqlite3_finalize(statement);
                sqlite3_close(exerciseDB);
            }else{
                NSString *query=[NSString stringWithFormat:@"UPDATE EXERCISE4 SET  datum='%@',experimentet='%@', forutsage='%@',forutprc='%@', resultat='%@',lardomar='%@' ,lardprc='%@' WHERE date='%@'",ex3c1.text,ex3c2.text, ex3c3.text,slabel1.text, ex3c4.text, ex3c5.text,slabel2.text, [listexercise4 objectAtIndex:c] ];
                const char *del_stmt = [query UTF8String];
                
                if (sqlite3_prepare_v2(exerciseDB, del_stmt, -1, & statement, NULL)==SQLITE_OK);{
                    if(SQLITE_DONE != sqlite3_step(statement))
                        NSLog(@"Error while updating. %s", sqlite3_errmsg(exerciseDB));
                    NSLog(@"sss");
                    isSaved = NO;
        
                }
            
                sqlite3_finalize(statement);
                sqlite3_close(exerciseDB);
            }
        }
        UIAlertView * alert1 = [[UIAlertView alloc] initWithTitle:nil message:@"Sparat" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok",nil];
        [alert1 show];
        [alert1 release];
    }
}


-(IBAction)newButton:(id)sender {
    if([ex3c1.text isEqualToString:@""] && [ex3c2.text isEqualToString:@""] && [ex3c3.text isEqualToString:@""] && [ex3c4.text isEqualToString:@""]&& [ex3c5.text isEqualToString:@""]){
        
    }else{
        
        if (isSaved == YES) {
            UIAlertView  *alert=[[UIAlertView alloc] initWithTitle:nil message:@"Du har inte sparat ditt formulär, är du säker på att du vill fortsätta?"
                                            delegate:self
                                   cancelButtonTitle:@"Forsätt"
                                   otherButtonTitles:@"Avbryt", nil];
            alert.tag=kAlertViewOne;
            [alert show];
            [alert release];
        }
        else {
            [self clearalltexts];
            raderabutton.enabled=NO;
            [list_exercise4 removeAllObjects];
            c=0;
            [list_exercise4 addObject:@"Null"];
            isSaved = YES;
        }
    }
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"ok");
    if(alertView.tag  == kAlertViewOne) {
        if (buttonIndex == 0) {
            NSLog(@"new form");
            [self clearalltexts];
            raderabutton.enabled=NO;
            [list_exercise4 removeAllObjects];
            c=0;
            [list_exercise4 addObject:@"Null"];
            isSaved = YES;
        }else{
            isSaved = YES;
        }
    } else if(alertView.tag == kAlertViewTwo) {
        if (buttonIndex == 0) {
            
            if (sqlite3_open([databasePath UTF8String], &exerciseDB) == SQLITE_OK) {
                
                NSString *sql = [NSString stringWithFormat: @"DELETE FROM EXERCISE4  WHERE date='%@'", [listexercise4 objectAtIndex:c] ];
                
                const char *del_stmt = [sql UTF8String];
                
                sqlite3_prepare_v2(exerciseDB, del_stmt, -1, & statement, NULL);
                if (sqlite3_step(statement) == SQLITE_ROW) {
                    
                    NSLog(@"sss");
                }
                
                sqlite3_finalize(statement);
                sqlite3_close(exerciseDB);
    
            }
            raderabutton.enabled=NO;
            [list_exercise4 removeAllObjects];
            c=0;
            [list_exercise4 addObject:@"Null"];
            [self clearalltexts];
            listofdates.hidden = YES;
            scroll.scrollEnabled = YES;
            
            UIAlertView * alert1 = [[UIAlertView alloc] initWithTitle:nil message:@"Raderat" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok",nil];
            [alert1 show];
            [alert1 release];
        }
        else {
            
        }
    }
}



-(void)clearalltexts {
    ex3c1.text=@"";
    ex3c2.text=@""; ex3c3.text=@""; ex3c4.text=@""; ex3c5.text=@"";
    slabel1.text=@"";
    slabel2.text=@"";
    slider.value=0.0;
    slider1.value=0.0;
}


-(IBAction)nextButton:(id)sender{
   
    
    scroll.scrollEnabled = NO;
    listexercise4=[[NSMutableArray alloc]init];
    [listexercise4 removeAllObjects];
    [self.view bringSubviewToFront:listofdates];
    listofdates.hidden = NO;
    [UIView beginAnimations:@"curlInView" context:nil];
    [UIView setAnimationDuration:1.0];
    [UIView commitAnimations];
      [self getlistofDates];
}
-(void)getlistofDates{
    const char *dbpath = [databasePath UTF8String];
    
    
    if (sqlite3_open(dbpath, &exerciseDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT date FROM EXERCISE4 ORDER BY date DESC"
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
                    [listexercise4 addObject:tmp];
                }
            }
            if (sqlite3_step(statement) != SQLITE_ROW) {
                NSLog(@"%u",listexercise4.count);
                if (listexercise4.count==0) {
                    listofdates.hidden = YES;
                    scroll.scrollEnabled=YES;
                }
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(exerciseDB);
    }
    
    [self.tableview reloadData];
    

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.listexercise4 count];
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
    cell.textLabel.text = [listexercise4 objectAtIndex:row];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	// Upon selecting an event, create an EKEventViewController to display the event.
	NSDictionary *dictionary = [self.listexercise4 objectAtIndex:indexPath.row];
    NSLog(@"%@",dictionary);
    c=indexPath.row;
    raderabutton.enabled=YES;
    SelectedDate=[NSString stringWithFormat:@"%@", dictionary];
    [list_exercise4 removeAllObjects];
    [list_exercise4 addObject:SelectedDate];
    
    NSLog(@"%@",SelectedDate);
   
   
    if (sqlite3_open([databasePath UTF8String], &exerciseDB) == SQLITE_OK) {
        
        NSString *sql = [NSString stringWithFormat: @"SELECT * FROM EXERCISE4 WHERE date='%@'", SelectedDate];
        
        const char *del_stmt = [sql UTF8String];
        
        sqlite3_prepare_v2(exerciseDB, del_stmt, -1, & statement, NULL);
        while (sqlite3_step(statement) == SQLITE_ROW) {
            
            char* c1 = (char*) sqlite3_column_text(statement,2);
            
            if (c1 != NULL){
                ex3c1.text = [NSString stringWithUTF8String:c1];
                NSLog(@"value form db :%@",ex3c1.text );
                
            }
            char* c2 = (char*) sqlite3_column_text(statement,3);
            
            if (c2 != NULL){
                ex3c2.text  = [NSString stringWithUTF8String:c2];
                NSLog(@"value form db :%@",ex3c2.text );
                
            }
            
            char* c3 = (char*) sqlite3_column_text(statement,4);
            
            if (c3!= NULL){
                ex3c3.text = [NSString stringWithUTF8String:c3];
                NSLog(@"value form db :%@",ex3c3.text );
            }
            char* c4 = (char*) sqlite3_column_text(statement,5);
            
            if (c4!= NULL){
                slabel1.text = [NSString stringWithUTF8String:c4];
                NSLog(@"value form db :%@",slabel1.text );
                int z=[slabel1.text intValue];
                float vOut = (float)z;
                slider.value=vOut;
                //slabel1.text=@"30%";
            }
            char* c5 = (char*) sqlite3_column_text(statement,6);
            
            if (c5 != NULL){
                ex3c4.text = [NSString stringWithUTF8String:c5];
                NSLog(@"value form db :%@",ex3c4.text );
                
            }
            char* c6 = (char*) sqlite3_column_text(statement,7);
            
            if (c6 != NULL){
                ex3c5.text = [NSString stringWithUTF8String:c6];
                NSLog(@"value form db :%@",ex3c5.text );
                
            }
            char* c7 = (char*) sqlite3_column_text(statement,8);
            
            if (c7 != NULL){
                NSString *str = [NSString stringWithUTF8String:c7];
                NSLog(@"value form db :%@",str);
                slabel2.text=str;
                int z=[slabel2.text intValue];
                float vOut = (float)z;
                slider1.value=vOut;
            }
        }
        
        sqlite3_finalize(statement);
        sqlite3_close(exerciseDB);
        
        
    }
    scroll.scrollEnabled = YES;
    listofdates.hidden = YES;
}

-(IBAction)CloseButton:(id)sender{
    scroll.scrollEnabled = YES;
     listofdates.hidden = YES;
}

- (IBAction)RaderaButton:(id)sender {
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:@"Är du säker på att du vill radera formuläret?" delegate:self cancelButtonTitle:@"Radera" otherButtonTitles:@"Avbryt", nil];
    alert.tag=kAlertViewTwo;
    [alert show];
    [alert release];
}


-(IBAction)displayDate:(id)sender{
    NSDate * selected = [picker date];
	NSString * date = [selected description];
    ex3c1.text=date;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
