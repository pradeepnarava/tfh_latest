//
//  Interoceptiv exponering.m
//  Välkommen till TFH-appen
//
//  Created by Mohammed Abdul Majeed on 5/6/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import "Interoceptiv exponering.h"

@interface Interoceptiv_exponering ()

@end

@implementation Interoceptiv_exponering

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
     noOfSection = 2;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        
        return YES;
    }
    
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}
#pragma mark - TableView Delegate Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return noOfSection;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 2){
        return 200;
    }
    return  50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
        UISwitch *switchBtn = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 20, 10)];
        cell.accessoryView = switchBtn;
        
        [switchBtn addTarget:self action:@selector(switchStateChanged:) forControlEvents:UIControlEventValueChanged];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:11];
        cell.textLabel.numberOfLines = 2;
        cell.detailTextLabel.numberOfLines = 2;
    }
    
    
    
    if(indexPath.section == 0){
        cell.textLabel.text = @"Cell-1 Text";
        cell.detailTextLabel.text = @"Cell-1 Detail text";
    }
    else if(indexPath.section == 1){
        cell.textLabel.text = @"Cell-2 Text";
    }
    else { // new added section code is here...
        cell.textLabel.text = @"New Added section";
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}
-(IBAction)switchStateChanged:(id)sender{
    UISwitch *switchState = sender;
    
    if(switchState.isOn == YES){
        NSLog(@"ON");
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:2];
        [self insertNewSectionWithIndexPath:indexPath];
    }
    else {
        NSLog(@"OFF");
        [self removeSectionWithIndexPath:[NSIndexPath indexPathForRow:0 inSection:2]];
    }
}
-(void)insertNewSectionWithIndexPath:(NSIndexPath *)indexPath{
    
    
    noOfSection = 3;
    [tblView insertSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationFade];
}
-(void)removeSectionWithIndexPath:(NSIndexPath *)indexPath{
    noOfSection = 2;
    [tblView deleteSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationFade];
}
@end