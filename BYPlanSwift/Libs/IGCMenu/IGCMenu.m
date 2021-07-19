//
//  IGCMenu.m
//  IGCMenu
//
//  Created by Sunil Sharma on 11/02/16.
//  Copyright (c) 2016 Sunil Sharma. All rights reserved.
//

#import "IGCMenu.h"
#import <QuartzCore/QuartzCore.h>

#define MENU_START_TAG(offset) (6000 + offset)
#define MENU_NAME_LABEL_TAG(offset) (6100 + offset)
#define ANIMATION_DURATION 0.4
#define MENU_BACKGROUND_VIEW_TAG 6200

@interface IGCMenu ()

@property (nonatomic, strong) NSMutableArray <UIButton *>*menuButtonArray;        //array of menu buttons
@property (nonatomic, strong) NSMutableArray <UILabel *>*menuNameLabelArray;     //array of menu name label
@property (nonatomic, strong) UIView *showMenuButtonSuperView;

@property (nonatomic, assign) CGPoint showMenuButtonCenter;

@end

@implementation IGCMenu

- (void)setShowMenuButton:(UIButton *)showMenuButton {
    _showMenuButton = showMenuButton;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        self.menuButtonArray = @[].mutableCopy;
        self.menuNameLabelArray = @[].mutableCopy;
        //Default values
        self.disableBackground = YES;
        self.numberOfMenuItem = 0;
        self.menuRadius = 120;
        self.maxColumn = 3;
        self.backgroundType = BlurEffectDark;
        self.menuTitleColor = [UIColor whiteColor];
        self.menuTitleFont = [UIFont systemFontOfSize:12];
    }
    return self;
}

- (void)createMenuButtons{
    [self.menuButtonArray removeAllObjects];
    [self.menuNameLabelArray removeAllObjects];
    for (int i = 0; i < self.numberOfMenuItem; i++) {
        UIButton *menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
        menuButton.backgroundColor = [UIColor whiteColor];
        menuButton.tag = MENU_START_TAG(i);
        CGRect newFrame = menuButton.frame;
        CGFloat menuButtonSize;
        if (self.menuHeight) {
            menuButtonSize = self.menuHeight;
        }
        else{
            menuButtonSize = self.menuHeight = 65;
        }
        newFrame.size = CGSizeMake(menuButtonSize, menuButtonSize);
        menuButton.frame = newFrame;
        CGRect rect = [self.showMenuButton.superview convertRect:self.showMenuButton.frame toView:self.showMenuButtonSuperView];
        CGPoint center = CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
        menuButton.center = center;
        menuButton.layer.cornerRadius = menuButton.frame.size.height / 2;
        menuButton.layer.masksToBounds = YES;
        menuButton.layer.opacity = 0.0;
        [menuButton addTarget:self action:@selector(menuButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.showMenuButtonSuperView insertSubview:menuButton belowSubview:self.showMenuButton];
        [self.menuButtonArray addObject:menuButton];
        //Display menu name if present
        if (self.menuItemsNameArray.count > i) {
            UILabel *menuNameLabel = [[UILabel alloc] init];
            menuNameLabel.backgroundColor = [UIColor clearColor];
            menuNameLabel.numberOfLines = 1;
            newFrame = menuNameLabel.frame;
            newFrame.size = CGSizeMake(menuButton.frame.size.width, 20);
            menuNameLabel.frame = newFrame;
            menuNameLabel.center = menuButton.center;
            menuNameLabel.layer.opacity = 0.0;
            menuNameLabel.textAlignment = NSTextAlignmentCenter;
            menuNameLabel.font = self.menuTitleFont;
            menuNameLabel.text = self.menuItemsNameArray[i];
            [menuNameLabel sizeToFit];
            menuNameLabel.textColor = self.menuTitleColor;
            [self.showMenuButtonSuperView insertSubview:menuNameLabel belowSubview:self.showMenuButton];
            [self.menuNameLabelArray addObject:menuNameLabel];
        }
        
        // set accessibility label and add the label if present
        if (self.menuItemsAccessibilityLabelsArray.count > i) {
            menuButton.isAccessibilityElement = YES;
            menuButton.accessibilityLabel = self.menuItemsAccessibilityLabelsArray[i];
        }
        
        //Set custom menus button background color if present
        if (self.menuBackgroundColorsArray.count > i) {
            menuButton.backgroundColor =(UIColor *)self.menuBackgroundColorsArray[i];
        }
        
        //Display menu images if present
        if (self.menuImagesNameArray.count > i) {
            [menuButton setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",self.menuImagesNameArray[i]]] forState:UIControlStateNormal];
        }
    }
}

- (void)menuSuperViewBackground{
    if (self.showMenuButtonSuperView == nil) {
        self.showMenuButtonSuperView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        self.showMenuButtonSuperView.tag = MENU_BACKGROUND_VIEW_TAG;
    }
    if (!self.menuSuperView) {
        self.menuSuperView = [self.showMenuButton superview];
    }
    [self.menuSuperView bringSubviewToFront:self.showMenuButton];
    [self.menuSuperView insertSubview:self.showMenuButtonSuperView belowSubview:self.showMenuButton];
    
    if (self.disableBackground){
        self.showMenuButtonSuperView.userInteractionEnabled = YES;
    }
    else{
        self.showMenuButtonSuperView.userInteractionEnabled = NO;
    }
    [self setBackgroundEffect];
}

- (void)setBackgroundEffect{
    
    switch (self.backgroundType) {
        case Dark:
            self.showMenuButtonSuperView.layer.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8].CGColor;
            break;
        case BlurEffectDark:
            [self setBlurredView:UIBlurEffectStyleDark];
            break;
        case BlurEffectLight:
            [self setBlurredView:UIBlurEffectStyleLight];
            break;
        case BlurEffectExtraLight:
            [self setBlurredView:UIBlurEffectStyleExtraLight];
            break;
        case None:
            self.showMenuButtonSuperView.layer.backgroundColor = [UIColor clearColor].CGColor;
            break;
        default:
            self.showMenuButtonSuperView.layer.backgroundColor = [UIColor clearColor].CGColor;
            break;
    }
}

- (void)setBlurredView:(UIBlurEffectStyle) blurEffectStyle{
    if (!UIAccessibilityIsReduceTransparencyEnabled()) {
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:blurEffectStyle];
        UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        blurEffectView.frame = self.showMenuButtonSuperView.bounds;
        blurEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self.showMenuButtonSuperView addSubview:blurEffectView];
    }
    else {
        self.showMenuButtonSuperView.backgroundColor = [UIColor clearColor];
    }
}

