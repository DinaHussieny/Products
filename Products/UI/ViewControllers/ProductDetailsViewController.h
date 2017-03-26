//
//  ProductDetailsViewController.h
//  Products
//
//  Created by Dina Hussieny on 3/18/17.
//  Copyright © 2017 Dina Hussieny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"

@interface ProductDetailsViewController : UITableViewController

- (instancetype)initWithProduct:(Product *)product;

@end
