//
//  EditUtmana.m
//  Välkommen till TFH-appen
//
//  Created by Mohammed Abdul Majeed on 5/2/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import "EditUtmana.h"

@interface EditUtmana ()

@end

@implementation EditUtmana
@synthesize datefrome3,c1,c2,c3,c4,c5,c6;
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
    self.navigationItem.title=@"Exercise-3";
    NSLog(@"datefrome3%@",datefrome3);
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Dela"
                                                                    style:UIBarButtonItemStylePlain target:self action:@selector(shareb:)];
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
        
        NSString *sql = [NSString stringWithFormat: @"SELECT * FROM EXERCISE3 WHERE date='%@'", datefrome3];
        
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
    

    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
-(IBAction)shareb:(id)sender{
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
-(IBAction)updatebutton:(id)sender{
  //  (date,negative,dina,hur,motbevis,tankefalla,alternativ)
    NSLog(@"%@",datefrome3);
  
    sqlite3_stmt    *statement;
    if (sqlite3_open([databasePath UTF8String], &exerciseDB) == SQLITE_OK) {
        /*NSString *query=[NSString stringWithFormat:@"UPDATE EXERCISE3 SET  negative=%@,dina=%@, hur=%@, motbevis=%@, tankefalla=%@,alternativ=%@ WHERE date=%@",c1.text,c2.text, c3.text,c4.text, c5.text,c6.text,datefrome3];*/
        NSString *query=[NSString stringWithFormat:@"UPDATE EXERCISE3 SET  negative='%@',dina='%@', hur='%@', motbevis='%@', tankefalla='%@',alternativ='%@' WHERE date='%@'",c1.text,c2.text, c3.text,c4.text, c5.text,c6.text,datefrome3];
        
        
        const char *del_stmt = [query UTF8String];
        
        if (sqlite3_prepare_v2(exerciseDB, del_stmt, -1, & statement, NULL)==SQLITE_OK){
            if(SQLITE_DONE != sqlite3_step(statement))
                NSLog(@"Error while updating. %s", sqlite3_errmsg(exerciseDB));
            NSLog(@"sss");
        }
        
        
        
        sqlite3_finalize(statement);
        sqlite3_close(exerciseDB);
        
        
    }

}
-(IBAction)deletebutton:(id)sender{
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
            
            NSString *sql = [NSString stringWithFormat: @"DELETE FROM EXERCISE3 WHERE date='%@'", datefrome3];
            
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
-(IBAction)chSlider:(id)sender {
    
    NSString *str= [[NSString alloc] initWithFormat:@"%d%@", (int)slider.value,@"%"];
    self.c3.text=str;
    NSLog(@"%@",str);
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
-(void)dealloc{
    [super dealloc];
    
}

@end
