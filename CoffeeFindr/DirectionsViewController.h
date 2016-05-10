//
//  DirectionsViewController.h
//  CoffeeFindr
//
//  Created by Paul Lefebvre on 5/9/16.
//  Copyright © 2016 Paul Lefebvre. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "CoffeeShop.h"

@interface DirectionsViewController : UIViewController

@property CoffeeShop *coffeeShop;
@property CLLocation *userLocation;

@end
