//
//  Product.m
//  Products
//
//  Created by Dina Hussieny on 3/17/17.
//  Copyright © 2017 Dina Hussieny. All rights reserved.
//

#import "Product.h"

@implementation Product

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"productDescription" : @"productDescription",
              @"productPrice" : @"price",
             @"productImageUrl" : @"image.url",
             @"imageHeight" : @"image.height"
             };
}

+ (NSValueTransformer *)productPriceJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSString *price, BOOL *success, NSError *__autoreleasing *error) {
        if (![price isEqual:[NSNull null]]) {
            NSNumber *priceNumber = @([price doubleValue]);;
            return priceNumber;
        }
        
        return @(0);
    }];
}

@end