- (void)showCircularMenu{
    
    [self menuSuperViewBackground];
    
    if (self.menuButtonArray.count <= 0) {
        [self createMenuButtons];
    }
    //menuButton.center = CGPointMake(homeButtonCenter.x - radius * cos(angle * i), homeButtonCenter.y - radius * sin(angle * i));
    
    for (int  i = 1; i < self.menuButtonArray.count * 2; i=i+2) {
        CGFloat angle = M_PI / (self.menuButtonArray.count * 2);
        [UIView animateWithDuration:ANIMATION_DURATION delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.showMenuButtonSuperView.layer.opacity = 1.0;
            UIButton * menuButton = [self.menuButtonArray objectAtIndex:i/2];
            menuButton.layer.opacity = 1.0;
            CGRect rect = [self.showMenuButton.superview convertRect:self.showMenuButton.frame toView:self.showMenuButtonSuperView];
            CGPoint center = CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
            menuButton.center = CGPointMake(center.x - self.menuRadius * cos(angle * i), center.y - self.menuRadius * sin(angle * i));
            if (self.menuNameLabelArray.count > (i/2)) {
                UILabel *menuNameLabel = (UILabel *)[self.menuNameLabelArray objectAtIndex:i/2];
                menuNameLabel.layer.opacity = 1.0;
                menuNameLabel.center = CGPointMake(menuButton.center.x, menuButton.frame.origin.y + menuButton.frame.size.height  + (menuNameLabel.frame.size.height / 2) + 5);
            }
        } completion:nil];
    }
}

- (void)hideCircularMenu{
    [UIView animateWithDuration:ANIMATION_DURATION delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        for (int i = 0; i < self.menuButtonArray.count; i++) {
            UIButton *menuButton = [self.menuButtonArray objectAtIndex:i];
            menuButton.layer.opacity = 0.0;
            CGRect rect = [self.showMenuButton.superview convertRect:self.showMenuButton.frame toView:self.showMenuButtonSuperView];
            CGPoint center = CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
            menuButton.center = center;
            if (self.menuNameLabelArray.count > i) {
                UILabel *menuNameLabel = (UILabel *)[self.menuNameLabelArray objectAtIndex:i];
                menuNameLabel.layer.opacity = 0.0;
                menuNameLabel.center = center;
                self.showMenuButtonSuperView.layer.opacity = 0.0;
            }
        }
    } completion:^(BOOL finished) {
        [self.showMenuButtonSuperView removeFromSuperview];
        self.showMenuButtonSuperView = nil;
        for (int i = 0; i < self.menuButtonArray.count; i++) {
            UIButton *menuButton = [self.menuButtonArray objectAtIndex:i];
            [menuButton removeFromSuperview];
            if (self.menuNameLabelArray.count > i) {
                UILabel *menuNameLabel = (UILabel *)[self.menuNameLabelArray objectAtIndex:i];
                [menuNameLabel removeFromSuperview];
            }
        }
        [self.menuNameLabelArray removeAllObjects];
        [self.menuButtonArray removeAllObjects];
    }];
}

