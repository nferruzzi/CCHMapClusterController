//
//  MKAnnotation+CCHClusterTracker.h
//  CCHMapClusterController Example iOS
//
//  Created by Nicola Ferruzzi on 05/02/14.
//  Copyright (c) 2014 Claus Höfele. All rights reserved.
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

#import <Foundation/Foundation.h>

@class CCHMapClusterAnnotation;

/**
 Add a weak reference to the parent cluster (and eventually more payload).

 Note:
 It's not a real MKAnnotation category: since it is a protocol we extend
 NSObject and check at runtime if the object conform to protocol MKAnnotation
 */
@interface NSObject (CCHClusterTracker)

- (void)cch_setCluster:(CCHMapClusterAnnotation *)cluster;
- (CCHMapClusterAnnotation *)cch_cluster;

// These methods are not used yet .. maybe we dont need them
- (void)cch_setPreviousCoordinate:(CLLocationCoordinate2D)coordinate;
- (CLLocationCoordinate2D)cch_previousCoordinate;
- (void)cch_setNewCoordinate:(CLLocationCoordinate2D)coordinate;
- (CLLocationCoordinate2D)cch_newCoordinate;

@end
