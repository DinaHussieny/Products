//
//  Product.h
//  Products
//
//  Created by Dina Hussieny on 3/17/17.
//  Copyright © 2017 Dina Hussieny. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Mantle/Mantle.h>

@interface Product : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSString *productDescription;
@property (nonatomic, strong) NSNumber *productPrice;
@property (nonatomic, strong) NSURL *productImageUrl;
@property (nonatomic, strong) NSNumber *imageHeight;

@end
