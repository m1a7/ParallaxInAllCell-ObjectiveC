//
//  JBParallaxCell.h
//  ParallaxInAllCell-ObjectiveC
//
//  Created by Uber on 22/01/2018.
//  Copyright © 2018 Uber. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ParallaxCellOnlyCode : UITableViewCell



@property (strong, nonatomic)  UIImageView *parallaxImage;
@property (strong, nonatomic)  UILabel *titleLabel;
@property (strong, nonatomic)  UIView *grayView;

- (void) fillDataToCell:(UIImage*) parallaxImg titleText:(NSString*) titleText;

- (void)cellOnTableView:(UITableView *)tableView didScrollOnView:(UIView *)view;

@end
