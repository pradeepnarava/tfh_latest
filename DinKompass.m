//
//  DinKompass.m
//  Välkommen till TFH-appen
//
//  Created by Mohammed Abdul Majeed on 5/15/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import "DinKompass.h"
#import <sqlite3.h>

#define DegreesToRadians(x) ((x) * M_PI / 180.0)

@interface DinKompass ()

@property (nonatomic, strong) CPTGraphHostingView *hostView;

@end

@implementation DinKompass

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    self.view.backgroundColor = [UIColor greenColor];
    [self performSelector:@selector(setupGraphType) withObject:nil afterDelay:0.2];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI_2);
    self.view.transform = transform;
    
    // Repositions and resizes the view.
    CGRect contentRect = CGRectMake(0,0, 480, 320);
    self.view.bounds = contentRect;
    
   NSMutableArray *data = [NSMutableArray array];
    //    [data addObject:[NSValue valueWithCGPoint:CGPointMake(-10, 100)]];
    //    [data addObject:[NSValue valueWithCGPoint:CGPointMake(-8, 95)]];
    //    [data addObject:[NSValue valueWithCGPoint:CGPointMake(-6, 85)]];
    //    [data addObject:[NSValue valueWithCGPoint:CGPointMake(-4, 70)]];
    //    [data addObject:[NSValue valueWithCGPoint:CGPointMake(-2, 50)]];
    // [data addObject:[NSValue valueWithCGPoint:CGPointMake(0, 0)]];
   [data addObject:[NSValue valueWithCGPoint:CGPointMake(2, 3.89)]];
    [data addObject:[NSValue valueWithCGPoint:CGPointMake(4, 4.44)]];
    [data addObject:[NSValue valueWithCGPoint:CGPointMake(6, 5.75)]];
    // [data addObject:[NSValue valueWithCGPoint:CGPointMake(8, 64)]];
     //[data addObject:[NSValue valueWithCGPoint:CGPointMake(10, 100)]];
