//
//  Registreratankar.m
//  Välkommen till TFH-appen
//
//  Created by Mohammed Abdul Majeed on 4/29/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import "Registreratankar.h"
#import "MTPopupWindow.h"

#define kAlertViewOne 1
#define kAlertViewTwo 2
NSMutableString *firstString;
@interface Registreratankar ()

@end

@implementation Registreratankar
@synthesize label,flykt,tanke,tabellen,nat;
@synthesize negative,situation,beteenden,overiga,alert;
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
    firstString=[[NSMutableString alloc]init];
    self.navigationItem.title=@"Registrera tankar";
    eevc=[[EditExerciseViewController alloc]initWithNibName:@"EditExerciseViewController" bundle:nil];
    UIBarButtonItem *bButton = [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                                                   style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = bButton;
    
    
//    label.userInteractionEnabled = YES;
//    UITapGestureRecognizer *tapGesture =
//    [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(mainlabelalert:)] autorelease];
//    [label addGestureRecognizer:tapGesture];
    
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

    [self.view addSubview:tabellenView];
    tabellenView.hidden=YES;
    scroll.scrollEnabled = YES;
    [scroll setContentSize:CGSizeMake(320, 1100)];
    
    scroll1.scrollEnabled = YES;
    [scroll1 setContentSize:CGSizeMake(320, 700)];
    [super viewDidLoad]; 
    // Do any additional setup after loading the view from its nib.
}
-(IBAction)mainlabelalert:(id)sender{
     [MTPopupWindow showWindowWithHTMLFile:@"Registreratankar.html" insideView:self.view];
}

-(IBAction)natalert:(id)sender{
    [MTPopupWindow showWindowWithHTMLFile:@"tanke.html" insideView:self.view];
}
-(IBAction)tabellenalert:(id)sender{
  //  [MTPopupWindow showWindowWithHTMLFile:@"lashorna.html" insideView:self.view];
  // self.view.hidden=YES;
    
    [self.view bringSubviewToFront:tabellenView];
    tabellenView.hidden = NO;
   
    
    [UIView beginAnimations:@"curlInView" context:nil];
    
    [UIView setAnimationDuration:3.0];
    
    [UIView commitAnimations];
}
-(IBAction)tankealert:(id)sender{
    [MTPopupWindow showWindowWithHTMLFile:@"tanke.html" insideView:self.view];
}
-(IBAction)flyktalert:(id)sender{
    [MTPopupWindow showWindowWithHTMLFile:@"flykt.html" insideView:self.view];
}

