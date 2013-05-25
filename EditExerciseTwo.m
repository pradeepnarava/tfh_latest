//
//  EditExerciseTwo.m
//  Välkommen till TFH-appen
//
//  Created by Mohammed Abdul Majeed on 5/1/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import "EditExerciseTwo.h"

@interface EditExerciseTwo ()

@end

@implementation EditExerciseTwo
@synthesize select_date,StagC2,StagC1,SelektC2,SelektC1,overC1,overC2,TankeC2,TankeC1,PerC1,PerC2,PliktC1,PliktC2,DiskC1,DiskC2,ForC1,ForC2,KanslC1,KanslC2,KataC1,KataC2,AllC1,AllC2,EtikeC1,EtikeC2;
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
    [super viewDidLoad];
    self.navigationItem.title=@"Tankefällor Exercise";
    NSLog(@"select_date%@",select_date);
    // Do any additional setup after loading the view from its nib.
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Dela"
                                                                    style:UIBarButtonItemStylePlain target:self action:@selector(sharebutton:)];
    self.navigationItem.rightBarButtonItem = rightButton;
    NSString *docsDir;
    NSArray *dirPaths;
    
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    
    // Build the path to the database file
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"exerciseDB.db"]];
    // const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt    *statement;
    if (sqlite3_open([databasePath UTF8String], &exerciseDB) == SQLITE_OK) {
        
        NSString *sql = [NSString stringWithFormat: @"SELECT * FROM EXERCISETWO WHERE date='%@'", select_date];
        
        const char *del_stmt = [sql UTF8String];
        
        sqlite3_prepare_v2(exerciseDB, del_stmt, -1, & statement, NULL);
        while (sqlite3_step(statement) == SQLITE_ROW) {
            
            char* c1 = (char*) sqlite3_column_text(statement,2);
           
            if (c1 != NULL){
                StagC1.text= [NSString stringWithUTF8String:c1];
                NSLog(@" StagC1.text :%@",StagC1.text);
                
            }
            char* c2 = (char*) sqlite3_column_text(statement,3);
            
            if (c2 != NULL){
                 StagC2.text = [NSString stringWithUTF8String:c2];
                NSLog(@" StagC2.text :%@", StagC2.text);
                
            }
            
            char* c3 = (char*) sqlite3_column_text(statement,4);
                       if (c3!= NULL){
                overC1.text= [NSString stringWithUTF8String:c3];
                NSLog(@"overC1.text :%@",overC1.text);
               
            }
            
            char* c4 = (char*) sqlite3_column_text(statement,5);
           
            if (c4 != NULL){
                overC2.text= [NSString stringWithUTF8String:c4];
                NSLog(@"overC2.text%@",overC2.text);
               
            }
            char* c5 = (char*) sqlite3_column_text(statement,6);
           
            if (c5 != NULL){
                TankeC1.text= [NSString stringWithUTF8String:c5];
                NSLog(@"value form db :%@", TankeC1.text);
                
            }
            char* c6 = (char*) sqlite3_column_text(statement,7);
         
            if (c6 != NULL){
                TankeC2.text= [NSString stringWithUTF8String:c6];
                NSLog(@"value form db :%@", TankeC2.text);
                
            }

            char* c7 = (char*) sqlite3_column_text(statement,8);
            
            if (c7 != NULL){
                PerC1.text= [NSString stringWithUTF8String:c7];
                NSLog(@"value form db :%@",PerC1.text);
                
            }
            char* c8 = (char*) sqlite3_column_text(statement,9);
           
            if (c4 != NULL){
                PerC2.text= [NSString stringWithUTF8String:c8];
                NSLog(@"value form db :%@",PerC2.text);
                
            }
            char* c9 = (char*) sqlite3_column_text(statement,10);
           
            if (c4 != NULL){
                DiskC1.text= [NSString stringWithUTF8String:c9];
                NSLog(@"value form db :%@",DiskC1.text);
                
            }
            char* c10 = (char*) sqlite3_column_text(statement,11);
           
            if (c10 != NULL){
                DiskC2.text= [NSString stringWithUTF8String:c10];
                NSLog(@"value form db :%@",DiskC2.text);
                
            }
        char* c11 = (char*) sqlite3_column_text(statement,12);
            
            if (c11 != NULL){
                ForC1.text= [NSString stringWithUTF8String:c11];
                NSLog(@"value form db :%@",ForC1.text);
                
            }
            char* c12 = (char*) sqlite3_column_text(statement,13);
                        if (c12 != NULL){
                ForC2.text= [NSString stringWithUTF8String:c12];
                NSLog(@" ForC2.text :%@", ForC2.text);
                
            }
            char* c13 = (char*) sqlite3_column_text(statement,14);
            
            if (c13 != NULL){
                KataC1.text= [NSString stringWithUTF8String:c13];
                NSLog(@"value form db :%@", KataC1.text);
                
            }
            char* c14 = (char*) sqlite3_column_text(statement,15);
           
            if (c14 != NULL){
                 KataC2.text= [NSString stringWithUTF8String:c14];
                NSLog(@"value form db :%@", KataC2.text);
                
            }
            char* c15 = (char*) sqlite3_column_text(statement,16);
         
            if (c15 != NULL){
                AllC1.text= [NSString stringWithUTF8String:c15];
                NSLog(@"value form db :%@",AllC1.text);
                
            }
            char* c16 = (char*) sqlite3_column_text(statement,17);
           
            if (c16 != NULL){
                AllC2.text= [NSString stringWithUTF8String:c16];
                NSLog(@"value form db :%@",AllC2.text);
                
            }
            char* c17 = (char*) sqlite3_column_text(statement,18);
            
            if (c17 != NULL){
                PliktC1.text= [NSString stringWithUTF8String:c17];
                NSLog(@"value form db :%@", PliktC1.text);
                
            }
            char* c18 = (char*) sqlite3_column_text(statement,19);
            
            if (c18 != NULL){
                 PliktC2.text= [NSString stringWithUTF8String:c18];
                NSLog(@"value form db :%@", PliktC2.text);
                
            }
            char* c19 = (char*) sqlite3_column_text(statement,20);
            
            if (c19 != NULL){
                SelektC1.text= [NSString stringWithUTF8String:c19];
                NSLog(@"value form db :%@",SelektC1.text);
                
            }char* c20 = (char*) sqlite3_column_text(statement,21);
            
            if (c20 != NULL){
                SelektC2.text= [NSString stringWithUTF8String:c20];
                NSLog(@"value form db :%@",SelektC2.text);
                
            }char* c21 = (char*) sqlite3_column_text(statement,22);
            
            if (c21!= NULL){
                KanslC1.text= [NSString stringWithUTF8String:c21];
                NSLog(@"value form db :%@",KanslC1.text);
                
            }
            char* c22 = (char*) sqlite3_column_text(statement,23);
          
            if (c22 != NULL){
                KanslC2.text= [NSString stringWithUTF8String:c22];
                NSLog(@"value form db :%@",KanslC2.text);
                
            }
            char* c23 = (char*) sqlite3_column_text(statement,24);
            
            if (c23 != NULL){
                EtikeC1.text= [NSString stringWithUTF8String:c23];
                NSLog(@"value form db :%@",EtikeC1.text);
                
            }
            char* c24 = (char*) sqlite3_column_text(statement,25);
            
            if (c24 != NULL){
                EtikeC2.text= [NSString stringWithUTF8String:c24];
                NSLog(@"value form db :%@",EtikeC2.text);
                
            }
        }
        
        sqlite3_finalize(statement);
        sqlite3_close(exerciseDB);
        
        
    }
    

    
}
-(IBAction)Upadebutton:(id)sender{
    
   // stagc1,stagc2,overc1,overc2,tankec1,tankec2,perc1,perc2,diskc1,diskc2,forc1,forc2,katac1,katac2,allc1,allc2,pliktc1,pliktc2,selektc1,selektc2,kanslc1,kanslc2,etikec1,etikec2
    NSLog(@"%@",StagC1.text);
    NSLog(@"%@",select_date);
   // NSString *xc=@"xxxxxxxx";
    sqlite3_stmt    *statement;
    if (sqlite3_open([databasePath UTF8String], &exerciseDB) == SQLITE_OK) {
        
        NSString *query=[NSString stringWithFormat:@"UPDATE EXERCISETWO SET stagc1='%@',stagc2='%@', overc1='%@', overc2='%@',tankec1='%@',tankec2='%@', perc1='%@', perc2='%@',diskc1='%@',diskc2='%@', forc1='%@', forc2='%@',katac1='%@',katac2='%@', allc1='%@', allc2='%@',pliktc1='%@',pliktc2='%@', selektc1='%@', selektc2='%@',kanslc1='%@',kanslc2='%@', etikec1='%@', etikec2='%@'  WHERE date='%@'",StagC1.text,StagC2.text, overC1.text,overC2.text,TankeC1.text,TankeC2.text,PerC1.text,PerC2.text,DiskC1.text,DiskC2.text,ForC1.text,ForC2.text,KataC1.text,KataC2.text,AllC1.text,AllC2.text,PliktC1.text,PliktC2.text,SelektC1.text,SelektC2.text,KanslC1.text,KanslC2.text,EtikeC1.text,EtikeC2.text, select_date];
        const char *del_stmt = [query UTF8String];
        
        if (sqlite3_prepare_v2(exerciseDB, del_stmt, -1, & statement, NULL)==SQLITE_OK);{
            if(SQLITE_DONE != sqlite3_step(statement))
                NSLog(@"Error while updating. %s", sqlite3_errmsg(exerciseDB));
                NSLog(@"sss");
                StagC1.text = @"";
                StagC2.text  = @"";
                overC1.text = @"";
                overC2.text=@"";
                TankeC1.text=@"";
                TankeC2.text=@"";
                PerC1.text=@"";
                PerC2.text=@"";
                DiskC1.text=@"";
                DiskC2.text=@"";
                ForC1.text=@"";
                ForC2.text=@"";
                KataC1.text=@"";
                KataC2.text=@"";
                AllC1.text=@"";
                AllC2.text=@"";
                PliktC1.text=@"";
                PliktC2.text=@"";
                SelektC1.text=@"";
                SelektC2.text=@"";
                KanslC1.text=@"";
                KanslC2.text=@"";
                EtikeC1.text=@"";
                EtikeC2.text=@"";
            
          
        }
        
        
        sqlite3_finalize(statement);
        sqlite3_close(exerciseDB);
        
        
    }

}
-(IBAction)Raderabutton:(id)sender{
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Alert message" message:@"Erasing the form or not?"
                                                 delegate:self
                                        cancelButtonTitle:@"Cancel"
                                        otherButtonTitles:@"Delete", nil];
    
    [alert show];
    [alert release];
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    
    if ([title isEqualToString:@"Delete"]) {
        NSLog(@"Delete.");
    
        sqlite3_stmt    *statement;
        if (sqlite3_open([databasePath UTF8String], &exerciseDB) == SQLITE_OK) {
            
            NSString *sql = [NSString stringWithFormat: @"DELETE FROM EXERCISETWO WHERE date='%@'", select_date];
            
            const char *del_stmt = [sql UTF8String];
            
            sqlite3_prepare_v2(exerciseDB, del_stmt, -1, & statement, NULL);
            if (sqlite3_step(statement) == SQLITE_ROW) {
                
                NSLog(@"sss");
            }
            
            sqlite3_finalize(statement);
            sqlite3_close(exerciseDB);
            
            
        }
        StagC1.text = @"";
        StagC2.text  = @"";
        overC1.text = @"";
        overC2.text=@"";
        TankeC1.text=@"";
        TankeC2.text=@"";
        PerC1.text=@"";
        PerC2.text=@"";
        DiskC1.text=@"";
        DiskC2.text=@"";
        ForC1.text=@"";
        ForC2.text=@"";
        KataC1.text=@"";
        KataC2.text=@"";
        AllC1.text=@"";
        AllC2.text=@"";
        PliktC1.text=@"";
        PliktC2.text=@"";
        SelektC1.text=@"";
        SelektC2.text=@"";
        KanslC1.text=@"";
        KanslC2.text=@"";
        EtikeC1.text=@"";
        EtikeC2.text=@"";
        
    }else if([title isEqualToString:@"Email"])
    {
        Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
        if (mailClass != nil)
        {
            // We must always check whether the current device is configured for sending emails
            if ([mailClass canSendMail])
            {
                [self displayComposerSheet];
            }
            else
            {
                [self launchMailAppOnDevice];
            }
        }
        else
        {
            [self launchMailAppOnDevice];
        }
    }
    else if([title isEqualToString:@"Bluetooth"])
    {
        NSLog(@"Button 2 was selected.");
    }
    else if([title isEqualToString:@"Print"])
    {
        NSLog(@"Button 3 was selected.");
    }

}
-(IBAction)sharebutton:(id)sender{
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Share"
                                                      message:@""
                                                     delegate:self
                                            cancelButtonTitle:@"Email"
                                            otherButtonTitles:nil];
    [message addButtonWithTitle:@"Bluetooth"];
    [message addButtonWithTitle:@"Print"];
    [message show];
    [message release];
   }
