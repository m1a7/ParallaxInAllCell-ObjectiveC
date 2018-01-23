//
//  TestJBParallaxCell.h
//  ParallaxInAllCell-ObjectiveC
//
//  Created by Uber on 22/01/2018.
//  Copyright © 2018 Uber. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ParallaxCellFromStoryboard : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *parallaxImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *grayView;

- (void) fillDataToCell:(UIImage*) parallaxImg titleText:(NSString*) titleText;

- (void)cellOnTableView:(UITableView *)tableView didScrollOnView:(UIView *)view;

@end
