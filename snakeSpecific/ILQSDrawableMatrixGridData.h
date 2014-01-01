//
//  ILQSDrawableMatrixGridData.h
//  Snake
//
//  Created by Ariel School on 2013-12-31.
//  Copyright (c) 2013 Liquid Sparks. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ILQSMatrixGridProgram;
@protocol ILQSAdjacentSpace;
@protocol ILQSTransformationResolver;

@protocol ILQSDrawableMatrixGridData <NSObject>

- (NSObject<ILQSMatrixGridProgram> *)matrixGridProgram;
- (NSObject<ILQSAdjacentSpace> *)gridSpace;
- (NSObject<ILQSAdjacentSpace> *)cameraSpace;
- (NSObject<ILQSTransformationResolver> *)transformationResolver;
- (float)exponent;

@end
