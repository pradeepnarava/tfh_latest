//
//  TUTSimpleScatterPlot.h
//  Core Plot Introduction
//
//  Created by John Wordsworth on 20/10/2011.
//

#import <Foundation/Foundation.h>
#import "CorePlot-CocoaTouch.h"

@interface TUTSimpleScatterPlot : NSObject <CPTScatterPlotDataSource> {
	CPTGraphHostingView *_hostingView;	
	CPTXYGraph *_graph;
	NSMutableArray *_graphData;
}

@property (nonatomic, retain) CPTGraphHostingView *hostingView;
@property (nonatomic, retain) CPTXYGraph *graph;
@property (nonatomic, retain) NSMutableArray *graphData;

// Methods to create this object and attach it to it's hosting view.
+(TUTSimpleScatterPlot *)plotWithHostingView:(CPTGraphHostingView *)hostingView andData:(NSMutableArray *)data;
-(id)initWithHostingView:(CPTGraphHostingView *)hostingView andData:(NSMutableArray *)data;

// Specific code that creates the scatter plot.
-(void)initialisePlot;

@end
