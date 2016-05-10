//
//  DirectionsViewController.m
//  CoffeeFindr
//
//  Created by Paul Lefebvre on 5/9/16.
//  Copyright © 2016 Paul Lefebvre. All rights reserved.
//

#import "DirectionsViewController.h"

@interface DirectionsViewController ()

@property (weak, nonatomic) IBOutlet UITextView *directionsTextView;

@end

@implementation DirectionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.coffeeShop.mapItem.name;
    [self getDirectionsFrom:self.userLocation.coordinate withDestination:self.coffeeShop.mapItem.placemark.location.coordinate];
}

-(void)getDirectionsFrom:(CLLocationCoordinate2D)sourceCoordinate
       withDestination:(CLLocationCoordinate2D)destinationCoordinate{
    MKPlacemark *sourcePlacemark = [[MKPlacemark alloc] initWithCoordinate:sourceCoordinate addressDictionary:nil];
    MKMapItem *sourceMapItem = [[MKMapItem alloc] initWithPlacemark:sourcePlacemark];
    
    MKPlacemark *destinationPlacemark = [[MKPlacemark alloc] initWithCoordinate:destinationCoordinate addressDictionary:nil];
    MKMapItem *destinationMapItem = [[MKMapItem alloc] initWithPlacemark:destinationPlacemark];
    
    MKDirectionsRequest *request = [MKDirectionsRequest new];
    [request setSource:sourceMapItem];
    [request setDestination:destinationMapItem];
    [request setTransportType:MKDirectionsTransportTypeWalking];
    request.requestsAlternateRoutes = NO;
    
    MKDirections *directions = [[MKDirections alloc] initWithRequest:request];
    
    [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse * _Nullable response, NSError * _Nullable error) {
        MKRoute *route = response.routes.lastObject;
        
        NSString *allSteps = [NSString new];
        
        for (int i = 0; i < route.steps.count; i++) {
            MKRouteStep *step = [route.steps objectAtIndex:i];
            NSString *newStepString = step.instructions;
            allSteps = [allSteps stringByAppendingString:[NSString stringWithFormat:@"%@ \n", newStepString]];
        }        
        self.directionsTextView.text = allSteps;
    }];
}


@end
