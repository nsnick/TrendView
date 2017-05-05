# TrendView

pod 'TrendView', '~> 0.2'

![Alt text](/screenshot.png?raw=true)

[Objective-C example](https://github.com/nsnick/trendview-example-objc)

[Swift example](https://github.com/nsnick/trendview-example-swift)

## Swift 
``` swift


```

## Objective-C

implement the TVTrendViewDatasource protocol

``` objective-c

-(void)viewDidLoad {
    [super viewDidLoad];
    CGRect trendViewFrame = CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.width*2/3);
    trendView = [[TVTrendView alloc] initWithFrame:trendViewFrame];
    trendView.titleText = @"Trend Title";
    trendView.xAxisLabelText = @"X Axis Label";
    trendView.yAxisLabelText = @"Y Axis Label";
    trendView.xUnits = @"X Units";
    trendView.yUnits = @"Y Units";
    trendView.datasource = self;
    
    [self.view addSubview:trendView];
}

-(NSUInteger)numberOfSeriesInTrendView:(TVTrendView *)trendView {
    return 2;
}

-(NSUInteger)trendView:(TVTrendView *)trendView numberOfElementsInSeries:(long)series {
    NSUInteger smallestNumber = NSUIntegerMax;
    for (NSArray *series in allSeries) {
        if (series.count < smallestNumber) {
            smallestNumber = series.count;
        }
    }
    return smallestNumber;
}

-(id<TVPointProtocol>)trendView:(TVTrendView *)trendView pointInSeries:(long)series forIndex:(long)index {
    TVPoint *point = [(NSMutableArray *)allSeries[series] objectAtIndex:index];
    return point;
}

/*
 *  You must tell the trendview what range of values to display
 */
-(TVDataRanges)dataRangesForTrendView:(TVTrendView *)trendView {
    TVPoint *point;
    

    point = [allSeries[0] objectAtIndex:0];
    
    double minX = point.x;
    double minY = point.y;
    double maxX = point.x;
    double maxY = point.y;
    
    for (NSMutableArray *series in allSeries) {
        for (TVPoint *point in series) {
            
            if (point.x < minX) {
                minX = point.x;
            }
            if (point.y < minY) {
                minY = point.y;
            }
            if (point.x > maxX) {
                maxX = point.x;
            }
            if (point.y > maxY) {
                maxY = point.y;
            }
        }
    }
    
    TVDataRanges ranges = [trendView dataRangeWithMinX:minX minY:minY maxX:maxX maxY:maxY];
    
    return ranges;
}

-(UIColor *)trendView:(TVTrendView *)trendView colorForSeries:(long)series {
    if (series == 0) {
        return [UIColor redColor];
    } else if (series == 1) {
        return [UIColor blueColor];
    } 
    return [UIColor yellowColor]; 
}

```

