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

@interface Utmanatankar ()
@property (nonatomic) BOOL isSaved;
@end

@implementation Utmanatankar
@synthesize  regTankerLabel,strategier,quesitonLabel1,quesitonLabel2,quesitonLabel3,quesitonLabel4,questionLabel5,questionLabel6,c1,c2,c3,c4,c5,c6;
@synthesize listexercise3,tableview,list_exercise3,isSaved;
//Gopal
@synthesize selectedRegistreraTankars;
@synthesize registreraTankars;

//Gopal
@synthesize regButton1,regButton2,regButton3,regButton4,regButton5,regButton6,regButton7,regButton8,regLabel1,regLabel2,regLabel3,regLabel4,regLabel5,regLabel6,regLabel7,regLabel8;

NSArray *pArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


#pragma mark TextViewDelegate Methods

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    isSaved = YES;
    if([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        if (textView == c6) {
            if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
                if ([[UIScreen mainScreen] bounds].size.height >  480 ) {
                    [UIView animateWithDuration:0.5
                                     animations:^{
                                         [scroll setContentOffset:CGPointMake(scroll.frame.origin.x, scroll.frame.origin.y + 850) animated:YES];
                                     }
                                     completion:^(BOOL finished){
                                         // whatever you need to do when animations are complete
                                         
                                     }];
                }
                else {
                    [UIView animateWithDuration:0.5
                                     animations:^{
                                         [scroll setContentOffset:CGPointMake(scroll.frame.origin.x, scroll.frame.origin.y + 940) animated:YES];
                                     }
                                     completion:^(BOOL finished){
                                         // whatever you need to do when animations are complete
                                         
                                     }];
                }
            }
        }
        
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
                         [scroll setContentOffset:CGPointMake(scroll.frame.origin.x, textView.frame.origin.y - 30) animated:YES];
                     }
                     completion:^(BOOL finished){
                         // whatever you need to do when animations are complete
                         NSLog(@"Finished");
                     }];
    
    return YES;
}


