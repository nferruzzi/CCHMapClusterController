//
//  CCHMoveInOutMapAnimator.m
//  CCHMapClusterController
//
//  Created by Nicola Ferruzzi
//  Copyright (C) 2013 Claus Höfele
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "CCHMoveInOutMapAnimator.h"

#import "CCHMapClusterController.h"
#import "CCHMapClusterAnnotation.h"
#import "MKAnnotation+CCHClusterTracker.h"
#import <MapKit/MapKit.h>

@implementation CCHMoveInOutMapAnimator

- (id)init
{
    self = [super init];
    if (self) {
        self.duration = 0.2;
    }
    return self;
}

- (void)mapClusterController:(CCHMapClusterController *)mapClusterController didAddAnnotationViews:(NSArray *)annotationViews
{
    // Animate annotations that get added
#if TARGET_OS_IPHONE
    NSMutableArray *coords = [NSMutableArray arrayWithCapacity:[annotationViews count]];
    
    for (MKAnnotationView *annotationView in annotationViews)
    {
        NSObject <MKAnnotation> *annotation = annotationView.annotation;
        CCHMapClusterAnnotation *cluster = [annotation cch_cluster];
        if (cluster) {
            [coords addObject:[NSValue valueWithMKCoordinate:annotation.coordinate]];
            [annotation setCoordinate:cluster.coordinate];
        }
    }
    
    [UIView animateWithDuration:self.duration animations:^{
        int i=0;
        for (MKAnnotationView *annotationView in annotationViews) {
            NSObject <MKAnnotation> *annotation = annotationView.annotation;
            CCHMapClusterAnnotation *cluster = [annotation cch_cluster];
            if (cluster) {
                [annotation setCoordinate:[coords[i++] MKCoordinateValue]];
            }
            annotationView.alpha = 1.0;
        }
    }];
#endif
}

- (void)mapClusterController:(CCHMapClusterController *)mapClusterController willRemoveAnnotations:(NSArray *)annotations withCompletionHandler:(void (^)())completionHandler
{
#if TARGET_OS_IPHONE
    MKMapView *mapView = mapClusterController.mapView;
    [UIView animateWithDuration:self.duration animations:^{
        for (NSObject<MKAnnotation> *annotation in annotations) {
            CCHMapClusterAnnotation *cluster = [annotation cch_cluster];
            if (cluster) {
                [annotation setCoordinate:cluster.coordinate];
            }

            MKAnnotationView *annotationView = [mapView viewForAnnotation:annotation];
            annotationView.alpha = 0.0;
        }
    } completion:^(BOOL finished) {
        if (completionHandler) {
            completionHandler();
        }
    }];
#else
    if (completionHandler) {
        completionHandler();
    }
#endif
}

@end
