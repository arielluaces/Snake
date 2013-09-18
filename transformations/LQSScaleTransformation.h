//
//  LQSScaleTransformation.h
//  Snake
//
//  Created by Ariel on 2013-09-03.
//  Copyright (c) 2013 Liquid Sparks. All rights reserved.
//

#import "ILQSTransformation.h"

@interface LQSScaleTransformation : NSObject <ILQSTransformation>

@property (nonatomic, assign) float scaleX;
@property (nonatomic, assign) float scaleY;
@property (nonatomic, assign) float scaleZ;

@end
