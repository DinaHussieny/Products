//
//  ProductDetailsViewController.m
//  Products
//
//  Created by Dina Hussieny on 3/18/17.
//  Copyright © 2017 Dina Hussieny. All rights reserved.
//

#import "ProductDetailsViewController.h"
#import "ProductDetailsTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <Masonry/Masonry.h>

@interface ProductDetailsViewController ()

@property (nonatomic, strong) Product *product;
@end

@implementation ProductDetailsViewController

static NSString * const ProductDetailsTableViewCellIdentifer = @"ProductDetailsTableViewCellIdentifer";

- (instancetype)initWithProduct:(Product *)product {
    if (self = [super init]) {
        _product = product;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Product Details";
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.estimatedRowHeight = 280;
    
    [self.tableView registerClass:[ProductDetailsTableViewCell class] forCellReuseIdentifier:ProductDetailsTableViewCellIdentifer];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ProductDetailsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ProductDetailsTableViewCellIdentifer forIndexPath:indexPath];
    
    [cell.productImageView sd_setImageWithURL:self.product.productImageUrl];
    cell.productDescriptionLabel.text = self.product.productDescription;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

@end
