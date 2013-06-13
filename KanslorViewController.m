//
//  KanslorViewController.m
//  Välkommen till TFH-appen
//
//  Created by Brilliance Tech Sols on 5/30/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import "KanslorViewController.h"

@interface KanslorViewController ()


@end

@implementation KanslorViewController
@synthesize allstrings,firstString,selectedstrings;
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
    self.navigationItem.title=@"Kanslor";
    NSArray* inputArray = [NSArray arrayWithObjects:@"Glad", @"Nöjd", @"Lycklig", @"Förtjust",@"lvrig",@"Exalterad",@"Stolt",@"Belåten",@"Upprymd",@"Munter",@"Livad",@"Euforisk",@"Hänförd",@"Lättad",@"Hat",@"Motvilja",@"Ovilja",@"Avsky",@"Äckel",@"Avsmak",@"Ledsen",@"Plågad",@"Deprimerad",@"Nedstämd",@"Lidande",@"Förvånad",@"Häpen",@"Förbluffad",@"Överraskad",nil];
     firstString=[[NSMutableString alloc]init];
    scroll.scrollEnabled = YES;
    [scroll setContentSize:CGSizeMake(320, 1350)];
    [super viewDidLoad];
    if ([selectedstrings isEqualToString:@""]) {
        
    }else{
        
        NSArray* myArray = [selectedstrings  componentsSeparatedByString:@","];
        for(int i=0;i<myArray.count;i++){
        NSString* firstStrings = [myArray objectAtIndex:0];
        NSLog(@"%@",firstStrings);
        NSUInteger index = [inputArray indexOfObject:firstStrings];
            NSLog(@"%u",index);
            if(index==0){
             [b1 setBackgroundImage:[UIImage imageNamed:@"buttonp.png"]  forState:UIControlStateNormal];
            }
        }
            }
    // Do any additional setup after loading the view from its nib.
}
-(IBAction)tabellencheck:(id)sender{
    UIButton *btn=(UIButton *)sender;
    
    NSLog(@"%u",btn.tag) ;
    switch (btn.tag) {
        case 1:
            
            if(btn.currentBackgroundImage==[UIImage imageNamed:@"buttonnp.png"]){
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonp.png"]  forState:UIControlStateNormal];
                
                [firstString appendString:@"Glad,"];
                NSLog(@"%@",firstString);
            }else{
               [btn setBackgroundImage:[UIImage imageNamed:@"buttonnp.png"]  forState:UIControlStateNormal];
                
            }
            
            break;
        case 2:
            if(btn.currentBackgroundImage==[UIImage imageNamed:@"buttonnp.png"]){
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonp.png"]  forState:UIControlStateNormal];
                [firstString appendString:@"Nöjd,"];
                NSLog(@"%@",firstString);
            }else{
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonnp.png"]  forState:UIControlStateNormal];
            }
            
            break;
        case 3:
            if(btn.currentBackgroundImage==[UIImage imageNamed:@"buttonnp.png"]){
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonp.png"]  forState:UIControlStateNormal];
               [firstString appendString:@" Lycklig,"];
            }else{
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonnp.png"]  forState:UIControlStateNormal];
                // beteenden.text=@"";
            }
            
            break;
        case 4:
            if(btn.currentBackgroundImage==[UIImage imageNamed:@"buttonnp.png"]){
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonp.png"]  forState:UIControlStateNormal];
               [firstString appendString:@" Förtjust,"];
            }else{
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonnp.png"]  forState:UIControlStateNormal];
                //beteenden.text=@"";
            }
            
            break;
        case 5:
            if(btn.currentBackgroundImage==[UIImage imageNamed:@"buttonnp.png"]){
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonp.png"]  forState:UIControlStateNormal];
                [firstString appendString:@"lvrig,"];
            }else{
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonnp.png"]  forState:UIControlStateNormal];
                // beteenden.text=@"";
            }
            
            break;
        case 6:
            if(btn.currentBackgroundImage==[UIImage imageNamed:@"buttonnp.png"]){
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonp.png"]  forState:UIControlStateNormal];
                [firstString appendString:@" Exalterad,"];
            }else{
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonnp.png"]  forState:UIControlStateNormal];
                //beteenden.text=@"";
            }
            
            break;
        case 7:
            if(btn.currentBackgroundImage==[UIImage imageNamed:@"buttonnp.png"]){
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonp.png"]  forState:UIControlStateNormal];
                [firstString appendString:@"  Stolt,"];
            }else{
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonnp.png"]  forState:UIControlStateNormal];
                //beteenden.text=@"";
            }
            
            break;
        case 8:
            if(btn.currentBackgroundImage==[UIImage imageNamed:@"buttonnp.png"]){
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonp.png"]  forState:UIControlStateNormal];
                [firstString appendString:@"Belåten,"];
            }else{
               [btn setBackgroundImage:[UIImage imageNamed:@"buttonnp.png"]  forState:UIControlStateNormal];
                //beteenden.text=@"";
            }
            
            break;
        case 9:
            if(btn.currentBackgroundImage==[UIImage imageNamed:@"buttonnp.png"]){
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonp.png"]  forState:UIControlStateNormal];
                [firstString appendString:@"upprymd,"];
            }else{
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonnp.png"]  forState:UIControlStateNormal];
                //beteenden.text=@"";
            }
            
            break;
        case 10:
            if(btn.currentBackgroundImage==[UIImage imageNamed:@"buttonnp.png"]){
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonp.png"]  forState:UIControlStateNormal];
                [firstString appendString:@"Munter,"];
            }else{
               [btn setBackgroundImage:[UIImage imageNamed:@"buttonnp.png"]  forState:UIControlStateNormal];
                //beteenden.text=@"";
            }
            
            break;
        case 11:
            if(btn.currentBackgroundImage==[UIImage imageNamed:@"buttonnp.png"]){
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonp.png"]  forState:UIControlStateNormal];
                [firstString appendString:@" Livad,"];
            }else{
               [btn setBackgroundImage:[UIImage imageNamed:@"buttonnp.png"]  forState:UIControlStateNormal];
                //beteenden.text=@"";
            }
            
            break;case 12:
            if(btn.currentBackgroundImage==[UIImage imageNamed:@"buttonnp.png"]){
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonp.png"]  forState:UIControlStateNormal];
                [firstString appendString:@"Euforisk,"];
            }else{
               [btn setBackgroundImage:[UIImage imageNamed:@"buttonnp.png"]  forState:UIControlStateNormal];
                //beteenden.text=@"";
            }
            
            break;
        case 13:
            if(btn.currentBackgroundImage==[UIImage imageNamed:@"buttonnp.png"]){
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonp.png"]  forState:UIControlStateNormal];
                [firstString appendString:@" Hänförd,"];
            }else{
               // [btn setBackgroundImage:[UIImage imageNamed:@"buttonnp.png"]  forState:UIControlStateNormal];
                //beteenden.text=@"";
            }
            
            break;
        case 14:
            if(btn.currentBackgroundImage==[UIImage imageNamed:@"buttonnp.png"]){
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonp.png"]  forState:UIControlStateNormal];
                [firstString appendString:@"  Lättad,"];
            }else{
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonnp.png"]  forState:UIControlStateNormal];
                //beteenden.text=@"";
            }
            
            break;
        case 15:
            if(btn.currentBackgroundImage==[UIImage imageNamed:@"buttonnp.png"]){
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonp.png"]  forState:UIControlStateNormal];
                [firstString appendString:@" Hat,"];
            }else{
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonnp.png"]  forState:UIControlStateNormal];
                //beteenden.text=@"";
            }
            
            break;
        case 16:
            if(btn.currentBackgroundImage==[UIImage imageNamed:@"buttonnp.png"]){
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonp.png"]  forState:UIControlStateNormal];
                [firstString appendString:@" Motvilja,"];
            }else{
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonnp.png"]  forState:UIControlStateNormal];
                //beteenden.text=@"";
            }
            
            break;
        case 17:
            if(btn.currentBackgroundImage==[UIImage imageNamed:@"buttonnp.png"]){
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonp.png"]  forState:UIControlStateNormal];
                [firstString appendString:@" Ovilja,"];
            }else{
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonnp.png"]  forState:UIControlStateNormal];
                //beteenden.text=@"";
            }
            
            break;
        case 18:
            if(btn.currentBackgroundImage==[UIImage imageNamed:@"buttonnp.png"]){
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonp.png"]  forState:UIControlStateNormal];
                [firstString appendString:@" Avsky,"];
            }else{
               [btn setBackgroundImage:[UIImage imageNamed:@"buttonnp.png"]  forState:UIControlStateNormal];
                //beteenden.text=@"";
            }
            
            break;
        case 19:
            if(btn.currentBackgroundImage==[UIImage imageNamed:@"buttonnp.png"]){
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonp.png"]  forState:UIControlStateNormal];
                [firstString appendString:@" Äckel,"];
            }else{
               [btn setBackgroundImage:[UIImage imageNamed:@"buttonnp.png"]  forState:UIControlStateNormal];
                //beteenden.text=@"";
            }
            
            break;
        case 20:
            if(btn.currentBackgroundImage==[UIImage imageNamed:@"buttonnp.png"]){
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonp.png"]  forState:UIControlStateNormal];
                [firstString appendString:@" Avsmak,"];
            }else{
               [btn setBackgroundImage:[UIImage imageNamed:@"buttonnp.png"]  forState:UIControlStateNormal];
                //beteenden.text=@"";
            }
            
            break;
        case 21:
            if(btn.currentBackgroundImage==[UIImage imageNamed:@"buttonnp.png"]){
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonp.png"]  forState:UIControlStateNormal];
                [firstString appendString:@"Ledsen,"];
            }else{
           [btn setBackgroundImage:[UIImage imageNamed:@"buttonnp.png"]  forState:UIControlStateNormal];
                //beteenden.text=@"";
            }
            
            break;
            
        case 22:
            if(btn.currentBackgroundImage==[UIImage imageNamed:@"buttonnp.png"]){
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonp.png"]  forState:UIControlStateNormal];
                [firstString appendString:@"Plågad,"];
                NSLog(@"%@",firstString);
            }else{
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonnp.png"]  forState:UIControlStateNormal];
                
            }
            
            break;
        case 23:
            if(btn.currentBackgroundImage==[UIImage imageNamed:@"buttonnp.png"]){
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonp.png"]  forState:UIControlStateNormal];
                [firstString appendString:@", Deprimerad"];
                NSLog(@"%@",firstString);
            }else{
            [btn setBackgroundImage:[UIImage imageNamed:@"buttonnp.png"]  forState:UIControlStateNormal];
            }
            
            break;
        case 24:
            if(btn.currentBackgroundImage==[UIImage imageNamed:@"buttonnp.png"]){
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonp.png"]  forState:UIControlStateNormal];
                [firstString appendString:@" , Nedstämd"];
            }else{
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonnp.png"]  forState:UIControlStateNormal];
                // beteenden.text=@"";
            }
            
            break;
        case 25:
            if(btn.currentBackgroundImage==[UIImage imageNamed:@"buttonnp.png"]){
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonp.png"]  forState:UIControlStateNormal];
                [firstString appendString:@" , Lidande"];
            }else{
               [btn setBackgroundImage:[UIImage imageNamed:@"buttonnp.png"]  forState:UIControlStateNormal];
                //beteenden.text=@"";
            }
            
            break;
        case 26:
            if(btn.currentBackgroundImage==[UIImage imageNamed:@"buttonnp.png"]){
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonp.png"]  forState:UIControlStateNormal];
                [firstString appendString:@", Förvånad"];
            }else{
            [btn setBackgroundImage:[UIImage imageNamed:@"buttonnp.png"]  forState:UIControlStateNormal];
                // beteenden.text=@"";
            }
            
            break;
        case 27:
            if(btn.currentBackgroundImage==[UIImage imageNamed:@"buttonnp.png"]){
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonp.png"]  forState:UIControlStateNormal];
                [firstString appendString:@" , Häpen"];
            }else{
              [btn setBackgroundImage:[UIImage imageNamed:@"buttonnp.png"]  forState:UIControlStateNormal];
                //beteenden.text=@"";
            }
            
            break;
        case 28:
            if(btn.currentBackgroundImage==[UIImage imageNamed:@"buttonnp.png"]){
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonp.png"]  forState:UIControlStateNormal];
                [firstString appendString:@" , Förbluffad"];
            }else{
             [btn setBackgroundImage:[UIImage imageNamed:@"buttonnp.png"]  forState:UIControlStateNormal];
                //beteenden.text=@"";
            }
            
            break;
        case 29:
            if(btn.currentBackgroundImage==[UIImage imageNamed:@"buttonnp.png"]){
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonp.png"]  forState:UIControlStateNormal];
                [firstString appendString:@" , Överraskad"];
            }else{
              [btn setBackgroundImage:[UIImage imageNamed:@"buttonnp.png"]  forState:UIControlStateNormal];
                //beteenden.text=@"";
            }
            
            break;
        case 30:
            if(btn.currentBackgroundImage==[UIImage imageNamed:@"buttonnp.png"]){
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonp.png"]  forState:UIControlStateNormal];
                [firstString appendString:@" , Rädd"];
            }else{
               [btn setBackgroundImage:[UIImage imageNamed:@"buttonnp.png"]  forState:UIControlStateNormal];
                //beteenden.text=@"";
            }
            
            break;
        case 31:
            if(btn.currentBackgroundImage==[UIImage imageNamed:@"buttonnp.png"]){
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonp.png"]  forState:UIControlStateNormal];
                [firstString appendString:@" , Skräckslagen"];
            }else{
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonnp.png"]  forState:UIControlStateNormal];
                //beteenden.text=@"";
            }
            
            break;
        case 32:
            if(btn.currentBackgroundImage==[UIImage imageNamed:@"buttonnp.png"]){
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonp.png"]  forState:UIControlStateNormal];
                [firstString appendString:@" , Ängslig"];
            }else{
               [btn setBackgroundImage:[UIImage imageNamed:@"buttonnp.png"]  forState:UIControlStateNormal];
                //beteenden.text=@"";
            }
            
            break;case 33:
            if(btn.currentBackgroundImage==[UIImage imageNamed:@"buttonnp.png"]){
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonp.png"]  forState:UIControlStateNormal];
                [firstString appendString:@" , Nervös"];
            }else{
               [btn setBackgroundImage:[UIImage imageNamed:@"buttonnp.png"]  forState:UIControlStateNormal];
                //beteenden.text=@"";
            }
            
            break;
        case 34:
            if(btn.currentBackgroundImage==[UIImage imageNamed:@"buttonnp.png"]){
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonp.png"]  forState:UIControlStateNormal];
                [firstString appendString:@" , Bekymrad"];
            }else{
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonnp.png"]  forState:UIControlStateNormal];
                //beteenden.text=@"";
            }
            
            break;
        case 35:
            if(btn.currentBackgroundImage==[UIImage imageNamed:@"buttonnp.png"]){
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonp.png"]  forState:UIControlStateNormal];
                [firstString appendString:@" , Orolig"];
            }else{
             [btn setBackgroundImage:[UIImage imageNamed:@"buttonnp.png"]  forState:UIControlStateNormal];
                //beteenden.text=@"";
            }
            
            break;
        case 36:
            if(btn.currentBackgroundImage==[UIImage imageNamed:@"buttonnp.png"]){
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonp.png"]  forState:UIControlStateNormal];
                [firstString appendString:@" , Spänd"];
            }else{
            [btn setBackgroundImage:[UIImage imageNamed:@"buttonnp.png"]  forState:UIControlStateNormal];
                //beteenden.text=@"";
            }
            
            break;
        case 37:
            if(btn.currentBackgroundImage==[UIImage imageNamed:@"buttonnp.png"]){
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonp.png"]  forState:UIControlStateNormal];
                [firstString appendString:@" , Skärrad"];
            }else{
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonnp.png"]  forState:UIControlStateNormal];
                //beteenden.text=@"";
            }
            
            break;
        case 38:
            if(btn.currentBackgroundImage==[UIImage imageNamed:@"buttonnp.png"]){
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonp.png"]  forState:UIControlStateNormal];
                [firstString appendString:@" , Vettskrämd"];
            }else{
               [btn setBackgroundImage:[UIImage imageNamed:@"buttonnp.png"]  forState:UIControlStateNormal];
                //beteenden.text=@"";
            }
            
            break;
        case 39:
            if(btn.currentBackgroundImage==[UIImage imageNamed:@"buttonnp.png"]){
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonp.png"]  forState:UIControlStateNormal];
                [firstString appendString:@" , Uppskrämd"];
            }else{
               [btn setBackgroundImage:[UIImage imageNamed:@"buttonnp.png"]  forState:UIControlStateNormal];
                //beteenden.text=@"";
            }
            
            break;
        case 40:
            if(btn.currentBackgroundImage==[UIImage imageNamed:@"buttonnp.png"]){
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonp.png"]  forState:UIControlStateNormal];
                [firstString appendString:@" , Intresserad"];
            }else{
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonnp.png"]  forState:UIControlStateNormal];
                //beteenden.text=@"";
            }
            
            break;
        case 41:
            if(btn.currentBackgroundImage==[UIImage imageNamed:@"buttonnp.png"]){
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonp.png"]  forState:UIControlStateNormal];
                [firstString appendString:@" , Nyfiken"];
            }else{
               [btn setBackgroundImage:[UIImage imageNamed:@"buttonnp.png"]  forState:UIControlStateNormal];
                //beteenden.text=@"";
            }
            
            break;
        case 42:
            if(btn.currentBackgroundImage==[UIImage imageNamed:@"buttonnp.png"]){
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonp.png"]  forState:UIControlStateNormal];
                [firstString appendString:@" , Inspirerad"];
            }else{
            [btn setBackgroundImage:[UIImage imageNamed:@"buttonnp.png"]  forState:UIControlStateNormal];
                //beteenden.text=@"";
            }
            
            break;
            
        case 43:
            if(btn.currentBackgroundImage==[UIImage imageNamed:@"buttonnp.png"]){
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonp.png"]  forState:UIControlStateNormal];
                [firstString appendString:@" , Generad"];
            }else{
            [btn setBackgroundImage:[UIImage imageNamed:@"buttonnp.png"]  forState:UIControlStateNormal];
                //beteenden.text=@"";
            }
            
            break;
        case 44:
            if(btn.currentBackgroundImage==[UIImage imageNamed:@"buttonnp.png"]){
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonp.png"]  forState:UIControlStateNormal];
                [firstString appendString:@" , Skamsen"];
            }else{
             [btn setBackgroundImage:[UIImage imageNamed:@"buttonnp.png"]  forState:UIControlStateNormal];
                //beteenden.text=@"";
            }
            
            break;
        case 45:
            if(btn.currentBackgroundImage==[UIImage imageNamed:@"buttonnp.png"]){
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonp.png"]  forState:UIControlStateNormal];
                [firstString appendString:@" , Osäker"];
            }else{
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonnp.png"]  forState:UIControlStateNormal];
                //beteenden.text=@"";
            }
            
            break;
        case 46:
            if(btn.currentBackgroundImage==[UIImage imageNamed:@"buttonnp.png"]){
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonp.png"]  forState:UIControlStateNormal];
                [firstString appendString:@" , IIsken"];
            }else{
               [btn setBackgroundImage:[UIImage imageNamed:@"buttonnp.png"]  forState:UIControlStateNormal];
                //beteenden.text=@"";
            }
            
            break;
        case 47:
            if(btn.currentBackgroundImage==[UIImage imageNamed:@"buttonnp.png"]){
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonp.png"]  forState:UIControlStateNormal];
                [firstString appendString:@" , Upprörd"];
            }else{
            [btn setBackgroundImage:[UIImage imageNamed:@"buttonnp.png"]  forState:UIControlStateNormal];
                //beteenden.text=@"";
            }
            
            break;
        case 48:
            if(btn.currentBackgroundImage==[UIImage imageNamed:@"buttonnp.png"]){
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonp.png"]  forState:UIControlStateNormal];
                [firstString appendString:@" , Hatisk"];
            }else{
               [btn setBackgroundImage:[UIImage imageNamed:@"buttonnp.png"]  forState:UIControlStateNormal];
                //beteenden.text=@"";
            }
            
            break;
        case 49:
            if(btn.currentBackgroundImage==[UIImage imageNamed:@"buttonnp.png"]){
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonp.png"]  forState:UIControlStateNormal];
                [firstString appendString:@" , Vrede"];
            }else{
               [btn setBackgroundImage:[UIImage imageNamed:@"buttonnp.png"]  forState:UIControlStateNormal];
                //beteenden.text=@"";
            }
            
            break;
        case 50:
            if(btn.currentBackgroundImage==[UIImage imageNamed:@"buttonnp.png"]){
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonp.png"]  forState:UIControlStateNormal];
                [firstString appendString:@" , Arg"];
            }else{
               // [btn setBackgroundImage:[UIImage imageNamed:@"buttonnp.png"]  forState:UIControlStateNormal];
                //beteenden.text=@"";
            }
            
            break;
        case 51:
            if(btn.currentBackgroundImage==[UIImage imageNamed:@"buttonnp.png"]){
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonp.png"]  forState:UIControlStateNormal];
                [firstString appendString:@" , Uppretad"];
            }else{
               // [btn setBackgroundImage:[UIImage imageNamed:@"buttonnp.png"]  forState:UIControlStateNormal];
                //beteenden.text=@"";
            }
            
            break;
        case 52:
            if(btn.currentBackgroundImage==[UIImage imageNamed:@"buttonnp.png"]){
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonp.png"]  forState:UIControlStateNormal];
                [firstString appendString:@" , Irriterad"];
            }else{
                //[btn setBackgroundImage:[UIImage imageNamed:@"buttonnp.png"]  forState:UIControlStateNormal];
                //beteenden.text=@"";
            }
            
            break;
            
        case 53:
            if(btn.currentBackgroundImage==[UIImage imageNamed:@"buttonnp.png"]){
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonp.png"]  forState:UIControlStateNormal];
                [firstString appendString:@" , Rasande"];
            }else{
                //[btn setBackgroundImage:[UIImage imageNamed:@"buttonnp.png"]  forState:UIControlStateNormal];
                //beteenden.text=@"";
            }
            
            break;
        case 54:
            if(btn.currentBackgroundImage==[UIImage imageNamed:@"buttonnp.png"]){
                [btn setBackgroundImage:[UIImage imageNamed:@"buttonp.png"]  forState:UIControlStateNormal];
                [firstString appendString:@" , Ursinning"];
            }else{
                //[btn setBackgroundImage:[UIImage imageNamed:@"buttonnp.png"]  forState:UIControlStateNormal];
                //beteenden.text=@"";
            }
            
            break;
            
        default:
            break;
    }
}
- (void)viewWillDisappear:(BOOL)animated {
     NSLog(@"stringssss%@",firstString);
    allstrings = [NSString stringWithString:firstString];
    NSLog(@"%@",allstrings);
  
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
   
}

@end