#pragma mark Loading the last saved Data
-(void)LoadSavedData {
    //SELECT * FROM EXERCISE3 WHERE date=(SELECT date FROM EXERCISE3 ORDER BY date DESC LIMIT 1)
    
    if (sqlite3_open([databasePath UTF8String], &exerciseDB) == SQLITE_OK) {
        
        NSString *sql = [NSString stringWithFormat: @"SELECT * FROM EXERCISE3 WHERE date=(SELECT date FROM EXERCISE3 ORDER BY date DESC LIMIT 1)"];
        
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
//    listofdates.hidden = YES;
//    scroll.scrollEnabled = YES;
//    Label1Popup.hidden=YES;
//    isSaved = NO;

    
    
    
    
}



#pragma mark ViewLifeCycle Methods

- (void)viewDidLoad
{
    selectedRegistreraTankars = [[NSMutableArray alloc] init];
    self.navigationItem.title=@"Utmana tankar";
    scroll.scrollEnabled = YES;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        if ([[UIScreen mainScreen] bounds].size.height >  480 ) {
            [scroll setContentSize:CGSizeMake(320, 1353)];
        }
        else {
            [scroll setContentSize:CGSizeMake(320, 1353)];
        }
        UIImage *image = [UIImage imageNamed:@"tillbaka1.png"];
        UIButton *okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [okBtn setFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
        [okBtn setBackgroundImage:image forState:UIControlStateNormal];
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
    
    [scroll1 setContentSize:CGSizeMake(768, 1570)];
    
    questionView1.hidden = YES;
    questionView2.hidden = YES;
    questionView3.hidden = YES;
    questionView4.hidden = YES;
    questionView5.hidden = YES;
    questionView6.hidden = YES;
    
    regLabel1.hidden = YES;
    regLabel2.hidden =YES;
    regLabel3.hidden = YES;
    regLabel4.hidden =YES;
    regLabel5.hidden = YES;
    regLabel6.hidden =YES;
    regLabel7.hidden = YES;
    regLabel8.hidden =YES;
    regButton1.hidden = YES;
    regButton2.hidden =YES;
    regButton3.hidden = YES;
    regButton4.hidden =YES;
    regButton5.hidden = YES;
    regButton6.hidden =YES;
    regButton7.hidden = YES;
    regButton8.hidden =YES;
    
    
    scroll1.scrollEnabled = YES;
    [scroll1 setContentSize:CGSizeMake(320, 1600)];
    list_exercise3=[[NSMutableArray alloc]init];
    [list_exercise3 addObject:@"Null"];
    raderaButton.enabled=NO;
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                                                   style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;
    
    
    //Gopal
    regTankerLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture2 =
    [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(registerTankerView:)] autorelease];
    [regTankerLabel addGestureRecognizer:tapGesture2];
    
    
    strategier.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture3 =
    [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(strategieralert:)] autorelease];
    [strategier addGestureRecognizer:tapGesture3];
    
    
    quesitonLabel1.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture4 =
    [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(questionTap1:)] autorelease];
    [quesitonLabel1 addGestureRecognizer:tapGesture4];
    
    
    quesitonLabel2.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture5 =
    [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(questionTap2:)] autorelease];
    [quesitonLabel2 addGestureRecognizer:tapGesture5];
    
    
    
    quesitonLabel3.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture6 =
    [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(questionTap3:)] autorelease];
    [quesitonLabel3 addGestureRecognizer:tapGesture6];
    
    
    quesitonLabel4.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture7 =
    [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(questionTap4:)] autorelease];
    [quesitonLabel4 addGestureRecognizer:tapGesture7];
    
    questionLabel5.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture8 =
    [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(questionTap5:)] autorelease];
    [questionLabel5 addGestureRecognizer:tapGesture8];
    
    questionLabel6.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture9 =
    [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(questionTap6:)] autorelease];
    [questionLabel6 addGestureRecognizer:tapGesture9];
    
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
        const char *sql_stmt = "CREATE TABLE IF NOT EXISTS EXERCISE3 (ID INTEGER PRIMARY KEY AUTOINCREMENT,DATE TEXT,NEGATIVE TEXT,DINA TEXT,HUR TEXT,MOTBEVIS TEXT,TANKEFALLA TEXT,ALTERNATIV TEXT)";
        
        if (sqlite3_exec(exerciseDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
        {
            NSLog(@"Failed to create database");
        }
        
        [self LoadSavedData];
        
        sqlite3_close(exerciseDB);
        
    } else {
        //status.text = @"Failed to open/create database";
    }
    
    [self.view addSubview:listofdates];
    listofdates.hidden=YES;
    [self.view addSubview:Label1Popup];
    Label1Popup.hidden=YES;
    [self getDataFromtheRegistreratanker];
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
}


-(void)backButon {
    
    [self.navigationController popViewControllerAnimated:YES];
}




-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
   //isSaved = YES;
}

- (void)viewDidAppear:(BOOL)animated
{
    NSLog(@"KBT");
}
-(void)viewWillDisappear:(BOOL)animated
{
    NSLog(@"KBT");
}
- (void)viewDidDisappear:(BOOL)animated
{
    NSLog(@"KBT");
}

// Lasdel
-(IBAction)labelalert:(id)sender{
    [MTPopupWindow showWindowWithHTMLFile:@"Utmanatankar.html" insideView:self.view];
}