- (void)showGridMenu{
    [self menuSuperViewBackground];
    if (self.menuButtonArray.count <= 0) {
        [self createMenuButtons];
    }
    
    int maxRow = ceilf(self.menuButtonArray.count /(float)self.maxColumn);
    __block CGFloat topMenuCenterY = self.showMenuButton.frame.origin.y - 10;
    CGFloat eachMenuVerticalSpace = 0;
    CGFloat eachMenuWidth = 0;
    if (self.menuButtonArray.count) {
        UIButton *menuButton = self.menuButtonArray[0];
        eachMenuVerticalSpace = menuButton.frame.size.height + 20;
        eachMenuWidth = menuButton.frame.size.width;
        if (self.menuNameLabelArray.count) {
            UILabel *nameLabel = (UILabel *)self.menuNameLabelArray[0];
            eachMenuVerticalSpace = eachMenuVerticalSpace + nameLabel.frame.size.height;
        }
        topMenuCenterY = topMenuCenterY - (eachMenuVerticalSpace * maxRow) + menuButton.frame.size.height/2;
    }
    else{
        eachMenuVerticalSpace = 100.0;
        topMenuCenterY = topMenuCenterY - (eachMenuVerticalSpace * maxRow) + eachMenuVerticalSpace/3;
    }
    
    __block CGFloat distanceBetweenMenu = ((self.showMenuButtonSuperView.frame.size.width - (self.maxColumn*eachMenuWidth))/(self.maxColumn +1));
    
    [UIView animateWithDuration:ANIMATION_DURATION delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.showMenuButtonSuperView.layer.opacity = 1.0;
        
        int menuIndex = 0;
        //for each row
        for(int  i = 1; i <= maxRow; i++,topMenuCenterY += eachMenuVerticalSpace) {
            
            NSInteger remainingMenuButton = self.maxColumn;
            //CGFloat menuCenterX = distanceBetweenMenu;
            
            CGFloat menuCenterX;
            //for each column
            for (int j = 1; j <= remainingMenuButton; j++) {
                UIButton *menuButton = [self.menuButtonArray objectAtIndex:menuIndex];
                menuButton.layer.opacity = 1.0;
                
                menuCenterX = (distanceBetweenMenu *j) + (2*j - 1)*(menuButton.frame.size.width/2);
                if (i == maxRow) {
                    remainingMenuButton = self.menuButtonArray.count % self.maxColumn;
                    if (remainingMenuButton == 0) {
                        remainingMenuButton = self.maxColumn;
                    }
                    menuCenterX = menuCenterX + ((self.maxColumn - remainingMenuButton)*(distanceBetweenMenu/2)) + (self.maxColumn - remainingMenuButton)*menuButton.frame.size.width/2;
                }
                menuButton.center = CGPointMake(menuCenterX, topMenuCenterY);
                
                if (self.menuNameLabelArray.count > menuIndex) {
                    UILabel *menuNameLabel = (UILabel *)[self.menuNameLabelArray objectAtIndex:menuIndex];
                    menuNameLabel.layer.opacity = 1.0;
                    menuNameLabel.center = CGPointMake(menuButton.center.x, menuButton.frame.origin.y + menuButton.frame.size.height  + (menuNameLabel.frame.size.height / 2) + 5);
                }
                
                menuIndex++;
            }
        }
    }completion:nil];
}

- (void)hideGridMenu{
    [self hideCircularMenu];
}

- (void)menuButtonClicked:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(igcMenuSelected:atIndex:)]) {
        int index;
        NSInteger buttonTag =  sender.tag;
        for (index = 0; index < self.menuButtonArray.count; index++) {
            UIButton *menuButton = [self.menuButtonArray objectAtIndex:index];
            if (menuButton.tag == buttonTag) {
                NSString *menuName;
                if (self.menuItemsNameArray.count > index) {
                    menuName = self.menuItemsNameArray[index];
                }
                if (self.delegate) {
                    [self.delegate igcMenuSelected:menuName atIndex:index];
                }
                break;
            }
        }
    }
}

@end
