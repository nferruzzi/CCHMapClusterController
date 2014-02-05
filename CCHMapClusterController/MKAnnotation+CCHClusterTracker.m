//
//  MKAnnotation+CCHClusterTracker.m
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

#import <objc/runtime.h>
#import <MapKit/MapKit.h>
#import "MKAnnotation+CCHClusterTracker.h"

static char const* const tag = "CCHClusterTracker";

@class CCHMapClusterAnnotation;

/**
 Private object to keep an extra payload for objects conform to MKAnnotation protocol.
 */
@interface CCHClusterTrackerPayload : NSObject
@property (nonatomic, weak) CCHMapClusterAnnotation *cluster;
@property (nonatomic, assign) CLLocationCoordinate2D previousCoordinate;
@property (nonatomic, assign) CLLocationCoordinate2D newCoordinate;
@end

@implementation CCHClusterTrackerPayload

- (id)init
{
    self = [super init];
    if (self) {
        _previousCoordinate = kCLLocationCoordinate2DInvalid;
        _newCoordinate = kCLLocationCoordinate2DInvalid;
    }
    return self;
}

@end

@implementation NSObject (CCHClusterTracker)

- (CCHClusterTrackerPayload *)cch_helper
{
    NSAssert([self conformsToProtocol:@protocol(MKAnnotation)], @"Must conform to protocol");
    CCHClusterTrackerPayload *payload = objc_getAssociatedObject(self, tag);

    if (!payload) {
        payload = [[CCHClusterTrackerPayload alloc] init];
        objc_setAssociatedObject(self, tag, payload, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return payload;
}

- (void)cch_setCluster:(CCHMapClusterAnnotation *)cluster
{
    CCHClusterTrackerPayload *payload = [self cch_helper];
    payload.cluster = cluster;
}

- (CCHMapClusterAnnotation *)cch_cluster
{
    CCHClusterTrackerPayload *payload = [self cch_helper];
    return  payload.cluster;
}

#pragma mark Unused  

- (void)cch_setPreviousCoordinate:(CLLocationCoordinate2D)coordinate
{
    CCHClusterTrackerPayload *payload = [self cch_helper];
    payload.previousCoordinate = coordinate;
}

- (CLLocationCoordinate2D)cch_previousCoordinate
{
    CCHClusterTrackerPayload *payload = [self cch_helper];
    return payload.previousCoordinate;
}

- (void)cch_setNewCoordinate:(CLLocationCoordinate2D)coordinate
{
    CCHClusterTrackerPayload *payload = [self cch_helper];
    payload.newCoordinate = coordinate;
}

- (CLLocationCoordinate2D)cch_newCoordinate
{
    CCHClusterTrackerPayload *payload = [self cch_helper];
    return payload.newCoordinate;
}

@end
