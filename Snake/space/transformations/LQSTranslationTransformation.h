//
//  LQSTranslationTransformation.h
//  Snake
//
//  Created by Ariel on 2013-09-04.
//  Copyright (c) 2013 Liquid Sparks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ILQSTransformation.h"

@interface LQSTranslationTransformation : NSObject <ILQSTransformation>

@property (nonatomic, assign) float x;
@property (nonatomic, assign) float y;
@property (nonatomic, assign) float z;

@end
