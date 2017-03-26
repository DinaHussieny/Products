//
//  UIScrollView+BottomDetection.m
//  Products
//
//  Created by Dina Hussieny on 3/19/17.
//  Copyright © 2017 Dina Hussieny. All rights reserved.
//

#import "UIScrollView+BottomDetection.h"

@implementation UIScrollView (BottomDetection)

- (BOOL)isAtBottom {
    return ([self verticalOffsetForBottom] - self.contentOffset.y <= 100.0f);
}

- (CGFloat)verticalOffsetForBottom {
    CGFloat scrollViewHeight = self.bounds.size.height;
    CGFloat scrollContentSizeHeight = self.contentSize.height;
    CGFloat bottomInset = self.contentInset.bottom;
    CGFloat scrollViewBottomOffset = scrollContentSizeHeight + bottomInset - scrollViewHeight;
    return scrollViewBottomOffset;
}

@end
