//
//  IGCMenu.h
//  IGCMenu
//
//  Created by Sunil Sharma on 11/02/16.
//  Copyright (c) 2016 Sunil Sharma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, IGCMenuBackgroundOptions) {
    None,
    Dark,
    BlurEffectExtraLight,
    BlurEffectLight,
    BlurEffectDark,
};

@protocol IGCMenuDelegate <NSObject>

@optional
-(void)igcMenuSelected:(NSString *)selectedMenuName atIndex:(NSInteger)index;

@end

@interface IGCMenu : NSObject

@property (nonatomic, weak) id <IGCMenuDelegate> delegate;

// Disable background view, default is TRUE
@property (nonatomic, assign) BOOL disableBackground;

// Default is BlurEffectDark
@property (nonatomic, assign) IGCMenuBackgroundOptions backgroundType;

// Maximium number of column,default is 3
@property (nonatomic, assign) NSInteger maxColumn;

// height = width ,default is 65
@property (nonatomic, assign) NSInteger menuHeight;

// Number of menu items to show
@property (nonatomic, assign) NSInteger numberOfMenuItem;

// Radius for circular menu
@property (nonatomic, assign) CGFloat menuRadius;

// Menu button reference
@property (nonatomic, strong) UIButton *showMenuButton;

// Menu button super view reference
@property (nonatomic, strong) UIView *menuSuperView;

// Menu items name array,it can be empty
@property (nonatomic, strong) NSArray *menuItemsNameArray;

// Menu items background color,it can be empty, default color is white
@property (nonatomic, strong) NSArray *menuBackgroundColorsArray;

// Menu item icons array it can be empty
@property (nonatomic, strong) NSArray *menuImagesNameArray;

// Menu Accessibility Labels
@property (nonatomic, strong) NSArray *menuItemsAccessibilityLabelsArray;

// Menu title color, default is white
@property (nonatomic, strong) UIColor *menuTitleColor;

// Menu title font, default is system regular 12
@property (nonatomic, strong) UIFont *menuTitleFont;

- (void)showCircularMenu;
- (void)hideCircularMenu;

- (void)showGridMenu;
- (void)hideGridMenu;

@end
