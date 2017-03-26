//
//  ProductCollectionViewCell.m
//
//
//  Created by Dina Hussieny on 3/17/17.
//
//

#import "ProductCollectionViewCell.h"
#import <Masonry/Masonry.h>

@implementation ProductCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.productImageView];
        [self.contentView addSubview:self.productPriceLabel];
        [self.contentView addSubview:self.productDescriptionLabel];
        
        [self setNeedsUpdateConstraints];
    }
    
    return self;
}

- (void)prepareForReuse {
    [super prepareForReuse];
    self.productImageView.image = nil;
}

- (void)updateConstraints {
    [self.productImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.equalTo(self.contentView);
        make.centerX.equalTo(self.contentView);
        make.width.equalTo(@(150));
    }];
    
    [self.productPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.productImageView.mas_top);
        make.trailing.equalTo(self.productImageView.mas_trailing);
    }];
    
    [self.productDescriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.productImageView.mas_bottom);
        make.leading.and.trailing.equalTo(self.productImageView);
    }];
    
    [super updateConstraints];
}

- (UIImageView *)productImageView {
    if (!_productImageView) {
        _productImageView = [[UIImageView alloc] init];
        _productImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    
    return _productImageView;
}

- (UILabel *)productPriceLabel {
    if (!_productPriceLabel) {
        _productPriceLabel = [[UILabel alloc] init];
        _productPriceLabel.textColor = [UIColor whiteColor];
        _productPriceLabel.backgroundColor = [UIColor lightGrayColor];
        _productPriceLabel.font = [UIFont boldSystemFontOfSize:13.0];
        _productPriceLabel.textAlignment = NSTextAlignmentNatural;
    }
    
    return _productPriceLabel;
}

- (UILabel *)productDescriptionLabel {
    if (!_productDescriptionLabel) {
        _productDescriptionLabel = [[UILabel alloc] init];
        _productDescriptionLabel.textColor = [UIColor whiteColor];
        _productDescriptionLabel.textAlignment = NSTextAlignmentNatural;
        _productDescriptionLabel.backgroundColor =  [UIColor lightGrayColor];
        _productDescriptionLabel.numberOfLines = 0;
        _productDescriptionLabel.font = [UIFont boldSystemFontOfSize:13.0];
        _productDescriptionLabel.adjustsFontSizeToFitWidth = YES;
    }
    
    return _productDescriptionLabel;
}

@end
