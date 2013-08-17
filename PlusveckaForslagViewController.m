//
//  PlusveckaForslagViewController.m
//  Välkommen till TFH-appen
//
//  Created by Brilliance Tech Sols on 8/16/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import "PlusveckaForslagViewController.h"

@interface PlusveckaForslagViewController ()

@end
#define kSelected @"selected"
#define kName  @"name"
@implementation PlusveckaForslagViewController
@synthesize dataArray,table;
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
    self.navigationItem.title=@"Välj från förslag";
    
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
    // Do any additional setup after loading the view from its nib.
}

-(void)backButon {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    dataArray = [[NSMutableArray alloc]initWithObjects:[[NSMutableDictionary alloc]initWithObjectsAndKeys:@"Bada",kName,@"F",kSelected, nil],[[NSMutableDictionary alloc]initWithObjectsAndKeys:@"Aka tag",kName,@"F",kSelected, nil],[[NSMutableDictionary alloc]initWithObjectsAndKeys:@"Cykla",kName,@"F",kSelected, nil],[[NSMutableDictionary alloc]initWithObjectsAndKeys:@"Ga och handla",kName,@"F",kSelected, nil],[[NSMutableDictionary alloc]initWithObjectsAndKeys:@"Osv",kName,@"F",kSelected, nil],[[NSMutableDictionary alloc]initWithObjectsAndKeys:@"Osv",kName,@"F",kSelected, nil],[[NSMutableDictionary alloc]initWithObjectsAndKeys:@"Osv",kName,@"F",kSelected, nil],[[NSMutableDictionary alloc]initWithObjectsAndKeys:@"Osv",kName,@"F",kSelected, nil], nil];
    [super viewWillAppear:YES];
}

- (IBAction)submitButtonAction:(id)sender {
    BOOL isSelected=NO;
    for (NSDictionary *dict in dataArray) {
        if ([[dict valueForKey:kSelected] isEqualToString:@"T"]) {
            isSelected = YES;
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setValue:[dict valueForKey:kName] forKey:@"eventDes"];
            [defaults synchronize];
            break;
        }
    }
    if (isSelected) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30.0f;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifer = @"CellIdentifier";
    
    TidigeraCell *cell = (TidigeraCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifer];
    
    if (cell == nil) {
        NSArray *objects =[[NSBundle mainBundle] loadNibNamed:@"TidigeraCell" owner:self options:nil];
        
        for (id object in objects) {
            if ([object isKindOfClass:[TidigeraCell class]]) {
                
                cell = (TidigeraCell*)object;
            }
        }
    }
    cell.selectedBackgroundView = [[UIView alloc]init];
    cell.cellBtn.tag = indexPath.row;
    NSMutableDictionary *dict = [dataArray objectAtIndex:indexPath.row];
    if ([[dict valueForKey:kSelected] isEqualToString:@"T"]) {
        [cell.cellBtn setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
        //cell.cellBtn.backgroundColor = [UIColor blueColor];
    }
    else{
        [cell.cellBtn setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
        //cell.cellBtn.backgroundColor = [UIColor whiteColor];
    }
    [cell.cellBtn addTarget:self action:@selector(cellButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    cell.cellLabel.text = [dict valueForKey:kName];
    cell.cellLabel.highlightedTextColor = [UIColor darkGrayColor];
    return cell;
}




-(void)cellButtonClicked:(id)sender{
    for (int j=0; j<[dataArray count]; j++) {
        NSMutableDictionary *dict = [dataArray objectAtIndex:j];
        if (j==[sender tag]) {
            [dict setValue:@"T" forKey:kSelected];
        }else{
            [dict setValue:@"F" forKey:kSelected];
        }
    }
    [table reloadData];
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    for (int j=0; j<[dataArray count]; j++) {
        NSMutableDictionary *dict = [dataArray objectAtIndex:j];
        if (j==indexPath.row) {
            [dict setValue:@"T" forKey:kSelected];
        }else{
            [dict setValue:@"F" forKey:kSelected];
        }
    }
    [table reloadData];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
