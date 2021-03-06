//
//  Registreratankar.m
//  Välkommen till TFH-appen
//
//  Created by Mohammed Abdul Majeed on 4/29/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import "Registreratankar.h"
#import "MTPopupWindow.h"
#import <QuartzCore/QuartzCore.h>

int s=0;

#define kAlertViewOne 1
#define kAlertViewTwo 2

//NSMutableString *firstString;
@interface Registreratankar ()

@property (nonatomic) BOOL isSaved;

@end

@implementation Registreratankar
@synthesize flykt,tanke,tabellen,nat,exercise1_list;
@synthesize negative,situation,beteenden,overiga;
@synthesize listexercise1,tableView,isSaved;
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
    isSaved = YES;
    if([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        if (textView == overiga) {
            if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
                if ([[UIScreen mainScreen] bounds].size.height >  480 ) {
                    [UIView animateWithDuration:0.5
                                     animations:^{
                                         [scroll setContentOffset:CGPointMake(scroll.frame.origin.x, scroll.frame.origin.y + 500 ) animated:YES];
                                     }
                                     completion:^(BOOL finished){
                                         // whatever you need to do when animations are complete
                                         
                                     }];
                }
                else {
                    [UIView animateWithDuration:0.5
                                     animations:^{
                                         [scroll setContentOffset:CGPointMake(scroll.frame.origin.x, scroll.frame.origin.y + 590 ) animated:YES];
                                     }
                                     completion:^(BOOL finished){
                                         // whatever you need to do when animations are complete
                                         
                                     }];
                    
                }
            }else {
                [UIView animateWithDuration:0.5
                                 animations:^{
                                     [scroll2 setContentOffset:CGPointMake(scroll2.frame.origin.x, scroll2.frame.origin.y + 250) animated:YES];
                                 }
                                 completion:^(BOOL finished){
                                     // whatever you need to do when animations are complete
                                     
                                 }];
                
            }
        }
    }
    else {
        return YES;
    }
    return 0;
}


- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] != UIUserInterfaceIdiomPhone) {
        if (textView == overiga) {
            
            [UIView animateWithDuration:0.5
                             animations:^{
                                 [scroll2 setContentOffset:CGPointMake(scroll2.frame.origin.x, scroll2.frame.origin.y + 250) animated:YES];
                             }
                             completion:^(BOOL finished){
                                 // whatever you need to do when animations are complete
                                 
                             }];
        }
    }
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        if ([[UIScreen mainScreen] bounds].size.height >  480 ) {
            
            [UIView animateWithDuration:0.5
                             animations:^{
                                 
                                 [scroll setContentOffset:CGPointMake(scroll.frame.origin.x, textView.frame.origin.y - 30 ) animated:YES];
                                 //                         self.view.frame = CGRectMake(self.view.frame.origin.x, -170,self.view.frame.size.width,self.view.frame.size.height);
                             }
                             completion:^(BOOL finished){
                                 // whatever you need to do when animations are complete
                                 NSLog(@"Animation Finished");
                             }];
        }
        else {
            [UIView animateWithDuration:0.5
                             animations:^{
                                 
                                 [scroll setContentOffset:CGPointMake(scroll.frame.origin.x, textView.frame.origin.y - 40 ) animated:YES];
                             }
                             completion:^(BOOL finished){
                                 // whatever you need to do when animations are complete
                                 NSLog(@"Animation Finished");
                             }];

        }
    }else {
        if (textView == beteenden ) {
            NSLog(@"teview ipad");
            [UIView animateWithDuration:0.5
                             animations:^{
                                 
                                 [scroll2 setContentOffset:CGPointMake(scroll2.frame.origin.x, textView.frame.origin.y - 150) animated:YES];
                                 
                             }
                             completion:^(BOOL finished){
                                 
                                 NSLog(@"Animation Finished");
                             }];
            
        }
    }
    
    return YES;
}