-(void)displayComposerSheet
{
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    picker.mailComposeDelegate = self;
    
    [picker setSubject:@"Hello from California!"];
    
    
    // Set up recipients
    NSArray *toRecipients = [NSArray arrayWithObject:@"prasanna.k539@gmail.com"];
    NSArray *ccRecipients = [NSArray arrayWithObjects:@"prasanna.nalam@gmail.com", nil];
    NSArray *bccRecipients = [NSArray arrayWithObject:@"avnypkumar@gmail.com"];
    
    [picker setToRecipients:toRecipients];
    [picker setCcRecipients:ccRecipients];
    [picker setBccRecipients:bccRecipients];
    
    // Attach an image to the email
    NSString *path = [[NSBundle mainBundle] pathForResource:@"rainy" ofType:@"png"];
    NSData *myData = [NSData dataWithContentsOfFile:path];
    [picker addAttachmentData:myData mimeType:@"image/png" fileName:@"rainy"];
    
    // Fill out the email body text
    NSString *emailBody = @"It is raining in sunny California!";
    [picker setMessageBody:emailBody isHTML:NO];
    
    [self presentModalViewController:picker animated:YES];
    [picker release];
}
// Dismisses the email composition interface when users tap Cancel or Send. Proceeds to update the message field with the result of the operation.
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    // message.hidden = NO;
    // Notifies users about errors associated with the interface
    switch (result)
    {
        case MFMailComposeResultCancelled:
            //    message.text = @"Result: canceled";
            break;
        case MFMailComposeResultSaved:
            //    message.text = @"Result: saved";
            break;
        case MFMailComposeResultSent:
            //   message.text = @"Result: sent";
            break;
        case MFMailComposeResultFailed:
            //   message.text = @"Result: failed";
            break;
        default:
            //   message.text = @"Result: not sent";
            break;
    }
    [self dismissModalViewControllerAnimated:YES];
}

// Launches the Mail application on the device.
-(void)launchMailAppOnDevice
{
    NSString *recipients = @"mailto:prasanna.k539@gmail.com?cc=prasanna.nalam@gmail.com&subject=Hello from California!";
    NSString *body = @"&body=It is raining in sunny California!";
    
    NSString *email = [NSString stringWithFormat:@"%@%@", recipients, body];
    email = [email stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:email]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