//self.scatterPlot = [[TUTSimpleScatterPlot alloc] initWithHostingView:_graphHostingView andData:data];
//[self.scatterPlot initialisePlot];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)setupGraphType
{
    if (_isComparisonGraph)
    {
        presentArray = [[NSMutableArray alloc] initWithArray:[self getValuesForDate:_presentDate]];
        olderArray = [[NSMutableArray alloc] initWithArray:[self getValuesForDate:_oldDate]];
        
        NSLog(@"PRESENT ARRAY = %@", presentArray);
        NSLog(@"OLDER ARRAY = %@", olderArray);
        [self initPlot];
    }
    else
    {
//        DateSelectingViewController *dateSelector;
//        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
//        {
//            dateSelector = [[DateSelectingViewController alloc] initWithNibName:@"DateSelectingViewController" bundle:nil];
//        }else
//        {
//            dateSelector = [[DateSelectingViewController alloc] initWithNibName:@"DateSelectingViewController_iPad" bundle:nil];
//        }
//
//        dateSelector.delegate = self;
//        [self presentViewController:dateSelector animated:YES completion:nil];
        averageArray = [[NSMutableArray alloc] init];
        datesArray = [[NSMutableArray alloc] init];
        
        NSString *docsDir;
        NSArray *dirPaths;
        sqlite3 *exerciseDB;
        
        // Get the documents directory
        dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        
        docsDir = [dirPaths objectAtIndex:0];
        
        // Build the path to the database file
        NSString *databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"exerciseDB.db"]];
        // const char *dbpath = [databasePath UTF8String];
        sqlite3_stmt    *statement;
        if (sqlite3_open([databasePath UTF8String], &exerciseDB) == SQLITE_OK)
        {
            
            NSString *sql = [NSString stringWithFormat: @"SELECT * FROM EXERCISE7 ORDER BY id DESC LIMIT 20"];
            
            const char *del_stmt = [sql UTF8String];
            
            sqlite3_prepare_v2(exerciseDB, del_stmt, -1, & statement, NULL);
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                char* date = (char*) sqlite3_column_text(statement,1);
                
                if (date != NULL)
                {
                    //                NSLog(@"Date OF CURRENT ITEM = %@", dateOfCurrentItem);
                    //                NSDate *presentDate = [formatter dateFromString:dateOfCurrentItem];
//                    NSDate *rowDate = [formatter dateFromString:[NSString stringWithUTF8String:date]];
//                    
//                    if (([rowDate compare:[formatter dateFromString:startDate]] == NSOrderedDescending || [rowDate compare:[formatter dateFromString:startDate]] == NSOrderedSame) && ([rowDate compare:[formatter dateFromString:endDate]] == NSOrderedAscending || [rowDate compare:[formatter dateFromString:endDate]] == NSOrderedSame))
//                    {
                        char* c3 = (char*) sqlite3_column_text(statement,4);
                        NSString *tmp3;
                        if (c3!= NULL)
                        {
//                            NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
//                            [dateFormatter setTimeZone:[NSTimeZone defaultTimeZone]];
//                            [dateFormatter setDateFormat:@"MMM d YYYY HH:mm:ss"];
//                            NSDate *rowDate = [dateFormatter dateFromString:[NSString stringWithUTF8String:date]];
//                            
////                            NSDate* sourceDate = [NSDate date];
//                            
//                            NSLog(@"DB DATE = %@", [NSString stringWithUTF8String:date]);
//                            
//                            [dateFormatter setDateFormat:@"MMM dd, yyyy"];
//                            
//                            NSDate *finaldate = [dateFormatter dateFromString:[dateFormatter stringFromDate:rowDate]];
                            
//                            NSDate *sourceDate = [NSDate date];
//                            NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
//                            NSTimeZone* destinationTimeZone = [NSTimeZone systemTimeZone];
//                            
//                            NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:sourceDate];
//                            NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:sourceDate];
//                            NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
//                            
//                            NSDate* destinationDate = [[[NSDate alloc] initWithTimeInterval:interval sinceDate:finaldate] autorelease];
                            NSArray *dateComponents = [[[NSArray alloc] initWithArray:[[NSString stringWithUTF8String:date] componentsSeparatedByString:@" "]] autorelease];
                            
//                            NSLog(@"Date = %@", destinationDate);
//                            NSLog(@"STring From Date = %@", [dateFormatter stringFromDate:destinationDate]);
                            tmp3= [NSString stringWithUTF8String:c3];
//                            NSLog(@"value form db :%@",tmp3);
                            [averageArray addObject:[NSNumber numberWithFloat:[tmp3 floatValue]]];
                            [datesArray addObject:[NSString stringWithFormat:@"%@ %@,\n  %@", [dateComponents objectAtIndex:0], [dateComponents objectAtIndex:1], [dateComponents objectAtIndex:2]]];
                        }
                        
//                    }
                }
            }
            sqlite3_finalize(statement);
            sqlite3_close(exerciseDB);
        }
        NSLog(@"AVERAGES ARRAY = %@", averageArray);
        NSLog(@"DATES ARRAY = %@", datesArray);
        if ([datesArray count] > 0 && [averageArray count] > 0)
        {
            _presentDate = [NSString stringWithString:[datesArray lastObject]];
            _oldDate = [NSString stringWithString:[datesArray objectAtIndex:0]];
            [self initPlot];
        }
        else
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"No Entries to plot graph" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
            [alertView release];
        }
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
//{
//    // Return YES for supported orientations
//	return YES;
//}

#pragma mark - Chart behavior
-(void)initPlot {
    [self configureHost];
    [self configureGraph];
    [self configurePlots];
    [self configureAxes];
}

-(void)configureHost {
	self.hostView = [(CPTGraphHostingView *) [CPTGraphHostingView alloc] initWithFrame:self.view.bounds];
	self.hostView.allowPinchScaling = NO;
//    self.hostView.backgroundColor = [UIColor redColor];
	[self.view addSubview:self.hostView];
}

