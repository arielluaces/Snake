//
//  LQSDrawableMatrixGrid.h
//  Snake
//
//  Created by Ariel School on 2013-12-31.
//  Copyright (c) 2013 Liquid Sparks. All rights reserved.
//

#import "ILQSDrawable.h"

@protocol ILQSDrawableMatrixGridData;

@interface LQSDrawableMatrixGrid : NSObject<ILQSDrawable>

@property (nonatomic) NSObject<ILQSDrawableMatrixGridData> *matrixGridData;

@end
