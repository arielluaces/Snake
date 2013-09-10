//
//  LQSDrawableParent.m
//  Snake
//
//  Created by Ariel on 2013-09-09.
//  Copyright (c) 2013 Liquid Sparks. All rights reserved.
//

#import "LQSDrawableParent.h"
#import "ILQSDrawable.h"
#import "LQSDrawableArray.h"

@implementation LQSDrawableParent

- (id)init
{
    self = [super init];
    if (self) {
        _drawableArray = [[LQSDrawableArray alloc] init];
    }
    return self;
}

- (void)draw
{
    for (NSObject<ILQSDrawable> *drawableObject in _drawableArray)
    {
        [drawableObject draw];
    }
}

@end