-(void)registerTankerView:(id)sender {
    NSLog(@"Gopal");
    for (int i = 0 ; i < [registreraTankars count];i++) {
        if (i == 0) {
             regLabel1.hidden = NO;
            regLabel1.text = [registreraTankars objectAtIndex:i];
            regButton1.hidden = NO;
        }
        if (i == 1) {
             regLabel2.hidden = NO;
            regLabel2.text = [registreraTankars objectAtIndex:i];
            regButton2.hidden= NO;
        }
        if (i == 2) {
             regLabel3.hidden = NO;
            regLabel3.text = [registreraTankars objectAtIndex:i];
            regButton3.hidden = NO;
        }
        if (i == 3) {
             regLabel4.hidden = NO;
            regLabel4.text = [registreraTankars objectAtIndex:i];
            regButton4.hidden= NO;
        }
        if (i == 4) {
             regLabel5.hidden = NO;
            regLabel5.text = [registreraTankars objectAtIndex:i];
            regButton5.hidden = NO;
        }
        if (i == 5) {
             regLabel6.hidden = NO;
            regLabel6.text = [registreraTankars objectAtIndex:i];
            regButton6.hidden= NO;
        }
        if (i == 6) {
             regLabel7.hidden = NO;
            regLabel7.text = [registreraTankars objectAtIndex:i];
            regButton7.hidden = NO;
        }
        if (i == 7) {
             regLabel8.hidden = NO;
            regLabel8.text = [registreraTankars objectAtIndex:i];
            regButton8.hidden= NO;
        }
    }
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


//1.
-(void)questionTap1:(id)sender {
    
    questionView1.hidden = NO;
}

-(IBAction)questionCloseBtn1:(id)sender{
    questionView1.hidden =YES;
}

//2.
-(void)questionTap2:(id)sender {
    questionView2.hidden = NO;
}
-(IBAction)questionCloseBtn2:(id)sender{
    questionView2.hidden =YES;
}


//3.
-(void)questionTap3:(id)sender {
    questionView3.hidden = NO;
}

-(IBAction)questionCloseBtn3:(id)sender{
    questionView3.hidden =YES;
}
//4.
-(void)questionTap4:(id)sender {
    questionView4.hidden = NO;
}

-(IBAction)questionCloseBtn4:(id)sender{
    questionView4.hidden =YES;
}


//5.
-(void)questionTap5:(id)sender {
    questionView5.hidden = NO;
}

-(IBAction)questionCloseBtn5:(id)sender{
    questionView5.hidden =YES;
}

//6.
-(void)questionTap6:(id)sender {
    questionView6.hidden = NO;
}

-(IBAction)questionCloseBtn6:(id)sender{
    questionView6.hidden =YES;
}


//Slider Show Values
-(IBAction)changeSlider:(id)sender {
    
    NSString *str= [[NSString alloc] initWithFormat:@"%d%@", (int)slider.value,@"%"];
    self.c3.text=str;
}

-(void)getDataFromtheRegistreratanker {
    registreraTankars = [[NSMutableArray alloc] init];
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &exerciseDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:@"SELECT * FROM EXERCISEONE  ORDER BY date DESC"];
        
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(exerciseDB,query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            NSLog(@"%u",SQLITE_ROW);
            while (sqlite3_step(statement) == SQLITE_ROW) {
                NSLog(@"%u",SQLITE_ROW);
                char* _c1 = (char*) sqlite3_column_text(statement,3);
                
                if (_c1 != NULL){
                    NSString *tempString = [NSString stringWithUTF8String:_c1];
                    if (![tempString isEqualToString:@""]) {
                        [registreraTankars addObject:tempString];
                        regLabel1.text= [NSString stringWithUTF8String:_c1];
                        NSLog(@" StagC1.text :%@",regLabel1.text);
                    }
                }
            }
            
            sqlite3_finalize(statement);
        }
        sqlite3_close(exerciseDB);
    }
    NSLog(@"%@",registreraTankars);
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
        
         raderaButton.enabled=NO;
    }else{
        
        
        const char *dbpath = [databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &exerciseDB) == SQLITE_OK)
        {
            
            if([[list_exercise3 objectAtIndex:0] isEqualToString:@"Null"]){
                
                NSString *insertSQL = [NSString stringWithFormat: @"INSERT INTO EXERCISE3 (date,negative,dina,hur,motbevis,tankefalla,alternativ) VALUES (\"%@\", \"%@\", \"%@\" ,\"%@\",\"%@\", \"%@\", \"%@\")",str1,c1.text,c2.text,c3.text,c4.text,c5.text,c6.text];
                
                const char *insert_stmt = [insertSQL UTF8String];

                sqlite3_prepare_v2(exerciseDB, insert_stmt, -1, &statement, NULL);
                
                if (sqlite3_step(statement) == SQLITE_DONE)
                {
                    
                    isSaved = NO;
                    NSLog(@"Save");
                }
                else {
                    NSLog(@"Failed to add tankefallor");
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
                    
                    isSaved = NO;
                    //isSaved
                    
                }

                sqlite3_finalize(statement);
                sqlite3_close(exerciseDB);
                

            }
        }
         raderaButton.enabled=YES;
        UIAlertView * alert1 = [[UIAlertView alloc] initWithTitle:nil message:@"Sparat" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok",nil];
        [alert1 show];
        [alert1 release];
    }
}


