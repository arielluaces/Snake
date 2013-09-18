//
//  ILQSTransformation.h
//  Snake
//
//  Created by Ariel on 2013-09-03.
//  Copyright (c) 2013 Liquid Sparks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKMathTypes.h>

@protocol ILQSTransformation <NSObject>

- (GLKMatrix4)transformationMatrix;
- (GLKMatrix4)transformationMatrixInverse;

@end
