//Copyright 2017 Nick Wilkerson
//
//Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#import <UIKit/UIKit.h>
#import "TVPoint.h"


typedef enum TVTrendViewStyle {
    TVTrendViewStyleDefault,
    TVTrendViewStyleNoVerticalLines,
    TVTrendViewStyleNoLines,
    TVTrendViewStyleFull,
    TVTrendViewStyleFullNoVerticalLines,
    TVTrendViewStyleFullNoLines,
    TVTrendViewStyleScatter,
    TVTrendViewStyleFullScatter,
    TVTrendViewStyleTimeSeries,
    TVTrendViewStyleLineAndScatterTimeSeries
} TVTrendViewStyle;

typedef struct TVDataRanges {
    double minX;
    double minY;
    double maxX;
    double maxY;
} TVDataRanges;

//VKDataRanges rangesMake(double minX, double minY, double maxX, double maxY);

@protocol TVTrendViewDatasource;
@protocol TVTrendViewDelegate;

@interface TVTrendView : UIView {
    TVTrendViewStyle _style;
    UILabel *_titleLabel;
    UILabel *_xAxisLabel;
    UILabel *_yAxisLabel;
    UILabel *_xUnitsLabel;
    UILabel *_yUnitsLabel;
    BOOL _showXValues;
    BOOL _connectPoints;
    BOOL _showPoints;
    BOOL initialized;
}

-(id)initWithFrame:(CGRect)frame style:(TVTrendViewStyle)style;
-(TVDataRanges) dataRangeWithMinX:(double)minX minY:(double)minY maxX:(double)maxX maxY:(double) maxY;
@property (nonatomic, weak) id<TVTrendViewDatasource> datasource;
@property (nonatomic, weak) id<TVTrendViewDelegate> delegate;
@property (nonatomic) CGPoint drawingOrigin;
@property (nonatomic) CGSize drawingSize;
@property double lineWidth;

@property (nonatomic) TVTrendViewStyle style;
@property (nonatomic) NSString *titleText;
@property (nonatomic) NSString *xAxisLabelText;
@property (nonatomic) NSString *yAxisLabelText;
@property (nonatomic) NSString *xUnits;
@property (nonatomic) NSString *yUnits;
@property BOOL drawHorizontalLines;
@property BOOL drawVerticalLines;
@property BOOL showYValues;
@property BOOL showXValues;
@property BOOL connectPoints;
@property BOOL showPoints;
@end


@protocol TVTrendViewDatasource <NSObject>
@required
-(NSUInteger)numberOfSeriesInTrendView:(TVTrendView *)trendView;
-(NSUInteger)trendView:(TVTrendView *)trendView numberOfElementsInSeries:(long)series;
-(id<TVPointProtocol>)trendView:(TVTrendView *)trendView pointInSeries:(long)series forIndex:(long)index;
-(TVDataRanges)dataRangesForTrendView:(TVTrendView *)trendView;

@optional
-(UIColor *)trendView:(TVTrendView *)trendView colorForSeries:(long)series;
-(BOOL)highlightPointInSeries:(NSInteger)series atIndex:(NSInteger)index;

@end


@protocol TVTrendViewDelegate <NSObject>
@required

@optional

@end
