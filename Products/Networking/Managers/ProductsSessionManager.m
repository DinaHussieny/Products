//
//  ProductsSessionManager.m
//  
//
//  Created by Dina Hussieny on 3/17/17.
//
//

#import "ProductsSessionManager.h"
#import "AFNetworkActivityIndicatorManager.h"

@implementation ProductsSessionManager

static NSString * const kProductsBaseURL = @"https://limitless-forest-98976.herokuapp.com";

+ (instancetype)manager {
    ProductsSessionManager *sessionManager = [[[self class] alloc] initWithBaseURL:[NSURL URLWithString:kProductsBaseURL]];
    return sessionManager;
}

- (instancetype)initWithBaseURL:(NSURL *)url {
    if (self = [super initWithBaseURL:url]) {
        self.responseSerializer = [AFJSONResponseSerializer serializer];
        
        [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    }
    
    return self;
}

- (void)enginesWithStartingPageNumber:(NSUInteger)staringNo
                   success:(void (^)(NSArray *products))success
                   failure:(void (^)(NSError *error))failure {
 
    
    NSDictionary *parameters = @{
                                 @"from" : [NSNumber numberWithInteger:staringNo],
                                 @"count" : @(1)
                                 };
   
    
    [self GET:@"" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *products = [MTLJSONAdapter modelsOfClass:[Product class] fromJSONArray:responseObject error:nil];
        success (products);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
