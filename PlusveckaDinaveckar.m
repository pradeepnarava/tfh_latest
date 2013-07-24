//
//  PlusveckaDinaveckar.m
//  Välkommen till TFH-appen
//
//  Created by Brilliance Tech Sols on 7/19/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import "PlusveckaDinaveckar.h"

@interface PlusveckaDinaveckar ()

@end

@implementation PlusveckaDinaveckar
@synthesize table;
@synthesize dataArray;
@synthesize calanderView;
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
    
    NSMutableDictionary *dict1 = [[NSMutableDictionary alloc]init];
    [dict1 setValue:@"4/3 - 10/3 (2013)" forKey:@"week"];
    [dict1 setValue:@"F" forKey:@"selected"];
    NSMutableDictionary *dict2 = [[NSMutableDictionary alloc]init];
    [dict2 setValue:@"4/3 - 10/3 (2013)" forKey:@"week"];
    [dict2 setValue:@"F" forKey:@"selected"];
    NSMutableDictionary *dict3 = [[NSMutableDictionary alloc]init];
    [dict3 setValue:@"4/3 - 10/3 (2013)" forKey:@"week"];
    [dict3 setValue:@"F" forKey:@"selected"];
    dataArray = [[NSMutableArray alloc]initWithObjects:dict1,dict2,dict3, nil];
    // Do any additional setup after loading the view from its nib.
}

-(void)backButon {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)submitButtonAction:(id)sender {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        if ([[UIScreen mainScreen] bounds].size.height > 480) {
            if (!calanderView) {
                calanderView = [[PlusveckaDinaveckarView alloc]initWithNibName:@"PlusveckaDinaveckarView" bundle:nil];
            }
        }else{
            if (!calanderView) {
                calanderView = [[PlusveckaDinaveckarView alloc]initWithNibName:@"PlusveckaDinaveckarView_iPhone4" bundle:nil];
            }
        }
    }
    else{
        if (!calanderView) {
            calanderView = [[PlusveckaDinaveckarView alloc]initWithNibName:@"PlusveckaDinaveckarView_iPad" bundle:nil];
        }
    }
    
    [self.navigationController pushViewController:calanderView animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
    cell.cellBtn.tag = indexPath.row;
    NSMutableDictionary *dict = [dataArray objectAtIndex:indexPath.row];
    if ([[dict valueForKey:@"selected"] isEqualToString:@"T"]) {
        cell.cellBtn.backgroundColor = [UIColor blueColor];
    }
    else{
        cell.cellBtn.backgroundColor = [UIColor whiteColor];
    }
    
    [cell.cellBtn addTarget:self action:@selector(cellButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    cell.cellLabel.text = [dict valueForKey:@"week"];
    return cell;
}

-(void)cellButtonClicked:(id)sender{
    for (int j=0; j<[dataArray count]; j++) {
        NSMutableDictionary *dict = [dataArray objectAtIndex:j];
        if (j==[sender tag]) {
          [dict setValue:@"T" forKey:@"selected"];  
        }else{
           [dict setValue:@"F" forKey:@"selected"]; 
        }
    }
    [table reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        if ([[UIScreen mainScreen] bounds].size.height > 480) {
            if (!calanderView) {
                calanderView = [[PlusveckaCalenderViewController alloc]initWithNibName:@"PlusveckaCalenderView" bundle:nil];
            }
        }else{
            if (!calanderView) {
                calanderView = [[PlusveckaCalenderViewController alloc]initWithNibName:@"PlusveckaCalenderView_iPhone4" bundle:nil];
            }
        }
    }
    else{
        if (!calanderView) {
            calanderView = [[PlusveckaCalenderViewController alloc]initWithNibName:@"PlusveckaCalenderView_iPad" bundle:nil];
        }
    }
    
    [self.navigationController pushViewController:calanderView animated:YES];*/
}

@end
