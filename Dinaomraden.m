//
//  Dinaomraden.m
//  Välkommen till TFH-appen
//
//  Created by Mohammed Abdul Majeed on 5/11/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import "Dinaomraden.h"
#import <QuartzCore/QuartzCore.h>
#import "DinKompass.h"

@interface Dinaomraden ()

@end

@implementation Dinaomraden
bool isOmrade1choosesn=false;
bool isOmrade2choosesn=false;
bool NewFormCheck=false;
NSString *omrade1choosenName=@"";
NSString *omrade2choosenName=@"";
@synthesize  textview;

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
//- (BOOL)textFieldShouldReturn:(UITextField *)textField {
//    [textField resignFirstResponder];
//    return YES;
//}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    NewFormCheck=true;

    [textField resignFirstResponder];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title=@"Dina områden";
    
    _raderaButton.enabled = NO;
    skickaButton.enabled = NO;
    
    recentBtn1Selected = NO;
    recentBtn2Selected = NO;
    
    // Customing the segmented control
    UIImage *segmentSelected = [[UIImage imageNamed:@"segSelected.png"]
     resizableImageWithCapInsets:UIEdgeInsetsMake(0, 15, 0, 15)];
    UIImage *segmentUnselected = [[UIImage imageNamed:@"segUnSelected.png"]
     resizableImageWithCapInsets:UIEdgeInsetsMake(0, 15, 0, 15)];
    UIImage *segmentSelectedUnselected = [UIImage imageNamed:@"segSelectedUnSelected.png"];
    UIImage *segUnselectedSelected = [UIImage imageNamed:@"segUnSelectedSelected.png"];
    UIImage *segmentUnselectedUnselected = [UIImage imageNamed:@"segUnSelectedUnSelected.png"];
    
    [[UISegmentedControl appearance] setBackgroundImage:segmentUnselected
                                               forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [[UISegmentedControl appearance] setBackgroundImage:segmentSelected
                                               forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    
    [[UISegmentedControl appearance] setDividerImage:segmentUnselectedUnselected
                                 forLeftSegmentState:UIControlStateNormal
                                   rightSegmentState:UIControlStateNormal
                                          barMetrics:UIBarMetricsDefault];
    [[UISegmentedControl appearance] setDividerImage:segmentSelectedUnselected
                                 forLeftSegmentState:UIControlStateSelected
                                   rightSegmentState:UIControlStateNormal
                                          barMetrics:UIBarMetricsDefault];
    [[UISegmentedControl appearance] setDividerImage:segUnselectedSelected
                                 forLeftSegmentState:UIControlStateNormal
                                   rightSegmentState:UIControlStateSelected
                                          barMetrics:UIBarMetricsDefault];

//    UIBarButtonItem *btnDone = [[UIBarButtonItem alloc] initWithTitle:@"Tillbaka" style:UIBarButtonItemStyleBordered target:nil action:nil];
//    UIImage *stretchable = [UIImage imageNamed:@"tillbakabutton.png"] ;
//    [btnDone setBackButtonBackgroundImage:stretchable forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
//    [self.navigationItem setBackBarButtonItem:btnDone];
    
    dateOfCurrentItem = nil;
    scrollView.contentSize = self.view.frame.size;
    //CGRect frame = CGRectMake(10, 270, 350, 50);
   // subView = [[UIView alloc] initWithFrame:frame];
    subView.frame = CGRectMake(0, self.view.frame.size.height - subView.frame.size.height, self.view.frame.size.width, subView.frame.size.height);
    [self.view addSubview:subView];
    subView.hidden=YES;
    
    [self.view addSubview:settingsView];
    settingsView.hidden=YES;
    
    omradeLabel1.userInteractionEnabled = YES;
    omradeLabel2.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tapGesture = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelalert:)] autorelease];
    [omradeLabel1 addGestureRecognizer:tapGesture];
//    [omradeLabel2 addGestureRecognizer:tapGesture];
    
    UITapGestureRecognizer *tapGesture1 = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelalert:)] autorelease];
    [omradeLabel2 addGestureRecognizer:tapGesture1];
    
//    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Settings"                                                                    style:UIBarButtonItemStylePlain target:self action:@selector(settingsbutton:)];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:@"alarm-button.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(settingsbutton:) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 0, 30, 30);
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    NSString *docsDir;
    NSArray *dirPaths;
    sqlite3 *exerciseDB;
    
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
            const char *sql_stmt = "CREATE TABLE IF NOT EXISTS EXERCISE7 (ID INTEGER PRIMARY KEY AUTOINCREMENT, DATE TEXT,  OMRADE1 TEXT , AKTIVITET1 TEXT, OMRADE2 TEXT , AKTIVITET2 TEXT, AVERAGE TEXT,FAMILJ TEXT,VANNER TEXT,KARLEK TEXT,ARBETE TEXT,EKONOMI TEXT,KOST TEXT,MOTION TEXT,VILA TEXT,FRITID TEXT,SOMN TEXT)";
            
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
    
    [self averagevalue];
    
    // code added by malkit to make the navigatoin appear and work like the other views
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
    
}
-(void)backButon {
    
    [self.navigationController popViewControllerAnimated:YES];
}

    


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    [self initPlot];
    [self setRecentItems];
}

