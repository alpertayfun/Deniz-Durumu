//
//  details.m
//  DenizDurumu
//
//  Created by Alper Tayfun on 03-07-2011.
//  Copyright 2011 Alper Tayfun. All rights reserved.
//

#import "details.h"
#import "DDAppDelegate.h"
#import "JSON.h"


@implementation details

NSString const * APIHOST1 = @"api";
NSString const * APIKEY1 = @"91ebe09540369b9eda625437492d678e";

@synthesize session = _session;
@synthesize loginDialog = _loginDialog;
@synthesize facebookName = _facebookName;
@synthesize posting = _posting;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/
-(void)detailsSea
{
	DDAppDelegate *mainDelegate = (DDAppDelegate *)[[UIApplication sharedApplication]delegate];
	NSLog(@"%@",mainDelegate.customSearchQuery);
	SBJsonParser *parser = [[SBJsonParser alloc] init];
	NSString *urls = [NSString stringWithFormat:@"http://%@.denizdurumu.com/sea/%@/?apikey=%@",APIHOST1,mainDelegate.customSearchQuery,APIKEY1];
	NSLog(@"%@",urls);
	NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urls]];
	
	NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
	NSString *json_string = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
	
	NSArray *statuses = [parser objectWithString:json_string error:nil];
	arryData = [[NSMutableArray alloc] init];
	
	for (NSDictionary *status in statuses)
	{
		[arryData addObject:[status objectForKey:@"status"]];
		//NSLog(@"%@ - %@", [status objectForKey:@"name"] , [status objectForKey:@"key"]);
	}
	[tblDetails reloadData];
	[parser release];
}

-(void)detailsCity1
{
	DDAppDelegate *mainDelegate = (DDAppDelegate *)[[UIApplication sharedApplication]delegate];
	NSLog(@"%@",mainDelegate.customSearchQuery);
	SBJsonParser *parser = [[SBJsonParser alloc] init];
	NSString *urls1 = [NSString stringWithFormat:@"http://%@.denizdurumu.com/city/%@/?apikey=%@",APIHOST1,mainDelegate.customSearchQuery,APIKEY1];
	NSLog(@"%@",urls1);
	NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urls1]];
	
	NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
	NSString *json_string = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
	
	NSArray *statuses = [parser objectWithString:json_string error:nil];
	arryData = [[NSMutableArray alloc] init];
	
	for (NSDictionary *status in statuses)
	{
			[arryData addObject:[status objectForKey:@"status"]];
	}
	[tblDetails reloadData];
	[parser release];

}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	[tblDetails release];
	tblDetails.delegate = self;
	[imageViews release];
	
	mapView.mapType = MKMapTypeStandard;
	mapView.scrollEnabled = YES; 
	mapView.zoomEnabled = YES; 
	mapView.delegate = self;
	
	CLLocationCoordinate2D coords; 
	coords.latitude = 36.971838; 
	coords.longitude = 35.3210449; 
	MKCoordinateSpan span; 
	span.latitudeDelta=0.02; 
	span.longitudeDelta=0.02; 
	
	mapView.region = MKCoordinateRegionMake( coords, span ); 
	
	DDAppDelegate *mainDelegate = (DDAppDelegate *)[[UIApplication sharedApplication]delegate];
	NSLog(@"%@",mainDelegate.customSearchQuery1 );
	
	NSCharacterSet * set = [[NSCharacterSet characterSetWithCharactersInString:@"SEA"] invertedSet];
	
	if ([mainDelegate.customSearchQuery1 rangeOfCharacterFromSet:set].location != NSNotFound) {
		NSLog(@"city");
		[self detailsCity1];
		
		NSString *finalString = [mainDelegate.customSearchQuery stringByReplacingOccurrencesOfString:@"C" withString:@""];
		NSLog(@"%@",finalString);
		NSString *path = [NSString stringWithFormat:@"http://www.denizdurumu.com/chart_proxy.php?op=citytempreture&id=%@",finalString];
		NSURL *url = [NSURL URLWithString:path];
		NSData *data = [NSData dataWithContentsOfURL:url];
		UIImage *img = [[UIImage alloc] initWithData:data];
		imageViews.image = img;
		
	} else {
		NSLog(@"sea");
		[self detailsSea];
		
		NSString *finalString = [mainDelegate.customSearchQuery stringByReplacingOccurrencesOfString:@"S" withString:@""];
		NSLog(@"%@",finalString);
		NSString *path = [NSString stringWithFormat:@"http://www.denizdurumu.com/chart_proxy.php?op=seatempreture&id=%@",finalString];
		NSURL *url = [NSURL URLWithString:path];
		NSData *data = [NSData dataWithContentsOfURL:url];
		UIImage *img = [[UIImage alloc] initWithData:data];
		imageViews.image = img;
		
	}
	
	UIBarButtonItem* seaButton = [[UIBarButtonItem alloc] initWithTitle:@"Paylaş->" 
																  style:UIBarButtonItemStylePlain 
																 target:self 
																 action:@selector(detayButtonSelected:)];
    self.navigationItem.rightBarButtonItem = seaButton;
    [seaButton release];
	//static NSString* kApiKey = @"1509c7b5caf7f916b15067c1510f263b";
	//static NSString* kApiSecret = @"9e8b2661abff8be078dabe578d97e428";
	
	static NSString* kApiKey = @"7c6337c460e64bd09dd1a0e50645a53b";
	static NSString* kApiSecret = @"902a47ecbe2e01551507a3c407c7daf6";
	_session = [[FBSession sessionForApplication:kApiKey secret:kApiSecret delegate:self] retain];
	
	// Load a previous session from disk if available.  Note this will call session:didLogin if a valid session exists.
	[_session resume];
}
- (void)detayButtonSelected:(id)sender {
	// whatever needs to happen when button is tapped
	
	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Paylaş" delegate:self cancelButtonTitle:@"Kapat" destructiveButtonTitle:nil otherButtonTitles:@"Facebook", nil];
	[actionSheet showInView:self.view];
	[actionSheet release];
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	// the user clicked one of the OK/Cancel buttons
	if (buttonIndex == 0)
	{
		NSLog(@"Facebook");
		_posting = YES;
		// If we're not logged in, log in first...
		if (![_session isConnected]) {
			self.loginDialog = nil;
			_loginDialog = [[FBLoginDialog alloc] init];	
			[_loginDialog show];	
		}
		// If we have a session and a name, post to the wall!
		else if (_facebookName != nil) {
			[self postToWall];
		}
	}
}
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/
#pragma mark FBSessionDelegate methods

