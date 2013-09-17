//
//  LQSDrawableTexturedSquareData.h
//  Snake
//
//  Created by Ariel on 2013-09-16.
//  Copyright (c) 2013 Liquid Sparks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ILQSDrawableTexturedSquareData.h"

@interface LQSDrawableTexturedSquareData : NSObject <ILQSDrawableTexturedSquareData>

@property (nonatomic) NSObject<ILQSTexturedVerticesProgram> *program;
@property (nonatomic) NSObject<ILQSGLTexture> *texture;
@property (nonatomic) NSObject<ILQSAdjacentSpace> *squareSpace;
@property (nonatomic) NSObject<ILQSAdjacentSpace> *cameraSpace;
@property (nonatomic) NSObject<ILQSTransformationResolver> *transformationResolver;

@end
