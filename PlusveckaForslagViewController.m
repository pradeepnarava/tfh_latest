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
@synthesize dataArray,table,HeadingsArray;
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
    
    HeadingsArray = [[NSMutableArray alloc] initWithObjects:@"Träning och motion:",@"Hälsa, skönhet och hemmafix",@"Nöje och umgänge",@"Avkoppling",nil];
    
    dataArray = [[NSMutableArray alloc]initWithObjects:
                 [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"Ta en powerwalk",kName,@"F",kSelected, nil],
                 [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"Klättra på klättervägg",kName,@"F",kSelected, nil],
                 [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"Gå på ett träningspass på gymmet som du tycker verkar spännande",kName,@"F",kSelected, nil],
                 [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"Träna på ett utomhusgym",kName,@"F",kSelected, nil],
                 [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"Ta en cykeltur",kName,@"F",kSelected, nil],
                 [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"Jogga en runda (med musik eller podcast kanske?)",kName,@"F",kSelected, nil],
                 [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"Spela fotboll",kName,@"F",kSelected, nil],
                 [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"Gå ut och träna frisparkar på fotbollsplanen",kName,@"F",kSelected, nil],
                 [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"Träna en träningsform du gillar (ex jogga, simma, styrketräna)",kName,@"F",kSelected, nil],
                 [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"Simma ett träningspass",kName,@"F",kSelected, nil],
                 [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"Om det är snö ute, åk pulka",kName,@"F",kSelected, nil],
                 [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"Åk skridskor",kName,@"F",kSelected, nil],
                 //-----------------------------------------------
                 [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"Sola",kName,@"F",kSelected, nil],
                 [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"Fönstershoppa",kName,@"F",kSelected, nil],
                 [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"Fixa ett litet hemma-SPA (gör ett fotbad, måla naglarna, ta en ansiktsmask o.s.v.)",kName,@"F",kSelected, nil],
                 [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"Bjud dig själv på massage",kName,@"F",kSelected, nil],
                 [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"Gå på en behandling (ansiktsbehandling, manikyr o.s.v.)",kName,@"F",kSelected, nil],
                 [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"Så frön av växter du gillar att äta",kName,@"F",kSelected, nil],
                 [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"Tvätta bilen",kName,@"F",kSelected, nil],
                 [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"Ordna dina papper i en pärm",kName,@"F",kSelected, nil],
                 [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"Städa (med din favoritmusik?)",kName,@"F",kSelected, nil],
                 [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"Ta ledigt från jobbet för att fixa i hemmet",kName,@"F",kSelected, nil],
                 [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"Gå och handla mat för en maträtt du tycker om",kName,@"F",kSelected, nil],
                 [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"Laga en maträtt som du verkligen tycker om",kName,@"F",kSelected, nil],
                 [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"Testa ett nytt matrecept",kName,@"F",kSelected, nil],
                 [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"Lyssna på en bra skiva och diska undan disken",kName,@"F",kSelected, nil],
                 [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"Planera en fest",kName,@"F",kSelected, nil],
                 [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"Köp vackra blommor och plantera i kruka, på balkongen eller i trädgården",kName,@"F",kSelected, nil],
                 [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"Gör en smarrig efterrätt till maten",kName,@"F",kSelected, nil],
                 //-----------------------------------------------
                 [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"Ring en vän som du tycker om att prata med",kName,@"F",kSelected, nil],
                 [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"Ha sex med din partner",kName,@"F",kSelected, nil],
                 [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"Bjud en av dina närmaste vänner på ﬁka",kName,@"F",kSelected, nil],
                 [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"Ha en picknic i en mysig park",kName,@"F",kSelected, nil],
                 [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"Gå på teater",kName,@"F",kSelected, nil],
                 [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"Åk på en fisketur med några vänner",kName,@"F",kSelected, nil],
                 [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"Flörta med någon du gillar",kName,@"F",kSelected, nil],
                 [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"Gå på en klubb eller bar med en vän",kName,@"F",kSelected, nil],
                 [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"Åk på utﬂykt med en vän",kName,@"F",kSelected, nil],
                 [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"Gå på en fest där du känner dig bekväm",kName,@"F",kSelected, nil],
                 [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"Bjud över vän/vänner på middag",kName,@"F",kSelected, nil],
                 [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"Gå på stand up-klubb",kName,@"F",kSelected, nil],
                 [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"Gå på bio ensam eller med en vän",kName,@"F",kSelected, nil],
                 [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"Planera en resa du skulle vilja göra",kName,@"F",kSelected, nil],
                 [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"Gå och kolla på fotboll hos en vän",kName,@"F",kSelected, nil],
                 [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"Gå och kolla på film hos en vän",kName,@"F",kSelected, nil],
                 //--------------------------------------------------
                 [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"Ladda ner eller hyr en bra film som du vill se",kName,@"F",kSelected, nil],
                 [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"Ta en promenad",kName,@"F",kSelected, nil],
                 [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"Rama in foton",kName,@"F",kSelected, nil],
                 [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"Låna en bok på Biblioteket",kName,@"F",kSelected, nil],
                 [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"Lös korsord   ",kName,@"F",kSelected, nil],
                 [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"Gå på ett mysigt eller intressant museum",kName,@"F",kSelected, nil],
                 [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"Skriv några dikter",kName,@"F",kSelected, nil],
                 [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"Ta ett långt, varmt bad (kanske med en bra bok eller en rolig tidning?)",kName,@"F",kSelected, nil],
                 [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"Lös suduko",kName,@"F",kSelected, nil],
                 [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"Skriv brev till någon som betyder mycket för dig",kName,@"F",kSelected, nil],
                 [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"Gå på en föreläsning om något ämne som du är intresserad av",kName,@"F",kSelected, nil],
                 [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"Gå på ett tillfälle av en kvällskurs i något ämne du själv tycker om",kName,@"F",kSelected, nil],
                 [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"Lägg dig i sängen och lyssna på podcast/radio",kName,@"F",kSelected, nil],
                 [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"Spela tv-spel/datorspel",kName,@"F",kSelected, nil],
                 [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"Titta på en bra tv-serie ",kName,@"F",kSelected, nil],
                 nil];
    
    [super viewWillAppear:YES];
}

