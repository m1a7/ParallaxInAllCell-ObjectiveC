//
//  TestJBParallaxCell.m
//  ParallaxInAllCell-ObjectiveC
//
//  Created by Uber on 22/01/2018.
//  Copyright © 2018 Uber. All rights reserved.
//

#import "ParallaxCellFromStoryboard.h"

#define offsetForParallaxImage 25
#define offsetForTitleLabelHorizontal 15
#define offsetForTitleLabelVertical   8

@implementation ParallaxCellFromStoryboard

// Вызывается когда все прописано программно
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    }
    return self;
}


// вызывается когда есть в storyboard образец
-(id)initWithCoder:(NSCoder*)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self){
    }
    return self;
}


- (void) fillDataToCell:(UIImage*) parallaxImg titleText:(NSString*) titleText
{
    if (self.parallaxImage)
        self.parallaxImage.image = parallaxImg;
    if (self.titleLabel)
        self.titleLabel.text = titleText;
}

#pragma mark - ScrollView Parallax Effect

- (void)cellOnTableView:(UITableView *)tableView didScrollOnView:(UIView *)view
{
    CGRect rectInSuperview = [tableView convertRect:self.frame toView:view];
    
    float distanceFromCenter = CGRectGetHeight(view.frame)/2 - CGRectGetMinY(rectInSuperview);
    float difference = CGRectGetHeight(self.parallaxImage.frame) - CGRectGetHeight(self.frame);
    float move = (distanceFromCenter / CGRectGetHeight(view.frame)) * difference;
    
    CGRect imageRect = self.parallaxImage.frame;
    imageRect.origin.y = -(difference/2)+move;
    self.parallaxImage.frame = imageRect;
}

#pragma mark - Others

#pragma mark - Others


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    /*
     Это  сделано для того чтобы не было обесцвечивания grayView при нажатии на ячейку
     */
    UIColor* grayColor = self.grayView.backgroundColor;
    UIColor* imgColor  = self.parallaxImage.backgroundColor;
    
    [super setSelected:selected animated:animated];
    
    self.grayView.backgroundColor = grayColor;
    self.parallaxImage.backgroundColor = imgColor;
}

-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
    // [super setHighlighted:highlighted animated:animated];
}


@end
