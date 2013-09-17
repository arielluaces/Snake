//
//  LQSUniformScaleTransformation.h
//  Snake
//
//  Created by Ariel on 2013-09-04.
//  Copyright (c) 2013 Liquid Sparks. All rights reserved.
//

#import "ILQSTransformation.h"

@interface LQSUniformScaleTransformation : NSObject <ILQSTransformation>

@property (nonatomic, assign) float scale;

@end
