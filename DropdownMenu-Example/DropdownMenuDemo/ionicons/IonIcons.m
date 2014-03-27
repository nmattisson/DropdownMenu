//
//  IonIcons.m
//  ionicons-iOS is Copyright 2013 TapTemplate and released under the MIT license.
//  http://www.taptemplate.com
//  ==========================
//

#import "IonIcons.h"
#import <QuartzCore/QuartzCore.h>

@implementation IonIcons


//================================
// Font and Label Methods
//================================

+ (UIFont*)fontWithSize:(CGFloat)size;
{
    return [UIFont fontWithName:@"ionicons" size:size];
}

+ (UILabel*)labelWithIcon:(NSString*)icon_name
                     size:(CGFloat)size
                    color:(UIColor*)color
{
    UILabel *label = [[UILabel alloc] init];
    [IonIcons label:label setIcon:icon_name size:size color:color sizeToFit:YES];
    return label;
}

+ (void)label:(UILabel*)label
      setIcon:(NSString*)icon_name
         size:(CGFloat)size
        color:(UIColor*)color
    sizeToFit:(BOOL)shouldSizeToFit
{
    label.font = [IonIcons fontWithSize:size];
    label.text = icon_name;
    label.textColor = color;
    label.backgroundColor = [UIColor clearColor];
    if (shouldSizeToFit) {
        [label sizeToFit];
    }
    // NOTE: ionicons will be silent through VoiceOver, but the Label is still selectable through VoiceOver. This can cause a usability issue because a visually impaired user might navigate to the label but get no audible feedback that the navigation happened. So hide the label for VoiceOver by default - if your label should be descriptive, un-hide it explicitly after creating it, and then set its accessibiltyLabel.
    label.accessibilityElementsHidden = YES;
}

//================================
// Image Methods
//================================

+ (UIImage*)imageWithIcon:(NSString*)icon_name
                     size:(CGFloat)size
                    color:(UIColor*)color
{
    return [IonIcons imageWithIcon:icon_name
                         iconColor:color
                          iconSize:size
                         imageSize:CGSizeMake(size, size)];
}

+ (UIImage*)imageWithIcon:(NSString*)icon_name
                iconColor:(UIColor*)iconColor
                 iconSize:(CGFloat)iconSize
                imageSize:(CGSize)imageSize;
{
    NSAssert(icon_name, @"You must specify an icon from ionicons-codes.h.");
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6) {
        if (!iconColor) { iconColor = [UIColor blackColor]; }
        
        UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
        NSAttributedString* attString = [[NSAttributedString alloc]
                                         initWithString:icon_name
                                         attributes:@{NSFontAttributeName: [IonIcons fontWithSize:iconSize],
                                                      NSForegroundColorAttributeName : iconColor}];
        // get the target bounding rect in order to center the icon within the UIImage:
        NSStringDrawingContext *ctx = [[NSStringDrawingContext alloc] init];
        CGRect boundingRect = [attString boundingRectWithSize:CGSizeMake(iconSize, iconSize) options:0 context:ctx];
        // draw the icon string into the image:
        [attString drawInRect:CGRectMake((imageSize.width/2.0f) - boundingRect.size.width/2.0f,
                                         (imageSize.height/2.0f) - boundingRect.size.height/2.0f,
                                         imageSize.width,
                                         imageSize.height)];
        UIImage *iconImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        if (iconColor &&
            [iconImage respondsToSelector:@selector(imageWithRenderingMode:)]) {
            iconImage = [iconImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        }
        return iconImage;
    } else {
#if DEBUG
        NSLog(@" [ IonIcons ] Using lower-res iOS 5-compatible image rendering.");
#endif
        UILabel *iconLabel = [IonIcons labelWithIcon:icon_name size:iconSize color:iconColor];
        UIImage *iconImage = nil;
        UIGraphicsBeginImageContextWithOptions(imageSize, NO, 1.0);
        {
            CGContextRef imageContext = UIGraphicsGetCurrentContext();
            if (imageContext != NULL) {
                UIGraphicsPushContext(imageContext);
                {
                    CGContextTranslateCTM(imageContext,
                                          (imageSize.width/2.0f) - iconLabel.frame.size.width/2.0f,
                                          (imageSize.height/2.0f) - iconLabel.frame.size.height/2.0f);
                    [[iconLabel layer] renderInContext: imageContext];
                }
                UIGraphicsPopContext();
            }
            iconImage = UIGraphicsGetImageFromCurrentImageContext();
        }
        UIGraphicsEndImageContext();
        return iconImage;
    }
}

@end
