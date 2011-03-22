//
//  RootViewController.m
//  DD
//
//  Created by Alper Tayfun on 03-07-2011.
//  Copyright 2011 Alper Tayfun. All rights reserved.
//

#import "RootViewController.h"
#import "JSON.h"
#import "details.h"
#import "DDAppDelegate.h"
#import "DisplayMap.h"


@implementation RootViewController

NSString const * APIHOST = @"api";
NSString const * APIKEY = @"91ebe09540369b9eda625437492d678e";
//NSString const * APIKEY = @"69efa823f86eab67a231c576f9a9e8a™;

@synthesize locationManager,tabBar;

#pragma mark -
#pragma mark View lifecycle

-(void)updateGeo
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc]init];
	SBJsonParser *parser = [[SBJsonParser alloc] init];
	NSString *urls = [NSString stringWithFormat:@"http://%@.denizdurumu.com/geo/?apikey=%@&lat=%.4f&lng=%.4f",APIHOST,APIKEY,self.locationManager.location.coordinate.longitude,self.locationManager.location.coordinate.latitude];
	NSLog(@"%@",urls);
	NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urls]];
	
	NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
	NSString *json_string = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
	
	NSArray *statuses = [parser objectWithString:json_string error:nil];
	arryData = [[NSMutableArray alloc] init];
	for (NSDictionary *status in statuses)
	{
			[arryData addObject:[status objectForKey:@"NAME"]];
	}
	
	[tblSimpleTable reloadData];
	[parser release];
	[pool release];
}

-(void)updateSea
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc]init];
	SBJsonParser *parser = [[SBJsonParser alloc] init];
	NSString *urls = [NSString stringWithFormat:@"http://%@.denizdurumu.com/stations/?apikey=%@",APIHOST,APIKEY];
	NSLog(@"%@",urls);
	NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urls]];
	
	NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
	NSString *json_string = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
	
	NSArray *statuses = [parser objectWithString:json_string error:nil];
	arryData = [[NSMutableArray alloc] init];
	arryData2 = [[NSMutableArray alloc] init];
	for (NSDictionary *status in statuses)
	{
		if ([[status objectForKey:@"type"] rangeOfString:@"SEA"].location == NSNotFound) {
			
		}else {
			[arryData addObject:[status objectForKey:@"name"]];
			[arryData2 addObject:[status objectForKey:@"type"]];
			//NSLog(@"%@ - %@", [status objectForKey:@"name"] , [status objectForKey:@"key"]);
		}
	}
	
	NSArray *statuses1 = [parser objectWithString:json_string error:nil];
	arryData1 = [[NSMutableArray alloc] init];
	
	for (NSDictionary *status in statuses1)
	{
		if ([[status objectForKey:@"type"] rangeOfString:@"SEA"].location == NSNotFound) {
			
		}else {
			[arryData1 addObject:[status objectForKey:@"key"]];
			[arryData2 addObject:[status objectForKey:@"type"]];
			//NSLog(@"%@ - %@", [status objectForKey:@"name"] , [status objectForKey:@"key"]);
		}
	}
	
	
	[tblSimpleTable reloadData];
	[parser release];
	[pool release];
}

-(void)updateCity
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc]init];
	SBJsonParser *parser = [[SBJsonParser alloc] init];
	NSString *urls = [NSString stringWithFormat:@"http://%@.denizdurumu.com/stations/?apikey=%@",APIHOST,APIKEY];
	NSLog(@"%@",urls);
	NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urls]];
	
	NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
	NSString *json_string = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
	
	NSArray *statuses = [parser objectWithString:json_string error:nil];
	arryData = [[NSMutableArray alloc] init];
	arryData2 = [[NSMutableArray alloc] init];
	for (NSDictionary *status in statuses)
	{
		if ([[status objectForKey:@"type"] rangeOfString:@"CITY"].location == NSNotFound) {
			
		}else {
			[arryData addObject:[status objectForKey:@"name"]];
			[arryData2 addObject:[status objectForKey:@"type"]];
			//NSLog(@"%@ - %@", [status objectForKey:@"name"] , [status objectForKey:@"key"]);
		}
	}
	
	NSArray *statuses1 = [parser objectWithString:json_string error:nil];
	arryData1 = [[NSMutableArray alloc] init];
	for (NSDictionary *status in statuses1)
	{
		if ([[status objectForKey:@"type"] rangeOfString:@"CITY"].location == NSNotFound) {
			
		}else {
			[arryData1 addObject:[status objectForKey:@"key"]];
			[arryData2 addObject:[status objectForKey:@"type"]];
			//NSLog(@"%@ - %@", [status objectForKey:@"name"] , [status objectForKey:@"key"]);
		}
	}
	[tblSimpleTable reloadData];
	[parser release];
	[pool release];
}

