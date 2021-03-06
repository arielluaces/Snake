//
//  ILQSDrawableSquareData.h
//  Snake
//
//  Created by Ariel on 2013-09-09.
//  Copyright (c) 2013 Liquid Sparks. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ILQSColoredVerticesProgram;
@protocol ILQSAdjacentSpace;
@protocol ILQSTransformationResolver;

@protocol ILQSDrawableSquareData <NSObject>

-(NSObject<ILQSColoredVerticesProgram> *)program;
-(NSObject<ILQSAdjacentSpace> *)space;
-(NSObject<ILQSAdjacentSpace> *)rootSpace;
-(NSObject<ILQSTransformationResolver> *)transformationResolver;
-(float)colorR;
-(float)colorG;
-(float)colorB;

@end
