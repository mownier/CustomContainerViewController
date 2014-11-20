//
//  MenuBarItem.h
//  CustomContainerViewController
//
//  Created by mownier on 11/20/14.
//  Copyright (c) 2014 mownier. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MenuBarItemType) {
    MenuBarItemType1 = 0,
    MenuBarItemType2
};

@interface MenuBarItem : UIButton

@property (readwrite, nonatomic) MenuBarItemType barItemType;

@end
