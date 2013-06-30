//
//  TankefallorViewController.m
//  Välkommen till TFH-appen
//
//  Created by Mohammed Abdul Majeed on 4/30/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import "TankefallorViewController.h"
#import "MTPopupWindow.h"
#import <QuartzCore/QuartzCore.h>


#define kAlertViewOne 1
#define kAlertViewTwo 2


@interface TankefallorViewController ()

@property (nonatomic) BOOL isSaved,isExit;

@end

@implementation TankefallorViewController
@synthesize alltTV1,alltTV2,attTV1,attTV2,overTV1,overTV2,diskTV1,diskTV2,etikTV1,etikTV2;
@synthesize mansTV1,mansTV2,mentTV1,mentTV2,forTV1,forTV2,tankTV1,tankTV2,persTV1,persTV2;
@synthesize kataTV1,kataTV2;
@synthesize isSaved,isExit;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


#pragma mark -- TextViewDelegate Methods

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    isSaved = YES;
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        if (textView == mansTV2) {
            if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
                if ([[UIScreen mainScreen] bounds].size.height >  480 ) {
        [UIView animateWithDuration:0.5
                         animations:^{
                            [scroll setContentOffset:CGPointMake(scroll.frame.origin.x, scroll.frame.origin.y + 3525) animated:YES];
                         }
                         completion:^(BOOL finished){
                             // whatever you need to do when animations are complete
                             
                         }];
                }
                else {
                    [UIView animateWithDuration:0.5
                                     animations:^{
                                         [scroll setContentOffset:CGPointMake(scroll.frame.origin.x, scroll.frame.origin.y + 3610) animated:YES];
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
                         
                     }];
    
    return YES;
}


#pragma mark ViewLifeCycle Methods

- (void)viewDidLoad
{
    
    self.navigationItem.title=@"Tankefällor";
    
  
    scroll.scrollEnabled = YES;
    
    [scroll setContentSize:CGSizeMake(320, 4029)];
    scroll1.scrollEnabled = YES;
    
    [scroll1 setContentSize:CGSizeMake(320, 4418)];
   
    // Get the documents directory
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *docsDir = [dirPaths objectAtIndex:0];
    
   databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent:@"tankefallorDB.db"]];
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    if ([filemgr fileExistsAtPath: databasePath ] == NO)
    {
		const char *dbpath = [databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &tankefallorDB) == SQLITE_OK)
        {
            char *errMsg;
            
           const char *sql_stmt = "CREATE TABLE IF NOT EXISTS EXERCISETWO (ID INTEGER PRIMARY KEY AUTOINCREMENT,DATE TEXT,ALLC1 TEXT,ALLC2 TEXT,KATAC1 TEXT,KATAC2 TEXT,DISKC1 TEXT,DISKC2 TEXT,ATTC1 TEXT,ATTC2 TEXT,ETIKC1 TEXT,ETIKC2 TEXT, FORC1 TEXT,FORC2 TEXT,MENTC1 TEXT, MENTC2 TEXT,TANKC1 TEXT,TANKC2 TEXT,OVERC1 TEXT,OVERC2 TEXT,PERSC1 TEXT,PERSC2 TEXT,MANSC1 TEXT,MANSC2 TEXT)";
            
            if (sqlite3_exec(tankefallorDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
            {
                NSLog(@"Failed to create table");
            }
            
            sqlite3_close(tankefallorDB);
            
        } else {
            NSLog(@"Failed to open or create database");
        }
    }else {
        [self getDetailsFromtankefallorDB];
    }
    
    [filemgr release];
   
    [super viewDidLoad];
}



-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];


}



-(IBAction)mainlabelalert:(id)sender{
    [MTPopupWindow showWindowWithHTMLFile:@"Tankefallor.html" insideView:self.view];
}

