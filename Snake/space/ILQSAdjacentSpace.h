//
//  ILQSAdjacentSpace.h
//  Snake
//
//  Created by Ariel on 2013-09-03.
//  Copyright (c) 2013 Liquid Sparks. All rights reserved.
//

#import "ILQSSpace.h"

@protocol ILQSSpaceCollection;
@protocol ILQSTransformation;

@protocol ILQSAdjacentSpace <ILQSSpace>

- (NSObject<ILQSSpaceCollection> *)adjacentSpaces;
- (bool)isAdjacentSpace:(NSObject<ILQSAdjacentSpace> *)adjacentSpace;
- (NSObject<ILQSTransformation> *)transformationObjectToSpace:(NSObject<ILQSAdjacentSpace> *)adjacentSpace;

@end
