//
//  ProductCollectionViewCell.h
//  
//
//  Created by Dina Hussieny on 3/17/17.
//
//

#import <UIKit/UIKit.h>

@interface ProductCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *productImageView;
@property (nonatomic, strong) UILabel *productPriceLabel;
@property (nonatomic, strong) UILabel *productDescriptionLabel;

@end