- (void)viewDidLoad
{
    self.navigationItem.title=@"Registrera tankar";
    
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {

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
    
    kanslor.allstrings=[[NSString alloc]init];
    exercise1_list=[[NSMutableArray alloc]init];
    [exercise1_list addObject:@"Null"];
    raderabutton.enabled=NO;
    _skickaButton.enabled = NO;
    
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
        
        
        [self getTop1Date];

        
    } else {
        NSLog(@"Failed to open/create database");
    }
    
    
    [self.view addSubview:listofdates];

    listofdates.hidden=YES;
    PopupView1.hidden=YES;
    PopupView2.hidden=YES;
    PopupView3.hidden=YES;
    scroll.scrollEnabled = YES;
    
    [scroll setContentSize:CGSizeMake(320, 1006)];
    
    scroll2.scrollEnabled = YES;
    [scroll2 setContentSize:CGSizeMake(768, 1211)];
    
    
    [super viewDidLoad];
    
}


-(void)backButon {
    
    [self.navigationController popViewControllerAnimated:YES];
}



-(IBAction)mainlabelalert:(id)sender{
     [MTPopupWindow showWindowWithHTMLFile:@"Registreratankar.html" insideView:self.view];
}

-(IBAction)natalert:(id)sender{
  
    
   // [self.view bringSubviewToFront:PopupView2];
    PopupView2.hidden = NO;
   // [UIView beginAnimations:@"curlInView" context:nil];
   // [UIView setAnimationDuration:1.0];
   // [UIView commitAnimations];
}

-(void)tabellenalert:(id)sender{
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        if ([[UIScreen mainScreen] bounds].size.height > 480) {
            kanslor=[[KanslorViewController alloc]initWithNibName:@"KanslorViewController" bundle:nil];
        }else{
            kanslor=[[KanslorViewController alloc]initWithNibName:@"KanslorViewController_iPhone4" bundle:nil];
        }
        
    }
    else{
        kanslor=[[KanslorViewController alloc]initWithNibName:@"KanslorViewController_iPad" bundle:nil];
    }
    
    if([beteenden.text isEqualToString:@""]){
        NSLog(@"%@",beteenden.text);
    }else{
        kanslor.selectedstrings=[[NSString alloc]init];
        kanslor.selectedstrings = beteenden.text;
        NSLog(@"%@",kanslor.selectedstrings);
    }
    
    
    [self. navigationController pushViewController:kanslor animated:YES];
    
}


-(IBAction)tankealert:(id)sender{
    
   
    //[self.view bringSubviewToFront:PopupView1];
    PopupView1.hidden = NO;
    //[UIView beginAnimations:@"curlInView" context:nil];
    //[UIView setAnimationDuration:1.0];
   // [UIView commitAnimations];
}
-(IBAction)flyktalert:(id)sender{
    
   // [self.view bringSubviewToFront:PopupView4];
    PopupView3.hidden = NO;
    //[UIView beginAnimations:@"curlInView" context:nil];
    //[UIView setAnimationDuration:1.0];
    //[UIView commipl;tAnimations];
}

-(void)viewWillAppear:(BOOL)animated {
    
    if(kanslor.allstrings== nil){
        
    }else{
        NSLog(@"%@",kanslor.allstrings);
        beteenden.text=kanslor.allstrings;
    }
    [super viewWillAppear:animated];
    //isSaved = YES;
}



