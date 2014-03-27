//
//  IonIcons.h
//  ionicons-iOS is Copyright 2013 TapTemplate and released under the MIT license.
//  http://www.taptemplate.com
//  ==========================
//

#import <UIKit/UIKit.h>

#import "ionicons-codes.h"

@interface IonIcons : NSObject

//================================
// Font and Label Methods
//================================

/*! Convenience method to get the ionicons font.
 */
+ (UIFont*)fontWithSize:(CGFloat)size;

/*!  Convenience method to make a sized-to-fit UILabel containing an icon in the given font size and color.
 */
+ (UILabel*)labelWithIcon:(NSString*)icon_name
                     size:(CGFloat)size
                    color:(UIColor*)color;

/*! Adjust an existing UILabel to show an ionicon.
 */
+ (void)label:(UILabel*)label
      setIcon:(NSString*)icon_name
         size:(CGFloat)size
        color:(UIColor*)color
    sizeToFit:(BOOL)shouldSizeToFit;

//================================
// Image Methods
//================================

/*! Create a UIImage of an ionocin, making the image and the icon the same size:
 */
+ (UIImage*)imageWithIcon:(NSString*)icon_name
                     size:(CGFloat)size
                    color:(UIColor*)color;

/*! Create a UIImage of an ionocin, and specify different sizes for the image and the icon:
 */
+ (UIImage*)imageWithIcon:(NSString*)icon_name
                iconColor:(UIColor*)color
                 iconSize:(CGFloat)iconSize
                imageSize:(CGSize)imageSize;

@end
