//
//  Utmanatankar.m
//  Välkommen till TFH-appen
//
//  Created by Mohammed Abdul Majeed on 5/1/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import "Utmanatankar.h"
#import "MTPopupWindow.h"
int y=0;
#define kAlertViewOne 1
#define kAlertViewTwo 2
NSArray *pArray;
@interface Utmanatankar ()

@end

@implementation Utmanatankar
@synthesize  label1,strategier,negative,din,motavis,tanke,alltanke,c1,c2,c3,c4,c5,c6;
@synthesize listexercise3,tableView;

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
    self.navigationItem.title=@"Utmana tankar";
    scroll.scrollEnabled = YES;
    [scroll setContentSize:CGSizeMake(320, 1400)];
    listexercise3=[[NSMutableArray alloc]init];
    [listexercise3 addObject:@"Null"];
    raderaButton.hidden=YES;
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                                                   style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;
    
    
    
    label1.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture2 =
    [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(label1alert:)] autorelease];
    [label1 addGestureRecognizer:tapGesture2];
    
    
    strategier.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture3 =
    [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(strategieralert:)] autorelease];
    [strategier addGestureRecognizer:tapGesture3];
    
    
    negative.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture4 =
    [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(negativealert:)] autorelease];
    [negative addGestureRecognizer:tapGesture4];
    
    
    din.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture5 =
    [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dinalert:)] autorelease];
    [din addGestureRecognizer:tapGesture5];
    
    motavis.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture6 =
    [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(motavisalert:)] autorelease];
    [motavis addGestureRecognizer:tapGesture6];
    
    tanke.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture7 =
    [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tankealert:)] autorelease];
    [tanke addGestureRecognizer:tapGesture7];
    
    alltanke.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture8 =
    [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(alltankealert:)] autorelease];
    [alltanke addGestureRecognizer:tapGesture8];
    
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
            const char *sql_stmt = "CREATE TABLE IF NOT EXISTS EXERCISE3 (ID INTEGER PRIMARY KEY AUTOINCREMENT, DATE TEXT,  NEGATIVE TEXT ,DINA TEXT,HUR TEXT, MOTBEVIS TEXT,TANKEFALLA TEXT,ALTERNATIV TEXT)";
            
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
    [self.view addSubview:Label1Popup];
    Label1Popup.hidden=YES;
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
-(IBAction)labelalert:(id)sender{
    [MTPopupWindow showWindowWithHTMLFile:@"Utmanatankar.html" insideView:self.view];
}

-(IBAction)label1alert:(id)sender{
    //[MTPopupWindow showWindowWithHTMLFile:@"om.html" insideView:self.view];
    scroll.scrollEnabled = NO;
    [self.view bringSubviewToFront:Label1Popup];
    Label1Popup.hidden = NO;
    [UIView beginAnimations:@"curlInView" context:nil];
    [UIView setAnimationDuration:1.0];
    [UIView commitAnimations];
}
-(IBAction)strategieralert:(id)sender{
    [MTPopupWindow showWindowWithHTMLFile:@"tankefallar.html" insideView:self.view];
}
-(IBAction)negativealert:(id)sender{
    [MTPopupWindow showWindowWithHTMLFile:@"tanke.html" insideView:self.view];
}

-(IBAction)dinalert:(id)sender{
    [MTPopupWindow showWindowWithHTMLFile:@"Minabevis.html" insideView:self.view];
}
-(IBAction)motavisalert:(id)sender{
    [MTPopupWindow showWindowWithHTMLFile:@"Motbevis.html" insideView:self.view];
}
-(IBAction)tankealert:(id)sender{
    [MTPopupWindow showWindowWithHTMLFile:@"tanefallor.html" insideView:self.view];
}
-(IBAction)alltankealert:(id)sender{
    [MTPopupWindow showWindowWithHTMLFile:@"Alternativtanke.html" insideView:self.view];
}

-(IBAction)changeSlider:(id)sender {
    
    NSString *str= [[NSString alloc] initWithFormat:@"%d%@", (int)slider.value,@"%"];
    self.c3.text=str;
}