- (void)session:(FBSession*)session didLogin:(FBUID)uid {
	[self getFacebookName];
}

- (void)session:(FBSession*)session willLogout:(FBUID)uid {
	//_logoutButton.hidden = YES;
	_facebookName = nil;
}

#pragma mark Get Facebook Name Helper

- (void)getFacebookName {
	NSString* fql = [NSString stringWithFormat:
					 @"select uid,name from user where uid == %lld", _session.uid];
	NSDictionary* params = [NSDictionary dictionaryWithObject:fql forKey:@"query"];
	[[FBRequest requestWithDelegate:self] call:@"facebook.fql.query" params:params];
}

#pragma mark FBRequestDelegate methods

- (void)request:(FBRequest*)request didLoad:(id)result {
	if ([request.method isEqualToString:@"facebook.fql.query"]) {
		NSArray* users = result;
		NSDictionary* user = [users objectAtIndex:0];
		NSString* name = [user objectForKey:@"name"];
		self.facebookName = name;		
		//[_logoutButton setTitle:[NSString stringWithFormat:@"Facebook: Logout as %@", name] forState:UIControlStateNormal];
		if (_posting) {
			[self postToWall];
			_posting = NO;
		}
	}
}

#pragma mark Post to Wall Helper

- (void)postToWall {
	
	NSString *cityorsea = [[NSString alloc] initWithString:self.title];
	FBStreamDialog* dialog = [[[FBStreamDialog alloc] init] autorelease];
	dialog.userMessagePrompt = @"Enter your message:";
	dialog.attachment = [NSString stringWithFormat:@"{\"name\":\"%@ şuanda Deniz Durumu for iPhone kullanıyor. Havar Durumu : %@ - \"}",
						 _facebookName,cityorsea];
	//dialog.actionLinks = @"[{\"text\":\"Hemen oku !\",\"href\":\"http://www.apprika.net/\"}]";
	[dialog show];
	[cityorsea release];
	
}


#pragma mark Table view delegate
#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [arryData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *CellIdentifier = @"Cell";
    
	static NSInteger StateTag = 1;
	static NSInteger CapitalTag = 2;
	
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
		
        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
		CGRect frame;
		frame.origin.x = 105; 
		frame.origin.y = 5;
		frame.size.height = 15;
		frame.size.width = 200;
		
		UILabel *capitalLabel = [[UILabel alloc] initWithFrame:frame];
		capitalLabel.tag = CapitalTag;
		capitalLabel.textColor = [UIColor blueColor];
		[cell.contentView addSubview:capitalLabel];
		[capitalLabel release];
		
		frame.origin.y += 18;
		UILabel *stateLabel = [[UILabel alloc] initWithFrame:frame];
		stateLabel.tag = StateTag;
		[cell.contentView addSubview:stateLabel];
		[stateLabel release];
		
    }
    
	
	NSString *imageName = [NSString stringWithFormat:@"%@.jpg",[arryData objectAtIndex:indexPath.row]];
	UIImage *thumbImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:imageName ofType:nil]];
	
	UILabel * stateLabel = (UILabel *) [cell.contentView viewWithTag:StateTag];
	UILabel * capitalLabel = (UILabel *) [cell.contentView viewWithTag:CapitalTag];
	
	stateLabel.text = [arryData objectAtIndex:indexPath.row];
	capitalLabel.text = [arryData objectAtIndex:indexPath.row];
	cell.imageView.frame = CGRectMake(0, 0, 100, 100);
	cell.imageView.bounds = CGRectMake(0, 0, 100, 100);
	cell.imageView.image = thumbImage;
	
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	//mag_self.detailItem = [NSString stringWithFormat:@"%@", [arryData2 objectAtIndex:indexPath.row]]; 

	/*
	details *detailViewController = [[details alloc] initWithNibName:@"details" bundle:nil];
	[self.navigationController pushViewController:detailViewController animated:YES];
	self.navigationController.topViewController.title = [arryData objectAtIndex:indexPath.row];
	self.navigationController.topViewController.nibBundle.accessibilityValue = [arryData1 objectAtIndex:indexPath.row];
	[details release];
	*/
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 50.0; //returns floating point which will be used for a cell row height at specified row index
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
	[tblDetails release];
	[mapView release];
	[arryData release];
	[arryData1 release];
	[imageViews release];
}


- (void)dealloc {
    [super dealloc];
	[tblDetails release];
	[mapView release];
	[arryData release],arryData = nil;
	[arryData1 release],arryData1 = nil;
	[imageViews release],imageViews = nil;
}


@end
