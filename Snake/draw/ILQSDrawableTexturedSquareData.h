//
//  ILQSDrawableTexturedSquareData.h
//  Snake
//
//  Created by Ariel on 2013-09-16.
//  Copyright (c) 2013 Liquid Sparks. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ILQSTexturedVerticesProgram;
@protocol ILQSAdjacentSpace;
@protocol ILQSGLTexture;

@protocol ILQSDrawableTexturedSquareData <NSObject>

-(NSObject<ILQSTexturedVerticesProgram> *)program;
-(NSObject<ILQSGLTexture> *)texture;
-(NSObject<ILQSAdjacentSpace> *)squareSpace;
-(NSObject<ILQSAdjacentSpace> *)cameraSpace;

@end
