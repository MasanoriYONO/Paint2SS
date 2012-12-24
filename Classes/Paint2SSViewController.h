//
//  Paint2SSViewController.h
//  Paint2SS
//
//  Created by yono on 11/10/24.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "Paint2SSAppDelegate.h"

@interface Paint2SSViewController : UIViewController <UIWebViewDelegate,UITextFieldDelegate,UIScrollViewDelegate,UISearchBarDelegate> {
	//browser view
	UIView *browser_view;
	UIWebView *webView;
	UISearchBar *urlBar;
	
	//memo view
	UIView *memoView;
	UITextField *memo_text;
	UIButton *add_memo_Button;
	
	//memo scroll view
	UIScrollView *scrollView;
	UIImageView *imageView_over;
	UILabel *label;
	
	//screenshot view
	UIView *screen_canvas;
	UIImageView *imageView;
	
	//indicator view
	UIView *indicator_view;
	UILabel *waiting_label;
	//UIActivityIndicatorView *ss2roll_waiting;
	
	IBOutlet UIBarButtonItem *backButton;
	IBOutlet UIBarButtonItem *forwardButton;
	IBOutlet UIBarButtonItem *reloadButton;
	IBOutlet UIBarButtonItem *paintAddButton;
	IBOutlet UIBarButtonItem *memoAddButton;
	IBOutlet UIBarButtonItem *memoToggleButton;
	
	CGPoint touchPoint;
	
	//UIWindow *offscreenWindow;
	//Boolean isRendering;
}
//browser view
@property (nonatomic, retain) UIView *browser_view;
@property (nonatomic, retain) UIWebView *webView;
@property (nonatomic, retain) UISearchBar *urlBar;

//memo view
@property (nonatomic, retain) UIView *memoView;
@property (nonatomic, retain) UITextField *memo_text;
@property (nonatomic, retain) UIButton *add_memo_Button;

//memo scroll view
@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) UIImageView *imageView_over;
@property (nonatomic, retain) UILabel *label;

//screenshot view
@property (nonatomic, retain) UIView *screen_canvas;
@property (nonatomic, retain) UIImageView *imageView;

//indicator view
@property (nonatomic, retain) UIView *indicator_view;
@property (nonatomic, retain) UILabel *waiting_label;
//@property (nonatomic, retain) UIActivityIndicatorView *ss2roll_waiting;

//buttons created by InterfaceBuilder. 
@property (nonatomic, retain) IBOutlet UIBarButtonItem *backButton;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *forwardButton;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *reloadButton;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *paintAddButton;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *memoAddButton;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *memoToggleButton;

- (IBAction) backButton:(id)sender;
- (IBAction) forwardButton:(id)sender;
- (IBAction) reloadButton:(id)sender;
- (IBAction) paintAddButton:(id)sender;
- (IBAction) memoAddButton:(id)sender;
- (IBAction) memoToggleButton:(id)sender;
@end