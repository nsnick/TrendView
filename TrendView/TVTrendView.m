//Copyright 2017 Nick Wilkerson
//
//Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#import "TVTrendView.h"

@interface TVTrendView() {
    CGSize _drawingSize;
    CGPoint _drawingOrigin;
    NSMutableArray *verticalLabels;
    NSMutableArray *horizontalLabels;
    BOOL fullView;
    double titleSize;
    double axisLabelSize;
    double numberLabelSize;
}


@end




@implementation TVTrendView

@synthesize style=_style;
@synthesize drawingOrigin=_drawingOrigin;
@synthesize drawingSize=_drawingSize;
@synthesize delegate;
@synthesize datasource;
@synthesize drawHorizontalLines;
@synthesize showYValues;
@synthesize lineWidth;
@synthesize connectPoints=_connectPoints;
@synthesize showPoints=_showPoints;

-(id)initWithFrame:(CGRect)frame style:(TVTrendViewStyle)style {
    NSLog(@"VKTrendView - initWithFrame style: %d", style);
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.style = style;
        verticalLabels = [[NSMutableArray alloc] init];
        horizontalLabels = [[NSMutableArray alloc] init];
        if (self.style == TVTrendViewStyleDefault) {
            NSLog(@"VKTrendViewStyleDefault!");
        }
        NSLog(@"1self.style: %d", self.style);
        initialized = TRUE;
            [self setDimensionsWithFrame:frame];
           [self setNeedsDisplay];
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame {
    NSLog(@"VKTrendView - initWithFrame");
    return [self initWithFrame:frame style:TVTrendViewStyleDefault];
}

-(void)setFrame:(CGRect)frame {
    [super setFrame:frame];
//    [self setDimensionsWithFrame:frame];
 //   [self setNeedsDisplay];
}

-(void)setDimensionsWithFrame:(CGRect)frame {
    if (!initialized) {
        NSLog(@"!!! not initialized!!!");
        return;
    }
    NSLog(@"2self.style: %d", self.style);
    //    printf("setDimensionsWithFrame\n");
    if (self.style == TVTrendViewStyleDefault) {
        NSLog(@"VKTrendViewStyleDefault");
    }
    if (self.style == TVTrendViewStyleDefault || self.style == TVTrendViewStyleTimeSeries) {
        NSLog(@"VKTrendViewStyleTimeSeries");
        self.showYValues = TRUE;
        _showXValues = TRUE;
        self.drawHorizontalLines = TRUE;
        self.drawVerticalLines = TRUE;
        fullView = FALSE;
        _drawingSize = CGSizeMake(frame.size.width * 0.84, frame.size.height * 0.74);
        _drawingOrigin = CGPointMake(frame.size.width * 0.1,
                                     frame.size.height * 0.12);
        self.lineWidth = 1;
        self.connectPoints = TRUE;
        self.showPoints = FALSE;
    } else if (self.style == TVTrendViewStyleLineAndScatterTimeSeries) {
        NSLog(@"VKTrendViewStyleLineAndScatterTimeSeries");
        self.showYValues = TRUE;
        _showXValues = TRUE;
        self.drawHorizontalLines = TRUE;
        self.drawVerticalLines = TRUE;
        fullView = FALSE;
        _drawingSize = CGSizeMake(frame.size.width * 0.84, frame.size.height * 0.74);
        _drawingOrigin = CGPointMake(frame.size.width * 0.1,
                                     frame.size.height * 0.12);
        self.lineWidth = 1;
        self.connectPoints = TRUE;
        self.showPoints = TRUE;
    } else if (self.style == TVTrendViewStyleNoVerticalLines) {
        NSLog(@"VKTrendViewStyleNoVerticalLines");
        self.showYValues = TRUE;
        self.showXValues = TRUE;
        self.drawHorizontalLines = TRUE;
        self.drawVerticalLines = FALSE;
        fullView = FALSE;
        _drawingSize = CGSizeMake(frame.size.width * 0.84, frame.size.height * 0.75);
        _drawingOrigin = CGPointMake(frame.size.width * 0.1,
                                     frame.size.height * 0.12);
        self.lineWidth = 1;
        self.connectPoints = TRUE;
        self.showPoints = FALSE;
    } else if (self.style == TVTrendViewStyleNoLines) {
        NSLog(@"VKTrendViewStyleNoLines");
        self.showYValues = TRUE;
        self.showXValues = TRUE;
        self.drawHorizontalLines = FALSE;
        self.drawVerticalLines = FALSE;
        fullView = FALSE;
        _drawingSize = CGSizeMake(frame.size.width * 0.84, frame.size.height * 0.75);
        _drawingOrigin = CGPointMake(frame.size.width * 0.1,
                                     frame.size.height * 0.12);
        self.lineWidth = 1;
        self.connectPoints = TRUE;
        self.showPoints = FALSE;
    } else if (self.style == TVTrendViewStyleFull) {
        NSLog(@"VKTrendViewStyleFull");
        fullView = TRUE;
        _drawingSize = frame.size;
        _drawingOrigin = CGPointMake(0, 0);
        self.drawHorizontalLines = TRUE;
        self.drawVerticalLines = TRUE;
        self.lineWidth = 1;
        self.showYValues = TRUE;
        self.showXValues = TRUE;
        self.connectPoints = TRUE;
        self.showPoints = FALSE;
    } else if (self.style == TVTrendViewStyleFullNoVerticalLines) {
        NSLog(@"VKTrendViewStyleFullNoVerticalLines");
        fullView = TRUE;
        _drawingSize = frame.size;
        _drawingOrigin = CGPointMake(0, 0);
        self.drawHorizontalLines = TRUE;
        self.drawVerticalLines = FALSE;
        self.lineWidth = 1;
        self.showYValues = TRUE;
        self.showXValues = TRUE;
        self.connectPoints = TRUE;
        self.showPoints = FALSE;
    } else if (self.style == TVTrendViewStyleFullNoLines) {
        NSLog(@"VKTrendViewStyleFullNoLines");
        fullView = TRUE;
        _drawingSize = frame.size;
        _drawingOrigin = CGPointMake(0, 0);
        self.drawHorizontalLines = FALSE;
        self.drawVerticalLines = FALSE;
        self.lineWidth = 1;
        self.showYValues = TRUE;
        self.showXValues = TRUE;
        self.connectPoints = TRUE;
        self.showPoints = FALSE;
    } else if (self.style == TVTrendViewStyleScatter) {
        NSLog(@"VKTrendViewStyleScatter");
        fullView = FALSE;
        _drawingSize = CGSizeMake(frame.size.width * 0.84, frame.size.height * 0.85);
        _drawingOrigin = CGPointMake(frame.size.width * 0.1,
                                     frame.size.height * 0.1);
        self.drawHorizontalLines = FALSE;
        self.lineWidth = 1;
        self.showYValues = TRUE;
        self.showXValues = TRUE;
        self.connectPoints = FALSE;
        self.showPoints = TRUE;
    } else if (self.style == TVTrendViewStyleFullScatter) {
        NSLog(@"VKTrendViewStyleFullScatter");
        fullView = TRUE;
        _drawingSize = frame.size;
        _drawingOrigin = CGPointMake(0, 0);
        self.drawHorizontalLines = FALSE;
        self.lineWidth = 1;
        self.showYValues = TRUE;
        self.showXValues = TRUE;
        self.connectPoints = FALSE;
        self.showPoints = TRUE;
    } else {
        
    }
    
    [self createLabelsWithFrame:frame];
    
}

-(void)createLabelsWithFrame:(CGRect)frame {
    
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
    }
    if (_xAxisLabel == nil) {
        _xAxisLabel = [[UILabel alloc] init];
    }
    if (_yAxisLabel == nil) {
        _yAxisLabel = [[UILabel alloc] init];
    } else {
        [_yAxisLabel setTransform:CGAffineTransformIdentity];
    }
    //    printf("creating labels\n");
    _titleLabel.frame = CGRectMake(0,
                                   0,
                                   frame.size.width,
                                   frame.size.height*0.12);
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    if (fullView) {
        _xAxisLabel.frame = CGRectMake(0,
                                       frame.size.height * 0.85,
                                       frame.size.width,
                                       frame.size.height * 0.1);
    } else {
        _xAxisLabel.frame = CGRectMake(0,
                                       frame.size.height * 0.9,
                                       frame.size.width,
                                       frame.size.height * 0.1);
    }
    _xAxisLabel.textAlignment = NSTextAlignmentCenter;
    CGRect yAxisLabelRect;
    if (fullView) {
        yAxisLabelRect = CGRectMake(-frame.size.width/2.32,
                                    frame.size.height / 2.2,
                                    frame.size.width,
                                    frame.size.width * 0.08);
    } else {
        yAxisLabelRect = CGRectMake(-frame.size.width/2.12,
                                    frame.size.height / 2.2,
                                    frame.size.width,
                                    frame.size.width * 0.08);
    }
    _yAxisLabel.frame = yAxisLabelRect;
    _yAxisLabel.textAlignment = NSTextAlignmentCenter;
    [_yAxisLabel setTransform:CGAffineTransformMakeRotation(-M_PI / 2)];
    double minDimension = fmin(frame.size.height, frame.size.width);
    titleSize = minDimension / 22;
    axisLabelSize = minDimension / 20;
    _titleLabel.font = [UIFont systemFontOfSize:titleSize];
    _xAxisLabel.font = [UIFont systemFontOfSize:axisLabelSize];
    _yAxisLabel.font = [UIFont systemFontOfSize:axisLabelSize];
    [self addSubview:_titleLabel];
    [self addSubview:_xAxisLabel];
    [self addSubview:_yAxisLabel];
}

