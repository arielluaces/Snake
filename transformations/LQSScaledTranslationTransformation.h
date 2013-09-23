//
//  LQSScaledTranslationTransformation.h
//  Snake
//
//  Created by Ariel on 2013-09-23.
//  Copyright (c) 2013 Liquid Sparks. All rights reserved.
//

#import "ILQSTransformation.h"

@interface LQSScaledTranslationTransformation : NSObject <ILQSTransformation>

@property (nonatomic, assign) float scale;
@property (nonatomic, assign) float x;
@property (nonatomic, assign) float y;
@property (nonatomic, assign) float z;

@end