-(void)configureGraph {
	// 1 - Create the graph
	CPTGraph *graph = [[CPTXYGraph alloc] initWithFrame:self.hostView.bounds];
	[graph applyTheme:[CPTTheme themeNamed:kCPTPlainWhiteTheme]];
	self.hostView.hostedGraph = graph;
	// 2 - Set graph title
    NSString *title;
    if (_isComparisonGraph)
    {
        NSArray *dateComponents1 = [[[NSArray alloc] initWithArray:[_presentDate componentsSeparatedByString:@" "]] autorelease];
        NSArray *dateComponents2 = [[[NSArray alloc] initWithArray:[_oldDate componentsSeparatedByString:@" "]] autorelease];
        
        title = [NSString stringWithFormat:@"Jämförelse %@ - %@", [NSString stringWithFormat:@"%@ %@, %@", [dateComponents1 objectAtIndex:0], [dateComponents1 objectAtIndex:1], [dateComponents1 objectAtIndex:2]], [NSString stringWithFormat:@"%@ %@, %@", [dateComponents2 objectAtIndex:0], [dateComponents2 objectAtIndex:1], [dateComponents2 objectAtIndex:2]]];
    }
    else
    {
        title = [NSString stringWithFormat:@"Utveckling %@ - %@", [datesArray lastObject], [datesArray objectAtIndex:0]];
    }
	graph.title = title;
	// 3 - Create and set text style
	CPTMutableTextStyle *titleStyle = [CPTMutableTextStyle textStyle];
	titleStyle.color = [CPTColor blackColor];
	titleStyle.fontName = @"Helvetica-Bold";
	titleStyle.fontSize = 16.0f;
	graph.titleTextStyle = titleStyle;
	graph.titlePlotAreaFrameAnchor = CPTRectAnchorTop;
	graph.titleDisplacement = CGPointMake(0.0f, 10.0f);
	// 4 - Set padding for plot area
	[graph.plotAreaFrame setPaddingLeft:10.0f];
	[graph.plotAreaFrame setPaddingBottom:10.0f];
	// 5 - Enable user interactions for plot space
	CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *) graph.defaultPlotSpace;
	plotSpace.allowsUserInteraction = YES;
}

-(void)configurePlots {
	// 1 - Get graph and plot space
	CPTGraph *graph = self.hostView.hostedGraph;
	CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *) graph.defaultPlotSpace;
    
    if (_isComparisonGraph)
    {
        // 2 - Create the two plots
        CPTScatterPlot *presentPlot = [[CPTScatterPlot alloc] init];
        presentPlot.dataSource = self;
        presentPlot.identifier = _presentDate;
        CPTColor *presentColor = [CPTColor redColor];
        [graph addPlot:presentPlot toPlotSpace:plotSpace];
        
        CPTScatterPlot *oldPlot = [[CPTScatterPlot alloc] init];
        oldPlot.dataSource = self;
        oldPlot.identifier = _oldDate;
        CPTColor *oldColor = [CPTColor greenColor];
        [graph addPlot:oldPlot toPlotSpace:plotSpace];
        
        // 3 - Set up plot space
//        [plotSpace scaleToFitPlots:[NSArray arrayWithObjects:presentPlot, oldPlot, nil]];
        
        CPTMutablePlotRange *xRange = [plotSpace.xRange mutableCopy];
        [xRange expandRangeByFactor:CPTDecimalFromCGFloat(6.2f)];
        plotSpace.xRange = xRange;
        CPTMutablePlotRange *yRange = [plotSpace.yRange mutableCopy];
        [yRange expandRangeByFactor:CPTDecimalFromCGFloat(11.6f)];
        plotSpace.yRange = yRange;
        // 4 - Create styles and symbols
        CPTMutableLineStyle *presentLineStyle = [presentPlot.dataLineStyle mutableCopy];
        presentLineStyle.lineWidth = 2.5;
        presentLineStyle.lineColor = presentColor;
        presentPlot.dataLineStyle = presentLineStyle;
        CPTMutableLineStyle *presentSymbolLineStyle = [CPTMutableLineStyle lineStyle];
        presentSymbolLineStyle.lineColor = presentColor;
        CPTPlotSymbol *presentSymbol = [CPTPlotSymbol ellipsePlotSymbol];
        presentSymbol.fill = [CPTFill fillWithColor:presentColor];
        presentSymbol.lineStyle = presentSymbolLineStyle;
        presentSymbol.size = CGSizeMake(6.0f, 6.0f);
        presentPlot.plotSymbol = presentSymbol;
        
        CPTMutableLineStyle *oldLineStyle = [oldPlot.dataLineStyle mutableCopy];
        oldLineStyle.lineWidth = 1.0;
        oldLineStyle.lineColor = oldColor;
        oldPlot.dataLineStyle = oldLineStyle;
        CPTMutableLineStyle *oldSymbolLineStyle = [CPTMutableLineStyle lineStyle];
        oldSymbolLineStyle.lineColor = oldColor;
        CPTPlotSymbol *oldSymbol = [CPTPlotSymbol starPlotSymbol];
        oldSymbol.fill = [CPTFill fillWithColor:oldColor];
        oldSymbol.lineStyle = oldSymbolLineStyle;
        oldSymbol.size = CGSizeMake(6.0f, 6.0f);
        oldPlot.plotSymbol = oldSymbol;
    }
    else
    {
        CPTScatterPlot *presentPlot = [[CPTScatterPlot alloc] init];
        presentPlot.dataSource = self;
        presentPlot.identifier = _presentDate;
        CPTColor *presentColor = [CPTColor redColor];
        [graph addPlot:presentPlot toPlotSpace:plotSpace];
        
        // 3 - Set up plot space
//        [plotSpace scaleToFitPlots:[NSArray arrayWithObjects:presentPlot, nil]];
        
        CPTMutablePlotRange *xRange = [plotSpace.xRange mutableCopy];
        [xRange expandRangeByFactor:CPTDecimalFromCGFloat(6.2f)];
        plotSpace.xRange = xRange;
        CPTMutablePlotRange *yRange = [plotSpace.yRange mutableCopy];
        [yRange expandRangeByFactor:CPTDecimalFromCGFloat(11.6f)];
        plotSpace.yRange = yRange;
        
        // 4 - Create styles and symbols
        CPTMutableLineStyle *presentLineStyle = [presentPlot.dataLineStyle mutableCopy];
        presentLineStyle.lineWidth = 2.5;
        presentLineStyle.lineColor = presentColor;
        presentPlot.dataLineStyle = presentLineStyle;
        CPTMutableLineStyle *presentSymbolLineStyle = [CPTMutableLineStyle lineStyle];
        presentSymbolLineStyle.lineColor = presentColor;
        CPTPlotSymbol *presentSymbol = [CPTPlotSymbol ellipsePlotSymbol];
        presentSymbol.fill = [CPTFill fillWithColor:presentColor];
        presentSymbol.lineStyle = presentSymbolLineStyle;
        presentSymbol.size = CGSizeMake(6.0f, 6.0f);
        presentPlot.plotSymbol = presentSymbol;
    }
}

