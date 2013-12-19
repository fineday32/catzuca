//
//  mapVC.m
//  catzuca
//
//  Created by cytms on 13/12/18.
//  Copyright (c) 2013年 Thomas Hsu. All rights reserved.
//

#import "mapVC.h"
#import <CoreLocation/CoreLocation.h>
#import <Parse/Parse.h>

@interface mapVC ()

@end

@implementation mapVC
@synthesize mapView=_mapView;

- (void)dealloc {
    self.mapView.delegate = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    CLLocation *newLocation = self.mapView.userLocation.location;
//    [self.mapView setCenterCoordinate:self.mapView.userLocation.location.coordinate animated:YES];
//    PFGeoPoint *userGeoPoint = [PFGeoPoint geoPointWithLatitude:newLocation.coordinate.latitude longitude:newLocation.coordinate.longitude];
//    NSLog(@"%f %f", newLocation.coordinate.latitude, newLocation.coordinate.longitude);
    CLLocationCoordinate2D defaultCoordinate;
    defaultCoordinate.latitude = 47.517201;
    defaultCoordinate.longitude = -120.366211;
    [_mapView setRegion:MKCoordinateRegionMake(defaultCoordinate, MKCoordinateSpanMake(6.8, 6.8)) animated:NO];
    CLLocationCoordinate2D center = defaultCoordinate;
    center.latitude -= self.mapView.region.span.latitudeDelta * 0.40;
    [self.mapView setCenterCoordinate:center animated:YES];
	// Do any additional setup after loading the view.
}

#pragma mark - Map View

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    // Use default style for user's location
    NSLog(@"in the viewForAnnotation");
    
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    
    // Reuse annotation 把物件塞這兒～
    static NSString * AnnotationIdentifier = @"Annotation";
    MKAnnotationView *annotationView = [_mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationIdentifier];
    if (!annotationView) {
        annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation
                                                      reuseIdentifier:AnnotationIdentifier];
        annotationView.canShowCallout = YES;
        annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
//        annotationView.rightCalloutAccessoryView.tag = AnnotationViewRightCalloutTag;
        annotationView.image = [UIImage imageNamed:@"map_marker-50.png"];
    } else {
        annotationView.annotation = annotation;
    }
    
    // Setup image
    //    if ([annotation isKindOfClass:[TMStop class]]) {
    //        TMStop *stop = annotation;
    //        annotationView.image = stop.image;
    //    }
    //
    return annotationView;
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id <MKOverlay>)overlay {
    if ([overlay isKindOfClass:[MKPolyline class]]) {
        MKPolyline *polyline = (MKPolyline *)overlay;
        UIColor *color = [UIColor redColor];//objc_getAssociatedObject(polyline, &TMLinePolylineColorAssociationKey);
        
        MKPolylineRenderer *renderer = [[MKPolylineRenderer alloc] initWithPolyline:polyline];
        renderer.strokeColor = color;
        renderer.lineWidth = 7.5f;
        renderer.lineJoin = kCGLineJoinRound;
        renderer.lineCap = kCGLineCapRound; //磨成圓角～
        
        return renderer;
    }
    return nil;
}

//- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
//    if (control.tag == AnnotationViewRightCalloutTag) {
//        [self performSegueWithIdentifier:@"ShowDetail" sender:view];
//    }
//}


@end
