//
//  Paint2SSViewController.m
//  Paint2SS
//
//  Created by yono on 11/10/24.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//


#import "Paint2SSAppDelegate.h"
#import "Paint2SSViewController.h"

@implementation Paint2SSViewController
//browser view
@synthesize browser_view;
@synthesize webView;
@synthesize urlBar;

//memo view
@synthesize memoView;
@synthesize memo_text;
@synthesize add_memo_Button;

//memo scroll view
@synthesize scrollView;
@synthesize imageView_over;
@synthesize label;

//screenshot view
@synthesize screen_canvas;
@synthesize imageView;

//indicator view
@synthesize indicator_view;
@synthesize waiting_label;
//@synthesize ss2roll_waiting;

//buttons created by InterfaceBuilder
@synthesize backButton;
@synthesize forwardButton;
@synthesize reloadButton;
@synthesize paintAddButton;
@synthesize memoAddButton;
@synthesize memoToggleButton;


/*
 // The designated initializer. Override to perform setup that is required before the view is loaded.
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
 self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
 if (self) {
 // Custom initialization
 }
 return self;
 }
 */

/*
 // Implement loadView to create a view hierarchy programmatically, without using a nib.
 - (void)loadView {
 }
 */


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	/*	
	 UIWebView *wv = [[UIWebView alloc] init];
	 wv.frame = CGRectMake(0, 0, 320, 460);
	 wv.scalesPageToFit = YES;
	 [self.view addSubview:wv];
	 
	 //ここで指定するファイルは一度でもいいので、リソースに追加して
	 //参照できる状態にしておくこと。その後はリソースから参照を削除しても
	 //なぜかファイルのパスを取得できるような感じがする。詳細は調べてないけれど。
	 
	 NSString *pdf_path = [[NSBundle mainBundle] pathForResource:@"jbcf_guide2011" ofType:@"pdf"];
	 NSURL *url = [NSURL fileURLWithPath:pdf_path];
	 //NSURL *url = [NSURL URLWithString:@"/Users/yono/Documents/jbcf_guide2011.pdf"];
	 NSURLRequest *req = [NSURLRequest requestWithURL:url];
	 [wv loadRequest:req];
	 */	
	// 表示する UIImageView を生成
	/*
	 self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10 , 300, 400)];
	 imageView.backgroundColor = [UIColor blueColor];
	 [self.view addSubview:imageView];  
	 
	 //ここに書いてもブラウザの上に表示される。
	 self.imageView_over = [[UIImageView alloc] initWithFrame:CGRectMake(107, 153, 100, 50)];
	 imageView_over.backgroundColor = [UIColor yellowColor];
	 [self.view addSubview:imageView_over];
	 //label add.
	 UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10,10,80,30)];
	 label.text = @"グーグル";
	 UIFont *font = [UIFont systemFontOfSize:[UIFont smallSystemFontSize]];
	 label.font = font;
	 label.textColor = [UIColor redColor];
	 label.textAlignment = UITextAlignmentCenter;
	 [self.imageView_over addSubview:label];
	 */
	
	// UIWebView 用の表示しない UIWindow を生成  
	//self.offscreenWindow = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, 320, 416)];  
	
	//browser view.
	self.browser_view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 416)];
	//webview area.
	self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 44, 320, 372)];
	webView.delegate = self;  
	webView.scalesPageToFit = YES;  
	[self.browser_view addSubview:webView];
	
	NSURL* url = [NSURL URLWithString:@"http://www.google.co.jp/"];
	[webView loadRequest:[NSURLRequest requestWithURL:url]];  
	//isRendering = YES;
	
	//location bar
	self.urlBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
	urlBar.delegate = self;
	urlBar.keyboardType = UIKeyboardTypeURL;
	//UISearchBarにはリターンキータイプのプロパティはなかった。
	//urlBar.returnKeyType = UIReturnKeyGo;
	//[self.view addSubview:urlBar];
	[self.browser_view addSubview:urlBar];
	
	[self.view addSubview:browser_view];
	////browser view define end.
	////////////////////////////////////////////////////////////////////////////////////////////////////
	
	//memo view.
	self.memoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0 , 320, 416)];
	memoView.backgroundColor = [UIColor grayColor];
	memoView.alpha= 0.7f;
	
	//memo text.
	self.memo_text = [[UITextField alloc] initWithFrame:CGRectMake(20, 20, 280, 30)];
	memo_text.borderStyle = UITextBorderStyleRoundedRect;
	memo_text.returnKeyType = UIReturnKeyDone;
	memo_text.delegate = self;
	[self.memoView addSubview:memo_text];
	
	//button
	self.add_memo_Button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	add_memo_Button.frame = CGRectMake(20, 60, 80, 30);
	[add_memo_Button setTitle:@"メモ追加" forState:UIControlStateNormal];
	[add_memo_Button addTarget:self action:@selector(add_memo:)forControlEvents:UIControlEventTouchDown];
	[self.memoView addSubview:add_memo_Button];
	
	[self.view addSubview:memoView];
	memoView.hidden = YES;
	////memo view define end.
	////////////////////////////////////////////////////////////////////////////////////////////////////
	
	//scroll memo view
	self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, 416)];
	//scrollView.bounds = CGRectMake(0.0, 0.0, 200, 200.0);
	scrollView.contentSize = CGSizeMake(560,802);
	//scrollView.contentSize = imageView_over.bounds.size;
	scrollView.clipsToBounds = NO;
	scrollView.pagingEnabled = NO;
	scrollView.showsVerticalScrollIndicator = YES;
	scrollView.showsHorizontalScrollIndicator = YES;
	scrollView.minimumZoomScale = 1.0;
	scrollView.maximumZoomScale = 5.0;
	scrollView.bounces = NO;
	//self.scrollView.contentOffset=CGPointMake(-fabs(self.scrollView.center.x-self.imageView_over.center.x), 
	//										-fabs(self.scrollView.center.y-self.imageView_over.center.y));
	self.scrollView.contentOffset=CGPointMake(120,193); 
	scrollView.backgroundColor = [UIColor grayColor];
	scrollView.alpha = 0.5f;
	scrollView.delegate = self;
	[self.view addSubview:scrollView];
	
	//memo based image.
	self.imageView_over = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 416)];
	//imageView_over.backgroundColor = [UIColor blueColor];
	//[self.view addSubview:imageView_over];
	[self.scrollView addSubview:imageView_over];
	
	//label add.
	label = [[UILabel alloc] initWithFrame:CGRectMake(240,386,80,30)];
	label.text = @"メモサンプル";
	UIFont *font = [UIFont systemFontOfSize:[UIFont smallSystemFontSize]];
	label.font = font;
	label.textColor = [UIColor redColor];
	label.textAlignment = UITextAlignmentCenter;
	label.backgroundColor = [UIColor yellowColor];
	//label.alpha = 0.7f;
	[self.imageView_over addSubview:label];
	imageView_over.hidden = YES;
	scrollView.hidden = YES;
	////scroll view define end.
	////////////////////////////////////////////////////////////////////////////////////////////////////
	
	//screenshot view
	self.screen_canvas = [[UIView alloc] initWithFrame:CGRectMake(0, 0 , 320, 416)];
	screen_canvas.backgroundColor = [UIColor whiteColor];
	screen_canvas.alpha = 1.0f;
	
	//screenshot image
	self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0 , 320, 416)];
	imageView.backgroundColor = [UIColor whiteColor];
	imageView.alpha = 1.0f;
	[self.screen_canvas addSubview:imageView]; 
	[self.view insertSubview:screen_canvas aboveSubview:webView];  
	screen_canvas.hidden = YES;
	////screenshot view define end.
	////////////////////////////////////////////////////////////////////////////////////////////////////
	
	//indicator view
	self.indicator_view = [[UIView alloc] initWithFrame:CGRectMake(100, 380 , 120, 30)];
	//indicator_view.backgroundColor = [UIColor whiteColor];
	//indicator_view.alpha = 0.5f;
	
	//indicator
	/*
	 self.ss2roll_waiting = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
	 ss2roll_waiting.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
	 indicator_view.backgroundColor =[UIColor blackColor];
	 //indicator_view.alpha = 0.5f;
	 ss2roll_waiting.hidden = NO;
	 [self.indicator_view addSubview:ss2roll_waiting];
	 */
	//message label
	self.waiting_label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 30)];
	waiting_label.text = @"Saving...";
	UIFont *message_font = [UIFont systemFontOfSize:[UIFont labelFontSize]];
	waiting_label.font = message_font;
	waiting_label.textColor = [UIColor blackColor];
	waiting_label.textAlignment = UITextAlignmentCenter;
	waiting_label.backgroundColor = [UIColor whiteColor];
	waiting_label.alpha = 0.5f;
	[self.indicator_view addSubview:waiting_label];
	
	[self.view addSubview:indicator_view];
	indicator_view.hidden = YES;
	////indicator view define end.
	////////////////////////////////////////////////////////////////////////////////////////////////////
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
	NSLog(@"%s",__PRETTY_FUNCTION__ );
	[urlBar resignFirstResponder];
	[webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlBar.text]]];
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
	NSLog(@"%s",__PRETTY_FUNCTION__ );
	return YES;
}
/*
 - (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
 {
 return self.imageView_over;
 }
 */

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	NSLog(@"%s",__PRETTY_FUNCTION__ );
	
	UITouch *touch = [touches anyObject];
    touchPoint = [touch locationInView:imageView];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
	// 現在のタッチ座標をローカル変数currentPointに保持
    UITouch *touch = [touches anyObject]; 
    CGPoint currentPoint = [touch locationInView:imageView];
    
    // 描画領域をcanvasの大きさで生成
    UIGraphicsBeginImageContext(imageView.frame.size);
    // canvasにセットされている画像（UIImage）を描画
    [imageView.image drawInRect:
	 CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height)];
    // 線の角を丸くする
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    // 線の太さを指定
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 3.0);
    // 線の色を指定（RGB）
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 1.0, 0.0, 0.0, 0.7);
    // 線の描画開始座標をセット
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), touchPoint.x, touchPoint.y);
    // 線の描画終了座標をセット
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
    // 描画の開始～終了座標まで線を引く
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    // 描画領域を画像（UIImage）としてcanvasにセット
    imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    // 描画領域のクリア
    UIGraphicsEndImageContext();
    // 現在のタッチ座標を次の開始座標にセット
    touchPoint = currentPoint;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	NSLog(@"%s",__PRETTY_FUNCTION__ );
	[textField resignFirstResponder];
	label.text = [memo_text text];
	if(memoView.hidden == NO){
		memoView.hidden = !memoView.hidden;
	}
	return YES;
}