//retrieving city or sea heat / knot values
-(void)updateCitys
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc]init];
	SBJsonParser *parser = [[SBJsonParser alloc] init];
	//NSString *urls = [NSString stringWithFormat:@"http://%@.denizdurumu.com/city/?apikey=%@",APIHOST,APIKEY];
    DDAppDelegate *mainDelegate = (DDAppDelegate *)[[UIApplication sharedApplication]delegate];
    
    NSString *urls = [NSString stringWithFormat:@"http://%@.denizdurumu.com/%@/%@/?apikey=%@",APIHOST,mainDelegate.customSearchQuery1,mainDelegate.customSearchQuery,APIKEY];
    
	NSLog(@"%@",urls);
	NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urls]];
	
	NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
	NSString *json_string = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
	
	NSArray *statuses = [parser objectWithString:json_string error:nil];
	arryData = [[NSMutableArray alloc] init];
	arryData2 = [[NSMutableArray alloc] init];
	for (NSDictionary *status in statuses)
	{
    
			[arryData addObject:[status objectForKey:@"maxheat"]];
	}

	[tblSimpleTable reloadData];
	[parser release];
	[pool release];
}

-(BOOL)canBecomeFirstResponder {
    return YES;
}


//viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
	[tabBar release];
	[tabBar setDelegate:self];
	self.locationManager = [[[CLLocationManager alloc] init] autorelease];
	self.locationManager.delegate = self; // send loc updates to myself
	
	locationManager = [[CLLocationManager alloc] init];
    [self.locationManager startUpdatingLocation];
	NSLog(@"%.4f",locationManager.location.coordinate.longitude);
	NSLog(@"%.4f",locationManager.location.coordinate.latitude);
	
	mapViewmain.mapType = MKMapTypeStandard;
	mapViewmain.scrollEnabled = YES; 
	mapViewmain.zoomEnabled = YES; 
	mapViewmain.delegate = self;
	
	CLLocationCoordinate2D coords; 
	coords.latitude = locationManager.location.coordinate.latitude; 
	coords.longitude = locationManager.location.coordinate.longitude; 
	MKCoordinateSpan span; 
	span.latitudeDelta=0.02; 
	span.longitudeDelta=0.02; 
	
	mapViewmain.region = MKCoordinateRegionMake( coords, span ); 
	
	
	[self.locationManager stopUpdatingLocation];
	
	DisplayMap *ann = [[DisplayMap alloc] init]; 
	ann.title = @" İzmir ";
	ann.subtitle = @" Yağışlı "; 
	ann.coordinate = mapViewmain.region.center; 
	[mapViewmain addAnnotation:ann];
	[ann release];
	
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
	tblSimpleTable.delegate = self;
	[tblSimpleTable release];
	
	[self updateSea];
	
	UIBarButtonItem* seaButton = [[UIBarButtonItem alloc] initWithTitle:@"Deniz" 
                                                                   style:UIBarButtonItemStyleBordered
                                                                  target:self 
                                                                  action:@selector(seaButtonSelected:)];
    self.navigationItem.rightBarButtonItem = seaButton;
    [seaButton release];
	
	UIBarButtonItem* cityButton = [[UIBarButtonItem alloc] initWithTitle:@"Şehir" 
																  style:UIBarButtonItemStyleBordered 
																 target:self 
																 action:@selector(cityButtonSelected:)];
    self.navigationItem.leftBarButtonItem = cityButton;
    [cityButton release];
	
}