-(IBAction)sparabutton:(id)sender{
    
    NSLog(@"c2%@",c2.text);
    NSDate* date = [NSDate date];
    
    //Create the dateformatter object
    
    NSDateFormatter* formatter = [[[NSDateFormatter alloc] init] autorelease];
    
    //Set the required date format
    
    [formatter setDateFormat:@"MMM d YYYY HH:mm:ss"];
    
    //Get the string date
    
    NSString* str1 = [formatter stringFromDate:date];
    
    NSLog(@"date%@",str1);
    if ([c1.text isEqualToString:@""]&&[c2.text isEqualToString:@""]&&[c4.text isEqualToString:@""]
        &&[c5.text isEqualToString:@""]&&[c6.text isEqualToString:@""]) {
        alert=[[UIAlertView alloc] initWithTitle:@"Alert message" message:@"Please Enter the text above fields"
                                        delegate:self
                               cancelButtonTitle:@"Cancel"
                               otherButtonTitles:nil, nil];
        
        [alert show];
        [alert release];
    }else{
        
        
        const char *dbpath = [databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &exerciseDB) == SQLITE_OK)
        {
            if([[listexercise3 objectAtIndex:y] isEqualToString:@"Null"]){
                NSString *insertSQL = [NSString stringWithFormat: @"INSERT INTO EXERCISE3 (date,negative,dina,hur,motbevis,tankefalla,alternativ) VALUES (\"%@\", \"%@\", \"%@\" ,\"%@\",\"%@\",\"%@\",\"%@\")", str1, c1.text,c2.text, c3.text ,c4.text,c5.text,c6.text];
                
                const char *insert_stmt = [insertSQL UTF8String];
                
                sqlite3_prepare_v2(exerciseDB, insert_stmt, -1, &statement, NULL);
                if (sqlite3_step(statement) == SQLITE_DONE)
                    
                    
                    
                {
                    c1.text=@"";
                    c2.text=@"";
                    c3.text=@"0%";
                    c4.text=@"";
                    c5.text=@"";
                    c6.text=@"";
                    NSLog(@"yes");
                    slider.value=0.0;
                } else {
                    NSLog(@"no");
                }
                sqlite3_finalize(statement);
                sqlite3_close(exerciseDB);
            }
            else{
                NSString *query=[NSString stringWithFormat:@"UPDATE EXERCISE3 SET  negative='%@',dina='%@', hur='%@', motbevis='%@', tankefalla='%@',alternativ='%@' WHERE date='%@'",c1.text,c2.text, c3.text,c4.text, c5.text,c6.text,[listexercise3 objectAtIndex:y] ];
                
                
                const char *del_stmt = [query UTF8String];
                
                if (sqlite3_prepare_v2(exerciseDB, del_stmt, -1, & statement, NULL)==SQLITE_OK){
                    if(SQLITE_DONE != sqlite3_step(statement))
                        NSLog(@"Error while updating. %s", sqlite3_errmsg(exerciseDB));
                    NSLog(@"sss");
                    c1.text=@"";
                    c2.text=@"";
                    c3.text=@"0%";
                    c4.text=@"";
                    c5.text=@"";
                    c6.text=@"";
                    slider.value=0.0;
                    raderaButton.hidden=YES;
                    [listexercise3 removeAllObjects];
                    y=0;
                    [listexercise3 addObject:@"Null"];
                }
                
                
                
                sqlite3_finalize(statement);
                sqlite3_close(exerciseDB);
                
                
                
            }
        }
    }
    
}
-(IBAction)newbutton:(id)sender{
    if ([c1.text isEqualToString:@""]&&[c2.text isEqualToString:@""]&&[c4.text isEqualToString:@""]
        &&[c5.text isEqualToString:@""]&&[c6.text isEqualToString:@""]) {
        
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
    if( alert.tag==kAlertViewOne){
        if (buttonIndex == 1) {
            NSLog(@"new form");
            
            c1.text=@"";
            c2.text=@"";
            c3.text=@"0%";
            c4.text=@"";
            c5.text=@"";
            c6.text=@"";
            slider.value=0.0;
            raderaButton.hidden=YES;
            [listexercise3 removeAllObjects];
            y=0;
            [listexercise3 addObject:@"Null"];
        }else{
            
        }
    }else{
        
    }
}

-(IBAction)nextbutton:(id)sender{
    // udv=[[UtmanaDateView alloc]initWithNibName:@"UtmanaDateView" bundle:nil];
    // [self.navigationController pushViewController:udv animated:YES];
    scroll.scrollEnabled = NO;
    
    [listexercise3 removeAllObjects];
    [self.view bringSubviewToFront:listofdates];
    listofdates.hidden = NO;
    [UIView beginAnimations:@"curlInView" context:nil];
    [UIView setAnimationDuration:1.0];
    [UIView commitAnimations];
    [self getlistofDates3];
}
-(void)getlistofDates3{
    const char *dbpath = [databasePath UTF8String];
    
    
    if (sqlite3_open(dbpath, &exerciseDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT date FROM EXERCISE3"
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
                    [listexercise3 addObject:tmp];
                }
            }
            if (sqlite3_step(statement) != SQLITE_ROW) {
                NSLog(@"%u",listexercise3.count);
                
                if (listexercise3.count==0) {
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
    return [self.listexercise3 count];
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
    cell.textLabel.text = [listexercise3 objectAtIndex:row];
    
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	// Upon selecting an event, create an EKEventViewController to display the event.
	NSDictionary *dictionary = [self.listexercise3 objectAtIndex:indexPath.row];
    NSLog(@"%@",dictionary);
    y=indexPath.row;
    SelectedDate=[NSString stringWithFormat:@"%@", dictionary];
    NSLog(@"%@",SelectedDate);
    raderaButton.hidden=NO;
    if (sqlite3_open([databasePath UTF8String], &exerciseDB) == SQLITE_OK) {
        
        NSString *sql = [NSString stringWithFormat: @"SELECT * FROM EXERCISE3 WHERE date='%@'", SelectedDate];
        
        const char *del_stmt = [sql UTF8String];
        
        sqlite3_prepare_v2(exerciseDB, del_stmt, -1, & statement, NULL);
        while (sqlite3_step(statement) == SQLITE_ROW) {
            
            char* ch1 = (char*) sqlite3_column_text(statement,2);
            
            if (ch1 != NULL){
                c1.text = [NSString stringWithUTF8String:ch1];
                NSLog(@"value form db :%@",c1.text);
                
            }
            char* ch2 = (char*) sqlite3_column_text(statement,3);
            
            if (ch2 != NULL){
                c2.text = [NSString stringWithUTF8String:ch2];
                NSLog(@"value form db :%@",c2.text);
                
            }
            
            char* ch3 = (char*) sqlite3_column_text(statement,4);
            
            if (ch3!= NULL){
                c3.text= [NSString stringWithUTF8String:ch3];
                NSLog(@"value form db :%@",c3.text);
                int z=[c3.text intValue];
                float vOut = (float)z;
                slider.value=vOut;
                
            }
            
            char* ch4 = (char*) sqlite3_column_text(statement,5);
            
            if (ch4 != NULL){
                c4.text= [NSString stringWithUTF8String:ch4];
                NSLog(@"value form db :%@",c4.text);
                
            }
            char* ch5 = (char*) sqlite3_column_text(statement,6);
            
            if (ch5!= NULL){
                c5.text= [NSString stringWithUTF8String:ch5];
                NSLog(@"value form db :%@",c5.text);
                
            }
            
            char* ch6 = (char*) sqlite3_column_text(statement,7);
            
            if (ch6 != NULL){
                c6.text= [NSString stringWithUTF8String:ch6];
                NSLog(@"value form db :%@",c6.text);
                
            }
            
            
        }
        
        sqlite3_finalize(statement);
        sqlite3_close(exerciseDB);
        
        
    }
    
}
-(IBAction)aMethod:(id)sender{
    
    if (sqlite3_open([databasePath UTF8String], &exerciseDB) == SQLITE_OK) {
        
        NSString *sql = [NSString stringWithFormat: @"DELETE FROM EXERCISE3 WHERE date='%@'", [listexercise3 objectAtIndex:y] ];
        
        const char *del_stmt = [sql UTF8String];
        
        sqlite3_prepare_v2(exerciseDB, del_stmt, -1, & statement, NULL);
        if (sqlite3_step(statement) == SQLITE_ROW) {
            
            NSLog(@"sss");
        }
        
        sqlite3_finalize(statement);
        sqlite3_close(exerciseDB);
        
        
    }
    c1.text=@"";
    c2.text=@"";
    c3.text=@"0%";
    c4.text=@"";
    c5.text=@"";
    c6.text=@"";
    raderaButton.hidden=YES;
    [listexercise3 removeAllObjects];
    y=0;
    [listexercise3 addObject:@"Null"];
    [self getlistofDates3];
}
-(IBAction)Closelistofdates:(id)sender{
    listofdates.hidden = YES;
    scroll.scrollEnabled = YES;
    Label1Popup.hidden=YES;
}
-(IBAction)SelectChekBoxs:(id)sender{
    UIButton *btn=(UIButton *)sender;
    switch (btn.tag) {
        case 1:
            if (btn.currentImage==[UIImage imageNamed:@"unchecked.png"]){
                [btn setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
                
            }else{
                [btn setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
            }
            break;
        case 2:
            if (btn.currentImage==[UIImage imageNamed:@"unchecked.png"]){
                [btn setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
                
            }else{
                [btn setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
            }
            break;
        case 3:
            if (btn.currentImage==[UIImage imageNamed:@"unchecked.png"]){
                [btn setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
                
            }else{
                [btn setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
            }
            break;
        case 4:
            if (btn.currentImage==[UIImage imageNamed:@"unchecked.png"]){
                [btn setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
                
            }else{
                [btn setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
            }
            break;
        case 5:
            if (btn.currentImage==[UIImage imageNamed:@"unchecked.png"]){
                [btn setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
                
            }else{
                [btn setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
            }
            break;
        case 6:
            if (btn.currentImage==[UIImage imageNamed:@"unchecked.png"]){
                [btn setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
                
            }else{
                [btn setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
            }
            break;case 7:
            if (btn.currentImage==[UIImage imageNamed:@"unchecked.png"]){
                [btn setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
                
            }else{
                [btn setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
            }
            break;case 8:
            if (btn.currentImage==[UIImage imageNamed:@"unchecked.png"]){
                [btn setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
                
            }else{
                [btn setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
            }
            break;
            
        default:
            break;
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

