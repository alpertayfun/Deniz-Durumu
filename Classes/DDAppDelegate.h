//
//  DDAppDelegate.h
//  DD
//
//  Created by Alper Tayfun on 03-07-2011.
//  Copyright 2011 Alper Tayfun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    UINavigationController *navigationController;
	UITabBarController *tabBarController;
	NSString *customSearchQuery;
	NSString *customSearchQuery1;
	
	//map-global-string
	float *ltd1;
	float *lng1;
}
@property (assign, readwrite) NSString *customSearchQuery; 
@property (assign, readwrite) NSString *customSearchQuery1; 
@property (assign, readwrite) float *ltd1; 
@property (assign, readwrite) float *lng1; 
@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;
@end