-(void)configureAxes {
	// 1 - Create styles
	CPTMutableTextStyle *axisTitleStyle = [CPTMutableTextStyle textStyle];
	axisTitleStyle.color = [CPTColor blackColor];
	axisTitleStyle.fontName = @"Helvetica-Bold";
	axisTitleStyle.fontSize = 12.0f;
	CPTMutableLineStyle *axisLineStyle = [CPTMutableLineStyle lineStyle];
	axisLineStyle.lineWidth = 2.0f;
	axisLineStyle.lineColor = [CPTColor blackColor];
	CPTMutableTextStyle *axisTextStyle = [[CPTMutableTextStyle alloc] init];
	axisTextStyle.color = [CPTColor blackColor];
	axisTextStyle.fontName = @"Helvetica-Bold";
	axisTextStyle.fontSize = 11.0f;
	CPTMutableLineStyle *tickLineStyle = [CPTMutableLineStyle lineStyle];
	tickLineStyle.lineColor = [CPTColor blackColor];
	tickLineStyle.lineWidth = 2.0f;
//	CPTMutableLineStyle *gridLineStyle = [CPTMutableLineStyle lineStyle];
//	tickLineStyle.lineColor = [CPTColor blackColor];
//	tickLineStyle.lineWidth = 1.0f;
	// 2 - Get axis set
	CPTXYAxisSet *axisSet = (CPTXYAxisSet *) self.hostView.hostedGraph.axisSet;
	// 3 - Configure x-axis
	CPTAxis *x = axisSet.xAxis;
	x.titleTextStyle = axisTitleStyle;
    if (_isComparisonGraph)
    {
        x.titleOffset = 15.0f;
        x.title = @"Områden";
    }
    else
    {
        x.titleOffset = 30.0f;
        x.title = @"Datum";
    }
	x.axisLineStyle = axisLineStyle;
	x.labelingPolicy = CPTAxisLabelingPolicyNone;
	x.labelTextStyle = axisTextStyle;
	x.majorTickLineStyle = axisLineStyle;
	x.majorTickLength = 4.0f;
	x.tickDirection = CPTSignNegative;
    
	CGFloat dateCount = 10;
	NSMutableSet *xLabels = [NSMutableSet setWithCapacity:dateCount];
	NSMutableSet *xLocations = [NSMutableSet setWithCapacity:dateCount];
	NSInteger i = 0;
    
    NSArray *array;
    
    if (_isComparisonGraph)
    {
        array = [[NSArray alloc] initWithObjects:@"Fam", @"Vän", @"Kär", @"Arb", @"Eko", @"Kost", @"Mot", @"Vila", @"Frit", @"Sömn", nil];
        x.visibleRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(0) length:CPTDecimalFromFloat(10)];
    }
    else
    {
        array = [[NSArray alloc] initWithArray:datesArray];
        x.visibleRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(0) length:CPTDecimalFromFloat([datesArray count])];
    }
    
	for (NSString *date in array)
    {
		CPTAxisLabel *label = [[CPTAxisLabel alloc] initWithText:date  textStyle:x.labelTextStyle];
		CGFloat location = i++;
		label.tickLocation = CPTDecimalFromCGFloat(location);
		label.offset = x.majorTickLength;
		if (label)
        {
			[xLabels addObject:label];
			[xLocations addObject:[NSNumber numberWithFloat:location]];
		}
	}
    
	x.axisLabels = xLabels;
	x.majorTickLocations = xLocations;
	// 4 - Configure y-axis
	CPTAxis *y = axisSet.yAxis;
	y.title = @"Medelvärde";
	y.titleTextStyle = axisTitleStyle;
	y.titleOffset = -40.0f;
	y.axisLineStyle = axisLineStyle; 
