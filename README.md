# ParallaxInAllCell-ObjectiveC


In this project I made a parallax effect on all cells of the table

| iPhone Vertical |  iPhone Horizontal   |
| ------------- |:-------------:|
|![alt text](https://raw.githubusercontent.com/m1a7/ParallaxInAllCell-ObjectiveC/master/ParallaxInAllCell-ObjectiveC/ScreensForReadme/iphoneScreen1.png)    | ![alt text](https://raw.githubusercontent.com/m1a7/ParallaxInAllCell-ObjectiveC/master/ParallaxInAllCell-ObjectiveC/ScreensForReadme/iphoneScreen2.png)  |

<br>

| iPad Vertical |  iPad Horizontal   |
| ------------- |:-------------:|
|![alt text](https://raw.githubusercontent.com/m1a7/ParallaxInAllCell-ObjectiveC/master/ParallaxInAllCell-ObjectiveC/ScreensForReadme/ipadScreen1.png)    | ![alt text](https://raw.githubusercontent.com/m1a7/ParallaxInAllCell-ObjectiveC/master/ParallaxInAllCell-ObjectiveC/ScreensForReadme/ipadScreen2.png)  |

<br>
<br>


## Step by step.(How to repeat it)

### Step #1
Add this property to your UITableViewCell.

```objectivec
@interface ParallaxCellOnlyCode : UITableViewCell

@property (strong, nonatomic)  UIImageView *parallaxImage;

- (void)cellOnTableView:(UITableView *)tableView didScrollOnView:(UIView *)view;

@end
```

<br>

### Step #2

Add this method to your UITableViewCell (.h and .m file).

```objectivec
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
```

<br>

### Step #3

Start to support this Protocol in your controller.

```objectivec
@interface ViewControllerOnlyCode () <UIScrollViewDelegate>
...
@end
```

### Step #4

Call method [scrollViewDidScroll] in body viewDidAppear.

```objectivec
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self scrollViewDidScroll:nil];
}
```

### Step #5

Make a method support -scrollViewDidScroll:

Notice that:
If you use your uiviewcontroller on which lay is a table, you must write this line:
[cell cellOnTableView:self.tableView didScrollOnView:self.view];

If you use uitableviewcontroller, then write it:
[cell cellOnTableView:self.tableView didScrollOnView:self.view.superview];

```objectivec
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSArray *visibleCells = [self.tableView visibleCells];
    
    for (ParallaxCellOnlyCode *cell in visibleCells) {
        // Use this if you have uitableview on viewcontroller
        [cell cellOnTableView:self.tableView didScrollOnView:self.view];
        
        // Use this if you have uitableviewcontroller
        //[cell cellOnTableView:self.tableView didScrollOnView:self.view.superview];

    }
}
```

### PROFIT !!!
