//
//  LQSTransformationSet.h
//  Snake
//
//  Created by Ariel on 2013-09-20.
//  Copyright (c) 2013 Liquid Sparks. All rights reserved.
//

#import "ILQSTransformation.h"

@protocol ILQSTransformationArray;

@interface LQSTransformationSet : NSObject <ILQSTransformation>

@property (nonatomic, readonly) NSObject<ILQSTransformationArray> *transformationArray;

@end