//	y.majorGridLineStyle = gridLineStyle;
	y.labelingPolicy = CPTAxisLabelingPolicyNone;
	y.labelTextStyle = axisTextStyle;
	y.labelOffset = 16.0f;
	y.majorTickLineStyle = axisLineStyle;
	y.majorTickLength = 4.0f;
	y.minorTickLength = 2.0f;
	y.tickDirection = CPTSignPositive;
    y.visibleRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(0) length:CPTDecimalFromFloat(10)];
	NSInteger majorIncrement = 1;
	NSInteger minorIncrement = 1;
	CGFloat yMax = 10.0f;  // should determine dynamically based on max price
	NSMutableSet *yLabels = [NSMutableSet set];
	NSMutableSet *yMajorLocations = [NSMutableSet set];
	NSMutableSet *yMinorLocations = [NSMutableSet set];
	for (NSInteger j = minorIncrement; j <= yMax; j += minorIncrement) {
		NSUInteger mod = j % majorIncrement;
		if (mod == 0) {
			CPTAxisLabel *label = [[CPTAxisLabel alloc] initWithText:[NSString stringWithFormat:@"%i", j] textStyle:y.labelTextStyle];
			NSDecimal location = CPTDecimalFromInteger(j);
			label.tickLocation = location;
			label.offset = - y.majorTickLength - y.labelOffset;
			if (label) {
				[yLabels addObject:label];
			}
			[yMajorLocations addObject:[NSDecimalNumber decimalNumberWithDecimal:location]];
		} else {
			[yMinorLocations addObject:[NSDecimalNumber decimalNumberWithDecimal:CPTDecimalFromInteger(j)]];
		}
	}
	y.axisLabels = yLabels;
	y.majorTickLocations = yMajorLocations;
	y.minorTickLocations = yMinorLocations;
}

//#pragma mark - Rotation
//-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
//    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
//}