- (void)seaButtonSelected:(id)sender {
	[self updateSea];
	// whatever needs to happen when button is tapped
}

- (void)cityButtonSelected:(id)sender {
	[self updateCity];
	// whatever needs to happen when button is tapped
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	[self becomeFirstResponder];
    
    //return views update location
    
    locationManager = [[CLLocationManager alloc] init];
    [self.locationManager startUpdatingLocation];
	NSLog(@"%.4f",locationManager.location.coordinate.longitude);
	NSLog(@"%.4f",locationManager.location.coordinate.latitude);
	
	mapViewmain.mapType = MKMapTypeStandard;
	mapViewmain.scrollEnabled = YES; 
	mapViewmain.zoomEnabled = YES; 
	mapViewmain.delegate = self;
	
	CLLocationCoordinate2D coords; 
	coords.latitude = locationManager.location.coordinate.latitude; 
	coords.longitude = locationManager.location.coordinate.longitude; 
	MKCoordinateSpan span; 
	span.latitudeDelta=0.02; 
	span.longitudeDelta=0.02; 
	
	mapViewmain.region = MKCoordinateRegionMake( coords, span ); 
	
	
	[self.locationManager stopUpdatingLocation];
}
- (void)viewDidDisappear:(BOOL)animated {
	[self resignFirstResponder];
	[super viewDidDisappear:animated];
}
/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/

/*
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}
*/


 // Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations.
	return NO;
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{

	NSLog(@"%@",item.title);
	if ([item.title rangeOfString:@"Yakınımdakiler"].location == NSNotFound) {
		
	}
	else {
		[self updateGeo];

	}
	if ([item.title rangeOfString:@"Yardım"].location == NSNotFound) {
		
	}
	else {
		NSLog(@"help_clicked");
		
		mvc1 = [[help alloc] initWithNibName:@"help" bundle:nil];
		mvc1.delegate = self;
		
		if(![mvc1 retain]){
			NSLog(@"retain edilmiş");
		}
		else {
			NSLog(@"retain edilmemiş");
			mvc1.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
			[self presentModalViewController:mvc1 animated:YES];
			[mvc1 retain];
			[mvc1 autorelease];
			mvc1 = nil;
		}
		
	}
	
}

- (void) helpDidFinish: (help *) controller {
	
	[self dismissModalViewControllerAnimated: YES];
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
	
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
		
        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
		CGRect frame;
		frame.origin.x = 55; 
		frame.origin.y = 5;
		frame.size.height = 43;
		frame.size.width = 200;
		
		UILabel *stateLabel = [[UILabel alloc] initWithFrame:frame];
		stateLabel.tag = StateTag;
		[cell.contentView addSubview:stateLabel];
		[stateLabel release];
		
    }
	
	NSString *imageName = [NSString stringWithFormat:@"karli.png"];
	UIImage *thumbImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:imageName ofType:nil]];
	
	
	UILabel * stateLabel = (UILabel *) [cell.contentView viewWithTag:StateTag];
	[stateLabel setFont:[UIFont fontWithName:@"Trebuchet MS" size:18]];
	
	//NSString *asd = [NSString stringWithFormat:@"%@ - %@",[arryData objectAtIndex:indexPath.row],[arryData1 objectAtIndex:indexPath.row]];
	NSString *asd = [NSString stringWithFormat:@"%@    15°",[arryData objectAtIndex:indexPath.row]];
	//stateLabel.text = [arryData objectAtIndex:indexPath.row];
	stateLabel.text = asd;
	cell.imageView.frame = CGRectMake(0, 0, 100, 100);
	cell.imageView.bounds = CGRectMake(0, 0, 100, 100);
	cell.imageView.image = thumbImage;
	
	DDAppDelegate *mainDelegate = (DDAppDelegate *)[[UIApplication sharedApplication]delegate];
	[mainDelegate setCustomSearchQuery:[arryData1 objectAtIndex:indexPath.row]];
	[mainDelegate setCustomSearchQuery1:[arryData2 objectAtIndex:indexPath.row]];
    
    //cell accessoryType
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	//mag_self.detailItem = [NSString stringWithFormat:@"%@", [arryData2 objectAtIndex:indexPath.row]]; 
	
	DDAppDelegate *mainDelegate = (DDAppDelegate *)[[UIApplication sharedApplication]delegate];
	[mainDelegate setCustomSearchQuery:[arryData1 objectAtIndex:indexPath.row]];
	[mainDelegate setCustomSearchQuery1:[arryData2 objectAtIndex:indexPath.row]];
	[mainDelegate retain];
	
	details *detailViewController = [[details alloc] initWithNibName:@"details" bundle:nil];
	[self.navigationController pushViewController:detailViewController animated:YES];
	self.navigationController.topViewController.title = [arryData objectAtIndex:indexPath.row];
	self.navigationController.topViewController.nibBundle.accessibilityValue = [arryData1 objectAtIndex:indexPath.row];
	
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 45.0; //returns floating point which will be used for a cell row height at specified row index
}

