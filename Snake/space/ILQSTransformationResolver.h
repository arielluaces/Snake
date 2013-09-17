//
//  ILQSTransformationResolver.h
//  Snake
//
//  Created by Ariel on 2013-09-16.
//  Copyright (c) 2013 Liquid Sparks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKMathTypes.h>

@protocol ILQSAdjacentSpace;

@protocol ILQSTransformationResolver <NSObject>

- (GLKMatrix4)transformationMatrixFromSpace:(NSObject<ILQSAdjacentSpace> *)space1 toSpace:(NSObject<ILQSAdjacentSpace> *)space2;

@end