-(void)layoutSubviews {
    
}

- (void)drawRect:(CGRect)rect {
    NSLog(@"VKTrendView - drawRect");
    for (UILabel *label in verticalLabels) {
        [label removeFromSuperview];
    }
    [verticalLabels removeAllObjects];
    for (UILabel *label in horizontalLabels) {
        [label removeFromSuperview];
    }
    [horizontalLabels removeAllObjects];
    /* sizes */
    double minDimension = fmin(self.bounds.size.height, self.bounds.size.width);
    numberLabelSize = minDimension / 25;
    titleSize = minDimension / 16;
    axisLabelSize = minDimension / 20;
    _titleLabel.font = [UIFont systemFontOfSize:titleSize];
    _xAxisLabel.font = [UIFont systemFontOfSize:axisLabelSize];
    _yAxisLabel.font = [UIFont systemFontOfSize:axisLabelSize];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self drawAxis:context];
    [self drawHorizontalLines:context];
    [self drawVerticalLines:context];
    [self drawData:context];
    
}

-(void)drawAxis:(CGContextRef)context {
    /* draw axis */
    CGContextSetLineWidth(context, self.lineWidth);
    
    CGContextMoveToPoint(context, self.drawingOrigin.x, self.drawingOrigin.y);
    CGContextAddLineToPoint(context,
                            self.drawingOrigin.x,
                            self.drawingOrigin.y + self.drawingSize.height);
    CGContextAddLineToPoint(context,
                            self.drawingOrigin.x + self.drawingSize.width,
                            self.drawingOrigin.y + self.drawingSize.height);
    CGContextStrokePath(context);
}

