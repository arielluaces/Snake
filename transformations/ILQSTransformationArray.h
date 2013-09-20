//
//  ILQSTransformationArray.h
//  Snake
//
//  Created by Ariel on 2013-09-20.
//  Copyright (c) 2013 Liquid Sparks. All rights reserved.
//

#import "ILQSTransformationCollection.h"

@protocol ILQSTransformationArray <ILQSTransformationCollection>

- (void)insertTransformation:(NSObject<ILQSTransformation> *)transformation atIndex:(uint)index;

@end