-(IBAction)newbutton:(id)sender{
    if ([c1.text isEqualToString:@""]&&[c2.text isEqualToString:@""]&&[c4.text isEqualToString:@""]
        &&[c5.text isEqualToString:@""]&&[c6.text isEqualToString:@""]) {
        
    }else{
        
        
        
        alert=[[UIAlertView alloc] initWithTitle:nil message:@"Du har inte sparat formuläret, vill du fortsätta?    "
                                        delegate:self
                               cancelButtonTitle:@"Forsätt"
                               otherButtonTitles:@"Avbryt", nil];
        alert.tag=kAlertViewOne;
        [alert show];
        [alert release];
        
    }
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"ok");
    if(alert.tag  == kAlertViewOne) {
        if (buttonIndex == 0) {
            
            
            if (isSaved == YES) {
                //
                NSLog(@"new form");
                c1.text=@"";
                c2.text=@"";
                c3.text=@"0%";
                c4.text=@"";
                c5.text=@"";
                c6.text=@"";
                slider.value=0.0;
                raderaButton.enabled=NO;
                [list_exercise3 removeAllObjects];
                y=0;
                [list_exercise3 addObject:@"Null"];
            }
            else {
                c1.text=@"";
                c2.text=@"";
                c3.text=@"0%";
                c4.text=@"";
                c5.text=@"";
                c6.text=@"";
                slider.value=0.0;
                raderaButton.enabled=NO;
                [listexercise3 removeAllObjects];
                y=0;
                [listexercise3 addObject:@"Null"];
                //isSaved = YES;
            }
            //isSaved = YES;
        }else{
            //isSaved = YES;
        }
    } else if(alert.tag == kAlertViewTwo) {
        if (buttonIndex == 0) {
            
            
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
            raderaButton.enabled=NO;
            [list_exercise3 removeAllObjects];
            y=0;
            [list_exercise3 addObject:@"Null"];
            [self getlistofDates3];
            
            
            UIAlertView * alert1 = [[UIAlertView alloc] initWithTitle:nil message:@"Raderat" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok",nil];
            [alert1 show];
            [alert1 release];
        }
        else {
            
        }
    }
}



-(IBAction)nextbutton:(id)sender{

    scroll.scrollEnabled = NO;
    listexercise3=[[NSMutableArray alloc]init];
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
                              @"SELECT date FROM EXERCISE3 ORDER BY date DESC"
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
    [self.tableview reloadData];
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
    raderaButton.enabled=YES;
    [list_exercise3 removeAllObjects];
    [list_exercise3 addObject:SelectedDate];
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
    listofdates.hidden = YES;
    scroll.scrollEnabled = YES;
    Label1Popup.hidden=YES;
    isSaved = NO;
}


