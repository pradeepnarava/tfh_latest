//
//  RegistreringDinaveckarViewController.m
//  Välkommen till TFH-appen
//
//  Created by Chandrika on 22/07/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import "RegistreringDinaveckarViewController.h"
#import "RegiDinaveckarCalendarViewController.h"
#import "DataBaseHelper.h"
#import "Events.h"
#import "NewRegistrering.h"

#define kStartDate @"startDate"
#define kEndDate   @"endDate"
#define kStatus    @"status"
#define kDayTime   @"dayTime"
#define kEventDes  @"eventDes"
#define kSub1Id    @"Sub1Id"

#define kSelected @"selected"
#define kCurrentDate  @"currentDate"
#define kId    @"id"

@interface RegistreringDinaveckarViewController ()

@end


@implementation RegistreringDinaveckarViewController
@synthesize dataArray,table;
@synthesize regiDinaCalVC;


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
    
    self.navigationItem.title=@"Dina veckor";
    
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

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (!self.dataArray) {
         self.dataArray = [[NSMutableArray alloc]init];
    }
   
    [self getData];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    
}

- (void)viewDidDisappear:(BOOL)animated {
    self.dataArray = nil;
}

-(void)dealloc {
    [dataArray release];
    [super dealloc];
}


-(void)backButon {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/////////////////////////////Gopalakrishna******??????????????

-(void)getData {
    dataArray = [[[DataBaseHelper sharedDatasource] getnewRegisVecka] mutableCopy];
    [table reloadData];
}

- (IBAction)submitButtonAction:(id)sender {
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NewRegistrering *selectedDict = [[NewRegistrering alloc] init];
    for (int k=0; k<[dataArray count]; k++) {
        NewRegistrering *dict = [dataArray objectAtIndex:k];
        if ([dict.uncheck isEqualToString:@"YES"]) {
            selectedDict = dict;
            break;
        }
    }
    BOOL isExist = NO;
    for (int p=0; p<[dataArray count]; p++) {
        NewRegistrering *dict = [dataArray objectAtIndex:p];
        if (dict!=selectedDict&&[[formatter stringFromDate:[self dateFromString:dict.startDate]] isEqualToString:[formatter stringFromDate:[self dateFromString:selectedDict.startDate]]]&&[[formatter stringFromDate:[self dateFromString:dict.endDate]] isEqualToString:[formatter stringFromDate:[self dateFromString:dict.endDate]]]) {
            isExist = YES;
        }
    }
    [dataArray removeObject:selectedDict];
    /*if (!isExist) {
     for (int m=0; m<[sub2EventsArray count]; m++) {
     NSString *dayTime = [[sub2EventsArray objectAtIndex:m]valueForKey:kDayTime];
     NSArray *array = [dayTime componentsSeparatedByString:@" "];
     NSString *dateString = [array objectAtIndex:0];
     NSDate *date = [formatter dateFromString:dateString];
     if ([date compare:[selectedDict valueForKey:kStartDate]]==NSOrderedSame||[date compare:[selectedDict valueForKey:kEndDate]]==NSOrderedSame||([date compare:[selectedDict valueForKey:kStartDate]]==NSOrderedDescending && [date compare:[selectedDict valueForKey:kEndDate]]==NSOrderedAscending) ) {
     [self deleteRecord:[sub2EventsArray objectAtIndex:m]];
     }
     }
     }*/
    [table reloadData];
}



-(NSDate*)dateFromString:(NSString*)date {
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *dateString = [dateFormatter dateFromString:date];
    return dateString;
}

-(NSString*)yearStringFromDate:(NSDate*)date{
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormatter setDateFormat:@"yyyy"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}

-(NSString*)monthStringFromDate:(NSDate*)date{
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormatter setDateFormat:@"d/M"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}


#pragma mark UITableViewDatasource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifer = @"CellIdentifier";
    
    DinaveckarCell *cell = (DinaveckarCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifer];
    
    if (cell == nil) {
        NSArray *objects =[[NSBundle mainBundle] loadNibNamed:@"DinaveckarCell" owner:self options:nil];
        for (id object in objects) {
            if ([object isKindOfClass:[DinaveckarCell class]]) {
                cell = (DinaveckarCell*)object;
            }
        }
    }
    
    //cell.selectedBackgroundView = [[UIView alloc]init];
    cell.cellBtn.tag = indexPath.row;
    NewRegistrering *newReg = [dataArray objectAtIndex:indexPath.row];
    if ([newReg.uncheck isEqualToString:@"YES"]) {
        [cell.cellBtn setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
    }
    else{
        [cell.cellBtn setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
    }
    
    [cell.cellBtn addTarget:self action:@selector(cellButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    NSString *yearLabel1 = [self yearStringFromDate:[self dateFromString:newReg.startDate]];
    NSString *yearLabel2 = [self yearStringFromDate:[self dateFromString:newReg.endDate]];
    if([yearLabel1 isEqualToString:yearLabel2]){
        cell.cellLabel.text = [NSString stringWithFormat:@"%@ - %@ (%@)",[self monthStringFromDate:[self dateFromString:newReg.startDate]],[self monthStringFromDate:[self dateFromString:newReg.endDate]],yearLabel1];
    }else{
        cell.cellLabel.text = [NSString stringWithFormat:@"%@ (%@) - %@ (%@)",[self monthStringFromDate:[self dateFromString:newReg.startDate]],yearLabel1,[self monthStringFromDate:[self dateFromString:newReg.endDate]],yearLabel2];
    }
    cell.cellLabel.highlightedTextColor = [UIColor grayColor];
    
    return cell;
}

#pragma mark UITableViewDelegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        if ([[UIScreen mainScreen] bounds].size.height > 480) {
            if (!regiDinaCalVC) {
                regiDinaCalVC = [[RegiDinaveckarCalendarViewController alloc]initWithNibName:@"RegiDinaveckarCalendarView" bundle:nil];
            }
        }else{
            if (!regiDinaCalVC) {
                regiDinaCalVC = [[RegiDinaveckarCalendarViewController alloc]initWithNibName:@"RegiDinaveckarCalendarView_iPhone4" bundle:nil];
            }
        }
    }
    else{
        if (!regiDinaCalVC) {
            regiDinaCalVC = [[RegiDinaveckarCalendarViewController alloc]initWithNibName:@"RegiDinaveckarCalendarView_iPad" bundle:nil];
        }
    }
    
    regiDinaCalVC.registreringObj = [dataArray objectAtIndex:indexPath.row];
    
    [self.navigationController pushViewController:regiDinaCalVC animated:YES];
}


-(void)cellButtonClicked:(id)sender {
    for (int j=0; j<[dataArray count]; j++) {
        NewRegistrering *dict = [dataArray objectAtIndex:j];
        if (j==[sender tag]) {
            dict.uncheck = @"YES";
        }else{
            dict.uncheck = @"NO";
        }
    }
    [table reloadData];
}





@end
