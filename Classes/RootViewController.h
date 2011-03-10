//
//  RootViewController.h
//  DD
//
//  Created by Alper Tayfun on 03-07-2011.
//  Copyright 2011 Alper Tayfun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "help.h"

@class DisplayMap;

@interface RootViewController : UIViewController <helpDelegate,MKMapViewDelegate,UITableViewDelegate,UITableViewDataSource,UITabBarControllerDelegate,UITabBarDelegate,CLLocationManagerDelegate>{
	NSMutableArray *arryData;
	NSMutableArray *arryData1;
	NSMutableArray *arryData2;
	IBOutlet UITableView *tblSimpleTable;
	CLLocationManager *locationManager;
	IBOutlet UITabBar *tabBar;
	
	IBOutlet MKMapView *mapViewmain;
	
	help *mvc1;
	
	NSMutableArray *arryData3;
	NSMutableArray *arryData4;
}
@property (nonatomic, retain) CLLocationManager *locationManager; 
@property (nonatomic, retain) UITabBar *tabBar;

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation;

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error;
@end