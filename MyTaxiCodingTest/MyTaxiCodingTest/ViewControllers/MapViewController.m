//
//  MapViewController.m
//  MyTaxiCodingTest
//
//  Created by Amit  Singh on 30/07/19.
//  Copyright © 2019 singhamit089. All rights reserved.
//

#import "MapViewController.h"
#import <MapKit/MapKit.h>
#import "MyTaxiCodingTest-Swift.h"
#import "Annotation.h"

@interface MapViewController ()<MKMapViewDelegate>
@property (strong, nonatomic) IBOutlet MKMapView *taxiMapView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (strong,nonatomic) NSMutableArray* annotationList;
@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"MyTaxi - Map";
    self.annotationList = [NSMutableArray new];
    [self.activityIndicator stopAnimating];
}

#pragma mark - MapKit

-(MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    MKPinAnnotationView *taxiPin=[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"current"];
    
    UIButton *advertButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    [advertButton addTarget:self action:@selector(onAnnotationClickAction:) forControlEvents:UIControlEventTouchUpInside];
    
    taxiPin.rightCalloutAccessoryView = advertButton;
    taxiPin.draggable = YES;
    taxiPin.canShowCallout = YES;
    taxiPin.highlighted = NO;
    
    if ([annotation.title isEqualToString:@"TAXI"]) {
        taxiPin.image = [UIImage imageNamed:@"taxi"];
    } else {
        taxiPin.image = [UIImage imageNamed:@"carpool"];
    }
    
    return taxiPin;
}

- (void)onAnnotationClickAction:(id)sender {
    
}

- (void)updateAnnotationOnMap:(NSArray*)newTaxiList {
    
    [self.taxiMapView removeAnnotations:self.annotationList];
    [self.annotationList removeAllObjects];

    for (Taxi* taxi in newTaxiList) {
        
        MKCoordinateRegion Bridge = { {0.0, 0.0} , {0.0, 0.0} };
        Bridge.center.latitude = taxi.location.latitude;
        Bridge.center.longitude = taxi.location.longitude;
        Bridge.span.longitudeDelta = 0.01f;
        Bridge.span.latitudeDelta = 0.01f;
        
        Annotation *annotation = [[Annotation alloc] init];
        annotation.title = [NSString stringWithFormat:@"%@",taxi.fleetType];
        annotation.subtitle = [NSString stringWithFormat:@"%f",taxi.id];
        annotation.coordinate = Bridge.center;
        [self.annotationList addObject:annotation];
        [self.taxiMapView addAnnotation:annotation];
    }
}

- (void)mapViewDidChangeVisibleRegion:(MKMapView *)mapView {
    
    if (!self.activityIndicator.animating) {
        
        [self.activityIndicator startAnimating];
        
        MKMapRect mRect = mapView.visibleMapRect;
        MKMapPoint neMapPoint = MKMapPointMake(MKMapRectGetMaxX(mRect), mRect.origin.y);
        MKMapPoint swMapPoint = MKMapPointMake(mRect.origin.x, MKMapRectGetMaxY(mRect));
        CLLocationCoordinate2D neCoord = MKCoordinateForMapPoint(neMapPoint);
        CLLocationCoordinate2D swCoord = MKCoordinateForMapPoint(swMapPoint);
        
        Coordinate* p1 = [[Coordinate alloc] initWithLocation:neCoord];
        Coordinate* p2 = [[Coordinate alloc] initWithLocation:swCoord];
        
        [APIManager.sharedAPI searchTaxiWithP1:p1 p2:p2 completion:^(NSArray<Taxi *> * _Nullable taxiList, NSString * _Nullable error) {
            [self updateAnnotationOnMap:taxiList];
            [self.activityIndicator stopAnimating];
        }];
    }
}

@end
