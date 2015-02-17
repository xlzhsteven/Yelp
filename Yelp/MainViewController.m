//
//  MainViewController.m
//  Yelp
//
//  Created by Timothy Lee on 3/21/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "MainViewController.h"
#import "YelpClient.h"
#import "Business.h"
#import "BusinessCell.h"
#import "FilterViewController.h"

NSString * const kYelpConsumerKey = @"XsMu-qODjZ0bkSzL4U-FFA";
NSString * const kYelpConsumerSecret = @"U1oZ0INAygJWEUHdKpSPjio0XxY";
NSString * const kYelpToken = @"nzNztxkNedzqTjxaj6ieiQQLMtnGhAJy";
NSString * const kYelpTokenSecret = @"xwZ8qZsV9V9tZJb2P90kVrPOGnQ";

@interface MainViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, FilterViewControllerDelegate>

@property (nonatomic, strong) YelpClient *client;
@property (nonatomic, strong) NSArray *businesses;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UISearchBar *searchBar;

@end

@implementation MainViewController

- (void) fetchBusinessesWithQuery:(NSString *)query params:(NSDictionary *)params {
    [self.client searchWithTerm:query params:params success:^(AFHTTPRequestOperation *operation, id response) {
        NSLog(@"response: %@", response);
        NSArray *businessDictionaries = response[@"businesses"];
        self.businesses = [Business businessesWithDictionaries:businessDictionaries];
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error: %@", [error description]);
    }];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // You can register for Yelp API keys here: http://www.yelp.com/developers/manage_api_keys
        self.client = [[YelpClient alloc] initWithConsumerKey:kYelpConsumerKey consumerSecret:kYelpConsumerSecret accessToken:kYelpToken accessSecret:kYelpTokenSecret];
        [self fetchBusinessesWithQuery:@"Restaurants" params:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    // After adding View controller-based status bar appearance to NO in the Yelp.plist, set the following to change the status bar color
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"BusinessCell" bundle:nil] forCellReuseIdentifier:@"BusinessCell"];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 88;
//    self.title = @"Yelp";
    
    // add navigation bar button to go to filters view controller
    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc] initWithTitle:@"Filters" style:UIBarButtonItemStylePlain target:self action:@selector(onFilterButton)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    
    self.searchBar = [UISearchBar new];
    self.searchBar.delegate = self;
    [self.searchBar sizeToFit];
    self.searchBar.placeholder = @"Yelp Search";
    self.searchBar.frame = CGRectMake(0,0,250, self.searchBar.bounds.size.height);
    self.searchBar.searchBarStyle = UISearchBarStyleMinimal;
    self.searchBar.tintColor = [UIColor grayColor];
    UIView *barView = [[UIView alloc] initWithFrame:self.searchBar.frame];
    [barView addSubview:self.searchBar];
    self.navigationItem.titleView = barView;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.769 green:0.071 blue:0 alpha:1];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.businesses.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BusinessCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BusinessCell"];
    cell.business = self.businesses[indexPath.row];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // dismiss keyboard when scroll
    [self.searchBar resignFirstResponder];
}

#pragma mark - filter delegate methods
- (void)filterViewController:(FilterViewController *)filterViewController didChangeFilters:(NSDictionary *)filters {
    [self fetchBusinessesWithQuery:@"Restaurants" params:filters];
    NSLog(@"linking happened %@", filters);
}

#pragma mark - Search bar methods
-(void) searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSString* text = searchBar.text;
    [self fetchBusinessesWithQuery:text params:nil];
    [searchBar resignFirstResponder];
}

#pragma mark - private methods

// method invoked when filters button is clicked
- (void)onFilterButton {
    FilterViewController *fvc = [[FilterViewController alloc] init];
    fvc.delegate = self;
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:fvc];
    [self presentViewController:nvc animated:YES completion:nil];
}

@end
