//
//  ProductsViewController.m
//
//
//  Created by Dina Hussieny on 3/17/17.
//
//

#import "ProductsViewController.h"
#import "ProductsSessionManager.h"
#import "ProductCollectionViewCell.h"
#import "SelfSizingWaterfallCollectionViewLayout.h"
#import "ProductDetailsViewController.h"
#import "UIScrollView+BottomDetection.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import "AFNetworkActivityIndicatorManager.h"



@interface ProductsViewController ()

@property (nonatomic, strong) NSArray *products;
@property (nonatomic, assign) NSUInteger startPageNumber;
@property (nonatomic, assign) BOOL loadedLastPage;
@property (nonatomic, assign) NSInteger nextPageNumber;
@property (nonatomic, assign, getter = isLoadingProducts) BOOL loadingProducts;


@end

@implementation ProductsViewController

static NSString * const ProductCollectionViewCellIdentifier = @"ProductCollectionViewCellIdentifier";
static NSString * const kProductsUserDefaultsKey = @"kProductsUserDefaultsKey";
static const CGFloat CollectionViewMinimumInteritemSpacing = 10;

- (instancetype)init{
    SelfSizingWaterfallCollectionViewLayout *flowLayout = [[SelfSizingWaterfallCollectionViewLayout alloc] init];
    flowLayout.minimumInteritemSpacing = CollectionViewMinimumInteritemSpacing;
    flowLayout.minimumLineSpacing = CollectionViewMinimumInteritemSpacing;
    flowLayout.estimatedItemHeight = 200;
    flowLayout.sectionInset = UIEdgeInsetsMake(CollectionViewMinimumInteritemSpacing,0,CollectionViewMinimumInteritemSpacing,0);
    
    if (self = [super initWithCollectionViewLayout:flowLayout]) {
        self.collectionView.backgroundColor = [UIColor whiteColor];

        [self.collectionView registerClass:[ProductCollectionViewCell class] forCellWithReuseIdentifier:ProductCollectionViewCellIdentifier];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Products";
    [self loadProducts];
}

- (void)loadProducts {
    if (!self.products) {
        self.startPageNumber = 0;
        self.loadedLastPage = NO;
        [SVProgressHUD show];
    }
    
    [[ProductsSessionManager manager] enginesWithStartingPageNumber:self.startPageNumber success:^(NSArray *products) {
        
        self.loadingProducts = NO;
        self.startPageNumber = self.startPageNumber + 10;
        
        if ([products count] < 10) {
            self.loadedLastPage = YES;
        }
        
        NSMutableArray *mutableProducts = [NSMutableArray arrayWithArray:self.products];
        [mutableProducts addObjectsFromArray:products];
        self.products = mutableProducts;
        [self cacheProductsWithProducts:self.products];
        
        [self.collectionView reloadData];
        
        if (!self.loadedLastPage ) {
            [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
        }
        
        [SVProgressHUD dismiss];
        
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
    }];
}

- (void)cacheProductsWithProducts:(NSArray *)products {
    NSMutableArray *mutableProducts = products.mutableCopy;
    NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:mutableProducts];
    [[NSUserDefaults standardUserDefaults] setObject:encodedObject forKey:kProductsUserDefaultsKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

- (NSArray *)cachedProducts {
    NSData *encodedObject = [[NSUserDefaults standardUserDefaults] objectForKey:kProductsUserDefaultsKey];
    
    if (encodedObject) {
        NSArray *engines = (NSArray *)[NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
        return engines;
    }
    
    return [NSArray array];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSArray *products = [self cachedProducts];
    return products.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ProductCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ProductCollectionViewCellIdentifier forIndexPath:indexPath];
    NSArray *products = [self cachedProducts];
    Product *product = [products objectAtIndex:indexPath.item];
    
    [cell.productImageView sd_setImageWithURL:product.productImageUrl completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [collectionView reloadItemsAtIndexPaths:@[indexPath]];
    }];
    
    cell.productPriceLabel.text = [NSString stringWithFormat:@"%@ %@",[product.productPrice stringValue], @"$"];
    cell.productDescriptionLabel.text = product.productDescription;
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
       NSArray *products = [self cachedProducts];
    Product *product = [products objectAtIndex:indexPath.item];
    ProductDetailsViewController *productDetailsViewController = [[ProductDetailsViewController alloc] initWithProduct:product];
    [self.navigationController pushViewController:productDetailsViewController animated:YES];
}

#pragma mark SelfSizingWaterfallCollectionViewLayoutDelegate

- (NSUInteger)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout numberOfColumnsInSection:(NSUInteger)section {
    NSUInteger compactColumns = 2;
    
    if (self.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClassRegular) {
        return compactColumns + 1;
    }
    
    return compactColumns;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if ([self.collectionView isAtBottom] &&
        [self.products count] > 0 &&
        !self.loadedLastPage &&
        !self.isLoadingProducts) {
        [self loadProducts];
    }
}

@end
