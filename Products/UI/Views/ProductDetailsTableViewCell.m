//
//  ProductDetailsTableViewCell.m
//
//
//  Created by Dina Hussieny on 3/18/17.
//
//

#import "ProductDetailsTableViewCell.h"
#import <Masonry/Masonry.h>

@implementation ProductDetailsTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.productImageView];
        [self.contentView addSubview:self.productDescriptionLabel];
        
        [self setNeedsUpdateConstraints];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.separatorInset = UIEdgeInsetsZero;
    }
    
    return self;
}


- (void)updateConstraints {
    [self.productImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).with.offset(50);
        make.centerX.equalTo(self.contentView);
        make.width.equalTo(@(300));
        make.bottom.equalTo(self.productDescriptionLabel.mas_top).with.offset(-10);
        make.height.equalTo(@(150));
    }];
    
    [self.productDescriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.and.trailing.equalTo(self.productImageView);
        make.bottom.equalTo(self.contentView).with.offset(-10);
    }];
    
    [super updateConstraints];
}

- (UIImageView *)productImageView {
    if (!_productImageView) {
        _productImageView = [[UIImageView alloc] init];
        _productImageView.contentMode = UIViewContentModeScaleAspectFill;
        _productImageView.clipsToBounds = YES;
    }
    
    return _productImageView;
}

- (UILabel *)productDescriptionLabel {
    if (!_productDescriptionLabel) {
        _productDescriptionLabel = [[UILabel alloc] init];
        _productDescriptionLabel.textColor = [UIColor whiteColor];
        _productDescriptionLabel.textAlignment = NSTextAlignmentNatural;
        _productDescriptionLabel.backgroundColor = [UIColor lightGrayColor];
        _productDescriptionLabel.numberOfLines = 0;
    }
    
    return _productDescriptionLabel;
}

@end
