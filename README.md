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
  CGRect trendViewFrame = CGRectMake(0, 0, 200, 100);
  trendView = [[TVTrendView alloc] initWithFrame:trendViewFrame];
  trendView.titleText = @"Trend Title";
  trendView.xAxisLabelText = @"X Axis Label";
  trendView.yAxisLabelText = @"Y Axis Label";
  trendView.xUnits = @"X Units";
  trendView.yUnits = @"Y Units";
  
  [self.view addSubview:trendView];
}

-(NSUInteger)numberOfSeriesInTrendView:(TVTrendView *)trendView {
    return 2;
}

-(NSUInteger)trendView:(TVTrendView *)trendView numberOfElementsInSeries:(long)series {
    NSUInteger smallestNumber = NSUIntegerMax;
    for (NSArray *series in AllSeries) {
      if (series.count < smallestNumber) {
        smallestNumber = series.count;
      }
    }
    return smallestNumber;
}

-(id<TVPointProtocol>)trendView:(TVTrendView *)trendView pointInSeries:(long)series forIndex:(long)index {
    TVPoint *point = [(NSMutableArray *)self.allSeries[series] objectAtIndex:index];
    return point;
}

/*
 *  You must tell the trendview what range of values to display
 */
-(TVDataRanges)dataRangesForTrendView:(TVTrendView *)trendView {
    TVPoint *point;

    if ([self.totalAreaSeries count] < 1) {
        NSLog(@"dataRangesForTrendView no data\n");
        return [trendView dataRangeWithMinX:0 minY:0 maxX:0 maxY:0];
    }
    point = [self.totalAreaSeries objectAtIndex:0];
    
    double minX = point.x;
    double minY = point.y;
    double maxX = point.x;
    double maxY = point.y;

    for (NSMutableArray *series in self.allSeries) {
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
    if (series == 1) {
        return [UIColor redColor];
    } else if (series == 2) {
        return [UIColor blueColor];
    } 
    return [UIColor yellowColor]; 
}

```