#pragma mark -
#pragma mark Corelocation delegate

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"Location: %@", [newLocation description]);
}

- (void)locationManager:(CLLocationManager *)manager
	   didFailWithError:(NSError *)error
{
	NSLog(@"Error: %@", [error description]);
}

- (void)locationUpdate:(CLLocation *)location {
    NSLog(@"Location: %@",[location description]);
}

- (void)locationError:(NSError *)error {
    NSLog(@"Error: %@", [error description]);
}


#pragma mark -
#pragma mark mapViewmain Delegate
-(MKAnnotationView *)mapView:(MKMapView *)mV viewForAnnotation:(id <MKAnnotation>)annotation
{
	MKPinAnnotationView *pinView = nil; 
	if(annotation != mapViewmain.userLocation)
	{
		static NSString *defaultPinID = @"com.denizdurumu.pin";
		pinView = (MKPinAnnotationView *)[mapViewmain dequeueReusableAnnotationViewWithIdentifier:defaultPinID];
		if ( pinView == nil ) pinView = [[[MKPinAnnotationView alloc]
										  initWithAnnotation:annotation reuseIdentifier:defaultPinID] autorelease];
		
		pinView.pinColor = MKPinAnnotationColorGreen;
		pinView.canShowCallout = YES;
		pinView.animatesDrop = YES;
	} 
	else {
		[mapViewmain.userLocation setTitle:@"I am here"];
	}
	return pinView;
}

#pragma mark -
#pragma mark Device Shake

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion == UIEventSubtypeMotionShake)
    {
		DDAppDelegate *mainDelegate = (DDAppDelegate *)[[UIApplication sharedApplication]delegate];
		NSLog(@"Shake Detect : %@",mainDelegate.customSearchQuery1 );
		
		NSCharacterSet * set = [[NSCharacterSet characterSetWithCharactersInString:@"SEA"] invertedSet];
		
		if ([mainDelegate.customSearchQuery1 rangeOfCharacterFromSet:set].location != NSNotFound) {
			[self updateSea];
		}
		else {
			
			[self updateCity];
		}

    }
}

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
	[self.locationManager release];
	[tblSimpleTable release];
	[tabBar release];
	[mapViewmain release];
	[arryData release];
	[arryData1 release];
	[arryData2 release];
	[arryData3 release];
	[arryData4 release];
}


- (void)dealloc {
    [super dealloc];
	[self.locationManager release],locationManager = nil;
	[tblSimpleTable release],tblSimpleTable =nil;
	[tabBar release],tabBar = nil;
	[mapViewmain release],mapViewmain = nil;
	[arryData release],arryData = nil;
	[arryData1 release],arryData1 = nil;
	[arryData2 release],arryData2 = nil;
	[arryData3 release],arryData3 = nil;
	[arryData4 release],arryData4 = nil;
}


@end