- (IBAction)skickaButtonClicked:(id)sender
{
    UIActionSheet *cameraActionSheet = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Download", @"Email", nil];
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
            [htmlMsg appendString:[NSString stringWithFormat:@"Please find the attached form on %@", [NSDate date]]];
            [htmlMsg appendString:@": </p></body></html>"];
            
            NSData *jpegData = UIImageJPEGRepresentation([self getFormImage], 1);
            
            NSString *fileName = [NSString stringWithString:[NSDate date]];
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


-(IBAction)Sparabutton:(id)sender {
    
    NSDate* date = [NSDate date];
    
    //Create the dateformatter object
    
    NSDateFormatter* formatter = [[[NSDateFormatter alloc] init] autorelease];
    
    //Set the required date format
    
    [formatter setDateFormat:@"MMM d YYYY HH:mm:ss"];
    
    //Get the string date
    
    NSString* str = [formatter stringFromDate:date];
    
    NSLog(@"date%@",str);
    
    sqlite3_stmt    *statement;
    
    const char *dbpath = [databasePath UTF8String];
    
    if([alltTV1.text isEqualToString:@""] && [alltTV2.text isEqualToString:@""] && [kataTV1.text isEqualToString:@""] && [kataTV2.text isEqualToString:@""]&& [diskTV1.text isEqualToString:@""] && [diskTV2.text isEqualToString:@""] && [attTV1.text isEqualToString:@""] && [attTV2.text isEqualToString:@""] && [etikTV1.text isEqualToString:@""] && [etikTV2.text isEqualToString:@""]&& [forTV1.text isEqualToString:@""] && [forTV2.text isEqualToString:@""] && [tankTV1.text isEqualToString:@""] && [mentTV1.text isEqualToString:@""] && [mentTV2.text isEqualToString:@""] && [tankTV2.text isEqualToString:@""] && [overTV1.text isEqualToString:@""] && [overTV2.text isEqualToString:@""]&& [persTV1.text isEqualToString:@""] && [persTV2.text isEqualToString:@""] && [mansTV1.text isEqualToString:@""] && [mansTV2.text isEqualToString:@""] ){
        
    }
    else if (sqlite3_open(dbpath, &tankefallorDB) == SQLITE_OK) {
        
        if (isExit == NO) {
            
            NSString *insertSQL = [NSString stringWithFormat: @"INSERT INTO EXERCISETWO (date,allc1,allc2,katac1,katac2,diskc1,diskc2,attc1,attc2,etikc1,etikc2,forc1,forc2,mentc1,mentc2,tankc1,tankc2,overc1,overc2,persc1,persc2,mansc1,mansc2) VALUES (\"%@\", \"%@\", \"%@\" ,\"%@\",\"%@\", \"%@\", \"%@\" ,\"%@\",\"%@\", \"%@\", \"%@\" ,\"%@\",\"%@\", \"%@\", \"%@\" ,\"%@\",\"%@\", \"%@\", \"%@\" ,\"%@\",\"%@\", \"%@\", \"%@\")", str, alltTV1.text,alltTV2.text,kataTV1.text,kataTV2.text,diskTV1.text,diskTV2.text,attTV1.text,attTV2.text,etikTV1.text,etikTV2.text,forTV1.text,forTV2.text,mentTV1.text,mentTV2.text,tankTV1.text,tankTV2.text,overTV1.text,overTV2.text,persTV1.text,persTV2.text,mansTV1.text,mansTV2.text];
            
            const char *insert_stmt = [insertSQL UTF8String];
            
            sqlite3_prepare_v2(tankefallorDB, insert_stmt, -1, &statement, NULL);
           
            if (sqlite3_step(statement) == SQLITE_DONE)
            {
                isExit = YES;
                isSaved = NO;
                NSLog(@"Save");
            }
            else {
                NSLog(@"Failed to add tankefallor");
            }
            sqlite3_finalize(statement);
            sqlite3_close(tankefallorDB);
        }
        else {
            NSString *query=[NSString stringWithFormat:@"UPDATE EXERCISETWO SET allc1='%@',allc2='%@',katac1='%@',katac2='%@',diskc1='%@',diskc2='%@',attc1='%@',attc2='%@',etikc1='%@',etikc2='%@',forc1='%@',forc2='%@',mentc1='%@',mentc2='%@',tankc1='%@',tankc2='%@',overc1='%@',overc2='%@',persc1='%@',persc2='%@',mansc1='%@',mansc2='%@'",alltTV1.text,alltTV2.text, kataTV1.text,kataTV2.text,diskTV1.text,diskTV2.text,attTV1.text,attTV2.text,etikTV1.text,etikTV2.text,forTV1.text,forTV2.text,mentTV1.text,mentTV2.text,tankTV1.text,tankTV2.text,overTV1.text,overTV2.text,persTV1.text,persTV2.text,mansTV1.text,mansTV2.text];
            
            const char *del_stmt = [query UTF8String];
            
            if (sqlite3_prepare_v2(tankefallorDB, del_stmt, -1, & statement, NULL)==SQLITE_OK);{
                if(SQLITE_DONE != sqlite3_step(statement))
                    NSLog(@"Error while updating. %s", sqlite3_errmsg(tankefallorDB));
                NSLog(@"sss");
                isSaved = NO;
                isExit = YES;
            
            }
        
            sqlite3_finalize(statement);
            sqlite3_close(tankefallorDB);
        }
        UIAlertView * alert1 = [[UIAlertView alloc] initWithTitle:nil message:@"Sparat" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok",nil];
        [alert1 show];
        [alert1 release];
    }
}
  
-(IBAction)Nyttbutton:(id)sender  {
    
    if([alltTV1.text isEqualToString:@""] && [alltTV2.text isEqualToString:@""] && [kataTV1.text isEqualToString:@""] && [kataTV2.text isEqualToString:@""]&& [diskTV1.text isEqualToString:@""] && [diskTV2.text isEqualToString:@""] && [attTV1.text isEqualToString:@""] && [attTV2.text isEqualToString:@""] && [etikTV1.text isEqualToString:@""] && [etikTV2.text isEqualToString:@""]&& [forTV1.text isEqualToString:@""] && [forTV2.text isEqualToString:@""] && [tankTV1.text isEqualToString:@""] && [tankTV2.text isEqualToString:@""] && [overTV1.text isEqualToString:@""] && [overTV2.text isEqualToString:@""]&& [persTV1.text isEqualToString:@""] && [persTV2.text isEqualToString:@""] && [mansTV1.text isEqualToString:@""] && [mansTV2.text isEqualToString:@""] && [mentTV1.text isEqualToString:@""] && [mentTV2.text isEqualToString:@""]){
        
    }else {
        if (isSaved == YES) {
            
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:@"Vill du ta bort all text som du skrivit ner i övningen?"
                                            delegate:self
                                   cancelButtonTitle:@"Forsätt"
                                   otherButtonTitles:@"Avbryt", nil];
            alert.tag=kAlertViewOne;
            [alert show];
            [alert release];
        }
        else {
            [self clearalltexts];
            sqlite3_stmt    *statement;
            
            const char *dbpath = [databasePath UTF8String];
            
            if (sqlite3_open(dbpath, &tankefallorDB) == SQLITE_OK) {
                
                NSString *query=[NSString stringWithFormat:@"UPDATE EXERCISETWO SET allc1='%@',allc2='%@',katac1='%@',katac2='%@',diskc1='%@',diskc2='%@',attc1='%@',attc2='%@',etikc1='%@',etikc2='%@',forc1='%@',forc2='%@',mentc1='%@',mentc2='%@',tankc1='%@',tankc2='%@',overc1='%@',overc2='%@',persc1='%@',persc2='%@',mansc1='%@',mansc2='%@'",alltTV1.text,alltTV2.text, kataTV1.text,kataTV2.text,diskTV1.text,diskTV2.text,attTV1.text,attTV2.text,etikTV1.text,etikTV2.text,forTV1.text,forTV2.text,mentTV1.text,mentTV2.text,tankTV1.text,tankTV2.text,overTV1.text,overTV2.text,persTV1.text,persTV2.text,mansTV1.text,mansTV2.text];
                
                const char *del_stmt = [query UTF8String];
                
                if (sqlite3_prepare_v2(tankefallorDB, del_stmt, -1, & statement, NULL)==SQLITE_OK);{
                    if(SQLITE_DONE != sqlite3_step(statement))
                        NSLog(@"Error while updating. %s", sqlite3_errmsg(tankefallorDB));
                    NSLog(@"sss");
                    
                }
                sqlite3_finalize(statement);
                sqlite3_close(tankefallorDB);
            }
        }
    }
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == kAlertViewOne) {
        if (buttonIndex == 0) {
            [self clearalltexts];
        }
    }
}