- (IBAction)submitButtonAction:(id)sender {
    NSMutableString *string = [[NSMutableString alloc]init];
    NSMutableArray *array = [[NSMutableArray alloc]init];
    BOOL isSelected=NO;
    for (NSDictionary *dict in dataArray) {
        if ([[dict valueForKey:kSelected] isEqualToString:@"T"]) {
            isSelected = YES;
            [array addObject:dict];
        }
    }
    if (isSelected) {
        for (int p=0; p<[array count]; p++) {
            NSDictionary *dict = [array objectAtIndex:p];
            if (p==[array count]-1) {
                [string appendFormat:@"%@",[dict valueForKey:kName]];
            }else{
                [string appendFormat:@"%@,",[dict valueForKey:kName]];
            }
        }
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setValue:string forKey:@"eventDes"];
        [defaults synchronize];
        [self.navigationController popViewControllerAnimated:YES];
        //[self.view setHidden:YES];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return HeadingsArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 12;
    }
    else if (section == 1) {
        return 17;
    }
    else if (section == 2) {
        return 16;
    }
    else if (section == 3) {
        return 15;
    }
    return [dataArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30.0f;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [HeadingsArray objectAtIndex:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifer = @"CellIdentifier";
    
    TidigeraCell *cell = (TidigeraCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifer];
    int offset = 0;
    if (indexPath.section == 0) {
        offset = 0;
    }
    else if (indexPath.section == 1) {
        offset = 12;
    }
    else if ( indexPath.section == 2) {
        offset = 12+17;
    }
    else if (indexPath.section == 3) {
        offset = 12+17+16;
    }
    
    if (cell == nil) {
        NSArray *objects =[[NSBundle mainBundle] loadNibNamed:@"TidigeraCell" owner:self options:nil];
        
        for (id object in objects) {
            if ([object isKindOfClass:[TidigeraCell class]]) {
                
                cell = (TidigeraCell*)object;
            }
        }
    }
    cell.selectedBackgroundView = [[UIView alloc]init];
    cell.cellBtn.tag = indexPath.row+offset;
    NSMutableDictionary *dict = [dataArray objectAtIndex:indexPath.row+offset];
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

    NSMutableDictionary *dict = [dataArray objectAtIndex:[sender tag]];
    if ([[dict valueForKey:kSelected]isEqualToString:@"T"]) {
        [dict setValue:@"F" forKey:kSelected];
    }
    else {
        [dict setValue:@"T" forKey:kSelected];
    }
    
    
    //this is bad coding
    
//    for (int j=0; j<[dataArray count]; j++) {
//        NSMutableDictionary *dict = [dataArray objectAtIndex:j];
//        if (j==[sender tag]) {
//            if ([[dict valueForKey:kSelected] isEqualToString:@"T"]) {
//                [dict setValue:@"F" forKey:kSelected];
//            }else{
//                [dict setValue:@"T" forKey:kSelected];
//            }
//        }
//    }
    
    
    
    
    [table reloadData];
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    int offset = 0;
    if (indexPath.section == 0) {
        offset = 0;
    }
    else if (indexPath.section == 1) {
        offset = 12;
    }
    else if ( indexPath.section == 2) {
        offset = 12+17;
    }
    else if (indexPath.section == 3) {
        offset = 12+17+16;
    }
    
    for (int j=0; j<[dataArray count]; j++) {
        NSMutableDictionary *dict = [dataArray objectAtIndex:j];
        if (j==indexPath.row+offset) {
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