-(void)add_memo:(UIButton*)button{
	NSLog(@"%s",__PRETTY_FUNCTION__ );
	//memoView.hidden = YES;
	//label.text = [memo_text text];
	[self textFieldShouldReturn:memo_text];
}


-(void)loadHome {
    NSLog(@"%s",__PRETTY_FUNCTION__ );
    
    NSURL *request = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"index_login" ofType:@"html" inDirectory:nil]];
    [webView loadRequest:[NSURLRequest requestWithURL:request]];
    webView.scalesPageToFit = YES;
    backButton.enabled = [webView canGoBack];
    forwardButton.enabled = [webView canGoForward];
	//reloadButton.enabled = NO;
}

- (IBAction) backButton:(id)sender{
    // goBackできる状態(戻ることができる状態)なら戻るを実行する
    if (webView.canGoBack) {
        [webView goBack];
    }
}
- (IBAction) forwardButton:(id)sender{
    if (webView.canGoForward) {
        [webView goForward];
    }
}
- (IBAction) reloadButton:(id)sender{
	[webView reload];
}

- (IBAction) paintAddButton:(id)sender{
	
	//表示されているならカメラロールへ保存
	if(screen_canvas.hidden == NO){
		NSLog(@"%s: カメラロールへ保存",__PRETTY_FUNCTION__);
		indicator_view.hidden = NO;
		//[ss2roll_waiting startAnimating];
		UIImageWriteToSavedPhotosAlbum(imageView.image
									   ,self 
									   ,@selector(savingImageIsFinished:didFinishSavingWithError:contextInfo:)
									   ,nil);
	}else{
		imageView.image = nil;
		//imageView_location_bar.image = nil;
		[self performSelector:@selector(renderWebContent) withObject:nil afterDelay:0];  
	}
	
	screen_canvas.hidden = !screen_canvas.hidden;
}