- (NSArray *)getValuesForDate:(NSString *)date
{
    NSString *docsDir;
    NSArray *dirPaths;
    sqlite3 *exerciseDB;
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    
    // Build the path to the database file
    NSString *databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"exerciseDB.db"]];
    // const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt    *statement;
    if (sqlite3_open([databasePath UTF8String], &exerciseDB) == SQLITE_OK) {
        
        NSString *sql = [NSString stringWithFormat: @"SELECT * FROM EXERCISE7 WHERE date='%@'", date];
        
        const char *del_stmt = [sql UTF8String];
        
        sqlite3_prepare_v2(exerciseDB, del_stmt, -1, & statement, NULL);
        while (sqlite3_step(statement) == SQLITE_ROW)
        {
            char* c4 = (char*) sqlite3_column_text(statement,5);
            NSString *tmp4;
            if (c4!= NULL){
                tmp4= [NSString stringWithUTF8String:c4];
                NSLog(@"value form db :%@",tmp4);
                [array addObject:[NSNumber numberWithInt:[tmp4 intValue]]];
//                tf1.text = tmp4;
            }
            
            char* c5 = (char*) sqlite3_column_text(statement,6);
            NSString *tmp5;
            if (c5!= NULL){
                tmp5= [NSString stringWithUTF8String:c5];
                NSLog(@"value form db :%@",tmp5);
                [array addObject:[NSNumber numberWithInt:[tmp5 intValue]]];
//                tf2.text = tmp5;
            }
            
            char* c6 = (char*) sqlite3_column_text(statement,7);
            NSString *tmp6;
            if (c6!= NULL){
                tmp6= [NSString stringWithUTF8String:c6];
                NSLog(@"value form db :%@",tmp6);
                [array addObject:[NSNumber numberWithInt:[tmp6 intValue]]];
//                tf3.text = tmp6;
            }
            
            char* c7 = (char*) sqlite3_column_text(statement,8);
            NSString *tmp7;
            if (c7!= NULL){
                tmp7= [NSString stringWithUTF8String:c7];
                NSLog(@"value form db :%@",tmp7);
                [array addObject:[NSNumber numberWithInt:[tmp7 intValue]]];
//                tf4.text = tmp7;
            }
            
            char* c8 = (char*) sqlite3_column_text(statement,9);
            NSString *tmp8;
            if (c8!= NULL){
                tmp8= [NSString stringWithUTF8String:c8];
                NSLog(@"value form db :%@",tmp8);
                [array addObject:[NSNumber numberWithInt:[tmp8 intValue]]];
//                tf5.text = tmp8;
            }
            
            char* c9 = (char*) sqlite3_column_text(statement,10);
            NSString *tmp9;
            if (c9!= NULL){
                tmp9= [NSString stringWithUTF8String:c9];
                NSLog(@"value form db :%@",tmp9);
                [array addObject:[NSNumber numberWithInt:[tmp9 intValue]]];
//                tf6.text = tmp9;
            }
            
            char* c10 = (char*) sqlite3_column_text(statement,11);
            NSString *tmp10;
            if (c10!= NULL){
                tmp10= [NSString stringWithUTF8String:c10];
                NSLog(@"value form db :%@",tmp10);
                [array addObject:[NSNumber numberWithInt:[tmp10 intValue]]];
//                tf7.text = tmp10;
            }
            
            char* c11 = (char*) sqlite3_column_text(statement,12);
            NSString *tmp11;
            if (c11!= NULL){
                tmp11= [NSString stringWithUTF8String:c11];
                NSLog(@"value form db :%@",tmp11);
                [array addObject:[NSNumber numberWithInt:[tmp11 intValue]]];
//                tf8.text = tmp11;
            }
            
            char* c12 = (char*) sqlite3_column_text(statement,13);
            NSString *tmp12;
            if (c12!= NULL){
                tmp12= [NSString stringWithUTF8String:c12];
                NSLog(@"value form db :%@",tmp12);
                [array addObject:[NSNumber numberWithInt:[tmp12 intValue]]];
//                tf9.text = tmp12;
            }
            
            char* c13 = (char*) sqlite3_column_text(statement,14);
            NSString *tmp13;
            if (c13!= NULL){
                tmp13= [NSString stringWithUTF8String:c13];
                NSLog(@"value form db :%@",tmp13);
                [array addObject:[NSNumber numberWithInt:[tmp13 intValue]]];
//                tf10.text = tmp13;
            }
        }
        
        sqlite3_finalize(statement);
        sqlite3_close(exerciseDB);
    }
    
    return array;
}

#pragma mark - CPTPlotDataSource methods
-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot
{
    if (_isComparisonGraph)
        return 10;
    else
        return [datesArray count];
}

-(NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index
{
//	NSInteger valueCount = [[[CPDStockPriceStore sharedInstance] datesInMonth] count];
	switch (fieldEnum) {
		case CPTScatterPlotFieldX:
			if (index < (_isComparisonGraph ? 10 : [datesArray count])) {
				return [NSNumber numberWithUnsignedInteger:index];
			}
			break;
			
		case CPTScatterPlotFieldY:
            if (_isComparisonGraph)
            {
                if ([plot.identifier isEqual:_presentDate] == YES) {
                    return [presentArray objectAtIndex:index];
                } else if ([plot.identifier isEqual:_oldDate] == YES) {
                    return [olderArray objectAtIndex:index];
                }
            }
            else
            {
                if ([plot.identifier isEqual:_presentDate] == YES)
                    return [averageArray objectAtIndex:index];
            }
			break;
	}
	return [NSDecimalNumber zero];
}

@end
