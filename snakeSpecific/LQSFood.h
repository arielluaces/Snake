//
//  LQSFood.h
//  Snake
//
//  Created by Ariel School on 2014-01-15.
//  Copyright (c) 2014 Liquid Sparks. All rights reserved.
//

#import "ILQSFood.h"

@interface LQSFood : NSObject<ILQSFood>

@property (nonatomic) NSObject<ILQSAdjacentSpace> *space;
@property (nonatomic) NSObject<ILQSAdjacentSpace> *subSpace;
@property (nonatomic) LQSDrawableSquare *draw;
@property (nonatomic) LQSDrawableSquareData *drawData;
@property (nonatomic) LQSTranslationTransformation *translationTransformation;
@property (nonatomic) LQSRotationTransformation *rotationTransformation;

@end
