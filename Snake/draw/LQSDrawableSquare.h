//
//  LQSDrawableSquare.h
//  Snake
//
//  Created by Ariel on 2013-09-09.
//  Copyright (c) 2013 Liquid Sparks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ILQSDrawable.h"

@protocol ILQSDrawableSquareData;

@interface LQSDrawableSquare : NSObject <ILQSDrawable>

@property (nonatomic) NSObject<ILQSDrawableSquareData> *squareData;

@end
