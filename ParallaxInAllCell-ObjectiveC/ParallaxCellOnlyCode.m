//
//  JBParallaxCell.m
//  ParallaxInAllCell-ObjectiveC
//
//  Created by Uber on 22/01/2018.
//  Copyright © 2018 Uber. All rights reserved.
//

#import "ParallaxCellOnlyCode.h"

#define offsetForParallaxImage 25
#define offsetForTitleLabelHorizontal 15
#define offsetForTitleLabelVertical   8



@interface ParallaxCellOnlyCode ()
@end

@implementation ParallaxCellOnlyCode

// Вызывается когда все прописано программно
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initAllUIComponents];
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

//
// вызывается при перерисовке - перевороте
-(void)layoutSubviews{
    [super layoutSubviews];
}

- (void) resizeAllSubviews
{
    // Parallax - UIImageView
    __weak ParallaxCellOnlyCode* weakSelf = self;
    [UIView animateWithDuration:0.1f animations:^{
        weakSelf.parallaxImage.frame = CGRectMake(0, -offsetForParallaxImage,
                                                  CGRectGetWidth(weakSelf.contentView.frame),
                                                  CGRectGetHeight(weakSelf.contentView.frame)+offsetForParallaxImage);
    }];
    
    // Gray view - UIView
    CGFloat widthGrayView = CGRectGetWidth(self.contentView.frame);
    CGFloat heighGrayView;
    
    // Если ipad тогда высота grayView - 25%. Если iphone тогда высота grayView - 30%.
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        heighGrayView = (CGRectGetHeight(self.contentView.frame)/100)*25;
    else
        heighGrayView = (CGRectGetHeight(self.contentView.frame)/100)*30;
    
    CGFloat xGrayView = 0;
    CGFloat yGrayView = CGRectGetHeight(self.contentView.frame)-heighGrayView;
    self.grayView.frame =  CGRectMake(xGrayView, yGrayView, widthGrayView, heighGrayView);
    
    // TitleLabel - UILabel
    CGFloat xTitleLabel     = offsetForTitleLabelHorizontal;
    CGFloat yTitleLabel     = yGrayView + offsetForTitleLabelVertical;
    CGFloat widthTitleLabel = CGRectGetWidth(self.contentView.bounds)-(offsetForTitleLabelHorizontal*2);
    CGFloat heighTitleLabel = heighGrayView-offsetForTitleLabelVertical;
    self.titleLabel.frame =  CGRectMake(xTitleLabel, yTitleLabel, widthTitleLabel, heighTitleLabel);
}

#pragma mark - Init All UI Components

- (void) initAllUIComponents
{
    self.clipsToBounds = YES;
    // Parallax - UIImageView
    self.parallaxImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, -offsetForParallaxImage,
                                                                       CGRectGetWidth(self.contentView.frame),
                                                                       CGRectGetHeight(self.contentView.frame)+offsetForParallaxImage)];
    self.parallaxImage.clipsToBounds = YES;
    self.parallaxImage.layer.masksToBounds = YES;
    self.parallaxImage.translatesAutoresizingMaskIntoConstraints = NO;

    self.parallaxImage.backgroundColor = [UIColor yellowColor];
    [self.parallaxImage setContentMode:UIViewContentModeScaleAspectFill];
    [self.contentView addSubview:self.parallaxImage];
    
    // Gray view - UIView
    self.grayView = [UIView new];
    self.grayView.backgroundColor = [UIColor blackColor];
    self.grayView.translatesAutoresizingMaskIntoConstraints = NO;

    // Add gradient half-transparent for self.gradientView
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame  = self.grayView.bounds;
    gradient.colors = @[(id)[UIColor colorWithRed:0.17 green:0.22 blue:0.25 alpha:0.0].CGColor,
                        (id)[UIColor colorWithRed:0.17 green:0.22 blue:0.25 alpha:0.1].CGColor];
    self.grayView.alpha = 0.75f;
    [self.grayView.layer insertSublayer:gradient atIndex:0];
    [self.contentView addSubview:self.grayView];
    
    // TitleLabel - UILabel
    CGFloat fontSize          = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? 23.f : 13.f; // Size for iPad : Size for iPhone
    UIFont* fontForTitleLabel =  [UIFont fontWithName:@"AvenirNext-Medium" size:fontSize];
    
    self.titleLabel               = [[UILabel alloc]init];
    self.titleLabel.clipsToBounds = YES;
    self.titleLabel.font = fontForTitleLabel;
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.clipsToBounds = YES;
    self.titleLabel.backgroundColor = [UIColor clearColor];
    self.titleLabel.textColor       = [UIColor whiteColor];
    self.titleLabel.textAlignment   = NSTextAlignmentLeft;
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:self.titleLabel];
    
    [self addConstrintsToSubviewsCell];
}


#pragma mark - Add Data to Cell

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
    
    float distanceFromCenter     = CGRectGetHeight(view.frame)/2 - CGRectGetMinY(rectInSuperview);
    float difference             = CGRectGetHeight(self.parallaxImage.frame) - CGRectGetHeight(self.frame);
    float move                   = (distanceFromCenter / CGRectGetHeight(view.frame)) * difference;
    
    CGRect imageRect         = self.parallaxImage.frame;
    imageRect.origin.y       = -(difference/2)+move;
    self.parallaxImage.frame = imageRect;
}

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

#pragma mark - Constraints

- (void) addConstrintsToSubviewsCell
{
    if (self.parallaxImage){
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.parallaxImage
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeTop
                                                                    multiplier:1.0
                                                                      constant:-offsetForParallaxImage]];
        
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.parallaxImage
                                                                     attribute:NSLayoutAttributeLeading
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeLeading
                                                                    multiplier:1.0
                                                                      constant:0]];
        
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.parallaxImage
                                                                     attribute:NSLayoutAttributeBottom
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeBottom
                                                                    multiplier:1.0
                                                                      constant:offsetForParallaxImage]];
        
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.parallaxImage
                                                                     attribute:NSLayoutAttributeTrailing
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeTrailing
                                                                    multiplier:1.0
                                                                      constant:0]];
    }
    
    if (self.grayView){
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.grayView
                                                                     attribute:NSLayoutAttributeLeading
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeLeading
                                                                    multiplier:1.0
                                                                      constant:0]];
        
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.grayView
                                                                     attribute:NSLayoutAttributeTrailing
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeTrailing
                                                                    multiplier:1.0
                                                                      constant:0]];
        
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.grayView
                                                                     attribute:NSLayoutAttributeBottom
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeBottom
                                                                    multiplier:1.0
                                                                      constant:0]];
        
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.grayView
                                                                     attribute:NSLayoutAttributeHeight
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeHeight
                                                                    multiplier:0.3
                                                                      constant:0]];
    }
    
    if (self.titleLabel){
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLabel
                                                                     attribute:NSLayoutAttributeLeading
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeLeading
                                                                    multiplier:1.0
                                                                      constant:offsetForTitleLabelHorizontal]];
        
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLabel
                                                                     attribute:NSLayoutAttributeTrailing
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeTrailing
                                                                    multiplier:1.0
                                                                      constant:-offsetForTitleLabelHorizontal]];
        
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLabel
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.grayView
                                                                     attribute:NSLayoutAttributeTop
                                                                    multiplier:1.0
                                                                      constant:0]];
        
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLabel
                                                                     attribute:NSLayoutAttributeBottom
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.grayView
                                                                     attribute:NSLayoutAttributeBottom
                                                                    multiplier:1.0
                                                                      constant:0]];
    }
}

@end