- (void)setRecentItems
{    
    NSString *docsDir;
    NSArray *dirPaths;
    sqlite3 *exerciseDB;
    
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    
    // Build the path to the database file
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"exerciseDB.db"]];
    // const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt    *statement;
    if (sqlite3_open([databasePath UTF8String], &exerciseDB) == SQLITE_OK)
    {
        NSString *rLabel1 = nil;
        NSString *rLabel2 = nil;
        NSString *rTextView1 = nil;
        NSString *rTextView2 = nil;
        
        NSString *sql = [NSString stringWithFormat: @"SELECT * FROM EXERCISE7 ORDER BY id DESC"];
        
        const char *del_stmt = [sql UTF8String];
        
        sqlite3_prepare_v2(exerciseDB, del_stmt, -1, & statement, NULL);
        while (sqlite3_step(statement) == SQLITE_ROW)
        {
            
            char* c1 = (char*) sqlite3_column_text(statement,2);
            NSString *tmp1;
            if (c1 != NULL){
                tmp1 = [NSString stringWithUTF8String:c1];
//                NSLog(@"value form db :%@",tmp1);
                rLabel1 = [NSString stringWithString:tmp1];
            }
            char* c2 = (char*) sqlite3_column_text(statement,3);
            NSString *tmp2;
            if (c2 != NULL){
                tmp2 = [NSString stringWithUTF8String:c2];
//                NSLog(@"value form db :%@",tmp2);
                rTextView1 = [NSString stringWithString:tmp2];
            }
            
            char* c14 = (char*) sqlite3_column_text(statement,4);
            NSString *tmp14;
            if (c14 != NULL){
                tmp14 = [NSString stringWithUTF8String:c14];
//                NSLog(@"value form db :%@",tmp14);
                rLabel2 = [NSString stringWithString:tmp14];
            }
            char* c15 = (char*) sqlite3_column_text(statement,5);
            NSString *tmp15;
            if (c15 != NULL){
                tmp15 = [NSString stringWithUTF8String:c15];
//                NSLog(@"value form db :%@",tmp15);
                rTextView2 = [NSString stringWithString:tmp15];
            }
            
            // code to set recent values on buttons - malkit
            char* c151 = (char*) sqlite3_column_text(statement,6);
            NSString *tmp151;
            if (c15 != NULL){
                tmp151 = [NSString stringWithUTF8String:c151];
                //                NSLog(@"value form db :%@",tmp15);
                
                [averageBt setTitle:tmp151 forState:UIControlStateNormal];
            }
            char* c152 = (char*) sqlite3_column_text(statement,7);
            NSString *tmp152;
            if (c152 != NULL){
                tmp152 = [NSString stringWithUTF8String:c152];
                //                NSLog(@"value form db :%@",tmp15);
                tf1.text = [NSString stringWithString:tmp152];
            }
            char* c153 = (char*) sqlite3_column_text(statement,8);
            NSString *tmp153;
            if (c153 != NULL){
                tmp153 = [NSString stringWithUTF8String:c153];
                //                NSLog(@"value form db :%@",tmp15);
                tf2.text = [NSString stringWithString:tmp153];
            }
            
            char* c154 = (char*) sqlite3_column_text(statement,9);
            NSString *tmp154;
            if (c154 != NULL){
                tmp154 = [NSString stringWithUTF8String:c154];
                //                NSLog(@"value form db :%@",tmp15);
                tf3.text = [NSString stringWithString:tmp154];
            }
            
            char* c155 = (char*) sqlite3_column_text(statement,10);
            NSString *tmp155;
            if (c155 != NULL){
                tmp155 = [NSString stringWithUTF8String:c155];
                //                NSLog(@"value form db :%@",tmp15);
                tf4.text = [NSString stringWithString:tmp155];
            }
            
            char* c156 = (char*) sqlite3_column_text(statement,11);
            NSString *tmp156;
            if (c156 != NULL){
                tmp156 = [NSString stringWithUTF8String:c156];
                //                NSLog(@"value form db :%@",tmp15);
                tf5.text = [NSString stringWithString:tmp156];
            }
            
            char* c157 = (char*) sqlite3_column_text(statement,12);
            NSString *tmp157;
            if (c157 != NULL){
                tmp157 = [NSString stringWithUTF8String:c157];
                //                NSLog(@"value form db :%@",tmp15);
                tf6.text = [NSString stringWithString:tmp157];
            }
            
            char* c158 = (char*) sqlite3_column_text(statement,13);
            NSString *tmp158;
            if (c158 != NULL){
                tmp158 = [NSString stringWithUTF8String:c158];
                //                NSLog(@"value form db :%@",tmp15);
                tf7.text = [NSString stringWithString:tmp158];
            }
            
            char* c159 = (char*) sqlite3_column_text(statement,14);
            NSString *tmp159;
            if (c159 != NULL){
                tmp159 = [NSString stringWithUTF8String:c159];
                //                NSLog(@"value form db :%@",tmp15);
                tf8.text = [NSString stringWithString:tmp159];
            }
            
            char* c160 = (char*) sqlite3_column_text(statement,15);
            NSString *tmp160;
            if (c160 != NULL){
                tmp160 = [NSString stringWithUTF8String:c160];
                //                NSLog(@"value form db :%@",tmp15);
                tf9.text = [NSString stringWithString:tmp160];
            }
            
            char* c161 = (char*) sqlite3_column_text(statement,16);
            NSString *tmp161;
            if (c161 != NULL){
                tmp161 = [NSString stringWithUTF8String:c161];
                //                NSLog(@"value form db :%@",tmp15);
                tf10.text = [NSString stringWithString:tmp161];
            }










            
            
            break;
        }
        
        if (rLabel1 && ![rLabel1 isEqualToString:@""])
        {
            _recentButton1.hidden = NO;
            _recentLabel1.hidden = NO;
            
            _recentLabel1.text = rLabel1;
            // showing recent saved omrades code by malkit
            omradeLabel1.text=rLabel1;
            [textview setText:rTextView1];
        }
        else
        {
            _recentButton1.hidden = YES;
            _recentLabel1.hidden = YES;
        }
        
        if (rLabel2 && ![rLabel2 isEqualToString:@""])
        {
            _recentButton2.hidden = NO;
            _recentLabel2.hidden = NO;
            
            _recentLabel2.text = rLabel2;
            omradeLabel2.text=rLabel2;
            [self.textview1 setText:rTextView2];
            
        }
        else
        {
            _recentButton2.hidden = YES;
            _recentLabel2.hidden = YES;
        }
        
        sqlite3_finalize(statement);
        sqlite3_close(exerciseDB);
    }
}

- (void)updateCurrentItem
{
    if (dateOfCurrentItem)
    {
        NSString *docsDir;
        NSArray *dirPaths;
        sqlite3 *exerciseDB;
        
        // Get the documents directory
        dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        
        docsDir = [dirPaths objectAtIndex:0];
        
        // Build the path to the database file
        databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"exerciseDB.db"]];
        // const char *dbpath = [databasePath UTF8String];
        sqlite3_stmt    *statement;
        if (sqlite3_open([databasePath UTF8String], &exerciseDB) == SQLITE_OK) {
            
            NSString *sql = [NSString stringWithFormat: @"SELECT * FROM EXERCISE7 WHERE date='%@'", dateOfCurrentItem];
            
            const char *del_stmt = [sql UTF8String];
            
            sqlite3_prepare_v2(exerciseDB, del_stmt, -1, & statement, NULL);
            while (sqlite3_step(statement) == SQLITE_ROW) {
                
                char* c1 = (char*) sqlite3_column_text(statement,2);
                NSString *tmp1;
                if (c1 != NULL){
                    tmp1 = [NSString stringWithUTF8String:c1];
//                    NSLog(@"value form db :%@",tmp1);
                    omradeLabel1.text=tmp1;
                }
                char* c2 = (char*) sqlite3_column_text(statement,3);
                NSString *tmp2;
                if (c2 != NULL){
                    tmp2 = [NSString stringWithUTF8String:c2];
//                    NSLog(@"value form db :%@",tmp2);
                    textview.text=tmp2;
                }
                
                char* c14 = (char*) sqlite3_column_text(statement,4);
                NSString *tmp14;
                if (c14 != NULL){
                    tmp14 = [NSString stringWithUTF8String:c14];
//                    NSLog(@"value form db :%@",tmp14);
                    omradeLabel2.text=tmp14;
                }
                char* c15 = (char*) sqlite3_column_text(statement,5);
                NSString *tmp15;
                if (c15 != NULL){
                    tmp15 = [NSString stringWithUTF8String:c15];
//                    NSLog(@"value form db :%@",tmp15);
                    self.textview1.text=tmp15;
                }
                
                char* c3 = (char*) sqlite3_column_text(statement,6);
                NSString *tmp3;
                if (c3!= NULL){
                    tmp3= [NSString stringWithUTF8String:c3];
//                    NSLog(@"value form db :%@",tmp3);
                    [averageBt setTitle:tmp3 forState:UIControlStateNormal];
                }
                
                char* c4 = (char*) sqlite3_column_text(statement,7);
                NSString *tmp4;
                if (c4!= NULL){
                    tmp4= [NSString stringWithUTF8String:c4];
//                    NSLog(@"value form db :%@",tmp4);
                    tf1.text = tmp4;
                }
                
                char* c5 = (char*) sqlite3_column_text(statement,8);
                NSString *tmp5;
                if (c5!= NULL){
                    tmp5= [NSString stringWithUTF8String:c5];
//                    NSLog(@"value form db :%@",tmp5);
                    tf2.text = tmp5;
                }
                
                char* c6 = (char*) sqlite3_column_text(statement,9);
                NSString *tmp6;
                if (c6!= NULL){
                    tmp6= [NSString stringWithUTF8String:c6];
//                    NSLog(@"value form db :%@",tmp6);
                    tf3.text = tmp6;
                }
                
                char* c7 = (char*) sqlite3_column_text(statement,10);
                NSString *tmp7;
                if (c7!= NULL){
                    tmp7= [NSString stringWithUTF8String:c7];
//                    NSLog(@"value form db :%@",tmp7);
                    tf4.text = tmp7;
                }
                
                char* c8 = (char*) sqlite3_column_text(statement,11);
                NSString *tmp8;
                if (c8!= NULL){
                    tmp8= [NSString stringWithUTF8String:c8];
//                    NSLog(@"value form db :%@",tmp8);
                    tf5.text = tmp8;
                }
                
                char* c9 = (char*) sqlite3_column_text(statement,12);
                NSString *tmp9;
                if (c9!= NULL){
                    tmp9= [NSString stringWithUTF8String:c9];
//                    NSLog(@"value form db :%@",tmp9);
                    tf6.text = tmp9;
                }
                
                char* c10 = (char*) sqlite3_column_text(statement,13);
                NSString *tmp10;
                if (c10!= NULL){
                    tmp10= [NSString stringWithUTF8String:c10];
//                    NSLog(@"value form db :%@",tmp10);
                    tf7.text = tmp10;
                }
                
                char* c11 = (char*) sqlite3_column_text(statement,14);
                NSString *tmp11;
                if (c11!= NULL){
                    tmp11= [NSString stringWithUTF8String:c11];
//                    NSLog(@"value form db :%@",tmp11);
                   tf8.text = tmp11;
                }
                
                char* c12 = (char*) sqlite3_column_text(statement,15);
                NSString *tmp12;
                if (c12!= NULL){
                    tmp12= [NSString stringWithUTF8String:c12];
//                    NSLog(@"value form db :%@",tmp12);
                    tf9.text = tmp12;
                }
                
                char* c13 = (char*) sqlite3_column_text(statement,16);
                NSString *tmp13;
                if (c13!= NULL){
                    tmp13= [NSString stringWithUTF8String:c13];
//                    NSLog(@"value form db :%@",tmp13);
                    tf10.text = tmp13;
                }
             }
            
            sqlite3_finalize(statement);
            sqlite3_close(exerciseDB);
        }
