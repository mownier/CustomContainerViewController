//
//  MenuBar.m
//  CustomContainerViewController
//
//  Created by mownier on 11/19/14.
//  Copyright (c) 2014 mownier. All rights reserved.
//

#import "MenuBar.h"

#define kMenuBarHeight 49.0f
#define kActiveBackgroundColor [UIColor lightGrayColor]
#define kInActiveBackgroundColor [UIColor whiteColor]

@interface MenuBar ()

@property (strong, nonatomic) MenuBarItem *menuBarItem1;
@property (strong, nonatomic) MenuBarItem *menuBarItem2;

- (void)tapMenuItem:(MenuBarItem *)item;
- (void)addConstraintWithVisualFormat:(NSString *)visualFormat views:(NSDictionary *)views;
- (void)setSelectedItem:(MenuBarItem *)item;

- (MenuBarItem *)createBarItemWithType:(MenuBarItemType)type;
- (void)initializeBarItems;

@end

@implementation MenuBar

#pragma mark -
#pragma mark - Initialization

- (instancetype)init {
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, kMenuBarHeight);
        self.backgroundColor = [UIColor greenColor];
        [self initializeBarItems];
    }
    return self;
}

#pragma mark -
#pragma mark - Add Visual Format

- (void)addConstraintWithVisualFormat:(NSString *)visualFormat views:(NSDictionary *)views {
    NSDictionary *metrics = @{ @"menuBarItemHeight" : @kMenuBarHeight };
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:visualFormat options:0 metrics:metrics views:views]];
}

#pragma mark -
#pragma mark - Layout Subviews

- (void)layoutSubviews {

    [self addSubview:self.menuBarItem1];
    [self addSubview:self.menuBarItem2];
    
    NSDictionary *views = @{ @"menuBarItem1": self.menuBarItem1,
                             @"menuBarItem2": self.menuBarItem2 };
    
    [self addConstraintWithVisualFormat:@"V:[menuBarItem1(menuBarItemHeight)]" views:views];
    [self addConstraintWithVisualFormat:@"V:[menuBarItem2(menuBarItemHeight)]" views:views];
    [self addConstraintWithVisualFormat:@"V:|-0-[menuBarItem1]-0-|" views:views];
    [self addConstraintWithVisualFormat:@"V:|-0-[menuBarItem2]-0-|" views:views];
    [self addConstraintWithVisualFormat:@"H:|-0-[menuBarItem1]-0-[menuBarItem2(==menuBarItem1)]-0-|" views:views];
}

#pragma mark -
#pragma mark - Initialize Bar Items

- (MenuBarItem *)createBarItemWithType:(MenuBarItemType)type {
    MenuBarItem *menuBarItem = [MenuBarItem buttonWithType:UIButtonTypeCustom];
    menuBarItem.translatesAutoresizingMaskIntoConstraints = NO;
    menuBarItem.backgroundColor = kInActiveBackgroundColor;
    [menuBarItem setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [menuBarItem addTarget:self
                    action:@selector(tapMenuItem:)
          forControlEvents:UIControlEventTouchUpInside];
    [menuBarItem setTitle:[NSString stringWithFormat:@"%d", (int)type + 1]
                 forState:UIControlStateNormal];
    menuBarItem.barItemType = type;
    return menuBarItem;
}

- (void)initializeBarItems {
    self.menuBarItem1 = [self createBarItemWithType:MenuBarItemType1];
    self.menuBarItem2 = [self createBarItemWithType:MenuBarItemType2];
}

#pragma mark -
#pragma mark - Actions

- (void)tapMenuItem:(MenuBarItem *)item {
    [self setSelectedItemWithType:item.barItemType];
}

#pragma mark -
#pragma mark - Setting Selected Item

- (void)setSelectedItemWithType:(MenuBarItemType)type {
    switch (type) {
        case MenuBarItemType1: {
            [self setSelectedItem:self.menuBarItem1];
            self.menuBarItem1.backgroundColor = kActiveBackgroundColor;
            self.menuBarItem2.backgroundColor = kInActiveBackgroundColor;
        }
            break;
        case MenuBarItemType2: {
            [self setSelectedItem:self.menuBarItem2];
            self.menuBarItem1.backgroundColor = kInActiveBackgroundColor;
            self.menuBarItem2.backgroundColor = kActiveBackgroundColor;
        }
            break;
    }
}

- (void)setSelectedItem:(MenuBarItem *)item {
    if (self.delegate && [self.delegate respondsToSelector:@selector(menuBar:didSelectType:)]) {
        [self.delegate menuBar:self didSelectType:item.barItemType];
    }
}

@end
