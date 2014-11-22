//
//  MyDropdownMenuController.m
//  DropdownMenuDemo
//
//  Created by Nils Mattisson on 1/13/14.
//  Copyright (c) 2014 Nils Mattisson. All rights reserved.
//

#import "MyDropdownMenuController.h"
#import "IonIcons.h"

@interface MyDropdownMenuController ()

@end

@implementation MyDropdownMenuController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

-(void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // Customize your menu programmatically here.
    [self customizeMenu];
}

-(void) customizeMenu {
    // EXAMPLE: To set the menubar background colour programmatically.
    // FYI: There is a bug where the color comes out differently when set programmatically
    // than when set in XCode Interface builder, and I don't know why.
    //[self setMenubarBackground:[UIColor greenColor]];
    
    // Replace menu button with an IonIcon.
    [self.menuButton setTitle:nil forState:UIControlStateNormal];
    [self.menuButton setImage:[IonIcons imageWithIcon:icon_navicon size:30.0f color:[UIColor whiteColor]] forState:UIControlStateNormal];
    
    //Uncomment to stop drop 'Triangle' from appearing
    //[self dropShapeShouldShowWhenOpen:NO];
    
    //Uncomment to fade to white instead of default (black)
    //[self setFadeTintWithColor:[UIColor whiteColor]];
    
    //Uncomment for increased fade effect (default is 0.5f)
    //[self setFadeAmountWithAlpha:0.2f];
    
    // Style menu buttons with IonIcons.
    for (UIButton *button in self.buttons) {
        if ([button.titleLabel.text isEqual: @"Profile"]) {
            [IonIcons label:button.titleLabel setIcon:icon_navicon_round size:15.0f color:[UIColor whiteColor] sizeToFit:NO];
            [button setImage:[IonIcons imageWithIcon:icon_person size:20.0f color:[UIColor whiteColor]] forState:UIControlStateNormal];
        } else if ([button.titleLabel.text isEqual: @"Home"]) {
            [IonIcons label:button.titleLabel setIcon:icon_home size:15.0f color:[UIColor whiteColor] sizeToFit:NO];
            [button setImage:[IonIcons imageWithIcon:icon_home size:20.0f color:[UIColor whiteColor]] forState:UIControlStateNormal];
        } else if ([button.titleLabel.text isEqual: @"Photos"]) {
            [IonIcons label:button.titleLabel setIcon:icon_image size:15.0f color:[UIColor whiteColor] sizeToFit:NO];
            [button setImage:[IonIcons imageWithIcon:icon_image size:20.0f color:[UIColor whiteColor]] forState:UIControlStateNormal];
        }
        
        // Set the title and icon position
        [button sizeToFit];
        button.titleEdgeInsets = UIEdgeInsetsMake(0, -button.imageView.frame.size.width-10, 0, button.imageView.frame.size.width);
        button.imageEdgeInsets = UIEdgeInsetsMake(0, button.titleLabel.frame.size.width, 0, -button.titleLabel.frame.size.width);
        
        // Set color to white
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
