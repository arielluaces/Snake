//
//  LQSDrawableMatrixGridData.h
//  Snake
//
//  Created by Ariel School on 2013-12-31.
//  Copyright (c) 2013 Liquid Sparks. All rights reserved.
//

#import "ILQSDrawableMatrixGridData.h"

@interface LQSDrawableMatrixGridData : NSObject<ILQSDrawableMatrixGridData>

@property (nonatomic) NSObject<ILQSMatrixGridProgram> *matrixGridProgram;
@property (nonatomic) NSObject<ILQSAdjacentSpace> *gridSpace;
@property (nonatomic) NSObject<ILQSAdjacentSpace> *cameraSpace;
@property (nonatomic) NSObject<ILQSTransformationResolver> *transformationResolver;
@property (nonatomic) float exponent;

@end
