//
//  MenuBar.h
//  CustomContainerViewController
//
//  Created by mownier on 11/19/14.
//  Copyright (c) 2014 mownier. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuBarItem.h"

@protocol MenuBarDelegate;

@interface MenuBar : UIView

@property (strong, nonatomic) id<MenuBarDelegate> delegate;

- (void)setSelectedItemWithType:(MenuBarItemType)type;

@end

@protocol MenuBarDelegate <NSObject>

- (void)menuBar:(MenuBar *)menuBar didSelectType:(MenuBarItemType)type;

@end
