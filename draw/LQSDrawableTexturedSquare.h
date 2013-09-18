//
//  LQSDrawableTexturedSquare.h
//  Snake
//
//  Created by Ariel on 2013-09-16.
//  Copyright (c) 2013 Liquid Sparks. All rights reserved.
//

#import "ILQSDrawable.h"

@protocol ILQSDrawableTexturedSquareData;

@interface LQSDrawableTexturedSquare : NSObject <ILQSDrawable>

@property (nonatomic) NSObject<ILQSDrawableTexturedSquareData> *squareData;

@end