-(IBAction)closebutton:(id)sender{
    NSString *string = [NSString stringWithString:firstString];
    NSLog(@"%@",string);
    beteenden.text=string;
    tabellenView.hidden=YES;
}
-(IBAction)tabellencheck:(id)sender{
    UIButton *btn=(UIButton *)sender;
   
    NSLog(@"%u",btn.tag) ;
    switch (btn.tag) {
        case 1:
            if(btn.currentImage==[UIImage imageNamed:@"uncheck.png"]){
                [btn setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
             [firstString appendString:@"Glad"];
                 NSLog(@"%@",firstString);
            }else{
                [btn setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
              
            }

            break;
        case 2:
            if(btn.currentImage==[UIImage imageNamed:@"uncheck.png"]){
                [btn setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
                 [firstString appendString:@", Rädsla"];
                   NSLog(@"%@",firstString);
            }else{
                [btn setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
                         }
            
            break;
        case 3:
            if(btn.currentImage==[UIImage imageNamed:@"uncheck.png"]){
                [btn setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
                [firstString appendString:@" , Hat"];
            }else{
                [btn setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
               // beteenden.text=@"";
            }
            
            break;
        case 4:
            if(btn.currentImage==[UIImage imageNamed:@"uncheck.png"]){
                [btn setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
                 [firstString appendString:@" , intresserad"];
            }else{
                [btn setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
                //beteenden.text=@"";
            }
            
            break;
        case 5:
            if(btn.currentImage==[UIImage imageNamed:@"uncheck.png"]){
                [btn setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
                 [firstString appendString:@", Nöjd"];
            }else{
                [btn setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
               // beteenden.text=@"";
            }
            
            break;
        case 6:
            if(btn.currentImage==[UIImage imageNamed:@"uncheck.png"]){
                [btn setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
                 [firstString appendString:@" , Skräckslagen"];
            }else{
                [btn setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
                //beteenden.text=@"";
            }
            
            break;
        case 7:
            if(btn.currentImage==[UIImage imageNamed:@"uncheck.png"]){
                [btn setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
                [firstString appendString:@" , Motvilja"];
            }else{
                [btn setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
                //beteenden.text=@"";
            }
            
            break;
        case 8:
            if(btn.currentImage==[UIImage imageNamed:@"uncheck.png"]){
                [btn setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
                [firstString appendString:@" , Nyfiken"];
            }else{
                [btn setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
                //beteenden.text=@"";
            }
            
            break;
        case 9:
            if(btn.currentImage==[UIImage imageNamed:@"uncheck.png"]){
                [btn setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
                [firstString appendString:@" , Lycklig"];
            }else{
                [btn setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
                //beteenden.text=@"";
            }
            
            break;
        case 10:
            if(btn.currentImage==[UIImage imageNamed:@"uncheck.png"]){
                [btn setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
                [firstString appendString:@" , Ängslig"];
            }else{
                [btn setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
                //beteenden.text=@"";
            }
            
            break;
        case 11:
            if(btn.currentImage==[UIImage imageNamed:@"uncheck.png"]){
                [btn setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
                [firstString appendString:@" , Ovilja"];
            }else{
                [btn setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
                //beteenden.text=@"";
            }
            
            break;case 12:
            if(btn.currentImage==[UIImage imageNamed:@"uncheck.png"]){
                [btn setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
                [firstString appendString:@" , Inspirerad"];
            }else{
                [btn setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
                //beteenden.text=@"";
            }
            
            break;
        case 13:
            if(btn.currentImage==[UIImage imageNamed:@"uncheck.png"]){
                [btn setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
                [firstString appendString:@" , Överlycklig"];
            }else{
                [btn setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
                //beteenden.text=@"";
            }
            
            break;
        case 14:
            if(btn.currentImage==[UIImage imageNamed:@"uncheck.png"]){
                [btn setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
                [firstString appendString:@" , Nervös"];
            }else{
                [btn setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
                //beteenden.text=@"";
            }
            
            break;
        case 15:
            if(btn.currentImage==[UIImage imageNamed:@"uncheck.png"]){
                [btn setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
                [firstString appendString:@" , Avsky"];
            }else{
                [btn setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
                //beteenden.text=@"";
            }
            
            break;
        case 16:
            if(btn.currentImage==[UIImage imageNamed:@"uncheck.png"]){
                [btn setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
                [firstString appendString:@" , Ivrig"];
            }else{
                [btn setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
                //beteenden.text=@"";
            }
            
            break;
        case 17:
            if(btn.currentImage==[UIImage imageNamed:@"uncheck.png"]){
                [btn setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
                [firstString appendString:@" , Bekymrad"];
            }else{
                [btn setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
                //beteenden.text=@"";
            }
            
            break;
        case 18:
            if(btn.currentImage==[UIImage imageNamed:@"uncheck.png"]){
                [btn setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
                [firstString appendString:@" , Äckel"];
            }else{
                [btn setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
                //beteenden.text=@"";
            }
            
            break;
        case 19:
            if(btn.currentImage==[UIImage imageNamed:@"uncheck.png"]){
                [btn setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
                [firstString appendString:@" , Generad"];
            }else{
                [btn setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
                //beteenden.text=@"";
            }
            
            break;
        case 20:
            if(btn.currentImage==[UIImage imageNamed:@"uncheck.png"]){
                [btn setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
                [firstString appendString:@" , Förtjust"];
            }else{
                [btn setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
                //beteenden.text=@"";
            }
            
            break;
        case 21:
            if(btn.currentImage==[UIImage imageNamed:@"uncheck.png"]){
                [btn setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
                [firstString appendString:@" , Orolig"];
            }else{
                [btn setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
                //beteenden.text=@"";
            }
            
            break;

        case 22:
            if(btn.currentImage==[UIImage imageNamed:@"uncheck.png"]){
                [btn setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
                [firstString appendString:@"Avsmak"];
                NSLog(@"%@",firstString);
            }else{
                [btn setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
                
            }
            
            break;
        case 23:
            if(btn.currentImage==[UIImage imageNamed:@"uncheck.png"]){
                [btn setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
                [firstString appendString:@", Skamsen"];
                NSLog(@"%@",firstString);
            }else{
                [btn setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
            }
            
            break;
        case 24:
            if(btn.currentImage==[UIImage imageNamed:@"uncheck.png"]){
                [btn setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
                [firstString appendString:@" , Stolt"];
            }else{
                [btn setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
                // beteenden.text=@"";
            }
            
            break;
        case 25:
            if(btn.currentImage==[UIImage imageNamed:@"uncheck.png"]){
                [btn setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
                [firstString appendString:@" , Spänd"];
            }else{
                [btn setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
                //beteenden.text=@"";
            }
            
            break;
        case 26:
            if(btn.currentImage==[UIImage imageNamed:@"uncheck.png"]){
                [btn setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
                [firstString appendString:@", Osäker"];
            }else{
                [btn setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
                // beteenden.text=@"";
            }
            
            break;
        case 27:
            if(btn.currentImage==[UIImage imageNamed:@"uncheck.png"]){
                [btn setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
                [firstString appendString:@" , Euforisk"];
            }else{
                [btn setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
                //beteenden.text=@"";
            }
            
            break;
        case 28:
            if(btn.currentImage==[UIImage imageNamed:@"uncheck.png"]){
                [btn setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
                [firstString appendString:@" , Skärrad"];
            }else{
                [btn setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
                //beteenden.text=@"";
            }
            
            break;
        case 29:
            if(btn.currentImage==[UIImage imageNamed:@"uncheck.png"]){
                [btn setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
                [firstString appendString:@" , Förvånad"];
            }else{
                [btn setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
                //beteenden.text=@"";
            }
            
            break;
        case 30:
            if(btn.currentImage==[UIImage imageNamed:@"uncheck.png"]){
                [btn setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
                [firstString appendString:@" , Upprymd"];
            }else{
                [btn setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
                //beteenden.text=@"";
            }
            
            break;
        case 31:
            if(btn.currentImage==[UIImage imageNamed:@"uncheck.png"]){
                [btn setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
                [firstString appendString:@" , Vettskrämd"];
            }else{
                [btn setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
                //beteenden.text=@"";
            }
            
            break;
        case 32:
            if(btn.currentImage==[UIImage imageNamed:@"uncheck.png"]){
                [btn setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
                [firstString appendString:@" , Häpen"];
            }else{
                [btn setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
                //beteenden.text=@"";
            }
            
            break;case 33:
            if(btn.currentImage==[UIImage imageNamed:@"uncheck.png"]){
                [btn setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
                [firstString appendString:@" , Munter"];
            }else{
                [btn setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
                //beteenden.text=@"";
            }
            
            break;
        case 34:
            if(btn.currentImage==[UIImage imageNamed:@"uncheck.png"]){
                [btn setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
                [firstString appendString:@" , Uppskrämd"];
            }else{
                [btn setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
                //beteenden.text=@"";
            }
            
            break;
        case 35:
            if(btn.currentImage==[UIImage imageNamed:@"uncheck.png"]){
                [btn setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
                [firstString appendString:@" , Förbluffad"];
            }else{
                [btn setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
                //beteenden.text=@"";
            }
            
            break;
        case 36:
            if(btn.currentImage==[UIImage imageNamed:@"uncheck.png"]){
                [btn setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
                [firstString appendString:@" , Lättad"];
            }else{
                [btn setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
                //beteenden.text=@"";
            }
            
            break;
        case 37:
            if(btn.currentImage==[UIImage imageNamed:@"uncheck.png"]){
                [btn setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
                [firstString appendString:@" , Överraskad"];
            }else{
                [btn setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
                //beteenden.text=@"";
            }
            
            break;
        case 38:
            if(btn.currentImage==[UIImage imageNamed:@"uncheck.png"]){
                [btn setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
                [firstString appendString:@" , Ledsen"];
            }else{
                [btn setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
                //beteenden.text=@"";
            }
            
            break;
        case 39:
            if(btn.currentImage==[UIImage imageNamed:@"uncheck.png"]){
                [btn setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
                [firstString appendString:@" , Nedstämd"];
            }else{
                [btn setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
                //beteenden.text=@"";
            }
            
            break;
        case 40:
            if(btn.currentImage==[UIImage imageNamed:@"uncheck.png"]){
                [btn setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
                [firstString appendString:@" , Ilsken"];
            }else{
                [btn setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
                //beteenden.text=@"";
            }
            
            break;
        case 41:
            if(btn.currentImage==[UIImage imageNamed:@"uncheck.png"]){
                [btn setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
                [firstString appendString:@" , Uppretac"];
            }else{
                [btn setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
                //beteenden.text=@"";
            }
            
            break;
        case 42:
            if(btn.currentImage==[UIImage imageNamed:@"uncheck.png"]){
                [btn setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
                [firstString appendString:@" , Plågad"];
            }else{
                [btn setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
                //beteenden.text=@"";
            }
            
            break;

        case 43:
            if(btn.currentImage==[UIImage imageNamed:@"uncheck.png"]){
                [btn setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
                [firstString appendString:@" , Lidande"];
            }else{
                [btn setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
                //beteenden.text=@"";
            }
            
            break;
        case 44:
            if(btn.currentImage==[UIImage imageNamed:@"uncheck.png"]){
                [btn setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
                [firstString appendString:@" , Upprörd"];
            }else{
                [btn setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
                //beteenden.text=@"";
            }
            
            break;
        case 45:
            if(btn.currentImage==[UIImage imageNamed:@"uncheck.png"]){
                [btn setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
                [firstString appendString:@" , Irriterad"];
            }else{
                [btn setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
                //beteenden.text=@"";
            }
            
            break;
        case 46:
            if(btn.currentImage==[UIImage imageNamed:@"uncheck.png"]){
                [btn setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
                [firstString appendString:@" , Deprimerad"];
            }else{
                [btn setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
                //beteenden.text=@"";
            }
            
            break;
        case 47:
            if(btn.currentImage==[UIImage imageNamed:@"uncheck.png"]){
                [btn setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
                [firstString appendString:@" , Hatisk"];
            }else{
                [btn setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
                //beteenden.text=@"";
            }
            
            break;
        case 48:
            if(btn.currentImage==[UIImage imageNamed:@"uncheck.png"]){
                [btn setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
                [firstString appendString:@" , Rasande"];
            }else{
                [btn setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
                //beteenden.text=@"";
            }
            
            break;
        case 49:
            if(btn.currentImage==[UIImage imageNamed:@"uncheck.png"]){
                [btn setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
                [firstString appendString:@" , Prövad"];
            }else{
                [btn setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
                //beteenden.text=@"";
            }
            
            break;
        case 50:
            if(btn.currentImage==[UIImage imageNamed:@"uncheck.png"]){
                [btn setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
                [firstString appendString:@" , Vrede"];
            }else{
                [btn setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
                //beteenden.text=@"";
            }
            
            break;
        case 51:
            if(btn.currentImage==[UIImage imageNamed:@"uncheck.png"]){
                [btn setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
                [firstString appendString:@" , Ursining"];
            }else{
                [btn setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
                //beteenden.text=@"";
            }
            
            break;
        case 52:
            if(btn.currentImage==[UIImage imageNamed:@"uncheck.png"]){
                [btn setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
                [firstString appendString:@" , Arg"];
            }else{
                [btn setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
                //beteenden.text=@"";
            }
            
            break;
        
      
            
        default:
            break;
    }
 }
-(IBAction)Sparabutton:(id)sender{
    NSDate* date = [NSDate date];
    
    //Create the dateformatter object
    
    NSDateFormatter* formatter = [[[NSDateFormatter alloc] init] autorelease];
    
    //Set the required date format
    
    [formatter setDateFormat:@"dd-MM-yyyy HH:mm:ss"];
    
    //Get the string date
    
    NSString* str = [formatter stringFromDate:date];
    
    NSLog(@"date%@",str);
    
    if([negative.text isEqualToString:@""]){
       
        
    }else if([situation.text isEqualToString:@""]){
       
    }else if([beteenden.text isEqualToString:@""]){
      
    }else if([overiga.text isEqualToString:@""]){
       
    }else{
        NSLog(@"yes");
        sqlite3_stmt    *statement;
        
        const char *dbpath = [databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &exerciseDB) == SQLITE_OK)
        {
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
        }

    }
            

    
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
-(IBAction)retrivebutton:(id)sender{
   /* const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt    *statement;
    
    if (sqlite3_open(dbpath, &exerciseDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT negative FROM EXERCISEONE"
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
                    
                }
            } 
            sqlite3_finalize(statement);
        }
        sqlite3_close(exerciseDB);
    }
*/
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
    [self.navigationController pushViewController:eevc animated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
