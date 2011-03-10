//
//  details.h
//  DenizDurumu
//
//  Created by Alper Tayfun on 03-07-2011.
//  Copyright 2011 Alper Tayfun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBConnect.h"
#import <MapKit/MapKit.h>

@class FBSession;

@interface details : UIViewController <MKMapViewDelegate,UIActionSheetDelegate ,FBSessionDelegate, FBRequestDelegate,UITableViewDelegate,UITableViewDataSource >{

	FBSession* _session;
	FBLoginDialog *_loginDialog;
	NSString *_facebookName;
	BOOL _posting;
	
	IBOutlet UITableView *tblDetails;
	NSMutableArray *arryData;
	NSMutableArray *arryData1;
	IBOutlet MKMapView *mapView;
	
	IBOutlet UIImageView *imageViews;
}

@property (nonatomic, retain) FBSession *session;
@property (nonatomic, retain) FBLoginDialog *loginDialog;
@property (nonatomic, copy) NSString *facebookName;
@property (nonatomic, assign) BOOL posting;

- (void)postToWall;
- (void)getFacebookName;
@end