-(void)drawHorizontalLines:(CGContextRef)context {
    CGContextSetLineWidth(context, self.lineWidth * 0.6);
    
    CGFloat dashedLinesLength[]   = {self.drawingSize.width * 0.006, self.drawingSize.width * 0.003};
    static size_t const dashedCount            = (2.0f);
    CGContextSetLineDash(context, 0, dashedLinesLength, dashedCount);
    TVDataRanges ranges = [self.datasource dataRangesForTrendView:self];
    double dataHeight = ranges.maxY - ranges.minY;
    long dataMagY = (long)log10(dataHeight);
    
    double horizontalLineHeight;
    double distanceBetweenHorizontalLines;
    double rangeFactor = 1;
    //    printf("dataMagY %d\n", dataMagY);
    if ( dataMagY < 1) {
        rangeFactor = pow(10, labs(dataMagY) + 1);
    }
    //    printf("rangeFactor %f\n", rangeFactor);
    //    printf("ranges.maxY * rangeFactor = %f\n", ranges.maxY*rangeFactor);
    
    if (dataHeight / pow(10,dataMagY-1) > 50) {
        distanceBetweenHorizontalLines = pow(10, dataMagY-1)*10;
        horizontalLineHeight = (double)(((long)(ranges.maxY *rangeFactor) / (long)(distanceBetweenHorizontalLines * rangeFactor)) * distanceBetweenHorizontalLines);
    } else if (dataHeight / pow(10,dataMagY-1) > 20) {
        distanceBetweenHorizontalLines = pow(10, dataMagY-1)*5;
        horizontalLineHeight = (double)(((long)(ranges.maxY * rangeFactor) / (long)(distanceBetweenHorizontalLines * rangeFactor)) * distanceBetweenHorizontalLines);
    } else if (dataHeight / pow(10,dataMagY-1) > 10) {
        distanceBetweenHorizontalLines = pow(10, dataMagY-1)*2;
        horizontalLineHeight = (double)(((long)(ranges.maxY * rangeFactor) / (long)(distanceBetweenHorizontalLines * rangeFactor)) *distanceBetweenHorizontalLines);
    } else {
        distanceBetweenHorizontalLines = pow(10, dataMagY-1);
        horizontalLineHeight = (double)(((long)(ranges.maxY * rangeFactor) / (long)(distanceBetweenHorizontalLines * rangeFactor)) * distanceBetweenHorizontalLines);
    }
    //    printf("distanceBetweenHorizontalLines = %f\n", distanceBetweenHorizontalLines);
    //    printf("horizontalLineHeight %f\n", horizontalLineHeight);
    
    while (horizontalLineHeight > ranges.minY) {
        //        printf("minY %lf", ranges.minY);
        /* show horizontal lines */
        if (self.drawHorizontalLines) {
            CGContextMoveToPoint(context,
                                 self.drawingOrigin.x,
                                 self.drawingOrigin.y + self.drawingSize.height - ((horizontalLineHeight-ranges.minY) * self.drawingSize.height/dataHeight));
            CGContextAddLineToPoint(context,
                                    self.drawingOrigin.x + self.drawingSize.width,
                                    self.drawingOrigin.y + self.drawingSize.height - ((horizontalLineHeight-ranges.minY) * self.drawingSize.height/dataHeight));
            CGContextStrokePath(context);
        }
        /* show vertical labels */
        double minDimension = fmin(self.bounds.size.height, self.bounds.size.width);
        if (self.showYValues){
            CGRect verticalLabelFrame;
            UILabel *verticalLabel;
            if (fullView) {
                verticalLabelFrame = CGRectMake(self.drawingOrigin.x + self.drawingSize.width * 0.008,
                                                self.drawingOrigin.y + self.drawingSize.height - numberLabelSize *0.2 - ((horizontalLineHeight-ranges.minY) * self.drawingSize.height/dataHeight),
                                                minDimension/8,
                                                minDimension/18);
                verticalLabel = [[UILabel alloc] initWithFrame:verticalLabelFrame];
                verticalLabel.textAlignment = NSTextAlignmentLeft;
            } else {
                verticalLabelFrame = CGRectMake(self.bounds.origin.x,
                                                self.drawingOrigin.y + self.drawingSize.height - numberLabelSize *0.7 - ((horizontalLineHeight-ranges.minY) * self.drawingSize.height/dataHeight),
                                                self.drawingOrigin.x - self.drawingSize.width * 0.005,
                                                minDimension/18);
                verticalLabel = [[UILabel alloc] initWithFrame:verticalLabelFrame];
                verticalLabel.textAlignment = NSTextAlignmentRight;
            }
            verticalLabel.font = [UIFont systemFontOfSize:numberLabelSize];
            if (fabs(horizontalLineHeight) < pow(10, dataMagY-4)) {
                [verticalLabel setText:[NSString stringWithFormat:@"%0.0f", horizontalLineHeight]];
            } else if (fabs(distanceBetweenHorizontalLines/*horizontalLineHeight*/) < .001) {
                [verticalLabel setText:[NSString stringWithFormat:@"%0.1fE%ld", horizontalLineHeight/pow(10, dataMagY), dataMagY]];
            } else if (fabs(distanceBetweenHorizontalLines/*horizontalLineHeight*/) < .1) {
                [verticalLabel setText:[NSString stringWithFormat:@"%0.2f", horizontalLineHeight]];
            } else if (fabs(distanceBetweenHorizontalLines/*horizontalLineHeight*/) < 1) {
                [verticalLabel setText:[NSString stringWithFormat:@"%0.1f", horizontalLineHeight]];
            } else if (fabs(distanceBetweenHorizontalLines/*horizontalLineHeight*/) < 10) {
                [verticalLabel setText:[NSString stringWithFormat:@"%0.1f", horizontalLineHeight]];
            } else if (fabs(distanceBetweenHorizontalLines/*horizontalLineHeight*/) < 1000) {
                [verticalLabel setText:[NSString stringWithFormat:@"%0.0f", horizontalLineHeight]];
            } else if (fabs(distanceBetweenHorizontalLines/*horizontalLineHeight*/) < 1000000) {
                [verticalLabel setText:[NSString stringWithFormat:@"%0.1fK", horizontalLineHeight/1000]];
            } else {
                [verticalLabel setText:[NSString stringWithFormat:@"%0.1fE%ld", horizontalLineHeight/pow(10, dataMagY), dataMagY]];
            }
            //            printf("horizontalLineHeight %f\n", horizontalLineHeight);
            
            [verticalLabels addObject:verticalLabel];
            [self addSubview:verticalLabel];
        }
        horizontalLineHeight = horizontalLineHeight - distanceBetweenHorizontalLines;
    }
}

