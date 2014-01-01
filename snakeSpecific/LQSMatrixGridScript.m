//
//  LQSMatrixGridScript.m
//  Snake
//
//  Created by Ariel School on 2013-12-31.
//  Copyright (c) 2013 Liquid Sparks. All rights reserved.
//

#import "LQSMatrixGridScript.h"
#import "LQSDrawableMatrixGridData.h"

@implementation LQSMatrixGridScript

- (void)update
{
    _matrixGridData.exponent = _matrixGridData.exponent + 1.0f;
}

@end
