/*
 * Copyright (c) 2013 Nils Mattisson, Martin Hartl
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

#import "DropdownMenuController.h"
#import "DropdownMenuSegue.h"

@implementation DropdownMenuController

CAShapeLayer *openMenuShape;
CAShapeLayer *closedMenuShape;

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // Set the current view controller to the one embedded (in the storyboard).
    self.currentViewController = self.childViewControllers.firstObject;
    
    // Draw the shapes for the open and close menu triangle.
    [self drawOpenLayer];
    [self drawClosedLayer];
}

- (void) setMenubarTitle:(NSString *) menubarTitle {
    self.titleLabel.text = menubarTitle;
}

- (void) setMenubarBackground:(UIColor *) color {
    self.menubar.backgroundColor = color;
}

- (IBAction) menuButtonAction: (UIButton *) sender {
    [self toggleMenu];
}

- (IBAction) listButtonAction: (UIButton *) sender {
    [self hideMenu];
}

- (void) toggleMenu {
    if(self.menu.hidden) {
        [self showMenu];
    } else {
        [self hideMenu];
    }
}

- (void) showMenu {
    self.menu.hidden = NO;
    
    [closedMenuShape removeFromSuperlayer];
    [[[self view] layer] addSublayer:openMenuShape];
    
    // Set new origin of menu
    CGRect menuFrame = self.menu.frame;
    menuFrame.origin.y = self.menubar.frame.size.height;
    
    // Set new alpha of Container View (to get fade effect)
    float containerAlpha = 0.5f;
    
    [UIView animateWithDuration:0.4
                          delay:0.0
         usingSpringWithDamping:1.0
          initialSpringVelocity:4.0
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.menu.frame = menuFrame;
                         [self.container setAlpha: containerAlpha];
                     }
                     completion:^(BOOL finished){
                     }];
    [UIView commitAnimations];

}

- (void) hideMenu {
    // Set the border layer to hidden menu state
    [openMenuShape removeFromSuperlayer];
    [[[self view] layer] addSublayer:closedMenuShape];
    
    // Set new origin of menu
    CGRect menuFrame = self.menu.frame;
    menuFrame.origin.y = self.menubar.frame.size.height-menuFrame.size.height;
    
    // Set new alpha of Container View (to get fade effect)
    float containerAlpha = 1.0f;
    
    [UIView animateWithDuration:0.3f
                          delay:0.05f
         usingSpringWithDamping:1.0
          initialSpringVelocity:4.0
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.menu.frame = menuFrame;
                         [self.container setAlpha: containerAlpha];
                     }
                     completion:^(BOOL finished){
                         self.menu.hidden = YES;
                     }];
    [UIView commitAnimations];
    
}

- (void) drawOpenLayer {
    openMenuShape = [CAShapeLayer layer];
    
    // Constants to ease drawing the border and the stroke.
    int height = self.menubar.frame.size.height;
    int width = self.menubar.frame.size.width;
    int triangleSize = 8;
    int trianglePosition = 0.87*width;
    
    // The path for the triangle (showing that the menu is open).
    UIBezierPath *triangleShape = [[UIBezierPath alloc] init];
    [triangleShape moveToPoint:CGPointMake(trianglePosition, height)];
    [triangleShape addLineToPoint:CGPointMake(trianglePosition+triangleSize, height-triangleSize)];
    [triangleShape addLineToPoint:CGPointMake(trianglePosition+2*triangleSize, height)];
    [triangleShape addLineToPoint:CGPointMake(trianglePosition, height)];
    
    [openMenuShape setPath:triangleShape.CGPath];
    //[openMenuShape setFillColor:[self.menubar.backgroundColor CGColor]];
    [openMenuShape setFillColor:[self.menu.backgroundColor CGColor]];
    UIBezierPath *borderPath = [[UIBezierPath alloc] init];
    [borderPath moveToPoint:CGPointMake(0, height)];
    [borderPath addLineToPoint:CGPointMake(trianglePosition, height)];
    [borderPath addLineToPoint:CGPointMake(trianglePosition+triangleSize, height-triangleSize)];
    [borderPath addLineToPoint:CGPointMake(trianglePosition+2*triangleSize, height)];
    [borderPath addLineToPoint:CGPointMake(width, height)];
    
    [openMenuShape setPath:borderPath.CGPath];
    [openMenuShape setStrokeColor:[[UIColor whiteColor] CGColor]];
    
    [openMenuShape setBounds:CGRectMake(0.0f, 0.0f, height+triangleSize, width)];
    [openMenuShape setAnchorPoint:CGPointMake(0.0f, 0.0f)];
    [openMenuShape setPosition:CGPointMake(0.0f, 0.0f)];
}

- (void) drawClosedLayer {
    closedMenuShape = [CAShapeLayer layer];
    
    // Constants to ease drawing the border and the stroke.
    int height = self.menubar.frame.size.height;
    int width = self.menubar.frame.size.width;
    
    // The path for the border (just a straight line)
    UIBezierPath *borderPath = [[UIBezierPath alloc] init];
    [borderPath moveToPoint:CGPointMake(0, height)];
    [borderPath addLineToPoint:CGPointMake(width, height)];
    
    [closedMenuShape setPath:borderPath.CGPath];
    [closedMenuShape setStrokeColor:[[UIColor whiteColor] CGColor]];
    
    [closedMenuShape setBounds:CGRectMake(0.0f, 0.0f, height, width)];
    [closedMenuShape setAnchorPoint:CGPointMake(0.0f, 0.0f)];
    [closedMenuShape setPosition:CGPointMake(0.0f, 0.0f)];
}

- (IBAction)displayGestureForTapRecognizer:(UITapGestureRecognizer *)recognizer {
    // Get the location of the gesture
    CGPoint tapLocation = [recognizer locationInView:self.view];
    // NSLog(@"Tap location X:%1.0f, Y:%1.0f", tapLocation.x, tapLocation.y);

    // If menu is open, and the tap is outside of the menu, close it.
    if (!CGRectContainsPoint(self.menu.frame, tapLocation) && !self.menu.hidden) {
        [self hideMenu];
    }
}

#pragma mark - Segue


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    self.currentSegueIdentifier = segue.identifier;
    [super prepareForSegue:segue sender:sender];
    
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    if ([self.currentSegueIdentifier isEqual:identifier]) {
        //Dont perform segue, if visible ViewController is already the destination ViewController
        return NO;
    }
    
    return YES;
}

#pragma mark - Memory Warning

- (void)didReceiveMemoryWarning {
        [super didReceiveMemoryWarning];
}

@end