//        dateOfCurrentItem = nil;
    }
    else
    {
        omradeLabel1.text=@"";
        omradeLabel2.text = @"";
        textview.text=@"";
        _textview1.text = @"";
        [averageBt setTitle:@"1.0" forState:UIControlStateNormal];
        tf1.text=@"1";
        tf2.text=@"1";
        tf3.text=@"1";
        tf4.text=@"1";
        tf5.text=@"1";
        tf6.text=@"1";
        tf7.text=@"1";
        tf8.text=@"1";
        tf9.text=@"1";
        tf10.text=@"1";
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [scrollView setContentOffset:CGPointZero animated:YES];
}

-(IBAction)labelalert:(UITapGestureRecognizer *)sender
{
    NSLog(@"CLASS = %i", [sender view].tag);
    if ([sender view].tag == 0)
    {
        isOmrade1 = YES;
        if (isOmrade1choosesn) {
            
            if ([omrade1choosenName isEqualToString:@"cb1"]) {
                    [cb1 setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
            }
            else if ([omrade1choosenName isEqualToString:@"cb2"]) {
                [cb2 setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
            }
            else if ([omrade1choosenName isEqualToString:@"cb3"]) {
                [cb3 setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
            }
            else if ([omrade1choosenName isEqualToString:@"cb4"]) {
                [cb4 setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
            }
            else if ([omrade1choosenName isEqualToString:@"cb5"]) {
                [cb5 setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
            }
            else if ([omrade1choosenName isEqualToString:@"cb6"]) {
                [cb6 setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
            }
            else if ([omrade1choosenName isEqualToString:@"cb7"]) {
                [cb7 setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
            }
            else if ([omrade1choosenName isEqualToString:@"cb8"]) {
                [cb8 setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
            }
            else if ([omrade1choosenName isEqualToString:@"cb9"]) {
                [cb9 setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
            }
            else if ([omrade1choosenName isEqualToString:@"cb10"]) {
                [cb10 setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
            }


        }
    }
    else
    {
        isOmrade1 = NO;
        if (isOmrade2choosesn) {
            
            if ([omrade2choosenName isEqualToString:@"cb1"]) {
                [cb1 setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
            }
            else if ([omrade2choosenName isEqualToString:@"cb2"]) {
                [cb2 setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
            }
            else if ([omrade2choosenName isEqualToString:@"cb3"]) {
                [cb3 setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
            }
            else if ([omrade2choosenName isEqualToString:@"cb4"]) {
                [cb4 setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
            }
            else if ([omrade2choosenName isEqualToString:@"cb5"]) {
                [cb5 setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
            }
            else if ([omrade2choosenName isEqualToString:@"cb6"]) {
                [cb6 setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
            }
            else if ([omrade2choosenName isEqualToString:@"cb7"]) {
                [cb7 setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
            }
            else if ([omrade2choosenName isEqualToString:@"cb8"]) {
                [cb8 setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
            }
            else if ([omrade2choosenName isEqualToString:@"cb9"]) {
                [cb9 setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
            }
            else if ([omrade2choosenName isEqualToString:@"cb10"]) {
                [cb10 setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
            }
            
            
        }

    }
    
    // code to set checkboxes accordingly
//    if(isOmrade1)
//    {
//        if(isOmrade1choosesn)
//        {
//            
//        }
//    }
    // resetting all the checkboxes
  

    
    
    [self.view bringSubviewToFront:subView];
    subView.hidden = NO;
    settingsView.hidden = YES;
    label1.text=@"Familj";
    label2.text=@"Vänner";
    label3.text=@"Kärlek";
    label4.text=@"Arbete";
    label5.text=@"Ekonomi";
    label6.text=@"Kost";
    label7.text=@"Motion";
    label8.text=@"Vila";
    label9.text=@"Fritid";
    label10.text=@"Sömn";
 
    
    [UIView beginAnimations:@"curlInView" context:nil];
    
    [UIView setAnimationDuration:3.0];
    
    [UIView commitAnimations];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)selectedcheckbox:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    NewFormCheck=true;

    if (btn.tag == 1)
    {
              NSLog(@"%@",scb);
            if(cb1.currentImage==[UIImage imageNamed:@"uncheck.png"])
            {
                if (isOmrade1)
                {
                     isOmrade1choosesn=true;
                    
                     omrade1choosenName=@"cb1";
                    [cb1 setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
                    omradeLabel1.text=label1.text;
                }
                else
                {
                    isOmrade2choosesn=true;
                    
                    omrade2choosenName=@"cb1";

                    [cb1 setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
                    omradeLabel2.text=label1.text;
                }
                
                [cb2 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
                [cb3 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
                [cb4 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
                [cb5 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
                [cb6 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
                [cb7 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
                [cb8 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
                [cb9 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
                [cb10 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
            }
            else
            {
                [cb1 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
                if (isOmrade1)
                {
                    isOmrade1choosesn=false;
                    
                    omrade1choosenName=@"";
                    
                    omradeLabel1.text = @"";
                }
                else
                {

                    isOmrade2choosesn=false;
                    
                    omrade2choosenName=@"";
                    omradeLabel2.text = @"";
                }
            }
    }
    else if(btn.tag == 2)
    {
       
        if(cb2.currentImage==[UIImage imageNamed:@"uncheck.png"])
        {
            if (isOmrade1)
            {
                isOmrade1choosesn=true;
                
                omrade1choosenName=@"cb2";
                [cb2 setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
                omradeLabel1.text=label2.text;
            }
            else
            {
                                isOmrade2choosesn=true;
                
                omrade2choosenName=@"cb2";
                [cb2 setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
                omradeLabel2.text=label2.text;
            }
            
            [cb1 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
            [cb3 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
            [cb4 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
            [cb5 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
            [cb6 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
            [cb7 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
            [cb8 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
            [cb9 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
            [cb10 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
        }
        else
        {
            [cb2 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
            if (isOmrade1)
            {
                omradeLabel1.text = @"";
                isOmrade1choosesn=false;
                
                omrade1choosenName=@"cb2";
            }
            else
            {
                omradeLabel2.text = @"";
                                isOmrade2choosesn=false;
                
                omrade2choosenName=@"cb2";
            }
        }
   
    }
    else if(btn.tag == 3){
        
        if(cb3.currentImage==[UIImage imageNamed:@"uncheck.png"])
        {
            if (isOmrade1)
            {
                isOmrade1choosesn=true;
                
                omrade1choosenName=@"cb3";
                [cb3 setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
                omradeLabel1.text=label3.text;
            }
            else
            {
                
                isOmrade2choosesn=true;
                
                omrade2choosenName=@"cb3";
                [cb3 setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
                omradeLabel2.text=label3.text;
            }
            
            [cb1 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
            [cb2 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
            [cb4 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
            [cb5 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
            [cb6 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
            [cb7 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
            [cb8 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
            [cb9 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
            [cb10 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
        }
        else
        {
            [cb3 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
            if (isOmrade1)
            {
                isOmrade1choosesn=false;
                
                omrade1choosenName=@"";
                omradeLabel1.text = @"";
            }
            else
            {
                isOmrade2choosesn=false;
                
                omrade2choosenName=@"";
                omradeLabel2.text = @"";
            }
        }
        
    }
    else if(btn.tag == 4)
    {
        if(cb4.currentImage==[UIImage imageNamed:@"uncheck.png"])
        {
            if (isOmrade1)
            {
                isOmrade1choosesn=true;
                
                omrade1choosenName=@"cb4";
                                [cb4 setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
                omradeLabel1.text=label4.text;
            }
            else
            {

                isOmrade2choosesn=true;
                
                omrade2choosenName=@"cb4";
                [cb4 setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
                omradeLabel2.text=label4.text;
            }
            
            [cb1 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
            [cb2 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
            [cb3 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
            [cb5 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
            [cb6 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
            [cb7 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
            [cb8 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
            [cb9 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
            [cb10 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
        }
        else
        {
            [cb4 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
            if (isOmrade1)
            {
                isOmrade1choosesn=false;
                
                omrade1choosenName=@"";
                omradeLabel1.text = @"";
            }
            else
            {
                isOmrade2choosesn=false;
                
                omrade2choosenName=@"";
                omradeLabel2.text = @"";
            }
        }
        
    }
    else if(btn.tag == 5)
    {
        if(cb5.currentImage==[UIImage imageNamed:@"uncheck.png"])
        {
            if (isOmrade1)
            {
                isOmrade1choosesn=true;
                
                omrade1choosenName=@"cb5";
                [cb5 setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
                omradeLabel1.text=label5.text;
            }
            else
            {

                isOmrade2choosesn=true;
                
                omrade2choosenName=@"cb5";
                [cb5 setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
                omradeLabel2.text=label5.text;
            }
            
            [cb1 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
            [cb2 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
            [cb3 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
            [cb4 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
            [cb6 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
            [cb7 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
            [cb8 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
            [cb9 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
            [cb10 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
        }
        else
        {
            [cb5 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
            if (isOmrade1)
            {
                isOmrade1choosesn=false;
                
                omrade1choosenName=@"";
                                omradeLabel1.text = @"";
            }
            else
            {
                isOmrade2choosesn=false;
                
                omrade2choosenName=@"";
                omradeLabel2.text = @"";
            }
        }
       
    }else if(btn.tag == 6)
    {
        if(cb6.currentImage==[UIImage imageNamed:@"uncheck.png"])
        {
            if (isOmrade1)
            {
                isOmrade1choosesn=true;
                
                omrade1choosenName=@"cb6";
                [cb6 setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
                omradeLabel1.text=label6.text;
            }
            else
            {

                isOmrade2choosesn=true;
                
                omrade2choosenName=@"cb6";
                [cb6 setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
                omradeLabel2.text=label6.text;
            }
            
            [cb1 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
            [cb2 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
            [cb3 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
            [cb4 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
            [cb5 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
            [cb7 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
            [cb8 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
            [cb9 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
            [cb10 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
        }
        else
        {
            [cb6 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
            if (isOmrade1)
            {
                isOmrade1choosesn=false;
                
                omrade1choosenName=@"";
                omradeLabel1.text = @"";
            }
            else
            {
                isOmrade2choosesn=false;
                
                omrade2choosenName=@"";

                omradeLabel2.text = @"";
            }
        }
      
     
    }else if(btn.tag == 7)
    {
        if(cb7.currentImage==[UIImage imageNamed:@"uncheck.png"])
        {
            if (isOmrade1)
            {
                isOmrade1choosesn=true;
                
                omrade1choosenName=@"cb7";
                                [cb7 setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
                omradeLabel1.text=label7.text;
            }
            else
            {

                isOmrade2choosesn=true;
                
                omrade2choosenName=@"cb7";
                [cb7 setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
                omradeLabel2.text=label7.text;
            }
            
            [cb1 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
            [cb2 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
            [cb3 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
            [cb4 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
            [cb5 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
            [cb6 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
            [cb8 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
            [cb9 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
            [cb10 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
        }
        else
        {
            [cb7 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
            if (isOmrade1)
            {
                isOmrade1choosesn=false;
                
                omrade1choosenName=@"";

                omradeLabel1.text = @"";
            }
            else
            {
                isOmrade2choosesn=false;
                
                omrade2choosenName=@"";

                omradeLabel2.text = @"";
            }
        }
    }else if(btn.tag == 8)
    {
    if(cb8.currentImage==[UIImage imageNamed:@"uncheck.png"])
    {
        if (isOmrade1)
        {
            isOmrade1choosesn=true;
            
            omrade1choosenName=@"cb8";
            [cb8 setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
            omradeLabel1.text=label8.text;
        }
        else
        {
            isOmrade2choosesn=true;
            
            omrade2choosenName=@"cb8";
            [cb8 setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
            omradeLabel2.text=label8.text;
        }
        
        [cb1 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
        [cb2 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
        [cb3 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
        [cb4 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
        [cb5 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
        [cb6 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
        [cb7 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
        [cb9 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
        [cb10 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
    }
    else
    {
        [cb8 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
        if (isOmrade1)
        {
            isOmrade1choosesn=false;
            
            omrade1choosenName=@"";

            omradeLabel1.text = @"";
        }
        else
        {
            isOmrade2choosesn=false;
            
            omrade2choosenName=@"";

            omradeLabel2.text = @"";
        }
    }
    
}else if(btn.tag == 9){
    
    if(cb9.currentImage==[UIImage imageNamed:@"uncheck.png"])
    {
        if (isOmrade1)
        {
            isOmrade1choosesn=true;
            
            omrade1choosenName=@"cb9";
            [cb9 setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
            omradeLabel1.text=label9.text;
        }
        else
        {
            isOmrade2choosesn=true;
            
            omrade2choosenName=@"cb9";
            [cb9 setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
            omradeLabel2.text=label9.text;
        }
        
        [cb2 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
        [cb3 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
        [cb4 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
        [cb5 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
        [cb6 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
        [cb7 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
        [cb8 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
        [cb1 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
        [cb10 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
    }
    else
    {
        [cb9 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
        if (isOmrade1)
        {
            isOmrade1choosesn=false;
            
            omrade1choosenName=@"";

            omradeLabel1.text = @"";
        }
        else
        {
            isOmrade2choosesn=false;
            
            omrade2choosenName=@"";

            omradeLabel2.text = @"";
        }
    }
    
    
    }else if(btn.tag == 10){
      
        if(cb10.currentImage==[UIImage imageNamed:@"uncheck.png"])
        {
            if (isOmrade1)
            {
                isOmrade1choosesn=true;
                
                omrade1choosenName=@"cb10";
                [cb10 setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
                omradeLabel1.text=label10.text;
            }
            else
            {
                isOmrade2choosesn=true;
                
                omrade2choosenName=@"cb10";
                [cb10 setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
                omradeLabel2.text=label10.text;
            }
            
            [cb2 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
            [cb3 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
            [cb4 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
            [cb5 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
            [cb6 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
            [cb7 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
            [cb8 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
            [cb9 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
            [cb1 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
        }
        else
        {
            [cb10 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
            if (isOmrade1)
            {
                isOmrade1choosesn=false;
                
                omrade1choosenName=@"";

                omradeLabel1.text = @"";
            }
            else
            {
                isOmrade2choosesn=false;
                
                omrade2choosenName=@"";

                omradeLabel2.text = @"";
            }
        }
        
    }
}
    
-(IBAction)CloseBtn:(id)sender
{
    [cb1 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
    
    [cb2 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
    [cb3 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
    [cb4 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
    [cb5 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
    [cb6 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
    [cb7 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
    [cb8 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
    [cb9 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
    [cb10 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
    
    if (!subView.isHidden)
    {
        subView.hidden = YES;
    }
    else if (!settingsView.isHidden)
    {
        UILocalNotification *notif = [[UILocalNotification alloc] init];
        
//        NSCalendar *cal = [NSCalendar currentCalendar];
//                
//        for (int i = 0; i <= 6; i++)
//        {
//            NSDate *newDate = [[_reminderDatePicker date] dateByAddingTimeInterval:(60 * 60 * 24 * i)];
//            
//            NSDateComponents *newDateComp = [cal components:NSWeekdayCalendarUnit fromDate:newDate];
//            
//            if (_weekSegmentControl.selectedSegmentIndex + 1 == [newDateComp weekday])
//            {
//                notif.fireDate = newDate;
//                notif.repeatInterval = NSWeekdayCalendarUnit;
//            }
//        }
        
        notif.fireDate = [_reminderDatePicker date];
        notif.repeatInterval = NSWeekdayCalendarUnit;
        notif.timeZone = [NSTimeZone defaultTimeZone];
        
        notif.alertBody = @"Påminnelser";
        notif.alertAction = @"Show me";
        notif.soundName = UILocalNotificationDefaultSoundName;
        notif.applicationIconBadgeNumber = 1;
        
        NSDictionary *infoDict = [NSDictionary dictionaryWithObject:@"Reminder" forKey:@"notifyKey"];
        notif.userInfo = infoDict;
        
        [[UIApplication sharedApplication] scheduleLocalNotification:notif];
        [notif release];
        
        settingsView.hidden = YES;
    }
}

-(IBAction)averagevalue
{
    int box1=[tf1.text intValue];
//    NSLog(@"%d",box1);
     int box2=[tf2.text intValue];
   int box3=[tf3.text intValue];
   int box4=[tf4.text intValue];
    int box5=[tf5.text intValue];
     int box6=[tf6.text intValue];
    int box7=[tf7.text intValue];
    int box8=[tf8.text intValue];
   int box9=[tf9.text intValue];
    int box10=[tf10.text intValue];
    
    float sumValue=box1+box2+box3+box4+box5+box6+box7+box8+box9+box10;
    float avgValue=sumValue/10;
     //NSLog(@"%.1f",avgValue);
    NSString *str=[NSString stringWithFormat: @"%.1f", avgValue];
    [averageBt setTitle:str forState:UIControlStateNormal];
    
}

-(IBAction)settingsbutton:(id)sender
{
    [self.view bringSubviewToFront:settingsView];
    
    if (_reminderOnButton.enabled && _reminderOffButton.enabled)
    {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"Reminder"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    settingsView.hidden = NO;
    subView.hidden = YES;
    
    [_reminderDatePicker setDate:[NSDate date]];
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"Reminder"])
    {
        _reminderOnButton.enabled = NO;
        _reminderOffButton.enabled = YES;
        
        _reminderDatePicker.hidden = NO;
        
//        _weekSegmentControl.hidden = NO;
        
        _settingBImageView.hidden = NO;
        _settingBLabel.hidden = NO;
        _settingBTitleImageView.hidden = NO;
        _kiLabel.hidden = NO;
    }
    else
    {
        _reminderOnButton.enabled = NO;
        _reminderOffButton.enabled = YES;
        
        _reminderDatePicker.hidden = YES;
        
//        _weekSegmentControl.hidden = YES;
        
        _settingBImageView.hidden = YES;
        _settingBLabel.hidden = YES;
        _settingBTitleImageView.hidden = YES;
        _kiLabel.hidden = YES;
    }
    
    [UIView beginAnimations:@"curlInView" context:nil];
    
    [UIView setAnimationDuration:3.0];
    
    [UIView commitAnimations];
}

-(IBAction)SaveBtn:(id)sender
{
    
    NSDate* date = [NSDate date];
    
    //Create the dateformatter object
    
    NSDateFormatter* formatter = [[[NSDateFormatter alloc] init] autorelease];
    
    //Set the required date format
    
    [formatter setDateFormat:@"MMM d YYYY HH:mm:ss"];
    
    //Get the string date
    
    NSString* str = [formatter stringFromDate:date];
    sqlite3 *exerciseDB;
    NSLog(@"date%@",str);
    sqlite3_stmt    *statement;
    
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &exerciseDB) == SQLITE_OK)
    {
        int rows = 0;
        
        NSString *sql = [NSString stringWithFormat: @"SELECT date FROM EXERCISE7"];
        
        const char *query_stmt = [sql UTF8String];
        
        if (sqlite3_prepare_v2(exerciseDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                char* date = (char*) sqlite3_column_text(statement,0);
                NSString *tmp;
                if (date != NULL)
                {
                    tmp = [NSString stringWithUTF8String:date];
                    NSLog(@"STR VALUE = %@", str);
                    NSLog(@"TEMP VALUE = %@",tmp);
                    NSArray *array = [[NSArray alloc] initWithArray:[tmp componentsSeparatedByString:@" "]];
                    
                    if ([str isEqualToString:[NSString stringWithFormat:@"%@ %@ %@", [array objectAtIndex:0], [array objectAtIndex:1], [array objectAtIndex:2]]])
                    {
                        NSLog(@"Came Here");
                        rows++;
                        break;
                    }
                }
            }
        }
        
        NSLog(@"ROW COUNT = %i", rows);
        NSString *insertSQL;
        
//        [formatter setDateFormat:@"MMM d YYYY HH:mm:ss"];
//        str = [formatter stringFromDate:date];
        
        if (!dateOfCurrentItem)
        {
            insertSQL = [NSString stringWithFormat: @"INSERT INTO EXERCISE7(date,omrade1,aktivitet1,omrade2,aktivitet2,average,familj,vanner,karlek,arbete,ekonomi,kost,motion,vila,fritid,somn) VALUES (\"%@\", \"%@\", \"%@\", \"%@\", \"%@\" ,\"%@\" ,\"%@\" ,\"%@\" ,\"%@\" ,\"%@\" ,\"%@\" ,\"%@\" ,\"%@\" ,\"%@\" ,\"%@\" ,\"%@\")", str, omradeLabel1.text,textview.text, omradeLabel2.text,self.textview1.text,averageBt.currentTitle, tf1.text, tf2.text, tf3.text, tf4.text, tf5.text, tf6.text, tf7.text, tf8.text, tf9.text, tf10.text];
        }
        else
        {
            insertSQL = [NSString stringWithFormat: @"UPDATE EXERCISE7 SET date='%@', omrade1='%@',aktivitet1='%@',omrade2='%@',aktivitet2='%@',average='%@',familj='%@',vanner='%@',karlek='%@',arbete='%@',ekonomi='%@',kost='%@',motion='%@',vila='%@',fritid='%@',somn='%@' WHERE date='%@'", dateOfCurrentItem, omradeLabel1.text,textview.text, omradeLabel2.text,self.textview1.text,averageBt.currentTitle, tf1.text, tf2.text, tf3.text, tf4.text, tf5.text, tf6.text, tf7.text, tf8.text, tf9.text, tf10.text, dateOfCurrentItem];
        }
        
        const char *insert_stmt = [insertSQL UTF8String];
        
        sqlite3_prepare_v2(exerciseDB, insert_stmt, -1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
        /*    omradeLabel1.text=@"";
            omradeLabel2.text = @"";
            textview.text=@"";
            _textview1.text = @"";
            tf1.text=@"1";
            tf2.text=@"1";
            tf3.text=@"1";
            tf4.text=@"1";
            tf5.text=@"1";
            tf6.text=@"1";
            tf7.text=@"1";
            tf8.text=@"1";
            tf9.text=@"1";
            tf10.text=@"1";
            [averageBt setTitle:@"1.0" forState:UIControlStateNormal];
            dateOfCurrentItem = nil;
            _raderaButton.enabled = NO;
            skickaButton.enabled = NO;
            
            _recentButton1.hidden = YES;
            _recentLabel1.hidden = YES;
            
            _recentButton2.hidden = YES;
            _recentLabel2.hidden = YES;*/   // commented out the code to preserve the last saved values
            
//            if (rows == 0)
//            {
//                UIAlertView *insertAlert = [[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Sparat" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] autorelease];
//                [insertAlert show];
//            }
//            else
//            {
            // code changes by malkit....alert title cleared
                UIAlertView *insertAlert = [[[UIAlertView alloc] initWithTitle:@"" message:@"Sparat" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] autorelease];
                [insertAlert show];
            NewFormCheck=false;
//            }
            
//            dateOfCurrentItem = [[NSString alloc] initWithString:str];
            
        } else {
            NSLog(@"no");
            NSLog(@"error: %s", sqlite3_errmsg(exerciseDB));
            UIAlertView *insertAlert = [[[UIAlertView alloc] initWithTitle:@"" message:@"Form Update/Save Failed" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] autorelease];
            [insertAlert show];
        }
        sqlite3_finalize(statement);
        sqlite3_close(exerciseDB);
    }

}
-(IBAction)NewBtn:(id)sender
{
//    if([label.text isEqualToString:@""] && [textview.text isEqualToString:@""] )
//    {
//        
//    }
//    else
//    {
    
    if (NewFormCheck) {
        
    
      UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"" message:@"Du har inte sparat ditt formulär, är du säker på att du vill fortsätta?"
                                        delegate:self
                               cancelButtonTitle:nil
                               otherButtonTitles:@"Fortsätt", @"Avbryt", nil];
        alert.tag = 1;
        
        [alert show];
        [alert release];}
    else
    {
        NSLog(@"new form");
        omradeLabel1.text=@"";
        omradeLabel2.text = @"";
        textview.text=@"";
        _textview1.text = @"";
        tf1.text=@"1";
        tf2.text=@"1";
        tf3.text=@"1";
        tf4.text=@"1";
        tf5.text=@"1";
        tf6.text=@"1";
        tf7.text=@"1";
        tf8.text=@"1";
        tf9.text=@"1";
        tf10.text=@"1";
        [averageBt setTitle:@"1.0" forState:UIControlStateNormal];
        dateOfCurrentItem = nil;
        _raderaButton.enabled = NO;
        skickaButton.enabled = NO;

    }
//    }

}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"ok");
    
        if (buttonIndex == 0 && alertView.tag == 1)
        {
            NSLog(@"new form");
            omradeLabel1.text=@"";
            omradeLabel2.text = @"";
            textview.text=@"";
            _textview1.text = @"";
            tf1.text=@"1";
              tf2.text=@"1";
              tf3.text=@"1";
            tf4.text=@"1";
              tf5.text=@"1";
              tf6.text=@"1";
              tf7.text=@"1";
              tf8.text=@"1";
              tf9.text=@"1";
              tf10.text=@"1";
               [averageBt setTitle:@"1.0" forState:UIControlStateNormal];
            dateOfCurrentItem = nil;
            _raderaButton.enabled = NO;
            skickaButton.enabled = NO;
            
        }
        else if (buttonIndex == 0 && alertView.tag == 2)
        {
            sqlite3 *exerciseDB;
            sqlite3_stmt    *statement;
            if (sqlite3_open([databasePath UTF8String], &exerciseDB) == SQLITE_OK) {
                
                NSLog(@"Date of Item to be delete = %@", dateOfCurrentItem);
                NSString *sql = [NSString stringWithFormat: @"DELETE FROM EXERCISE7 WHERE date='%@'", dateOfCurrentItem];
                
                const char *del_stmt = [sql UTF8String];
                
                sqlite3_prepare_v2(exerciseDB, del_stmt, -1, & statement, NULL);
                if (sqlite3_step(statement) == SQLITE_DONE) {
                    
                    NSLog(@"Deleted");
                    UIAlertView * alert1 = [[UIAlertView alloc] initWithTitle:nil message:@"Raderat" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok",nil];
                    [alert1 show];
                    [alert1 release];
                    
                    dateOfCurrentItem = nil;
                    [self updateCurrentItem];
                }
                
                sqlite3_finalize(statement);
                sqlite3_close(exerciseDB);
            }
        }
}
-(IBAction)listofvalues:(id)sender
{
    int rows = 0;
    NSString *docsDir;
    NSArray *dirPaths;
    
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    
    // Build the path to the database file
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"exerciseDB.db"]];
    // const char *dbpath = [databasePath UTF8String];
    sqlite3 *exerciseDB;
    sqlite3_stmt    *statement;
    if (sqlite3_open([databasePath UTF8String], &exerciseDB) == SQLITE_OK)
    {
        
        NSString *sql = [NSString stringWithFormat: @"SELECT COUNT(*) FROM EXERCISE7"];
        
        const char *query_stmt = [sql UTF8String];
        
        if (sqlite3_prepare_v2(exerciseDB,
                               query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                rows = sqlite3_column_int(statement, 0);
            }
        }
        
        NSLog(@"SQLite Rows: %i", rows);
        
        sqlite3_finalize(statement);
        sqlite3_close(exerciseDB);
    }
    
    if (rows > 0)
    {
        tableImageView = [[[UIImageView alloc] initWithFrame:CGRectMake(0, scrollView.contentSize.height - 280, self.view.frame.size.width, 280)] autorelease];
        [tableImageView setImage:[UIImage imageNamed:@"scrollbottom.png"]];
//        lok = [[ListOfKompass alloc]initWithNibName:@"ListOfKompass" bundle:nil];
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
        {
            lok = [[ListOfKompass alloc]initWithNibName:@"ListOfKompass" bundle:nil];
        }else
        {
            lok = [[ListOfKompass alloc]initWithNibName:@"ListOfKompass_iPad" bundle:nil];
        }
        
        lok.delegate = self;
        //    [self.navigationController pushViewController:lok animated:YES];
//        lok.tableView.layer.cornerRadius = 10;
//        lok.tableView.layer.borderColor = [UIColor blueColor].CGColor;
//        lok.tableView.layer.borderWidth = 3;
        
        lok.tableView.frame = CGRectMake(10, tableImageView.frame.origin.y + 10, self.view.frame.size.width - 20, 210);
        
        closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        closeButton.frame = CGRectMake((self.view.frame.size.width / 2) - 130, tableImageView.frame.origin.y + 230, 260, 31);
        [closeButton setBackgroundImage:[UIImage imageNamed:@"blargebutton.png"] forState:UIControlStateNormal];
        [closeButton addTarget:self action:@selector(removeTableSubviews) forControlEvents:UIControlEventTouchUpInside];
        [closeButton setTitle:@"Avbryt" forState:UIControlStateNormal];
        closeButton.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        [closeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
//        [self.view addSubview:lok.tableView];
        [self.view addSubview:tableImageView];
        [self.view addSubview:lok.tableView];
        [self.view addSubview:closeButton];
    }
    else
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Alert message" message:@"There are no saved entries."
                                                     delegate:self
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
}

- (void)removeTableSubviews
{
    [closeButton removeFromSuperview];
    [lok.tableView removeFromSuperview];
    [tableImageView removeFromSuperview];
}

- (void)didSelectDate:(NSString *)date
{
    _raderaButton.enabled = YES;
    skickaButton.enabled = YES;
    dateOfCurrentItem = [[NSString alloc] initWithString:date];
    [self updateCurrentItem];
    [lok.tableView removeFromSuperview];
    [closeButton removeFromSuperview];
    [lok.tableView removeFromSuperview];
    [tableImageView removeFromSuperview];
    [lok release];
    NSLog(@"Selected ITEM = %@", dateOfCurrentItem);
}

-(IBAction)Increase:(id)sender
{
    NewFormCheck=true;
     UIButton *btn = (UIButton *)sender;
    if(btn.tag==1){
        int box1=[tf1.text intValue];
        if(box1 != 10){
            box1++;
            NSString *str=[NSString stringWithFormat: @"%d", box1];
            tf1.text=str;
        }
      
    }
else if(btn.tag==2){
    int box1=[tf2.text intValue];
    if(box1 != 10){
        box1++;
        NSString *str=[NSString stringWithFormat: @"%d", box1];
        tf2.text=str;
    }
}
else if(btn.tag==3){
    int box1=[tf3.text intValue];
    if(box1 != 10){
        box1++;
        NSString *str=[NSString stringWithFormat: @"%d", box1];
        tf3.text=str;
    }
}
else if(btn.tag==4){
    int box1=[tf4.text intValue];
    if(box1 != 10){
        box1++;
        NSString *str=[NSString stringWithFormat: @"%d", box1];
        tf4.text=str;
    }
}
else if(btn.tag==5){
    int box1=[tf5.text intValue];
    if(box1 != 10){
        box1++;
        NSString *str=[NSString stringWithFormat: @"%d", box1];
        tf5.text=str;
    }
}
else if(btn.tag==6){
    int box1=[tf6.text intValue];
    if(box1 != 10){
        box1++;
        NSString *str=[NSString stringWithFormat: @"%d", box1];
        tf6.text=str;
    }
}
else if(btn.tag==7){
    int box1=[tf7.text intValue];
    if(box1 != 10){
        box1++;
        NSString *str=[NSString stringWithFormat: @"%d", box1];
        tf7.text=str;
    }
}
else if(btn.tag==8){
    int box1=[tf8.text intValue];
    if(box1 != 10){
        box1++;
        NSString *str=[NSString stringWithFormat: @"%d", box1];
        tf8.text=str;
    }
}
else if(btn.tag==9){
    int box1=[tf9.text intValue];
    if(box1 != 10){
        box1++;
        NSString *str=[NSString stringWithFormat: @"%d", box1];
        tf9.text=str;
    }
}
else if(btn.tag==10){
    int box1=[tf10.text intValue];
    if(box1 != 10){
        box1++;
        NSString *str=[NSString stringWithFormat: @"%d", box1];
        tf10.text=str;
    }
}
    
    [self averagevalue];
}


-(IBAction)Decrease:(id)sender{
    NewFormCheck=true;

     UIButton *btn = (UIButton *)sender;
    if(btn.tag==1){
        int box1=[tf1.text intValue];
          if(box1 != 1){
        box1--;
        NSString *str=[NSString stringWithFormat: @"%d", box1];
        tf1.text=str;
          }
    }
    else if(btn.tag==2){
        int box1=[tf2.text intValue];
        if(box1 != 1){
            box1--;
            NSString *str=[NSString stringWithFormat: @"%d", box1];
            tf2.text=str;
        }
    }
    else if(btn.tag==3){
        int box1=[tf3.text intValue];
        if(box1 != 1){
            box1--;
            NSString *str=[NSString stringWithFormat: @"%d", box1];
            tf3.text=str;
        }
    }
    else if(btn.tag==4){
        int box1=[tf4.text intValue];
        if(box1 != 1){
            box1--;
            NSString *str=[NSString stringWithFormat: @"%d", box1];
            tf4.text=str;
        }
    }
    else if(btn.tag==5){
        int box1=[tf5.text intValue];
        if(box1 != 1){
            box1--;
            NSString *str=[NSString stringWithFormat: @"%d", box1];
            tf5.text=str;
        }
    }
    else if(btn.tag==6){
        int box1=[tf6.text intValue];
        if(box1 != 1){
            box1--;
            NSString *str=[NSString stringWithFormat: @"%d", box1];
            tf6.text=str;
        }
    }
    else if(btn.tag==7){
        int box1=[tf7.text intValue];
        if(box1 != 1){
            box1--;
            NSString *str=[NSString stringWithFormat: @"%d", box1];
            tf7.text=str;
        }
    }
    else if(btn.tag==8){
        int box1=[tf8.text intValue];
        if(box1 != 1){
            box1--;
            NSString *str=[NSString stringWithFormat: @"%d", box1];
            tf8.text=str;
        }
    }
    else if(btn.tag==9){
        int box1=[tf9.text intValue];
        if(box1 != 1){
            box1--;
            NSString *str=[NSString stringWithFormat: @"%d", box1];
            tf9.text=str;
        }
    }
    else if(btn.tag==10){
        int box1=[tf10.text intValue];
        if(box1 != 1){
            box1--;
            NSString *str=[NSString stringWithFormat: @"%d", box1];
            tf10.text=str;
        }
    }
    [self averagevalue];
}

- (IBAction)deleteEntry:(id)sender
{
    if (dateOfCurrentItem)
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"" message:@"Är du säker på att du vill radera formuläret?"
                                                     delegate:self
                                            cancelButtonTitle:nil
                                            otherButtonTitles:@"Radera", @"Avbryt", nil];
        alert.tag = 2;
        [alert show];
        [alert release];
    }
    else
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Alert message" message:@"This is not a saved entry to delete. This is a fresh page."
                                                     delegate:self
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
}

- (IBAction)generateGraph:(id)sender
{
    NSDateFormatter* formatter = [[[NSDateFormatter alloc] init] autorelease];
    [formatter setDateFormat:@"MMM d YYYY HH:mm:ss"];
    
    NSString *olderDate = nil;
    
    NSString *docsDir;
    NSArray *dirPaths;
    
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    
//    sqlite3 *exerciseDB;
    
    // Build the path to the database file
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"exerciseDB.db"]];
    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt  *statement;
    sqlite3 *exerciseDB;
    
    if (sqlite3_open(dbpath, &exerciseDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT date FROM EXERCISE7 ORDER BY id DESC"
                              ];
        
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(exerciseDB,
                               query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW) {
                
                char* date = (char*) sqlite3_column_text(statement,0);
                
                if (date != NULL)
                {
                    NSLog(@"Date OF CURRENT ITEM = %@", dateOfCurrentItem);
                    NSDate *presentDate = [formatter dateFromString:dateOfCurrentItem];
                    NSDate *oldDate = [formatter dateFromString:[NSString stringWithUTF8String:date]];
                    
                    if ([presentDate compare:oldDate] == NSOrderedDescending)
                    {
                        olderDate = [[[NSString alloc] initWithUTF8String:date] autorelease];
                        break;
                    }
                    else
                    {
                        olderDate=@"";
                    }
                }
                
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(exerciseDB);
    }
    
    if (dateOfCurrentItem && olderDate)
    {
        DinKompass *dinKom;
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
        {
            dinKom = [[DinKompass alloc]initWithNibName:@"DinKompass" bundle:nil];
        }else
        {
            dinKom = [[DinKompass alloc]initWithNibName:@"DinKompass_iPad" bundle:nil];
        }
        
        dinKom.presentDate = [[NSString alloc] initWithString:dateOfCurrentItem];
        dinKom.oldDate = [[NSString alloc] initWithString:olderDate];
        if ([olderDate isEqualToString:@""]) {
            dinKom.isComparisonGraph=NO;
        
        }
        else
        dinKom.isComparisonGraph = YES;
        //    dinKom.delegate = self;
        [self.navigationController pushViewController:dinKom animated:YES];
    }
    else
    {
        UIAlertView *insertAlert = [[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please select one form to generate Kompass." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] autorelease];
        [insertAlert show];
    }
}

- (IBAction)reminderOnOff:(UIButton *)sender
{
    if (sender.tag == 1)
    {
        _reminderOnButton.enabled = NO;
        _reminderOffButton.enabled = YES;
        
        _reminderDatePicker.hidden = NO;
        
//        _weekSegmentControl.hidden = NO;
        
        _settingBImageView.hidden = NO;
        _settingBLabel.hidden = NO;
        _settingBTitleImageView.hidden = NO;
        _kiLabel.hidden = NO;
        
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"Reminder"];
    }
    else
    {
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
        _reminderOffButton.enabled = NO;
        _reminderOnButton.enabled = YES;
        
        _reminderDatePicker.hidden = YES;
        
//        _weekSegmentControl.hidden = YES;
        
        _settingBImageView.hidden = YES;
        _settingBLabel.hidden = YES;
        _settingBTitleImageView.hidden = YES;
        _kiLabel.hidden = YES;
        
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"Reminder"];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (IBAction)recentButtonsClicked:(id)sender
{
    if ([(UIButton *)sender tag] == 0)
    {
        if (recentBtn1Selected)
        {
            recentBtn1Selected = NO;
            [_recentButton1 setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
        }
        else
        {
            recentBtn1Selected = YES;
            [_recentButton1 setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
        }
        
        if ([omradeLabel1.text isEqualToString:@""])
        {
            omradeLabel1.text = _recentLabel1.text;
        }
        else if ([omradeLabel2.text isEqualToString:@""])
        {
            omradeLabel2.text = _recentLabel1.text;
        }
    }
    else
    {
        if (recentBtn2Selected)
        {
            recentBtn2Selected = NO;
            [_recentButton2 setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
        }
        else
        {
            recentBtn2Selected = YES;
            [_recentButton2 setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
        }
        
        if ([omradeLabel1.text isEqualToString:@""])
        {
            omradeLabel1.text = _recentLabel2.text;
        }
        else if ([omradeLabel2.text isEqualToString:@""])
        {
            omradeLabel2.text = _recentLabel2.text;
        }
    }
}

//-(CPTLayer *)dataLabelForPlot:(CPTPlot *)plot recordIndex:(NSUInteger)index {
//	// 1 - Define label text style
//	static CPTMutableTextStyle *labelText = nil;
//	if (!labelText) {
//		labelText= [[CPTMutableTextStyle alloc] init];
//		labelText.color = [CPTColor grayColor];
//	}
//	// 2 - Calculate portfolio total value
//	NSDecimalNumber *portfolioSum = [NSDecimalNumber zero];
//	for (NSDecimalNumber *price in [[CPDStockPriceStore sharedInstance] dailyPortfolioPrices]) {
//		portfolioSum = [portfolioSum decimalNumberByAdding:price];
//	}
//	// 3 - Calculate percentage value
//	NSDecimalNumber *price = [[[CPDStockPriceStore sharedInstance] dailyPortfolioPrices] objectAtIndex:index];
//	NSDecimalNumber *percent = [price decimalNumberByDividingBy:portfolioSum];
//	// 4 - Set up display label
//	NSString *labelValue = [NSString stringWithFormat:@"$%0.2f USD (%0.1f %%)", [price floatValue], ([percent floatValue] * 100.0f)];
//	// 5 - Create and return layer with label text
//	return [[CPTTextLayer alloc] initWithText:labelValue style:labelText];
//}
//
//-(NSString *)legendTitleForPieChart:(CPTPieChart *)pieChart recordIndex:(NSUInteger)index {
//	if (index < [[[CPDStockPriceStore sharedInstance] tickerSymbols] count]) {
//		return [[[CPDStockPriceStore sharedInstance] tickerSymbols] objectAtIndex:index];
//	}
//	return @"N/A";
//}

//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
//    
//    if ([title isEqualToString:@"Delete"]) {
//        NSLog(@"Delete.");
//        sqlite3_stmt    *statement;
//        if (sqlite3_open([databasePath UTF8String], &exerciseDB) == SQLITE_OK) {
//            
//            NSString *sql = [NSString stringWithFormat: @"DELETE FROM EXERCISE7 WHERE date='%@'", dateoflivskompass];
//            
//            const char *del_stmt = [sql UTF8String];
//            
//            sqlite3_prepare_v2(exerciseDB, del_stmt, -1, & statement, NULL);
//            if (sqlite3_step(statement) == SQLITE_ROW) {
//                
//                NSLog(@"sss");
//            }
//            
//            sqlite3_finalize(statement);
//            sqlite3_close(exerciseDB);
//            
//            
//        }
//        
//    }
//}

- (void)dealloc {
    [scrollView release];
    if (lok) {
        [lok release];
    }
    if (dateOfCurrentItem) {
        [dateOfCurrentItem release];
    }
    [settingsView release];
    [subView release];
    [_reminderOnButton release];
    [_reminderOffButton release];
//    [_weekSegmentControl release];
    [_reminderDatePicker release];
    [_textview1 release];
    [_recentButton1 release];
    [_recentButton2 release];
    [_recentLabel1 release];
    [_recentLabel2 release];
    [_raderaButton release];
    [_kiLabel release];
    [_settingBLabel release];
    [_settingBImageView release];
    [_settingBTitleImageView release];
    [super dealloc];
}

- (IBAction)skickaButtonClicked:(id)sender
{
    if (dateOfCurrentItem)
    {
        UIActionSheet *cameraActionSheet = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Download", @"Email", nil];
        cameraActionSheet.tag = 1;
        [cameraActionSheet showInView:self.view];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please select a form to share" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }
}

- (UIImage *)getFormImage
{
    UIImage *tempImage = nil;
    UIGraphicsBeginImageContext(scrollView.contentSize);
    {
        CGPoint savedContentOffset = scrollView.contentOffset;
        CGRect savedFrame = scrollView.frame;
        
        scrollView.contentOffset = CGPointZero;
        scrollView.frame = CGRectMake(0, 0, scrollView.contentSize.width, scrollView.contentSize.height);
        
        [scrollView.layer renderInContext: UIGraphicsGetCurrentContext()];
        tempImage = UIGraphicsGetImageFromCurrentImageContext();
        
        scrollView.contentOffset = savedContentOffset;
        scrollView.frame = savedFrame;
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
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Image downloaded" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
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
            [htmlMsg appendString:[NSString stringWithFormat:@"Please find the attached form on %@", dateOfCurrentItem]];
            [htmlMsg appendString:@": </p></body></html>"];
            
            NSData *jpegData = UIImageJPEGRepresentation([self getFormImage], 1);
            
            NSString *fileName = [NSString stringWithString:dateOfCurrentItem];
            fileName = [fileName stringByAppendingPathExtension:@"jpeg"];
            [emailDialog addAttachmentData:jpegData mimeType:@"image/jpeg" fileName:fileName];
            
            [emailDialog setSubject:@"Form"];
            [emailDialog setMessageBody:htmlMsg isHTML:YES];
            
            
            [self presentViewController:emailDialog animated:YES completion:nil];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Mail cannot be send now. Please check mail has been configured in your device and try again." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
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
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Mail sent successfully" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
        }
            break;
        case MFMailComposeResultFailed:
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Mail send failed" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
        }
            break;
        default:
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Mail was not sent." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
        }
            break;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
