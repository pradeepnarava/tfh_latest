//
//  ExerciseOneEditController.m
//  Välkommen till TFH-appen
//
//  Created by Mohammed Abdul Majeed on 4/30/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import "ExerciseOneEditController.h"

@interface ExerciseOneEditController ()

@end

@implementation ExerciseOneEditController
@synthesize selectedate,situation,overiga,negative,beteenden;
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
    self.navigationItem.title=@"Edit Form";
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Dela"
                                                                   style:UIBarButtonItemStylePlain target:self action:@selector(shareButton:)];
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
        
        NSString *sql = [NSString stringWithFormat: @"SELECT * FROM EXERCISEONE WHERE date='%@'", selectedate];
        
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


    // Do any additional setup after loading the view from its nib.
}


-(IBAction)shareButton:(id)sender{
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
    sqlite3_stmt    *statement;
    if (sqlite3_open([databasePath UTF8String], &exerciseDB) == SQLITE_OK) {
        NSString *query=[NSString stringWithFormat:@"UPDATE EXERCISEONE SET negative='%@', situation='%@' , beteenden='%@', overiga='%@' WHERE date='%@' ",negative.text,situation.text, beteenden.text,overiga.text, selectedate];
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
                
                NSString *sql = [NSString stringWithFormat: @"DELETE FROM EXERCISEONE WHERE date='%@'", selectedate];
                
                const char *del_stmt = [sql UTF8String];
                
                sqlite3_prepare_v2(exerciseDB, del_stmt, -1, & statement, NULL);
                if (sqlite3_step(statement) == SQLITE_ROW) {
                    
                    NSLog(@"sss");
                }
                
                sqlite3_finalize(statement);
                sqlite3_close(exerciseDB);
                
                
            }
            negative.text=@"";
            situation.text=@"";
            beteenden.text=@"";
            overiga.text=@"";

        }else  if([title isEqualToString:@"Email"])
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
-(void)displayComposerSheet
{
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    picker.mailComposeDelegate = self;
    
    [picker setSubject:@"Hello from California!"];
    
    
    // Set up recipients
    NSArray *toRecipients = [NSArray arrayWithObject:@"prasanna.nalam@gamil.com"];
    NSArray *ccRecipients = [NSArray arrayWithObjects:@"prasanna.k539@gmail.com",nil];
    NSArray *bccRecipients = [NSArray arrayWithObject:@"avnypkumar@gmail.com"];
    
    
    [picker setToRecipients:toRecipients];
    [picker setCcRecipients:ccRecipients];
    [picker setBccRecipients:bccRecipients];
    
    // Attach an image to the email
    NSString *path = [[NSBundle mainBundle] pathForResource:@"rainy" ofType:@"jpeg"];
    NSData *myData = [NSData dataWithContentsOfFile:path];
    [picker addAttachmentData:myData mimeType:@"popup.jpeg" fileName:@"rainy"];
    
    // Fill out the email body text
    NSString *emailBody = @"It is raining in sunny California!";
    [picker setMessageBody:emailBody isHTML:NO];
    
    [self presentModalViewController:picker animated:YES];
    [picker release];
}
// Dismisses the email composition interface when users tap Cancel or Send. Proceeds to update the message field with the result of the operation.
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
   
    // Notifies users about errors associated with the interface
    switch (result)
    {
        case MFMailComposeResultCancelled:
           // message.text = @"Result: canceled";
            break;
        case MFMailComposeResultSaved:
          //  message.text = @"Result: saved";
            break;
        case MFMailComposeResultSent:
         //   message.text = @"Result: sent";
            break;
        case MFMailComposeResultFailed:
          //  message.text = @"Result: failed";
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
    NSString *recipients = @"mailto:prasanna.nalam@gamil.com?cc=prasanna.k539@gmail.com,avnypkumar@gmail.com&subject=Hello from California!";
    NSString *body = @"&body=It is raining in sunny California!";
    
    NSString *email = [NSString stringWithFormat:@"%@%@", recipients, body];
    email = [email stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:email]];
}

-(void)dealloc{
    [selectedate release];
    [super dealloc];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
