//
//  Plusvecka.m
//  Välkommen till TFH-appen
//
//  Created by Mohammed Abdul Majeed on 5/3/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import "Plusvecka.h"
#import "MTPopupWindow.h"


@interface Plusvecka ()

@end

@implementation Plusvecka
@synthesize selectController;
@synthesize dinaveckarController,weekArray;
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
    self.navigationItem.title=@"Plusvecka";
    
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
    [super viewDidLoad];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [self week:[NSDate date]];
    [super viewWillAppear:YES];
}


-(void)backButon {
    [self.navigationController popViewControllerAnimated:YES];
}


-(IBAction)Ilabel:(id)sender{
       [MTPopupWindow showWindowWithHTMLFile:@"Plusvecka.html" insideView:self.view];
}

- (IBAction)PlaneraAction:(id)sender {
    NSString *startDate = [self dateFromString:[self.weekArray objectAtIndex:0]];
    NSString *endDate = [self dateFromString:[self.weekArray objectAtIndex:6]];
    NSString *currentDate = [self dateFromString:[NSDate date]];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setValue:startDate forKey:@"startDate"];
    [dict setValue:endDate forKey:@"endDate"];
    [dict setValue:currentDate forKey:@"currentDate"];
//    [self databaseInsertWeek:dict];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        if ([[UIScreen mainScreen] bounds].size.height > 480) {
           // if (!selectController) {
                selectController = [[SelectRegistreringsveckaViewController alloc]initWithNibName:@"SelectRegistreringsveckaViewController" bundle:nil];
           // }
        }else{
           // if (!selectController) {
                selectController = [[SelectRegistreringsveckaViewController alloc]initWithNibName:@"SelectRegistreringsveckaViewController_iPhone4" bundle:nil];
           // }
        }
    }
    else{
       // if (!selectController) {
            selectController = [[SelectRegistreringsveckaViewController alloc]initWithNibName:@"SelectRegistreringsveckaViewController_iPad" bundle:nil];
       // }
    }
    
    [self.navigationController pushViewController:selectController animated:YES];
}

- (IBAction)DinaVeckorAction:(id)sender {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        if ([[UIScreen mainScreen] bounds].size.height > 480) {
            //if (!dinaveckarController) {
                dinaveckarController = [[PlusveckaDinaveckar alloc]initWithNibName:@"PlusveckaDinaveckar" bundle:nil];
            //}
        }else{
            //if (!dinaveckarController) {
                dinaveckarController = [[PlusveckaDinaveckar alloc]initWithNibName:@"PlusveckaDinaveckar_iPhone4" bundle:nil];
            //}
        }
    }
    else{
        //if (!dinaveckarController) {
            dinaveckarController = [[PlusveckaDinaveckar alloc]initWithNibName:@"PlusveckaDinaveckar_iPad" bundle:nil];
        //}
    }
    
    [self.navigationController pushViewController:dinaveckarController animated:YES];
}

- (void)week:(NSDate *)_date {
    self.weekArray = [[NSMutableArray alloc] init];
    
    for (int i =1; i <= 7; i++)
    {
        NSDateComponents *comps1 = [[NSDateComponents alloc] init];
        [comps1 setMonth:0];
        [comps1 setDay:+i];
        [comps1 setHour:0];
        NSCalendar *calendar1 = [NSCalendar currentCalendar];
        NSDate *newDate1 = [calendar1 dateByAddingComponents:comps1 toDate:[NSDate date] options:0];
        [self.weekArray addObject:newDate1];
    }
}



-(NSString*)dateFromString:(NSDate*)date {
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}






- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