-(void)drawVerticalLines:(CGContextRef)context {
    //    printf("drawVerticalLines\n");
    CGContextSetLineWidth(context, self.lineWidth * 0.6);
    
    CGFloat dashedLinesLength[]   = {self.drawingSize.width * 0.006, self.drawingSize.width * 0.003};
    static size_t const dashedCount            = (2.0f);
    CGContextSetLineDash(context, 0, dashedLinesLength, dashedCount);
    
    TVDataRanges ranges = [self.datasource dataRangesForTrendView:self];
    double dataWidth = ranges.maxX - ranges.minX;
    long dataMagX = (long)log10(dataWidth);
    
    double verticalLineHeight;
    double distanceBetweenVerticalLines=1;//to prevent dividing by zero
    double rangeFactor = 1;
    if (self.style == TVTrendViewStyleTimeSeries || self.style == TVTrendViewStyleLineAndScatterTimeSeries) {
        if (dataWidth > 3600 * 24 * 365 * 5) {//five years
            distanceBetweenVerticalLines = 3600 * 24 * 365;//one year
        } else if (dataWidth > 3600 * 24 * 180) {//half year
            distanceBetweenVerticalLines = 3600 * 24 * 30 * 2;//two months
        } else if (dataWidth > 3600 * 24 * 15) {//two weeks
            distanceBetweenVerticalLines = 3600 * 24 * 7;//one week
        } else if (dataWidth > 3600 * 24 * 4) {//four days
            distanceBetweenVerticalLines = 3600 * 24;//one day
        } else if (dataWidth > 3600 * 25) {//25 hours
            distanceBetweenVerticalLines = 3600 * 12;//four hours
        } else if (dataWidth > 3600 * 13) {//13 hours
            distanceBetweenVerticalLines = 3600 * 4;//four hours
        } else if (dataWidth > 3600 * 2/3) {//40 min
            distanceBetweenVerticalLines = 360;//ten minutes
        } else if (dataWidth > 900) {//15 minutes
            distanceBetweenVerticalLines = 180;//five minutes
        } else {
            distanceBetweenVerticalLines = 60;//one minute
        }
        NSDate *sourceDate = [NSDate date];
        NSTimeZone* destinationTimeZone = [NSTimeZone systemTimeZone];
        long timeZoneOffset = (long)[destinationTimeZone secondsFromGMTForDate:sourceDate] / 3600.0;
        verticalLineHeight = (double)(((long)((ranges.maxX)  * rangeFactor) / (long)(distanceBetweenVerticalLines * rangeFactor)) * distanceBetweenVerticalLines);
        if (dataWidth > 3600 * 25) { /* this hack compensates for 1970 date starting at 5pm.  check other time zone*/
            verticalLineHeight = verticalLineHeight + 3600 * -timeZoneOffset;
        } else {
            verticalLineHeight = verticalLineHeight + 3600 * 2;
        }
        while (verticalLineHeight > ranges.maxX) {
            verticalLineHeight = verticalLineHeight - distanceBetweenVerticalLines;
        }
        
        //        NSLog(@"hours offset: %d", timeZoneOffset);
    } else {
        if ( dataMagX < 1) {
            rangeFactor = pow(10, labs(dataMagX) + 1);
        }
        
        if (dataWidth / pow(10,dataMagX-1) > 50) {
            distanceBetweenVerticalLines = pow(10, dataMagX-1)*10;
        } else if (dataWidth / pow(10,dataMagX-1) > 20) {
            distanceBetweenVerticalLines = pow(10, dataMagX-1)*5;
        } else if (dataWidth / pow(10,dataMagX-1) > 10) {
            distanceBetweenVerticalLines = pow(10, dataMagX-1)*2;
        } else {
            distanceBetweenVerticalLines = pow(10, dataMagX-1);
        }
        verticalLineHeight = (double)(((int)(ranges.maxX * rangeFactor) / (int)(distanceBetweenVerticalLines * rangeFactor)) * distanceBetweenVerticalLines);
    }
    
    //    printf("distanceBetweenVerticalLines: %lf\n", distanceBetweenVerticalLines);
    if (distanceBetweenVerticalLines > 1314870) {//ten months
        self.xAxisLabelText = @"Year-Month";
    } else if (distanceBetweenVerticalLines > 3600 * 24 * 15) {//15 days
        self.xAxisLabelText = @"Months-Days";
    } else if (distanceBetweenVerticalLines > 3600 * 13) {//13 hours
        self.xAxisLabelText = @"Month-Days";
    } else if (distanceBetweenVerticalLines > 3600 *1.5) {//one and half
        self.xAxisLabelText = @"Hour:Minute";
    } else if (distanceBetweenVerticalLines > 59) {//two minutes
        self.xAxisLabelText = @"Minute:Second";
    } else {
        self.xAxisLabelText = @"Second";
    }
    
    while (verticalLineHeight > ranges.minX) {
        //        printf("distanceBetweenVerticalLines %lf\n", distanceBetweenVerticalLines);
        //        printf("minX %lf\n", ranges.minX);
        /* show vertical lines */
        if (self.drawVerticalLines) {
            CGContextMoveToPoint(context,
                                 self.drawingOrigin.x + (verticalLineHeight-ranges.minX) * self.drawingSize.width/dataWidth,
                                 self.drawingOrigin.y);
            CGContextAddLineToPoint(context,
                                    self.drawingOrigin.x + (verticalLineHeight-ranges.minX) * self.drawingSize.width/dataWidth,
                                    self.drawingOrigin.y + self.drawingSize.height);
            CGContextStrokePath(context);
        }
        /* show x value labels */
        double minDimension = fmin(self.bounds.size.height, self.bounds.size.width);
        if (self.showXValues){
            CGRect horizontalLabelFrame;
            UILabel *horizontalLabel;
            if (fullView) {
                horizontalLabelFrame = CGRectMake(self.drawingOrigin.x -self.drawingSize.width * 0.08 + ((verticalLineHeight-ranges.minX) * self.drawingSize.width/dataWidth),
                                                  
                                                  self.drawingOrigin.y + self.drawingSize.height * 0.94,
                                                  minDimension/8,
                                                  minDimension/18);
                horizontalLabel = [[UILabel alloc] initWithFrame:horizontalLabelFrame];
                horizontalLabel.textAlignment = NSTextAlignmentRight;
            } else {
                horizontalLabelFrame = CGRectMake(self.drawingOrigin.x -self.drawingSize.width * 0.04 + ((verticalLineHeight-ranges.minX) * self.drawingSize.width/dataWidth),
                                                  
                                                  self.drawingOrigin.y + self.drawingSize.height,
                                                  self.drawingSize.width * 0.1,//0.08,
                                                  minDimension/18);
                horizontalLabel = [[UILabel alloc] initWithFrame:horizontalLabelFrame];
                horizontalLabel.textAlignment = NSTextAlignmentCenter;
            }
            horizontalLabel.font = [UIFont systemFontOfSize:numberLabelSize];
            if (self.style == TVTrendViewStyleTimeSeries || self.style == TVTrendViewStyleLineAndScatterTimeSeries) {
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                //                printf("verticalLineHeight = %lf\n", verticalLineHeight);
                if (distanceBetweenVerticalLines > 1314870) {//ten months
                    [dateFormatter setDateFormat:@"yy-MM"];
                } else if (distanceBetweenVerticalLines > 3600 * 24 * 15) {//15 days
                    [dateFormatter setDateFormat:@"MM-dd"];
                } else if (distanceBetweenVerticalLines > 3600 * 13) {//13 hours
                    [dateFormatter setDateFormat:@"MM-dd"];
                } else if (distanceBetweenVerticalLines > 3600 * 1.5) {//one hour
                    [dateFormatter setDateFormat:@"HH:mm"];
                } else if (distanceBetweenVerticalLines > 120) {//two minutes
                    [dateFormatter setDateFormat:@"mm:ss"];
                } else {
                    [dateFormatter setDateFormat:@"ss"];
                }
                //               printf("distanceBetweenVerticalLines: %lf\n", distanceBetweenVerticalLines);
                //[dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
                NSDate *date = [NSDate dateWithTimeIntervalSince1970:verticalLineHeight];
                NSString *dateString = [dateFormatter stringFromDate:date];
                [horizontalLabel setText:[NSString stringWithFormat:@"%@", dateString]];
                
            } else {
                if (fabs(verticalLineHeight) < .00000001) {
                    [horizontalLabel setText:[NSString stringWithFormat:@"%0.0f", verticalLineHeight]];
                } else if (fabs(verticalLineHeight) < .001) {
                    [horizontalLabel setText:[NSString stringWithFormat:@"%0.1fE%ld", verticalLineHeight/pow(10, dataMagX), dataMagX]];
                } else if (fabs(verticalLineHeight) < .01) {
                    [horizontalLabel setText:[NSString stringWithFormat:@"%0.4f", verticalLineHeight]];
                } else if (fabs(verticalLineHeight) < .1) {
                    [horizontalLabel setText:[NSString stringWithFormat:@"%0.3f", verticalLineHeight]];
                } else if (fabs(verticalLineHeight) < 1) {
                    [horizontalLabel setText:[NSString stringWithFormat:@"%0.2f", verticalLineHeight]];
                } else if (fabs(verticalLineHeight) < 1000) {
                    [horizontalLabel setText:[NSString stringWithFormat:@"%0.1f", verticalLineHeight]];
                } else if (fabs(verticalLineHeight) < 1000000) {
                    [horizontalLabel setText:[NSString stringWithFormat:@"%0.1fK", verticalLineHeight/1000]];
                } else {
                    [horizontalLabel setText:[NSString stringWithFormat:@"%0.1fE%ld", verticalLineHeight/pow(10, dataMagX), dataMagX]];
                }
            }
            
            
            [horizontalLabels addObject:horizontalLabel];
            [self addSubview:horizontalLabel];
        }
        verticalLineHeight = verticalLineHeight - distanceBetweenVerticalLines;
        
        
    }
    
    CGContextSetLineDash(context, 0, 0, 0);
}