-(void)getDetailsFromtankefallorDB {
    
    const char *dbpath = [databasePath UTF8String];
    
    sqlite3_stmt    *statement;
    
    if (sqlite3_open(dbpath, &tankefallorDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat: @"SELECT * FROM EXERCISETWO ORDER BY date DESC"];
        
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(tankefallorDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            
            while  (sqlite3_step(statement) == SQLITE_ROW) {
                
                char* c1 = (char*) sqlite3_column_text(statement,2);
                
                if (c1 != NULL){
                    alltTV1.text= [NSString stringWithUTF8String:c1];
                    NSLog(@" StagC1.text :%@",alltTV1.text);
                    
                }
                char* c2 = (char*) sqlite3_column_text(statement,3);
                
                if (c2 != NULL){
                    alltTV2.text = [NSString stringWithUTF8String:c2];
                    NSLog(@" StagC2.text :%@", alltTV2.text);
                    
                }
                
                char* c3 = (char*) sqlite3_column_text(statement,4);
                if (c3!= NULL){
                    kataTV1.text= [NSString stringWithUTF8String:c3];
                    NSLog(@"overC1.text :%@",kataTV1.text);
                    
                }
                
                char* c4 = (char*) sqlite3_column_text(statement,5);
                
                if (c4 != NULL){
                    kataTV2.text= [NSString stringWithUTF8String:c4];
                    NSLog(@"overC2.text%@",kataTV2.text);
                    
                }
                char* c5 = (char*) sqlite3_column_text(statement,6);
                
                if (c5 != NULL){
                    diskTV1.text= [NSString stringWithUTF8String:c5];
                    NSLog(@"value form db :%@", diskTV1.text);
                    
                }
                char* c6 = (char*) sqlite3_column_text(statement,7);
                
                if (c6 != NULL){
                    diskTV2.text= [NSString stringWithUTF8String:c6];
                    NSLog(@"value form db :%@", diskTV2.text);
                    
                }
                
                char* c7 = (char*) sqlite3_column_text(statement,8);
                
                if (c7 != NULL){
                    attTV1.text= [NSString stringWithUTF8String:c7];
                    NSLog(@"value form db :%@",attTV1.text);
                    
                }
                char* c8 = (char*) sqlite3_column_text(statement,9);
                
                if (c4 != NULL){
                    attTV2.text= [NSString stringWithUTF8String:c8];
                    NSLog(@"value form db :%@",attTV2.text);
                    
                }
                char* c9 = (char*) sqlite3_column_text(statement,10);
                
                if (c4 != NULL){
                    etikTV1.text= [NSString stringWithUTF8String:c9];
                    NSLog(@"value form db :%@",etikTV2.text);
                    
                }
                char* c10 = (char*) sqlite3_column_text(statement,11);
                
                if (c10 != NULL){
                    etikTV2.text= [NSString stringWithUTF8String:c10];
                    NSLog(@"value form db :%@",etikTV2.text);
                    
                }
                char* c11 = (char*) sqlite3_column_text(statement,12);
                
                if (c11 != NULL){
                    forTV1.text= [NSString stringWithUTF8String:c11];
                    NSLog(@"value form db :%@",forTV1.text);
                    
                }
                char* c12 = (char*) sqlite3_column_text(statement,13);
                if (c12 != NULL){
                    forTV2.text= [NSString stringWithUTF8String:c12];
                    NSLog(@" ForC2.text :%@", forTV2.text);
                    
                }
                char* c13 = (char*) sqlite3_column_text(statement,14);
                
                if (c13 != NULL){
                    mentTV1.text= [NSString stringWithUTF8String:c13];
                    NSLog(@"value form db :%@", mentTV1.text);
                    
                }
                char* c14 = (char*) sqlite3_column_text(statement,15);
                
                if (c14 != NULL){
                    mentTV2.text= [NSString stringWithUTF8String:c14];
                    NSLog(@"value form db :%@", mentTV2.text);
                    
                }
                char* c15 = (char*) sqlite3_column_text(statement,16);
                
                if (c15 != NULL){
                    tankTV1.text= [NSString stringWithUTF8String:c15];
                    NSLog(@"value form db :%@",tankTV1.text);
                    
                }
                char* c16 = (char*) sqlite3_column_text(statement,17);
                
                if (c16 != NULL){
                    tankTV2.text= [NSString stringWithUTF8String:c16];
                    NSLog(@"value form db :%@",tankTV2.text);
                    
                }
                char* c17 = (char*) sqlite3_column_text(statement,18);
                
                if (c17 != NULL){
                    overTV1.text= [NSString stringWithUTF8String:c17];
                    NSLog(@"value form db :%@", overTV1.text);
                    
                }
                char* c18 = (char*) sqlite3_column_text(statement,19);
                
                if (c18 != NULL){
                    overTV2.text= [NSString stringWithUTF8String:c18];
                    NSLog(@"value form db :%@", overTV2.text);
                    
                }
                char* c19 = (char*) sqlite3_column_text(statement,20);
                
                if (c19 != NULL){
                    persTV1.text= [NSString stringWithUTF8String:c19];
                    NSLog(@"value form db :%@",persTV1.text);
                    
                }char* c20 = (char*) sqlite3_column_text(statement,21);
                
                if (c20 != NULL){
                    persTV2.text= [NSString stringWithUTF8String:c20];
                    NSLog(@"value form db :%@",persTV2.text);
                    
                }char* c21 = (char*) sqlite3_column_text(statement,22);
                
                if (c21!= NULL){
                    mansTV1.text= [NSString stringWithUTF8String:c21];
                    NSLog(@"value form db :%@",mansTV1.text);
                    
                }
                char* c22 = (char*) sqlite3_column_text(statement,23);
                
                if (c22 != NULL){
                    mansTV2.text= [NSString stringWithUTF8String:c22];
                    NSLog(@"value form db :%@",mansTV2.text);
                    
                }
                isExit = YES;
            }
        }
        sqlite3_finalize(statement);
    }
    sqlite3_close(tankefallorDB);
}


-(IBAction)nextbutton:(id)sender{
    
    scroll.scrollEnabled = NO;
    
}


-(void)clearalltexts{
    alltTV1.text = @"";
    alltTV2.text  = @"";
    kataTV1.text = @"";
    kataTV2.text=@"";
    diskTV1.text=@"";
    diskTV2.text=@"";
    attTV1.text=@"";
    attTV2.text=@"";
    etikTV1.text=@"";
    etikTV2.text=@"";
    forTV1.text=@"";
    forTV2.text=@"";
    mentTV1.text=@"";
    mentTV2.text=@"";
    tankTV1.text=@"";
    tankTV2.text=@"";
    overTV1.text=@"";
    overTV2.text=@"";
    persTV1.text=@"";
    persTV2.text=@"";
    mansTV1.text=@"";
    mansTV2.text=@"";
  
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