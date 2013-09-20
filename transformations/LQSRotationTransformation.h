//
//  LQSRotationTransformation.h
//  Snake
//
//  Created by Ariel on 2013-09-20.
//  Copyright (c) 2013 Liquid Sparks. All rights reserved.
//

#import "ILQSTransformation.h"

@interface LQSRotationTransformation : NSObject <ILQSTransformation>

@property (nonatomic, assign) float radians;
@property (nonatomic, assign) float x;
@property (nonatomic, assign) float y;
@property (nonatomic, assign) float z;

@end
