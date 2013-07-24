//
//  PlusveckaDayView.m
//  Välkommen till TFH-appen
//
//  Created by Brilliance Tech Sols on 7/21/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import "PlusveckaDayView.h"

@interface PlusveckaDayView ()
@property (nonatomic, strong) NSString *currentDateBtn,*tabValue;
@property (nonatomic, strong) NSString *currentStatuBtn;
@end
@interface CustomButton3 : UIButton

@property (nonatomic, strong) NSString *currentDateString,*tabValue;

@end

@implementation CustomButton3
@synthesize currentDateString,tabValue;



@end
@implementation PlusveckaDayView
@synthesize currentDateBtn,currentStatuBtn,tabValue;
@synthesize scrollView;
@synthesize hoursTextField1,hoursTextField2,mintsTextField1,mintsTextField2;
@synthesize eventDesTextView,slider,sliderLabel;
@synthesize popupView,totalView;
@synthesize isDinackar;
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
    self.popupView.layer.cornerRadius = 12;
    self.popupView.layer.shadowOpacity = 0.7;
    self.popupView.layer.shadowOffset = CGSizeMake(6, 6);
    self.popupView.layer.shouldRasterize = YES;
    self.popupView.layer.rasterizationScale = [[UIScreen mainScreen] scale];
    self.totalView.layer.cornerRadius = 12;
    self.totalView.layer.shadowOpacity = 0.7;
    self.totalView.layer.shadowOffset = CGSizeMake(6, 6);
    self.totalView.layer.shouldRasterize = YES;
    self.totalView.layer.rasterizationScale = [[UIScreen mainScreen] scale];
    self.navigationItem.title=@"Måndag";
    
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
    [self createButton];
    
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
        const char *sql_stmt = "CREATE TABLE IF NOT EXISTS sub1event (id INTEGER PRIMARY KEY AUTOINCREMENT,date TEXT,startDate TEXT,endDate TEXT,status TEXT,dayDate TEXT,eventDescription TEXT)";
        const char *sql_stmt1 = "CREATE TABLE IF NOT EXISTS sub1total (id INTEGER PRIMARY KEY AUTOINCREMENT,date TEXT,total TEXT)";
        
        if (sqlite3_exec(exerciseDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
        {
            NSLog(@"Failed to create database");
        }
        if (sqlite3_exec(exerciseDB, sql_stmt1, NULL, NULL, &errMsg)!=SQLITE_OK) {
            NSLog(@"Failed to create total database");
        }
        
        sqlite3_close(exerciseDB);
        
    } else {
        NSLog(@"Failed to open/create database");
    }
    // Do any additional setup after loading the view from its nib.
}

-(void)backButon {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)emptyCell:(CustomButton3 *)sender {
    //currentButtonStatus = sender;
    currentDateBtn = sender.currentDateString;
    tabValue = sender.tabValue;
    
    ASDepthModalOptions style = ASDepthModalOptionAnimationGrow;
    [ASDepthModalViewController presentView:self.popupView
                            backgroundColor:nil
                                    options:style
                          completionHandler:^{
                              NSLog(@"Modal view closed.");
                              // [self refresh];
                          }];
}

-(IBAction)closeButtonClicked:(id)sender
{
    [ASDepthModalViewController dismiss];
}

-(IBAction)okButtonClicked:(id)sender
{
    [ASDepthModalViewController dismiss];
}

-(IBAction)totalOkButtonAction:(id)sender{
    [ASDepthModalViewController dismiss];
}

#pragma mark TotalButtonClicked

-(IBAction)totalButtonClicked:(id)sender
{
    ASDepthModalOptions style = ASDepthModalOptionAnimationGrow;
    [ASDepthModalViewController presentView:self.totalView
                            backgroundColor:nil
                                    options:style
                          completionHandler:^{
                              
                          }];
}

-(IBAction)sliderValueChanged:(UISlider*)sender{
    sliderLabel.text = [NSString stringWithFormat:@"%.0f",[sender value]];
}


-(IBAction)statusButtonClicked:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    NSLog(@"%i",btn.tag);
    
    switch (btn.tag) {
        case 1:
            currentStatuBtn = btn.currentTitle;
            break;
        case 2:
            currentStatuBtn = btn.currentTitle;
            break;
        case 3:
            currentStatuBtn = btn.currentTitle;
            break;
        default:
            break;
    }
}

#pragma mark UITextField Delegate Methods

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    [self.popupView setFrame:CGRectMake(self.popupView.frame.origin.x, self.popupView.frame.origin.y - 120, self.popupView.frame.size.width, self.popupView.frame.size.height)];
}


-(void)textFieldDidEndEditing:(UITextField *)textField {
    [self.popupView setFrame:CGRectMake(self.popupView.frame.origin.x, self.popupView.frame.origin.y + 120, self.popupView.frame.size.width, self.popupView.frame.size.height)];
}

-(void)textViewDidEndEditing:(UITextView *)textView {
    
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    [textField addTarget:self action:@selector(changeText:) forControlEvents:UIControlEventEditingChanged];
    return YES;
}


-(void)changeText:(UITextField*)textField {
    
    if (textField == hoursTextField1) {
        if ([textField.text length] > 24) {
            hoursTextField2.text = @"";
        }
        else {
            int h1 = [textField.text integerValue];
            h1 += 1;
            hoursTextField2.text = [NSString stringWithFormat:@"%i",h1];
        }
    }
    if (textField == mintsTextField1) {
        mintsTextField2.text = mintsTextField1.text;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

-(void)createButton {
    int p,q;
    if (isDinackar) {
        p=1;
        q=250;
    }
    else{
        p=2;
        q=125;
    }
    for (int i = 0; i < p; i++) {
        for (int j =0; j < 24 ; j++) {
            //NSString *hStr = [NSString stringWithFormat:@"%i",j];
            CustomButton3 *but = [[CustomButton3 alloc] initWithFrame:CGRectMake((i*q)+ 57, j*29,q, 29)];
            but.titleLabel.textAlignment = UITextAlignmentCenter;
            [but setBackgroundImage:[UIImage imageNamed:@"kalendar_cell_empty.png"] forState:UIControlStateNormal];
            [but setTabValue:[NSString stringWithFormat:@"%d",i]];
            [but addTarget:self action:@selector(emptyCell:) forControlEvents:UIControlEventTouchUpInside];
            //[but setCurrentDateString:[NSString stringWithFormat:@"%@ %@",[tm objectAtIndex:0],hStr]];
            NSString *strin = [NSString stringWithFormat:@"%d%d",j,i];
            [but setTag:[strin intValue]];
            [but setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [self.scrollView addSubview:but];
        }
    }
    
    [self.scrollView setContentSize:CGSizeMake(self.scrollView.frame.size.width, 24*29)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
