//
//  TestViewController.m
//  ParallaxInAllCell-ObjectiveC
//
//  Created by Uber on 22/01/2018.
//  Copyright © 2018 Uber. All rights reserved.
//

#import "ViewControllerFromStoryboard.h"

#import "ParallaxCellFromStoryboard.h"


#define IS_IPAD         (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_PORTRAIT     UIDeviceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])

@interface ViewControllerFromStoryboard () <UIScrollViewDelegate>

@property (nonatomic, strong) NSArray *tableItems;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *tableTitleItems;
@end

@implementation ViewControllerFromStoryboard

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray* imageNames = @[@"car_1",  @"car_2",  @"car_3",  @"car_4",  @"car_5",  @"car_6",
                            @"car_7",  @"car_8",  @"car_9",  @"car_10", @"car_11", @"car_12",
                            @"car_13", @"car_14", @"car_15", @"car_16", @"car_17", @"car_18",
                            @"car_19", @"car_20", @"car_21", @"car_22", @"car_23",
                            
                            @"life_1",  @"life_2",  @"life_3",  @"life_4",  @"life_5",  @"life_6",
                            @"life_7",  @"life_8",   @"life_10", @"life_11", @"life_12",
                            @"life_13", @"life_14", @"life_15", @"life_16", @"life_17", @"life_18",
                            @"life_19",
                            
                            @"plane_1",  @"plane_2",  @"plane_3",  @"plane_5",  @"plane_6",
                            @"plane_7",  @"plane_8"];
    NSArray* titles = @[@"Как вырезать светильник джека своими руками Как вырезать светильник джека своими руками",
                        @"Как вырезать светильник джека своими руками"];
    
    self.tableTitleItems = [NSArray arrayWithArray:titles];
    self.tableItems = [NSArray arrayWithArray:imageNames];
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self scrollViewDidScroll:nil];
    
    if (self.navigationController)
    {
        NSDictionary* titleTextAttributesDict = @{NSForegroundColorAttributeName : [UIColor whiteColor],
                                                  NSFontAttributeName            : [UIFont fontWithName:@"AvenirNext-Medium" size:23]};
        self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
        self.navigationController.navigationBar.topItem.title = @"USA 60th";
        [self.navigationController.navigationBar setTitleTextAttributes: titleTextAttributesDict];
    }
}


- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat standartHeightOfCell = 200;
    NSInteger numberOfCellOnScreenInPortrain   = 3;
    NSInteger numberOfCellOnScreenInHorizontal = 2;
    
    if (UIDeviceOrientationIsPortrait([UIDevice currentDevice].orientation))
    {
        return CGRectGetHeight(self.tableView.frame)/numberOfCellOnScreenInPortrain;
    }
    
    if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation))
    {
        if (IS_IPAD)
            return CGRectGetHeight(self.tableView.frame)/numberOfCellOnScreenInHorizontal;
        else
            return CGRectGetHeight(self.tableView.frame);
    }
    return standartHeightOfCell;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ParallaxCellFromStoryboard";
    ParallaxCellFromStoryboard *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[ParallaxCellFromStoryboard alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    NSString* textForLabel = (indexPath.row % 2 == 0) ? self.tableTitleItems[0] : self.tableTitleItems[1];
    [cell fillDataToCell:[UIImage imageNamed:self.tableItems[indexPath.row]]
               titleText:textForLabel];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // Get visible cells on table view.
    NSArray *visibleCells = [self.tableView visibleCells];
    for (ParallaxCellFromStoryboard *cell in visibleCells) {
        // parallaxImage
        [cell cellOnTableView:self.tableView didScrollOnView:self.view];
    }
}
@end
