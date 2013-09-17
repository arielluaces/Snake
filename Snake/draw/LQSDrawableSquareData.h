//
//  LQSDrawableSquareData.h
//  Snake
//
//  Created by Ariel on 2013-09-09.
//  Copyright (c) 2013 Liquid Sparks. All rights reserved.
//

#import "ILQSDrawableSquareData.h"

@interface LQSDrawableSquareData : NSObject <ILQSDrawableSquareData>

@property (nonatomic) NSObject<ILQSColoredVerticesProgram> *program;
@property (nonatomic) NSObject<ILQSAdjacentSpace> *space;
@property (nonatomic) NSObject<ILQSAdjacentSpace> *rootSpace;
@property (nonatomic) NSObject<ILQSTransformationResolver> *transformationResolver;
@property (nonatomic) float colorR;
@property (nonatomic) float colorG;
@property (nonatomic) float colorB;

@end