-(void)drawData:(CGContextRef)context {
    NSLog(@"drawData");
    CGContextSetLineDash(context, 0, 0, 0);
    
    CGContextSetLineWidth(context, self.lineWidth);
    
    /* draw data */
    NSUInteger numberOfSeries = [self.datasource numberOfSeriesInTrendView:self];
    TVDataRanges ranges = [self.datasource dataRangesForTrendView:self];
    double dataWidth = ranges.maxX - ranges.minX;
    if (dataWidth < 0.00001) {
        NSLog(@"Data width cannot be zero\n");
        return;
    }
    double dataHeight = ranges.maxY - ranges.minY;
    if (dataHeight < 0.00001) {
        NSLog(@"Data width cannot be zero\n");
        return;
    }
    for (long series = 0; series < numberOfSeries; series++) {
        CGContextSetLineWidth(context, self.lineWidth);
        UIColor *seriesColor;
        if ([self.datasource respondsToSelector:@selector(trendView:colorForSeries:)] == true) {
            seriesColor = [self.datasource trendView:self colorForSeries:series];
            if (seriesColor == nil) {
                seriesColor = [UIColor blackColor];
            }
        } else {
            seriesColor = [UIColor blueColor];
        }
        [seriesColor set];
        NSUInteger numberOfPoints = [self.datasource trendView:self numberOfElementsInSeries:series];
        if (numberOfPoints > 0) {
            TVPoint *point = [self.datasource trendView:self pointInSeries:series forIndex:0];
            CGContextMoveToPoint(context,
                                 self.drawingOrigin.x + (point.x-ranges.minX) * self.drawingSize.width/dataWidth,
                                 self.drawingOrigin.y + self.drawingSize.height - ((point.y-ranges.minY) * self.drawingSize.height/dataHeight));
       }
        for (long pointIndex = 1; pointIndex < numberOfPoints; pointIndex++) {
            NSLog(@"    point in series: %d", pointIndex);
            TVPoint *point = [self.datasource trendView:self pointInSeries:series forIndex:pointIndex];
            if (self.connectPoints == TRUE) {
                NSLog(@"connect points");
                CGContextAddLineToPoint(context,
                                        self.drawingOrigin.x + (point.x-ranges.minX) * self.drawingSize.width/dataWidth,
                                        self.drawingOrigin.y + self.drawingSize.height - ((point.y-ranges.minY) * self.drawingSize.height/dataHeight));
            }

        }
        
        
        CGContextStrokePath(context);
        if (numberOfPoints > 0) {
            TVPoint *point = [self.datasource trendView:self pointInSeries:series forIndex:0];
            CGContextMoveToPoint(context,
                                 self.drawingOrigin.x + (point.x-ranges.minX) * self.drawingSize.width/dataWidth,
                                 self.drawingOrigin.y + self.drawingSize.height - ((point.y-ranges.minY) * self.drawingSize.height/dataHeight));
            if (self.showPoints == TRUE) {
                NSLog(@"showPoints == TRUE");
                CGContextSetLineWidth(context, self.drawingSize.width * 0.005);
                CGContextAddArc(context,
                                self.drawingOrigin.x + (point.x-ranges.minX) * self.drawingSize.width/dataWidth,
                                self.drawingOrigin.y + self.drawingSize.height - ((point.y-ranges.minY) * self.drawingSize.height/dataHeight),
                                self.drawingSize.width*0.005,M_PI,M_PI*2,YES);
                CGContextAddArc(context,
                                self.drawingOrigin.x + (point.x-ranges.minX) * self.drawingSize.width/dataWidth,
                                self.drawingOrigin.y + self.drawingSize.height - ((point.y-ranges.minY) * self.drawingSize.height/dataHeight),
                                self.drawingSize.width*0.005,M_PI*2,M_PI,YES);
            }
        }
        for (int pointIndex = 1; pointIndex < numberOfPoints; pointIndex++) {
            TVPoint *point = [self.datasource trendView:self pointInSeries:series forIndex:pointIndex];
            if (self.showPoints == TRUE) {
                NSLog(@"showPoints == TRUE");
                CGFloat selectSizeMultiplier = 1.0;
                if ([self.datasource respondsToSelector:@selector(highlightPointInSeries:atIndex:)] == true) {
                    NSLog(@"    responds to highlightPointInSeries");
                    NSLog(@"    pointIndex: %d", pointIndex);
                    if ([self.datasource highlightPointInSeries:series atIndex:pointIndex]) {
                        selectSizeMultiplier = 2.0;
                    }
                } else {
                    NSLog(@"    does not respond to highlightPointInSeries");
                }
                CGContextMoveToPoint(context,
                                     self.drawingOrigin.x + (point.x-ranges.minX) * self.drawingSize.width/dataWidth,
                                     self.drawingOrigin.y + self.drawingSize.height - ((point.y-ranges.minY) * self.drawingSize.height/dataHeight));
                CGContextAddArc(context,
                                self.drawingOrigin.x + (point.x-ranges.minX) * self.drawingSize.width/dataWidth,
                                self.drawingOrigin.y + self.drawingSize.height - ((point.y-ranges.minY) * self.drawingSize.height/dataHeight),
                                self.drawingSize.width*0.005*selectSizeMultiplier,M_PI,M_PI*2,YES);
                CGContextAddArc(context,
                                self.drawingOrigin.x + (point.x-ranges.minX) * self.drawingSize.width/dataWidth,
                                self.drawingOrigin.y + self.drawingSize.height - ((point.y-ranges.minY) * self.drawingSize.height/dataHeight),
                                self.drawingSize.width*0.005*selectSizeMultiplier,M_PI*2,M_PI,YES);
            }
            
            if ([self.datasource respondsToSelector:@selector(highlightPointInSeries:atIndex:)] == true) {

            }
        }
        CGContextStrokePath(context);
    }
    
}