- (void) savingImageIsFinished:(UIImage *)_image didFinishSavingWithError:(NSError *)_error contextInfo:(void *)_contextInfo{
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"画面メモ" message:@"カメラロールへ保存しました。" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
	
	//[ss2roll_waiting stopAnimating];
	indicator_view.hidden = YES;
	[alert show];
	[alert release];
}

- (IBAction) memoAddButton:(id)sender{
	/*
	 if(memoView.hidden == YES){
	 memoView.hidden = NO;
	 }
	 */
	memoView.hidden = !memoView.hidden;
	
}

- (IBAction) memoToggleButton:(id)sender{
	imageView_over.hidden = !imageView_over.hidden;
	scrollView.hidden = !scrollView.hidden;
}

- (void) button_check {
    backButton.enabled = webView.canGoBack;
    forwardButton.enabled = webView.canGoForward;
}

- (void)webViewDidStartLoad:(UIWebView*)webView {
    [self button_check];
}

- (void) webViewDidFinishLoad:(UIWebView *)webView {
	
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	//URLはこれでも取れるらしい。通信前と後で同じことをやってて無駄だと思うけれど、通信前と後では
	//URLの取得方法も違う。リダイレクトされる場合もあるので。
	urlBar.text = [self.webView stringByEvaluatingJavaScriptFromString:@"document.URL"];
	
	//if (isRendering) {  
	//	isRendering = NO;
	// UIWebView の描画は別スレッドで行われ、  
	// 描画完了前にこのメソッドが呼ばれるので  
	// UIImage への描画処理は遅らせて実行する  
	
	//[self performSelector:@selector(renderWebContent) withObject:nil afterDelay:1.0];  
	//}
	[self button_check];
}  

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
    NSLog(@"%s: error %@",__PRETTY_FUNCTION__ ,error);
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    /*
	 [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	 [self removeWaitView];
	 backButton.enabled = [webView canGoBack];
	 forwardButton.enabled = [webView canGoForward];
	 reloadButton.enabled = YES;
	 if ( [error localizedFailureReason] == nil ) {
	 urlLabel.text = [NSString stringWithFormat:@"Stppped Lording. %@ ",url];
	 }else {                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
	 urlLabel.text = [NSString stringWithFormat:@"%@ %@ ",[error localizedFailureReason],url];
	 }
	 NSInteger err_code = [error code];
	 if (err_code == NSURLErrorCancelled) { 
	 return;
	 }
	 */
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
	
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	
	NSLog(@"%s",__PRETTY_FUNCTION__);
	
	NSURL *requestUrl = [request URL];
	urlBar.text = [requestUrl absoluteString];
	
	//yono modify 20111019
	/*
	 if(navigationType == UIWebViewNavigationTypeLinkClicked){
	 NSLog(@"UIWebViewNavigationTypeLinkClicked");
	 }
	 if(navigationType == UIWebViewNavigationTypeFormSubmitted){
	 NSLog(@"UIWebViewNavigationTypeFormSubmitted");
	 }
	 if(navigationType == UIWebViewNavigationTypeBackForward){
	 NSLog(@"UIWebViewNavigationTypeBackForward");
	 }
	 if(navigationType == UIWebViewNavigationTypeReload){
	 NSLog(@"UIWebViewNavigationTypeReload");
	 }
	 if(navigationType == UIWebViewNavigationTypeFormResubmitted){
	 NSLog(@"UIWebViewNavigationTypeFormResubmitted");
	 }
	 if(navigationType == UIWebViewNavigationTypeOther){
	 NSLog(@"UIWebViewNavigationTypeOther");
	 }
	 ////yono modify end.
	 //クエリ文字列がある場合
	 NSString *query_str = [requestUrl query];
	 NSLog(@"%s: query_str:%@",__PRETTY_FUNCTION__,query_str);
	 //logoutボタンを押した場合。
	 if(query_str != nil){
	 NSArray *a_query = [query_str componentsSeparatedByString:@"&"];
	 //output example -> '"id=30"'
	 NSLog(@"%@",[a_query description]);
	 int i;
	 NSArray *a_query_id;
	 for (i = 0; i < [a_query count]; i++) {
	 NSString *temp_a_query = [a_query objectAtIndex:i];            
	 a_query_id = [temp_a_query componentsSeparatedByString:@"="];
	 //webloginmode=lo がある場合。
	 if ([[a_query_id objectAtIndex:0] isEqualToString:@"webloginmode"]) {
	 NSLog(@"%s: a_query_id:%@",__PRETTY_FUNCTION__ ,[a_query_id description]);
	 if([[a_query_id objectAtIndex:1] isEqualToString:@"lo"]){
	 NSLog(@"%s: if block:'lo'",__PRETTY_FUNCTION__ );
	 [self loadHome];
	 return NO;
	 }
	 }
	 }
	 }
	 */
	return YES;
}

- (void) renderWebContent {  
	
	UIGraphicsBeginImageContext(browser_view.bounds.size);  
	[browser_view.layer renderInContext:UIGraphicsGetCurrentContext()];  
	imageView.image = UIGraphicsGetImageFromCurrentImageContext();  
	UIGraphicsEndImageContext();
	
	//ビューから消さない。
	//[webView removeFromSuperview];  
	//webView.delegate = nil;  
}


/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}


- (void)dealloc {
	//buttons
	[backButton release];
	[forwardButton release];
	[reloadButton release];
	[memoAddButton release];
	[memoToggleButton release];
	[paintAddButton release];
	
	//indicator view
	[waiting_label release];
	//[ss2roll_waiting release];
	[indicator_view release];
	
	//memo view
	[memo_text release];
	[add_memo_Button release];
	[memoView release];
	
	//memo scroll view
	[label release];
	[imageView_over release];
	[scrollView release];
	
	//screenshot view
	[imageView release];
	[screen_canvas release];
	
	//browser view
	[urlBar release];
	webView.delegate = nil;
	[webView release];
	[browser_view release];
    
	//[offscreenWindow release];
	[super dealloc];
}

@end