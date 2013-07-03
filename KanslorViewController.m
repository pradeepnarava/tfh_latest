//
//  KanslorViewController.m
//  Välkommen till TFH-appen
//
//  Created by Brilliance Tech Sols on 5/30/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import "KanslorViewController.h"

@interface KanslorViewController ()

@property (nonatomic, readonly) NSArray *buttonsArray;

@end

@implementation KanslorViewController
@synthesize allstrings,firstString,selectedstrings,buttonsArray,seletedStrings;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


#pragma mark Viewlife Cycle 

- (void)viewDidLoad
{
    [super viewDidLoad];
    seletedStrings  = [[NSMutableArray alloc] init];
    self.navigationItem.title=@"Kanslor";
    firstString = [[NSMutableString alloc]init];
    
    scroll.scrollEnabled = YES;
    [scroll setContentSize:CGSizeMake(320, 1350)];
    
    
    
    UIImage *image = [UIImage imageNamed:@"Klar_button.png"];
    UIButton *okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [okBtn setFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
    [okBtn setTitle:@"Klar" forState:UIControlStateNormal];
    [okBtn setBackgroundImage:image forState:UIControlStateNormal];
    [okBtn addTarget:self action:@selector(OkButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem =  [[UIBarButtonItem alloc] initWithCustomView:okBtn];
    
    
   // NSArray* inputArray = [NSArray arrayWithObjects:@"Glad", @"Nöjd", @"Lycklig", @"Förtjust",@"lvrig",@"Exalterad",@"Stolt",@"Belåten",@"Upprymd",@"Munter",@"Livad",@"Euforisk",@"Hänförd",@"Lättad",@"Hat",@"Motvilja",@"Ovilja",@"Avsky",@"Äckel",@"Avsmak",@"Ledsen",@"Plågad",@"Deprimerad",@"Nedstämd",@"Lidande",@"Förvånad",@"Häpen",@"Förbluffad",@"Överraskad",nil];
   
    
    buttonsArray = [[NSArray alloc] initWithObjects:b1,b2,b3,b4,b5,b6,b7,b8,b9,b10,b11,b12,b13,b14,b15,b16,b17,b18,b19,b20,b21,b22,b23,b24,b25,b26,b27,b28,b29,b30,b31,b32,b33,b34,b35,b36,b37,b38,b39,b40,b41,b42,b43,b44,b45,b46,b47,b48,b49,b50,b51,b52,b53,b54,nil];
    
   
}



-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if ([selectedstrings length] == 0) {
        
    }
    else{
        NSArray* myArray = [selectedstrings componentsSeparatedByString:@", "];
       // NSMutableString *tempString = [[NSMutableString alloc] init];
        for(int i=0;i<myArray.count;i++){
            NSString* firstStrings = [myArray objectAtIndex:i];
            
            NSLog(@"%@",firstStrings);
            for (int g = 0; g < [buttonsArray count]; g++) {
                UIButton *button = [buttonsArray objectAtIndex:g];
                NSString *secondString = [button currentTitle];
                if ([[firstStrings stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:secondString]) {

                    [seletedStrings addObject:firstStrings];
                    
                    [button setBackgroundImage:[UIImage imageNamed:@"buttonp.png"]  forState:UIControlStateNormal];
                }
            }
        }
    }
    NSLog(@"%@",seletedStrings);
}



-(void)OkButtonClicked {
    
    NSMutableString *tempString = [[NSMutableString alloc] init];
    for (int i =0; i < [seletedStrings count]; i++) {
        if (i == 0) {
            [tempString appendString:[seletedStrings objectAtIndex:i]];
        }
        else {
            [tempString appendFormat:@", "];
            [tempString appendString:[seletedStrings objectAtIndex:i]];
        }
    }
    
    allstrings = tempString;
    
   /* NSLog(@"stringssss%@", firstString);
    allstrings = [NSString stringWithString:firstString];
    NSLog(@"%@", allstrings);*/
    
    [self.navigationController popViewControllerAnimated:YES];
}


-(IBAction)tabellencheck:(id)sender{
    UIButton *btn=(UIButton *)sender;
    
    NSLog(@"%u",btn.tag);
    
    NSLog(@"%@",seletedStrings);
    
    switch (btn.tag) {
        case 1:
            
            if(btn.currentBackgroundImage==[UIImage imageNamed:@"buttonnp.png"]){
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonp.png"]  forState:UIControlStateNormal];
                [seletedStrings  addObject:[btn currentTitle]];
                
                
            }else{
               [btn setBackgroundImage:[UIImage imageNamed:@"buttonnp.png"]  forState:UIControlStateNormal];
                
                for (int i = 0; i < [seletedStrings count]; i++) {
                    
                    if ([[btn currentTitle] isEqualToString:[seletedStrings objectAtIndex:i]]) {
                        [seletedStrings removeObjectAtIndex:i];
                    }
                }

                
            }
            
            break;
        case 2:
            if(btn.currentBackgroundImage==[UIImage imageNamed:@"buttonnp.png"]){
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonp.png"]  forState:UIControlStateNormal];
                [seletedStrings  addObject:[btn currentTitle]];
               

            }else{
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonnp.png"]  forState:UIControlStateNormal];

                for (int i = 0; i < [seletedStrings count]; i++) {
                    
                    if ([[btn currentTitle] isEqualToString:[seletedStrings objectAtIndex:i]]) {
                        [seletedStrings removeObjectAtIndex:i];
                    }
                }
            }
            
            break;
        case 3:
            if(btn.currentBackgroundImage==[UIImage imageNamed:@"buttonnp.png"]){
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonp.png"]  forState:UIControlStateNormal];
                [seletedStrings  addObject:[btn currentTitle]];
               
            }else{
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonnp.png"]  forState:UIControlStateNormal];
                for (int i = 0; i < [seletedStrings count]; i++) {
                    
                    if ([[btn currentTitle] isEqualToString:[seletedStrings objectAtIndex:i]]) {
                        [seletedStrings removeObjectAtIndex:i];
                    }
                }

            }
            
            break;
        case 4:
            if(btn.currentBackgroundImage==[UIImage imageNamed:@"buttonnp.png"]){
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonp.png"]  forState:UIControlStateNormal];
                [seletedStrings  addObject:[btn currentTitle]];
               
            }else{
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonnp.png"]  forState:UIControlStateNormal];
                for (int i = 0; i < [seletedStrings count]; i++) {
                    
                    if ([[btn currentTitle] isEqualToString:[seletedStrings objectAtIndex:i]]) {
                        [seletedStrings removeObjectAtIndex:i];
                    }
                }

            }
            
            break;
        case 5:
            if(btn.currentBackgroundImage==[UIImage imageNamed:@"buttonnp.png"]){
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonp.png"]  forState:UIControlStateNormal];
                [seletedStrings  addObject:[btn currentTitle]];
               
            }else{
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonnp.png"]  forState:UIControlStateNormal];
                for (int i = 0; i < [seletedStrings count]; i++) {
                    
                    if ([[btn currentTitle] isEqualToString:[seletedStrings objectAtIndex:i]]) {
                        [seletedStrings removeObjectAtIndex:i];
                    }
                }

            }
            
            break;
        case 6:

            if(btn.currentBackgroundImage==[UIImage imageNamed:@"buttonnp.png"]){
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonp.png"]  forState:UIControlStateNormal];
                [seletedStrings  addObject:[btn currentTitle]];
                
            }else{
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonnp.png"]  forState:UIControlStateNormal];
                for (int i = 0; i < [seletedStrings count]; i++) {
                    
                    if ([[btn currentTitle] isEqualToString:[seletedStrings objectAtIndex:i]]) {
                        [seletedStrings removeObjectAtIndex:i];
                    }
                }
            }
            
            break;
        case 7:
            if(btn.currentBackgroundImage==[UIImage imageNamed:@"buttonnp.png"]){
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonp.png"]  forState:UIControlStateNormal];
                [seletedStrings  addObject:[btn currentTitle]];
               
            }else{
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonnp.png"]  forState:UIControlStateNormal];
                for (int i = 0; i < [seletedStrings count]; i++) {
                    
                    if ([[btn currentTitle] isEqualToString:[seletedStrings objectAtIndex:i]]) {
                        [seletedStrings removeObjectAtIndex:i];
                    }
                }
            }
            
            break;
        case 8:
            if(btn.currentBackgroundImage==[UIImage imageNamed:@"buttonnp.png"]){
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonp.png"]  forState:UIControlStateNormal];
                [seletedStrings  addObject:[btn currentTitle]];
               
            }else{
               [btn setBackgroundImage:[UIImage imageNamed:@"buttonnp.png"]  forState:UIControlStateNormal];
                for (int i = 0; i < [seletedStrings count]; i++) {
                    
                    if ([[btn currentTitle] isEqualToString:[seletedStrings objectAtIndex:i]]) {
                        [seletedStrings removeObjectAtIndex:i];
                    }
                }
            }
            
            break;
        case 9:
            if(btn.currentBackgroundImage==[UIImage imageNamed:@"buttonnp.png"]){
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonp.png"]  forState:UIControlStateNormal];
                [seletedStrings  addObject:[btn currentTitle]];
                
            }else{
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonnp.png"]  forState:UIControlStateNormal];
                for (int i = 0; i < [seletedStrings count]; i++) {
                    
                    if ([[btn currentTitle] isEqualToString:[seletedStrings objectAtIndex:i]]) {
                        [seletedStrings removeObjectAtIndex:i];
                    }
                }
            }
            
            break;
        case 10:
            if(btn.currentBackgroundImage==[UIImage imageNamed:@"buttonnp.png"]){
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonp.png"]  forState:UIControlStateNormal];
                [seletedStrings  addObject:[btn currentTitle]];
               
            }else{
               [btn setBackgroundImage:[UIImage imageNamed:@"buttonnp.png"]  forState:UIControlStateNormal];
                for (int i = 0; i < [seletedStrings count]; i++) {
                    
                    if ([[btn currentTitle] isEqualToString:[seletedStrings objectAtIndex:i]]) {
                        [seletedStrings removeObjectAtIndex:i];
                    }
                }
            }
            
            break;
        case 11:
            if(btn.currentBackgroundImage==[UIImage imageNamed:@"buttonnp.png"]){
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonp.png"]  forState:UIControlStateNormal];
                [seletedStrings  addObject:[btn currentTitle]];
               
            }else{
               [btn setBackgroundImage:[UIImage imageNamed:@"buttonnp.png"]  forState:UIControlStateNormal];
                for (int i = 0; i < [seletedStrings count]; i++) {
                    
                    if ([[btn currentTitle] isEqualToString:[seletedStrings objectAtIndex:i]]) {
                        [seletedStrings removeObjectAtIndex:i];
                    }
                }
            }
            
            break;
        case 12:
            if(btn.currentBackgroundImage==[UIImage imageNamed:@"buttonnp.png"]){
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonp.png"]  forState:UIControlStateNormal];
                [seletedStrings  addObject:[btn currentTitle]];
                
            }else{
               [btn setBackgroundImage:[UIImage imageNamed:@"buttonnp.png"]  forState:UIControlStateNormal];
                for (int i = 0; i < [seletedStrings count]; i++) {
                    
                    if ([[btn currentTitle] isEqualToString:[seletedStrings objectAtIndex:i]]) {
                        [seletedStrings removeObjectAtIndex:i];
                    }
                }
            }
            
            break;
        case 13:
            if(btn.currentBackgroundImage==[UIImage imageNamed:@"buttonnp.png"]){
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonp.png"]  forState:UIControlStateNormal];
                [seletedStrings  addObject:[btn currentTitle]];
                
            }else{
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonnp.png"]  forState:UIControlStateNormal];
                for (int i = 0; i < [seletedStrings count]; i++) {
                    
                    if ([[btn currentTitle] isEqualToString:[seletedStrings objectAtIndex:i]]) {
                        [seletedStrings removeObjectAtIndex:i];
                    }
                }
            }
            
            break;
        case 14:
            if(btn.currentBackgroundImage==[UIImage imageNamed:@"buttonnp.png"]){
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonp.png"]  forState:UIControlStateNormal];
                [seletedStrings  addObject:[btn currentTitle]];
                
            }else{
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonnp.png"]  forState:UIControlStateNormal];
                for (int i = 0; i < [seletedStrings count]; i++) {
                    
                    if ([[btn currentTitle] isEqualToString:[seletedStrings objectAtIndex:i]]) {
                        [seletedStrings removeObjectAtIndex:i];
                    }
                }
            }
            
            break;
        case 15:
            if(btn.currentBackgroundImage==[UIImage imageNamed:@"buttonnp.png"]){
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonp.png"]  forState:UIControlStateNormal];
                [seletedStrings  addObject:[btn currentTitle]];
               
            }else{
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonnp.png"]  forState:UIControlStateNormal];
                for (int i = 0; i < [seletedStrings count]; i++) {
                    
                    if ([[btn currentTitle] isEqualToString:[seletedStrings objectAtIndex:i]]) {
                        [seletedStrings removeObjectAtIndex:i];
                    }
                }
            }
            
            break;
        case 16:
            if(btn.currentBackgroundImage==[UIImage imageNamed:@"buttonnp.png"]){
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonp.png"]  forState:UIControlStateNormal];
                [seletedStrings  addObject:[btn currentTitle]];
                
            }else{
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonnp.png"]  forState:UIControlStateNormal];
                for (int i = 0; i < [seletedStrings count]; i++) {
                    
                    if ([[btn currentTitle] isEqualToString:[seletedStrings objectAtIndex:i]]) {
                        [seletedStrings removeObjectAtIndex:i];
                    }
                }
            }
            
            break;
        case 17:
            if(btn.currentBackgroundImage==[UIImage imageNamed:@"buttonnp.png"]){
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonp.png"]  forState:UIControlStateNormal];
                [seletedStrings  addObject:[btn currentTitle]];
                
            }else{
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonnp.png"]  forState:UIControlStateNormal];
                for (int i = 0; i < [seletedStrings count]; i++) {
                    
                    if ([[btn currentTitle] isEqualToString:[seletedStrings objectAtIndex:i]]) {
                        [seletedStrings removeObjectAtIndex:i];
                    }
                }
            }
            
            break;
        case 18:
            if(btn.currentBackgroundImage==[UIImage imageNamed:@"buttonnp.png"]){
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonp.png"]  forState:UIControlStateNormal];
                [seletedStrings  addObject:[btn currentTitle]];
                
            }else{
               [btn setBackgroundImage:[UIImage imageNamed:@"buttonnp.png"]  forState:UIControlStateNormal];
                for (int i = 0; i < [seletedStrings count]; i++) {
                    
                    if ([[btn currentTitle] isEqualToString:[seletedStrings objectAtIndex:i]]) {
                        [seletedStrings removeObjectAtIndex:i];
                    }
                }
            }
            
            break;
        case 19:
            if(btn.currentBackgroundImage==[UIImage imageNamed:@"buttonnp.png"]){
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonp.png"]  forState:UIControlStateNormal];
                [seletedStrings  addObject:[btn currentTitle]];
                
            }else{
               [btn setBackgroundImage:[UIImage imageNamed:@"buttonnp.png"]  forState:UIControlStateNormal];
                for (int i = 0; i < [seletedStrings count]; i++) {
                    
                    if ([[btn currentTitle] isEqualToString:[seletedStrings objectAtIndex:i]]) {
                        [seletedStrings removeObjectAtIndex:i];
                    }
                }
            }
            
            break;
        case 20:
            if(btn.currentBackgroundImage==[UIImage imageNamed:@"buttonnp.png"]){
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonp.png"]  forState:UIControlStateNormal];
                [seletedStrings  addObject:[btn currentTitle]];
               
            }else{
               [btn setBackgroundImage:[UIImage imageNamed:@"buttonnp.png"]  forState:UIControlStateNormal];
                for (int i = 0; i < [seletedStrings count]; i++) {
                    
                    if ([[btn currentTitle] isEqualToString:[seletedStrings objectAtIndex:i]]) {
                        [seletedStrings removeObjectAtIndex:i];
                    }
                }
            }
            
            break;
        case 21:
            if(btn.currentBackgroundImage==[UIImage imageNamed:@"buttonnp.png"]){
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonp.png"]  forState:UIControlStateNormal];
                [seletedStrings  addObject:[btn currentTitle]];
                
            }else{
           [btn setBackgroundImage:[UIImage imageNamed:@"buttonnp.png"]  forState:UIControlStateNormal];
                for (int i = 0; i < [seletedStrings count]; i++) {
                    
                    if ([[btn currentTitle] isEqualToString:[seletedStrings objectAtIndex:i]]) {
                        [seletedStrings removeObjectAtIndex:i];
                    }
                }
            }
            
            break;
            
        case 22:
            if(btn.currentBackgroundImage==[UIImage imageNamed:@"buttonnp.png"]){
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonp.png"]  forState:UIControlStateNormal];
                [seletedStrings  addObject:[btn currentTitle]];
        
            }else{
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonnp.png"]  forState:UIControlStateNormal];
                for (int i = 0; i < [seletedStrings count]; i++) {
                    
                    if ([[btn currentTitle] isEqualToString:[seletedStrings objectAtIndex:i]]) {
                        [seletedStrings removeObjectAtIndex:i];
                    }
                }
                
            }
            
            break;
        case 23:
            if(btn.currentBackgroundImage==[UIImage imageNamed:@"buttonnp.png"]){
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonp.png"]  forState:UIControlStateNormal];
                [seletedStrings  addObject:[btn currentTitle]];
        
            }else{
            [btn setBackgroundImage:[UIImage imageNamed:@"buttonnp.png"]  forState:UIControlStateNormal];
                for (int i = 0; i < [seletedStrings count]; i++) {
                    
                    if ([[btn currentTitle] isEqualToString:[seletedStrings objectAtIndex:i]]) {
                        [seletedStrings removeObjectAtIndex:i];
                    }
                }
            }
            
            break;
        case 24:
            if(btn.currentBackgroundImage==[UIImage imageNamed:@"buttonnp.png"]){
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonp.png"]  forState:UIControlStateNormal];
                [seletedStrings  addObject:[btn currentTitle]];
                
            }else{
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonnp.png"]  forState:UIControlStateNormal];
                for (int i = 0; i < [seletedStrings count]; i++) {
                    
                    if ([[btn currentTitle] isEqualToString:[seletedStrings objectAtIndex:i]]) {
                        [seletedStrings removeObjectAtIndex:i];
                    }
                }
            }
            
            break;
        case 25:
            if(btn.currentBackgroundImage==[UIImage imageNamed:@"buttonnp.png"]){
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonp.png"]  forState:UIControlStateNormal];
                [seletedStrings  addObject:[btn currentTitle]];
               
            }else{
               [btn setBackgroundImage:[UIImage imageNamed:@"buttonnp.png"]  forState:UIControlStateNormal];
                for (int i = 0; i < [seletedStrings count]; i++) {
                    
                    if ([[btn currentTitle] isEqualToString:[seletedStrings objectAtIndex:i]]) {
                        [seletedStrings removeObjectAtIndex:i];
                    }
                }
            }
            
            break;
        case 26:
            if(btn.currentBackgroundImage==[UIImage imageNamed:@"buttonnp.png"]){
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonp.png"]  forState:UIControlStateNormal];
                [seletedStrings  addObject:[btn currentTitle]];
                
            }else{
            [btn setBackgroundImage:[UIImage imageNamed:@"buttonnp.png"]  forState:UIControlStateNormal];
                for (int i = 0; i < [seletedStrings count]; i++) {
                    
                    if ([[btn currentTitle] isEqualToString:[seletedStrings objectAtIndex:i]]) {
                        [seletedStrings removeObjectAtIndex:i];
                    }
                }
            }
            
            break;
        case 27:
            if(btn.currentBackgroundImage==[UIImage imageNamed:@"buttonnp.png"]){
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonp.png"]  forState:UIControlStateNormal];
                [seletedStrings  addObject:[btn currentTitle]];
                
            }else{
              [btn setBackgroundImage:[UIImage imageNamed:@"buttonnp.png"]  forState:UIControlStateNormal];
                for (int i = 0; i < [seletedStrings count]; i++) {
                    
                    if ([[btn currentTitle] isEqualToString:[seletedStrings objectAtIndex:i]]) {
                        [seletedStrings removeObjectAtIndex:i];
                    }
                }
            }
            
            break;
        case 28:
            if(btn.currentBackgroundImage==[UIImage imageNamed:@"buttonnp.png"]){
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonp.png"]  forState:UIControlStateNormal];
                [seletedStrings  addObject:[btn currentTitle]];
               
            }else{
             [btn setBackgroundImage:[UIImage imageNamed:@"buttonnp.png"]  forState:UIControlStateNormal];
                for (int i = 0; i < [seletedStrings count]; i++) {
                    
                    if ([[btn currentTitle] isEqualToString:[seletedStrings objectAtIndex:i]]) {
                        [seletedStrings removeObjectAtIndex:i];
                    }
                }
            }
            
            break;
        case 29:
            if(btn.currentBackgroundImage==[UIImage imageNamed:@"buttonnp.png"]){
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonp.png"]  forState:UIControlStateNormal];
                [seletedStrings  addObject:[btn currentTitle]];
                
            }else{
              [btn setBackgroundImage:[UIImage imageNamed:@"buttonnp.png"]  forState:UIControlStateNormal];
                for (int i = 0; i < [seletedStrings count]; i++) {
                    
                    if ([[btn currentTitle] isEqualToString:[seletedStrings objectAtIndex:i]]) {
                        [seletedStrings removeObjectAtIndex:i];
                    }
                }
            }
            
            break;
        case 30:
            if(btn.currentBackgroundImage==[UIImage imageNamed:@"buttonnp.png"]){
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonp.png"]  forState:UIControlStateNormal];
                [seletedStrings  addObject:[btn currentTitle]];
               
            }else{
               [btn setBackgroundImage:[UIImage imageNamed:@"buttonnp.png"]  forState:UIControlStateNormal];
                for (int i = 0; i < [seletedStrings count]; i++) {
                    
                    if ([[btn currentTitle] isEqualToString:[seletedStrings objectAtIndex:i]]) {
                        [seletedStrings removeObjectAtIndex:i];
                    }
                }
            }
            
            break;
        case 31:
            if(btn.currentBackgroundImage==[UIImage imageNamed:@"buttonnp.png"]){
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonp.png"]  forState:UIControlStateNormal];
                [seletedStrings  addObject:[btn currentTitle]];
                
            }else{
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonnp.png"]  forState:UIControlStateNormal];
                for (int i = 0; i < [seletedStrings count]; i++) {
                    
                    if ([[btn currentTitle] isEqualToString:[seletedStrings objectAtIndex:i]]) {
                        [seletedStrings removeObjectAtIndex:i];
                    }
                }
            }
            
            break;
        case 32:
            if(btn.currentBackgroundImage==[UIImage imageNamed:@"buttonnp.png"]){
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonp.png"]  forState:UIControlStateNormal];
                [seletedStrings  addObject:[btn currentTitle]];
                
            }else{
               [btn setBackgroundImage:[UIImage imageNamed:@"buttonnp.png"]  forState:UIControlStateNormal];
                for (int i = 0; i < [seletedStrings count]; i++) {
                    
                    if ([[btn currentTitle] isEqualToString:[seletedStrings objectAtIndex:i]]) {
                        [seletedStrings removeObjectAtIndex:i];
                    }
                }
            }
            
            break;
        case 33:
            if(btn.currentBackgroundImage==[UIImage imageNamed:@"buttonnp.png"]){
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonp.png"]  forState:UIControlStateNormal];
                [seletedStrings  addObject:[btn currentTitle]];
               
            }else{
               [btn setBackgroundImage:[UIImage imageNamed:@"buttonnp.png"]  forState:UIControlStateNormal];
                for (int i = 0; i < [seletedStrings count]; i++) {
                    
                    if ([[btn currentTitle] isEqualToString:[seletedStrings objectAtIndex:i]]) {
                        [seletedStrings removeObjectAtIndex:i];
                    }
                }
            }
            
            break;
        case 34:
            if(btn.currentBackgroundImage==[UIImage imageNamed:@"buttonnp.png"]){
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonp.png"]  forState:UIControlStateNormal];
                [seletedStrings  addObject:[btn currentTitle]];
               
            }else{
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonnp.png"]  forState:UIControlStateNormal];
                for (int i = 0; i < [seletedStrings count]; i++) {
                    
                    if ([[btn currentTitle] isEqualToString:[seletedStrings objectAtIndex:i]]) {
                        [seletedStrings removeObjectAtIndex:i];
                    }
                }
            }
            
            break;
        case 35:
            if(btn.currentBackgroundImage==[UIImage imageNamed:@"buttonnp.png"]){
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonp.png"]  forState:UIControlStateNormal];
                [seletedStrings  addObject:[btn currentTitle]];
               
            }else{
             [btn setBackgroundImage:[UIImage imageNamed:@"buttonnp.png"]  forState:UIControlStateNormal];
                for (int i = 0; i < [seletedStrings count]; i++) {
                    
                    if ([[btn currentTitle] isEqualToString:[seletedStrings objectAtIndex:i]]) {
                        [seletedStrings removeObjectAtIndex:i];
                    }
                }
            }
            
            break;
        case 36:
            if(btn.currentBackgroundImage==[UIImage imageNamed:@"buttonnp.png"]){
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonp.png"]  forState:UIControlStateNormal];
                [seletedStrings  addObject:[btn currentTitle]];
               
            }else{
            [btn setBackgroundImage:[UIImage imageNamed:@"buttonnp.png"]  forState:UIControlStateNormal];
                for (int i = 0; i < [seletedStrings count]; i++) {
                    
                    if ([[btn currentTitle] isEqualToString:[seletedStrings objectAtIndex:i]]) {
                        [seletedStrings removeObjectAtIndex:i];
                    }
                }
            }
            
            break;
        case 37:
            if(btn.currentBackgroundImage==[UIImage imageNamed:@"buttonnp.png"]){
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonp.png"]  forState:UIControlStateNormal];
                [seletedStrings  addObject:[btn currentTitle]];
               
            }else{
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonnp.png"]  forState:UIControlStateNormal];
                for (int i = 0; i < [seletedStrings count]; i++) {
                    
                    if ([[btn currentTitle] isEqualToString:[seletedStrings objectAtIndex:i]]) {
                        [seletedStrings removeObjectAtIndex:i];
                    }
                }
            }
            
            break;
        case 38:
            if(btn.currentBackgroundImage==[UIImage imageNamed:@"buttonnp.png"]){
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonp.png"]  forState:UIControlStateNormal];
                [seletedStrings  addObject:[btn currentTitle]];
                
            }else{
               [btn setBackgroundImage:[UIImage imageNamed:@"buttonnp.png"]  forState:UIControlStateNormal];
                for (int i = 0; i < [seletedStrings count]; i++) {
                    
                    if ([[btn currentTitle] isEqualToString:[seletedStrings objectAtIndex:i]]) {
                        [seletedStrings removeObjectAtIndex:i];
                    }
                }
            }
            
            break;
        case 39:
            if(btn.currentBackgroundImage==[UIImage imageNamed:@"buttonnp.png"]){
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonp.png"]  forState:UIControlStateNormal];
                [seletedStrings  addObject:[btn currentTitle]];
               
            }else{
               [btn setBackgroundImage:[UIImage imageNamed:@"buttonnp.png"]  forState:UIControlStateNormal];
                for (int i = 0; i < [seletedStrings count]; i++) {
                    
                    if ([[btn currentTitle] isEqualToString:[seletedStrings objectAtIndex:i]]) {
                        [seletedStrings removeObjectAtIndex:i];
                    }
                }
            }
            
            break;
        case 40:
            if(btn.currentBackgroundImage==[UIImage imageNamed:@"buttonnp.png"]){
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonp.png"]  forState:UIControlStateNormal];
                [seletedStrings  addObject:[btn currentTitle]];
                
            }else{
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonnp.png"]  forState:UIControlStateNormal];
                for (int i = 0; i < [seletedStrings count]; i++) {
                    
                    if ([[btn currentTitle] isEqualToString:[seletedStrings objectAtIndex:i]]) {
                        [seletedStrings removeObjectAtIndex:i];
                    }
                }
            }
            
            break;
        case 41:
            if(btn.currentBackgroundImage==[UIImage imageNamed:@"buttonnp.png"]){
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonp.png"]  forState:UIControlStateNormal];
                [seletedStrings  addObject:[btn currentTitle]];
               
            }else{
               [btn setBackgroundImage:[UIImage imageNamed:@"buttonnp.png"]  forState:UIControlStateNormal];
                for (int i = 0; i < [seletedStrings count]; i++) {
                    
                    if ([[btn currentTitle] isEqualToString:[seletedStrings objectAtIndex:i]]) {
                        [seletedStrings removeObjectAtIndex:i];
                    }
                }
            }
            
            break;
        case 42:
            if(btn.currentBackgroundImage==[UIImage imageNamed:@"buttonnp.png"]){
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonp.png"]  forState:UIControlStateNormal];
                [seletedStrings  addObject:[btn currentTitle]];
                
            }else{
            [btn setBackgroundImage:[UIImage imageNamed:@"buttonnp.png"]  forState:UIControlStateNormal];
                for (int i = 0; i < [seletedStrings count]; i++) {
                    
                    if ([[btn currentTitle] isEqualToString:[seletedStrings objectAtIndex:i]]) {
                        [seletedStrings removeObjectAtIndex:i];
                    }
                }
            }
            
            break;
            
        case 43:
            if(btn.currentBackgroundImage==[UIImage imageNamed:@"buttonnp.png"]){
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonp.png"]  forState:UIControlStateNormal];
                [seletedStrings  addObject:[btn currentTitle]];
                
            }else{
            [btn setBackgroundImage:[UIImage imageNamed:@"buttonnp.png"]  forState:UIControlStateNormal];
                for (int i = 0; i < [seletedStrings count]; i++) {
                    
                    if ([[btn currentTitle] isEqualToString:[seletedStrings objectAtIndex:i]]) {
                        [seletedStrings removeObjectAtIndex:i];
                    }
                }
            }
            
            break;
        case 44:
            if(btn.currentBackgroundImage==[UIImage imageNamed:@"buttonnp.png"]){
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonp.png"]  forState:UIControlStateNormal];
                [seletedStrings  addObject:[btn currentTitle]];
               
            }else{
             [btn setBackgroundImage:[UIImage imageNamed:@"buttonnp.png"]  forState:UIControlStateNormal];
                for (int i = 0; i < [seletedStrings count]; i++) {
                    
                    if ([[btn currentTitle] isEqualToString:[seletedStrings objectAtIndex:i]]) {
                        [seletedStrings removeObjectAtIndex:i];
                    }
                }
            }
            
            break;
        case 45:
            if(btn.currentBackgroundImage==[UIImage imageNamed:@"buttonnp.png"]){
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonp.png"]  forState:UIControlStateNormal];
                [seletedStrings  addObject:[btn currentTitle]];
               
            }else{
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonnp.png"]  forState:UIControlStateNormal];
                for (int i = 0; i < [seletedStrings count]; i++) {
                    
                    if ([[btn currentTitle] isEqualToString:[seletedStrings objectAtIndex:i]]) {
                        [seletedStrings removeObjectAtIndex:i];
                    }
                }
            }
            
            break;
        case 46:
            if(btn.currentBackgroundImage==[UIImage imageNamed:@"buttonnp.png"]){
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonp.png"]  forState:UIControlStateNormal];
                [seletedStrings  addObject:[btn currentTitle]];
               
            }else{
               [btn setBackgroundImage:[UIImage imageNamed:@"buttonnp.png"]  forState:UIControlStateNormal];
                for (int i = 0; i < [seletedStrings count]; i++) {
                    
                    if ([[btn currentTitle] isEqualToString:[seletedStrings objectAtIndex:i]]) {
                        [seletedStrings removeObjectAtIndex:i];
                    }
                }
            }
            
            break;
        case 47:
            if(btn.currentBackgroundImage==[UIImage imageNamed:@"buttonnp.png"]){
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonp.png"]  forState:UIControlStateNormal];
                [seletedStrings  addObject:[btn currentTitle]];
                
            }else{
            [btn setBackgroundImage:[UIImage imageNamed:@"buttonnp.png"]  forState:UIControlStateNormal];
                for (int i = 0; i < [seletedStrings count]; i++) {
                    
                    if ([[btn currentTitle] isEqualToString:[seletedStrings objectAtIndex:i]]) {
                        [seletedStrings removeObjectAtIndex:i];
                    }
                }
            }
            
            break;
        case 48:
            if(btn.currentBackgroundImage==[UIImage imageNamed:@"buttonnp.png"]){
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonp.png"]  forState:UIControlStateNormal];
                [seletedStrings  addObject:[btn currentTitle]];
               
            }else{
               [btn setBackgroundImage:[UIImage imageNamed:@"buttonnp.png"]  forState:UIControlStateNormal];
                for (int i = 0; i < [seletedStrings count]; i++) {
                    
                    if ([[btn currentTitle] isEqualToString:[seletedStrings objectAtIndex:i]]) {
                        [seletedStrings removeObjectAtIndex:i];
                    }
                }
            }
            
            break;
        case 49:
            if(btn.currentBackgroundImage==[UIImage imageNamed:@"buttonnp.png"]){
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonp.png"]  forState:UIControlStateNormal];
                [seletedStrings  addObject:[btn currentTitle]];
                
            }else{
               [btn setBackgroundImage:[UIImage imageNamed:@"buttonnp.png"]  forState:UIControlStateNormal];
                for (int i = 0; i < [seletedStrings count]; i++) {
                    
                    if ([[btn currentTitle] isEqualToString:[seletedStrings objectAtIndex:i]]) {
                        [seletedStrings removeObjectAtIndex:i];
                    }
                }
            }
            
            break;
        case 50:
            if(btn.currentBackgroundImage==[UIImage imageNamed:@"buttonnp.png"]){
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonp.png"]  forState:UIControlStateNormal];
                [seletedStrings  addObject:[btn currentTitle]];
               
            }else{
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonnp.png"]  forState:UIControlStateNormal];
                for (int i = 0; i < [seletedStrings count]; i++) {
                    
                    if ([[btn currentTitle] isEqualToString:[seletedStrings objectAtIndex:i]]) {
                        [seletedStrings removeObjectAtIndex:i];
                    }
                }
            }
            
            break;
        case 51:
            if(btn.currentBackgroundImage==[UIImage imageNamed:@"buttonnp.png"]){
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonp.png"]  forState:UIControlStateNormal];
                [seletedStrings  addObject:[btn currentTitle]];
                
            }else{
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonnp.png"]  forState:UIControlStateNormal];
                for (int i = 0; i < [seletedStrings count]; i++) {
                    
                    if ([[btn currentTitle] isEqualToString:[seletedStrings objectAtIndex:i]]) {
                        [seletedStrings removeObjectAtIndex:i];
                    }
                }
            }
            
            break;
        case 52:
            if(btn.currentBackgroundImage==[UIImage imageNamed:@"buttonnp.png"]){
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonp.png"]  forState:UIControlStateNormal];
                [seletedStrings  addObject:[btn currentTitle]];
               
            }else{
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonnp.png"]  forState:UIControlStateNormal];
                for (int i = 0; i < [seletedStrings count]; i++) {
                    
                    if ([[btn currentTitle] isEqualToString:[seletedStrings objectAtIndex:i]]) {
                        [seletedStrings removeObjectAtIndex:i];
                    }
                }
            }
            
            break;
            
        case 53:
            if(btn.currentBackgroundImage==[UIImage imageNamed:@"buttonnp.png"]){
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonp.png"]  forState:UIControlStateNormal];
                [seletedStrings  addObject:[btn currentTitle]];
               
            }else{
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonnp.png"]  forState:UIControlStateNormal];
                for (int i = 0; i < [seletedStrings count]; i++) {
                    
                    if ([[btn currentTitle] isEqualToString:[seletedStrings objectAtIndex:i]]) {
                        [seletedStrings removeObjectAtIndex:i];
                    }
                }
            }
            
            break;
        case 54:
            if(btn.currentBackgroundImage==[UIImage imageNamed:@"buttonnp.png"]){
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonp.png"]  forState:UIControlStateNormal];
                [seletedStrings  addObject:[btn currentTitle]];
                
            }else{
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonnp.png"]  forState:UIControlStateNormal];
                for (int i = 0; i < [seletedStrings count]; i++) {
                    
                    if ([[btn currentTitle] isEqualToString:[seletedStrings objectAtIndex:i]]) {
                        [seletedStrings removeObjectAtIndex:i];
                    }
                }
            }
            
            break;
            
        default:
            break;
    }
    
    NSLog(@"%@",seletedStrings);
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
   
}

-(void)dealloc {
    [buttonsArray release];
    [seletedStrings release];
    [super dealloc];
}

@end
