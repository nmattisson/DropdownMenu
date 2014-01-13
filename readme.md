# DropdownMenu

<img src="https://raw.github.com/nmattisson/DropdownMenu/master/Screenshots/DropdownMenu.png" width="400" />
<img src="https://raw.github.com/nmattisson/DropdownMenu/master/Screenshots/DropdownMenu.gif" width="320" />

DropdownMenu is a navigation controller for setting the view of a ContainerViewController using a dropdown menu. Dropdown menus are in many situations superior to the more commonly used slide menu, and can also be a good alternative to tabs when you want to reduce visual distractions yet make less often used functions easily discoverable. This implementation is inspired by the menus used in the iOS7 apps from DropBox and Vine.
It's built with storyboard, segues and modern APIs and hence requires iOS6+. The project was adapted from Martin Hartl's [MHCustomTabBarController](https://github.com/mhaddl/MHCustomTabBarController) which in turn has lineage from Matthijs Hollemans' [MHTabBarController](https://github.com/hollance/MHTabBarController). Without their prior contributions this would have taken me a lot longer, so thanks guys!

## Usage
The easiest is to look at the supplied example, and hook up your ViewController the same way. The project relies on a UIViewController of the class 'DropdownMenuController' or a subclass thereof, which needs to contain two UIViews, the 'menuBar' and the 'menu' itself — in addition to the Container View. The menubar view needs to contain the button to toggle the menu, and the actual menu needs to contain the buttons to set the corresponding view in the Container View. Almost everything is controlled in the storyboard, and the outlets are listed below.

The first view that you want shown in the container view must be embedded in the Storyboard. Just ctrl-drag from the container to your first view and choose 'embed'. The buttons in the menu are actual NSButtons and you can style them as you see fit.

It recommended to subclass the DropdownMenu View Controller (as is done in the example) to be able to set properties of your menu programatically. In the supplied example, this is done in MyDropdownMenuController. This is where the menu buttons get their final look and the icons are added. In the supplied example I am using [IonIcons](https://github.com/TapTemplate/ionicons-iOS) but this is of course completely optional.

Likewise, the View Controllers in the example are subclassed and includes a call to the menu to update it's title, depending on which view controller is currently shown in the container view. You can also set the menubar background as shown in the section below.

### Installation:

Using CocoaPods:

1. Add `pod 'DropdownMenu'` to your Podfile.
2. Run `pod install`
3. Open the xcworkspace.
4. Modify your project's Storyboards as described above.

Manually:

1. Drag the folder 'DropdownMenu' with the source files into your project.
2. Modify your project's Storyboards as described above.


### Appearance Functions
These are the functions you can call from your View Controllers to set the current style of the menu to update its title and color.

```objective-c
- (void) setMenubarTitle:(NSString *) menubarTitle;
- (void) setMenubarBackground:(UIColor *) color;
```

### Outlets
```objective-c
// The Container View
@property (weak, nonatomic) IBOutlet UIView *container;
// The Menu Bar View, with the button to toggle the menu.
@property (weak, nonatomic) IBOutlet UIView *menuBar;
// The Dropdown Menu
@property (weak, nonatomic) IBOutlet UIView *menu;
// The Dropdown Menu button
@property (weak, nonatomic) IBOutlet UIButton *menuButton;
// The Title Label for the menu
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
// The array of buttons in the dropdown menu
@property (nonatomic) IBOutletCollection(UIButton) NSArray *buttons;
// Gesture Recognizer for the Super View, used to dismiss the menu
@property (nonatomic, strong) IBOutlet UITapGestureRecognizer *tapRecognizer;

// Actions for the menu button (show/hide menu) and list button (option in dropdown menu).
- (IBAction) menuButtonAction: (UIButton *) sender;
- (IBAction) listButtonAction: (UIButton *) sender;
```


## License

The MIT License (MIT)

Copyright (c) 2013 Nils Mattisson, Martin Hartl

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.


