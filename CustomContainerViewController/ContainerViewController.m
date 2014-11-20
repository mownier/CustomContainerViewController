//
//  ContainerViewController.m
//  CustomContainerViewController
//
//  Created by mownier on 11/19/14.
//  Copyright (c) 2014 mownier. All rights reserved.
//

#import "ContainerViewController.h"
#import "MenuBar.h"
#import "Content1ViewController.h"
#import "Content2ViewController.h"

@interface ContainerViewController () <MenuBarDelegate> {
    UIViewController *_selectedViewController;
}

@property (strong, nonatomic) Content1ViewController *content1ViewController;
@property (strong, nonatomic) Content2ViewController *content2ViewController;

@property (strong, nonatomic) UIView *contentView;
@property (strong, nonatomic) MenuBar *menuBar;

- (void)addLayoutConstraintWithVisualFormat:(NSString *)visualFormat views:(NSDictionary *)views;
- (void)addLayoutConstraintWithVisualFormat:(NSString *)visualFormat views:(NSDictionary *)views superview:(UIView *)superView;
- (void)setSelectedViewController:(UIViewController *)viewController;

@end

@implementation ContainerViewController

#pragma mark -
#pragma mark - View Cycle

- (void)viewDidLoad {
    [super viewDidLoad];

    self.content1ViewController = [Content1ViewController new];
    self.content2ViewController = [Content2ViewController new];
    
    [self.view addSubview:self.contentView];
    [self.view addSubview:self.menuBar];
    
    NSDictionary *views = @{ @"menuBar": self.menuBar,
                             @"contentView": self.contentView };
    [self addLayoutConstraintWithVisualFormat:@"H:|[menuBar]|" views:views];
    [self addLayoutConstraintWithVisualFormat:@"V:[menuBar(49)]|" views:views];
    [self addLayoutConstraintWithVisualFormat:@"H:|[contentView]|" views:views];
    [self addLayoutConstraintWithVisualFormat:@"V:|[contentView][menuBar]|" views:views];
    
    [self.menuBar setSelectedItemWithType:MenuBarItemType1];
}

#pragma mark -
#pragma mark - Adding Layout Constraint

- (void)addLayoutConstraintWithVisualFormat:(NSString *)visualFormat views:(NSDictionary *)views {
    [self addLayoutConstraintWithVisualFormat:visualFormat views:views superview:self.view];
}

- (void)addLayoutConstraintWithVisualFormat:(NSString *)visualFormat views:(NSDictionary *)views superview:(UIView *)superView {
    [superView addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:visualFormat
                                             options:0
                                             metrics:nil
                                               views:views]];
}

#pragma mark -
#pragma mark - Menu Bar

- (MenuBar *)menuBar {
    if (!_menuBar) {
        _menuBar = [[MenuBar alloc] init];
        _menuBar.translatesAutoresizingMaskIntoConstraints = NO;
        _menuBar.delegate = self;
    }
    return _menuBar;
}

#pragma mark -
#pragma mark - Menu Bar Delegate

- (void)menuBar:(MenuBar *)menuBar didSelectType:(MenuBarItemType)type {
    switch (type) {
        case MenuBarItemType1: {
            [self setSelectedViewController:self.content1ViewController];
        }
            break;
            
        case MenuBarItemType2: {
            [self setSelectedViewController:self.content2ViewController];
        }
            break;
    }
}

#pragma mark -
#pragma mark - Content View

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectZero];
        _contentView.translatesAutoresizingMaskIntoConstraints = NO;
        _contentView.backgroundColor = [UIColor lightGrayColor];
    }
    return _contentView;
}

#pragma mark -
#pragma mark - Selecting View Controller

- (void)setSelectedViewController:(UIViewController *)viewController {
    assert(viewController);
    if (![viewController isEqual:_selectedViewController]) {
        if (_selectedViewController) {
            [_selectedViewController removeFromParentViewController];
            [_selectedViewController.view removeFromSuperview];
            [_selectedViewController didMoveToParentViewController:nil];
        }
        viewController.view.frame = self.contentView.frame;
        [self addChildViewController:viewController];
        [self.contentView addSubview:viewController.view];
        [viewController didMoveToParentViewController:self];
        _selectedViewController = viewController;
    }
}

@end