-(IBAction)Sparabutton:(id)sender {
    NSDate* date = [NSDate date];
    
    //Create the dateformatter object
    
    NSDateFormatter* formatter = [[[NSDateFormatter alloc] init] autorelease];
    
    //Set the required date format
    
    [formatter setDateFormat:@"MMM d YYYY HH:mm:ss"];
    
    //Get the string date
    
    NSString* str = [formatter stringFromDate:date];
    
    NSLog(@"date%@",str);
    
    raderabutton.enabled=NO;
    _skickaButton.enabled = NO;
    
    if([negative.text isEqualToString:@""] &&[situation.text isEqualToString:@""] &&[beteenden.text isEqualToString:@""] && [overiga.text isEqualToString:@""]) {
        
        NSLog(@"Empty");
        
    }
    else{
        NSLog(@"yes");
        
        const char *dbpath = [databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &exerciseDB) == SQLITE_OK)
        {
            //activating buttons
            raderabutton.enabled=YES;
            _skickaButton.enabled = YES;

            
            //NSLog(@"%@",[listexercise1 objectAtIndex:s] );
            if([[exercise1_list objectAtIndex:0] isEqualToString:@"Null"]){
                NSString *insertSQL = [NSString stringWithFormat: @"INSERT INTO EXERCISEONE (date,negative,situation,beteenden,overiga) VALUES (\"%@\", \"%@\", \"%@\" ,\"%@\",\"%@\")", str, negative.text,situation.text, beteenden.text , overiga.text];
                
                const char *insert_stmt = [insertSQL UTF8String];
                
                sqlite3_prepare_v2(exerciseDB, insert_stmt, -1, &statement, NULL);
                if (sqlite3_step(statement) == SQLITE_DONE)
                {
                    
                    //situation.text = @"";
                    //negative.text = @"";
                    //overiga.text = @"";
                    //beteenden.text=@"";
                    isSaved = NO;
                    
                } else {
                    NSLog(@"no");
                }
                sqlite3_finalize(statement);
                sqlite3_close(exerciseDB);
            }
            else{
                
                //activating buttons
                raderabutton.enabled=YES;
                _skickaButton.enabled = YES;

                
                NSLog(@"Updated");
                NSString *query=[NSString stringWithFormat:@"UPDATE EXERCISEONE SET negative='%@', situation='%@' , beteenden='%@', overiga='%@' WHERE date='%@' ",negative.text,situation.text, beteenden.text,overiga.text, [listexercise1 objectAtIndex:s]];
                const char *del_stmt = [query UTF8String];
                
                if (sqlite3_prepare_v2(exerciseDB, del_stmt, -1, & statement, NULL)==SQLITE_OK){
                    if(SQLITE_DONE != sqlite3_step(statement))
                        NSLog(@"Error while updating. %s", sqlite3_errmsg(exerciseDB));
                    NSLog(@"sss");
                  /*  situation.text = @"";
                    negative.text = @"";
                    overiga.text = @"";
                    beteenden.text=@"";
                    [listexercise1 removeAllObjects];
                    s=0;
                    [listexercise1 addObject:@"Null"];*/
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


-(IBAction)nyttbutton:(id)sender{
    
    if([situation.text isEqualToString:@""] && [negative.text isEqualToString:@""] && [overiga.text isEqualToString:@""] && [beteenden.text isEqualToString:@""]){
   
    }else{
        if (isSaved == YES) {
            alert=[[UIAlertView alloc] initWithTitle:nil message:@"Vill du ta bort all text som du skrivit ner i övningen?"
                                            delegate:self
                                   cancelButtonTitle:@"Forsätt"
                                   otherButtonTitles:@"Avbryt", nil];
            alert.tag=kAlertViewOne;
            [alert show];
            [alert release];
        }
        else {
            situation.text = @"";
            negative.text = @"";
            overiga.text = @"";
            beteenden.text=@"";
            raderabutton.enabled=NO;
            _skickaButton.enabled = NO;
            [exercise1_list removeAllObjects];
            s=0;
            [exercise1_list addObject:@"Null"];
            //isSaved = YES;
        }
    }
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

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
     NSLog(@"ok");
    if(alert.tag  == kAlertViewOne) {
        if (buttonIndex == 0) {
            NSLog(@"new form");
            situation.text = @"";
            negative.text = @"";
            overiga.text = @"";
            beteenden.text=@"";
            raderabutton.enabled=NO;
            _skickaButton.enabled = NO;
            [exercise1_list removeAllObjects];
            s=0;
            [exercise1_list addObject:@"Null"];
            //isSaved = YES;
        }else{
            //isSaved = YES;
        }
    } else if(alert.tag == kAlertViewTwo) {
        if (buttonIndex == 0) {
            
            if (sqlite3_open([databasePath UTF8String], &exerciseDB) == SQLITE_OK) {
                
                NSString *sql = [NSString stringWithFormat: @"DELETE FROM EXERCISEONE WHERE date='%@'", [listexercise1 objectAtIndex:s]];
                
                const char *del_stmt = [sql UTF8String];
                
                sqlite3_prepare_v2(exerciseDB, del_stmt, -1, & statement, NULL);
                if (sqlite3_step(statement) == SQLITE_ROW) {
                    
                    NSLog(@"sss");
                    
                }
                raderabutton.enabled=NO;
                _skickaButton.enabled = NO;
                situation.text = @"";
                negative.text = @"";
                overiga.text = @"";
                beteenden.text=@"";
                [exercise1_list removeAllObjects];
                s=0;
                [exercise1_list addObject:@"Null"];
                sqlite3_finalize(statement);
                sqlite3_close(exerciseDB);
                
                
            }
            //[listexercise1 removeAllObjects];
            // [self getlistofDates];
            
            [self.tableView reloadData];
            
            UIAlertView * alert1 = [[UIAlertView alloc] initWithTitle:nil message:@"Raderat" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok",nil];
            [alert1 show];
            [alert1 release];
        }
        else {
            
        }
    }
}


-(IBAction)Editbutton:(id)sender{
    scroll.scrollEnabled = NO;
    listexercise1 =[[NSMutableArray alloc]init];
    [listexercise1 removeAllObjects];
    [self.view bringSubviewToFront:listofdates];
    listofdates.hidden = NO;
    [UIView beginAnimations:@"curlInView" context:nil];
    [UIView setAnimationDuration:1.0];
    [UIView commitAnimations];
    [self getlistofDates];
        //[self.navigationController pushViewController:eevc animated:YES];
}



-(void)getTop1Date {
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &exerciseDB) == SQLITE_OK)
    {
//        NSString *querySQL = [NSString stringWithFormat:@""];
        
        NSString *sql = [NSString stringWithFormat: @"SELECT * FROM EXERCISEONE WHERE date=(SELECT date FROM EXERCISEONE  ORDER BY date DESC LIMIT 1)"];
        
//        [exercise1_list removeAllObjects];
//        [exercise1_list addObject:SelectedDate];
        
        const char *del_stmt = [sql UTF8String];
        
        sqlite3_prepare_v2(exerciseDB, del_stmt, -1, & statement, NULL);
        while (sqlite3_step(statement) == SQLITE_ROW) {
            
//            [self setIsSaved:YES];
            
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
    
    listofdates.hidden = YES;
    scroll.scrollEnabled = YES;
    PopupView1.hidden=YES;
    PopupView3.hidden=YES;
    PopupView2.hidden=YES;
    isSaved = NO;
    NSLog(@"value of s%@",[listexercise1 objectAtIndex:s]);
}


-(void)getlistofDates {
    
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &exerciseDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:@"SELECT date FROM EXERCISEONE  ORDER BY date DESC"];
        
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
           
            sqlite3_finalize(statement);
        }
        sqlite3_close(exerciseDB);
    }
    if (listexercise1.count==0) {
        listofdates.hidden = YES;
        scroll.scrollEnabled=YES;
    }
    [self.tableView reloadData];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.listexercise1 count];
}

// This will tell your UITableView what data to put in which cells in your table.
- (UITableViewCell *)tableView:(UITableView *)tableView1 cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifer = @"CellIdentifier";
    
    cell = [tableView1 dequeueReusableCellWithIdentifier:CellIdentifer];
    
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
    raderabutton.enabled=YES;
    _skickaButton.enabled = YES;
    [exercise1_list removeAllObjects];
    [exercise1_list addObject:SelectedDate];
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
    
    listofdates.hidden = YES;
    scroll.scrollEnabled = YES;
    PopupView1.hidden=YES;
    PopupView3.hidden=YES;
    PopupView2.hidden=YES;
    isSaved = NO;
    NSLog(@"value of s%@",[listexercise1 objectAtIndex:s]);
}
-(IBAction)aMethod:(id)sender{
    
    alert=[[UIAlertView alloc] initWithTitle:nil message:@"Är du säker på att du vill radera formuläret?" delegate:self cancelButtonTitle:@"Radera" otherButtonTitles:@"Avbryt", nil];
    alert.tag=kAlertViewTwo;
    [alert show];
    [alert release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)Closelistofdates:(id)sender{
    if ([sender tag] == 0) {
        PopupView1.hidden=YES;
    }
    else if ([sender tag] == 1) {
        PopupView2.hidden=YES;
    }
    else if ([sender tag] == 2) {
        PopupView3.hidden=YES;
    }
    listofdates.hidden = YES;
      scroll.scrollEnabled = YES;
    
    NSLog(@"value of s%@",[listexercise1 objectAtIndex:s]);
}
- (void)dealloc {
    [_skickaButton release];
    [super dealloc];
}
@end