-(IBAction)aMethod:(id)sender{
    alert=[[UIAlertView alloc] initWithTitle:nil message:@"Är du säker på att du vill radera formuläret?" delegate:self cancelButtonTitle:@"Radera" otherButtonTitles:@"Avbryt", nil];
    alert.tag=kAlertViewTwo;
    [alert show];
    [alert release];
   
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
                [selectedRegistreraTankars addObject:regLabel1.text];
                
            }else{
                [btn setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
                
                for (int i = 0; i < [selectedRegistreraTankars count]; i++) {
                    
                    if ([regLabel1.text isEqualToString:[selectedRegistreraTankars objectAtIndex:i]]) {
                        [selectedRegistreraTankars removeObjectAtIndex:i];
                    }
                }
                
            }
            break;
        case 2:
            if (btn.currentImage==[UIImage imageNamed:@"unchecked.png"]){
                [btn setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
                [selectedRegistreraTankars addObject:regLabel2.text];
                
            }else{
                [btn setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
                for (int i = 0; i < [selectedRegistreraTankars count]; i++) {
                    
                    if ([regLabel2.text isEqualToString:[selectedRegistreraTankars objectAtIndex:i]]) {
                        [selectedRegistreraTankars removeObjectAtIndex:i];
                    }
                }
            }
            break;
        case 3:
            if (btn.currentImage==[UIImage imageNamed:@"unchecked.png"]){
                [btn setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
                [selectedRegistreraTankars addObject:regLabel3.text];
                
            }else{
                [btn setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
                for (int i = 0; i < [selectedRegistreraTankars count]; i++) {
                    
                    if ([regLabel3.text isEqualToString:[selectedRegistreraTankars objectAtIndex:i]]) {
                        [selectedRegistreraTankars removeObjectAtIndex:i];
                    }
                }
            }
            break;
        case 4:
            if (btn.currentImage==[UIImage imageNamed:@"unchecked.png"]){
                [btn setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
                [selectedRegistreraTankars addObject:regLabel4.text];
                
            }else{
                [btn setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
                for (int i = 0; i < [selectedRegistreraTankars count]; i++) {
                    
                    if ([regLabel4.text isEqualToString:[selectedRegistreraTankars objectAtIndex:i]]) {
                        [selectedRegistreraTankars removeObjectAtIndex:i];
                    }
                }
            }
            break;
        case 5:
            if (btn.currentImage==[UIImage imageNamed:@"unchecked.png"]){
                [btn setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
                [selectedRegistreraTankars addObject:regLabel5.text];
                
            }else{
                [btn setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
                for (int i = 0; i < [selectedRegistreraTankars count]; i++) {
                    
                    if ([regLabel5.text isEqualToString:[selectedRegistreraTankars objectAtIndex:i]]) {
                        [selectedRegistreraTankars removeObjectAtIndex:i];
                    }
                }
            }
            break;
        case 6:
            if (btn.currentImage==[UIImage imageNamed:@"unchecked.png"]){
                [btn setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
                [selectedRegistreraTankars addObject:regLabel6.text];
                
            }else{
                [btn setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
                for (int i = 0; i < [selectedRegistreraTankars count]; i++) {
                    
                    if ([regLabel6.text isEqualToString:[selectedRegistreraTankars objectAtIndex:i]]) {
                        [selectedRegistreraTankars removeObjectAtIndex:i];
                    }
                }
            }
            break;
        case 7:
            if (btn.currentImage==[UIImage imageNamed:@"unchecked.png"]){
                [btn setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
                [selectedRegistreraTankars addObject:regLabel7.text];
                
            }else{
                [btn setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
                for (int i = 0; i < [selectedRegistreraTankars count]; i++) {
                    
                    if ([regLabel7.text isEqualToString:[selectedRegistreraTankars objectAtIndex:i]]) {
                        [selectedRegistreraTankars removeObjectAtIndex:i];
                    }
                }
            }
            break;
        case 8:
            if (btn.currentImage==[UIImage imageNamed:@"unchecked.png"]){
                [btn setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
                [selectedRegistreraTankars addObject:regLabel8.text];
                
            }else{
                [btn setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
                for (int i = 0; i < [selectedRegistreraTankars count]; i++) {
                    
                    if ([regLabel8.text isEqualToString:[selectedRegistreraTankars objectAtIndex:i]]) {
                        [selectedRegistreraTankars removeObjectAtIndex:i];
                    }
                }
            }
            break;
            
        default:
            break;
    }
    NSLog(@"%@",selectedRegistreraTankars);
}


- (IBAction)skickaButtonClicked:(id)sender
{
    UIActionSheet *cameraActionSheet = [[UIActionSheet alloc] initWithTitle:@"Skicka" delegate:self cancelButtonTitle:@"Avbryt" destructiveButtonTitle:nil otherButtonTitles:@"Ladda ner", @"E-mail", nil];
    cameraActionSheet.tag = 1;
    [cameraActionSheet showInView:self.view];
}

- (UIImage *)getFormImage
{
    UIImage *tempImage = nil;
    UIGraphicsBeginImageContext(scroll.contentSize);
    {
        CGPoint savedContentOffset = scroll.contentOffset;
        CGRect savedFrame = scroll.frame;
        
        scroll.contentOffset = CGPointZero;
        scroll.frame = CGRectMake(0, 0, scroll.contentSize.width, scroll.contentSize.height);
        
        [scroll.layer renderInContext: UIGraphicsGetCurrentContext()];
        tempImage = UIGraphicsGetImageFromCurrentImageContext();
        
        scroll.contentOffset = savedContentOffset;
        scroll.frame = savedFrame;
    }
    UIGraphicsEndImageContext();
    
    return tempImage;
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    
	if (buttonIndex == 0)
    {
        UIImage *image = [self getFormImage];
        if (image)
        {
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Image downloaded" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alertView show];
        }
    }
    else if (buttonIndex == 1)
    {
        if ([MFMailComposeViewController canSendMail])
        {
            MFMailComposeViewController *emailDialog = [[MFMailComposeViewController alloc] init];
            emailDialog.mailComposeDelegate = self;
            NSMutableString *htmlMsg = [NSMutableString string];
            [htmlMsg appendString:@"<html><body><p>"];
            [htmlMsg appendString:[NSString stringWithFormat:@"Please find the attached form on %@", SelectedDate]];
            [htmlMsg appendString:@": </p></body></html>"];
            
            NSData *jpegData = UIImageJPEGRepresentation([self getFormImage], 1);
            
            NSString *fileName = [NSString stringWithString:SelectedDate];
            fileName = [fileName stringByAppendingPathExtension:@"jpeg"];
            [emailDialog addAttachmentData:jpegData mimeType:@"image/jpeg" fileName:fileName];
            
            [emailDialog setSubject:@"Form"];
            [emailDialog setMessageBody:htmlMsg isHTML:YES];
            
            
            [self presentViewController:emailDialog animated:YES completion:nil];
        }
        else
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Mail cannot be send now. Please check mail has been configured in your device and try again." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alertView show];
        }
    }
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    // Notifies users about errors associated with the interface
    switch (result)
    {
            
        case MFMailComposeResultCancelled:
            break;
        case MFMailComposeResultSaved:
            break;
        case MFMailComposeResultSent:
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Mail sent successfully" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alertView show];
        }
            break;
        case MFMailComposeResultFailed:
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Mail send failed" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alertView show];
        }
            break;
        default:
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Mail was not sent." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alertView show];
        }
            break;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}



-(IBAction)karClickedButton:(id)sender
{
    NSLog(@"%@",selectedRegistreraTankars);
    listofdates.hidden = YES;
    scroll.scrollEnabled = YES;
    Label1Popup.hidden=YES;
    NSMutableString *tempString = [[NSMutableString alloc] init];
    for (int i =0; i < [selectedRegistreraTankars count]; i++) {
        if (i == 0) {
            [tempString appendString:[selectedRegistreraTankars objectAtIndex:i]];
        }
        else {
            [tempString appendFormat:@", "];
             [tempString appendString:[selectedRegistreraTankars objectAtIndex:i]];
        }
    }
    
    c1.text = tempString;
    [tempString release];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_skickaButton release];
    [super dealloc];
}

@end

