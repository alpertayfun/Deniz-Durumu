//
//  help.h
//  Deniz Durumu
//
//  Created by Alper Tayfun on 03-08-2011.
//  Copyright 2011 Alper Tayfun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdMobView.h"

@protocol helpDelegate;

@class help;

@interface help : UIViewController {

	id<helpDelegate> delegate;
	IBOutlet UIButton *btns1;
	AdMobView *ad;
}

@property (nonatomic, assign) id<helpDelegate> delegate;
- (IBAction) helpkapat:(id) sender;
@end

@protocol helpDelegate
- (void) helpDidFinish: (help *) controller;
@end
