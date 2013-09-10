//
//  ILQSDrawableArray.h
//  Snake
//
//  Created by Ariel on 2013-09-09.
//  Copyright (c) 2013 Liquid Sparks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ILQSDrawableCollection.h"

@protocol ILQSDrawableArray <ILQSDrawableCollection>

- (void)insertObject:(NSObject<ILQSDrawable> *)drawableObject atIndex:(NSUInteger)index;

@end
