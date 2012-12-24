//
//  Paint2SSAppDelegate.h
//  Paint2SS
//
//  Created by yono on 11/10/24.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Paint2SSViewController.h"

@class Paint2SSViewController;

@interface Paint2SSAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    Paint2SSViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet Paint2SSViewController *viewController;

@end

