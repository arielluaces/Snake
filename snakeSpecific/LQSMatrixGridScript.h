//
//  LQSMatrixGridScript.h
//  Snake
//
//  Created by Ariel School on 2013-12-31.
//  Copyright (c) 2013 Liquid Sparks. All rights reserved.
//

#import "ILQSUpdatable.h"

@class LQSDrawableMatrixGridData;

@interface LQSMatrixGridScript : NSObject<ILQSUpdatable>

@property (nonatomic) LQSDrawableMatrixGridData *matrixGridData;

@end
