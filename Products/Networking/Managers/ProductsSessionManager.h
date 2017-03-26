//
//  ProductsSessionManager.h
//  
//
//  Created by Dina Hussieny on 3/17/17.
//
//

#import <AFNetworking/AFNetworking.h>
#import "Product.h"

@interface ProductsSessionManager : AFHTTPSessionManager

- (void)enginesWithStartingPageNumber:(NSUInteger)staringNo
                              success:(void (^)(NSArray *products))success
                              failure:(void (^)(NSError *error))failure;
@end