-(NSString *)titleText {
    return [_titleLabel text];
}

-(void)setTitleText:(NSString *)title {
    [_titleLabel setText:title];
}

-(NSString *)xAxisLabelText {
    return [_xAxisLabel text];
}

-(void)setXAxisLabelText:(NSString *)xLabelString {
    [_xAxisLabel setText:xLabelString];
}

-(NSString *)yAxisLabelText {
    return [_yAxisLabel text];
}

-(void)setYAxisLabelText:(NSString *)yLabelString {
    [_yAxisLabel setText:yLabelString];
}

-(NSString *)xUnits {
    return [_xUnitsLabel text];
}

-(void)setXUnits:(NSString *)xUnits {
    [_xUnitsLabel setText:xUnits];
}

-(NSString *)yUnits {
    return [_yUnitsLabel text];
}

-(void)setYUnits:(NSString *)yUnits {
    [_yUnitsLabel setText:yUnits];
}

-(BOOL)showXValues {
    return _showXValues;
}

-(void)setShowXValues:(BOOL)showX {
    _showXValues = showX;
    if (fullView == FALSE) {
        if (_showXValues) {
            _drawingSize = CGSizeMake(self.bounds.size.width * 0.84,
                                      self.bounds.size.height * 0.75);
        } else {
            _drawingSize = CGSizeMake(self.bounds.size.width * 0.84,
                                      self.bounds.size.height * 0.78);
        }
    }
}

-(TVDataRanges) dataRangeWithMinX:(double)minX minY:(double)minY maxX:(double)maxX maxY:(double) maxY {
    TVDataRanges ranges = {minX, minY, maxX, maxY};
    return ranges;
}

@end
