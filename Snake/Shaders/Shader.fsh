//
//  Shader.fsh
//  Snake
//
//  Created by Ariel on 2013-07-28.
//  Copyright (c) 2013 Liquid Sparks. All rights reserved.
//

varying lowp vec4 colorVarying;

void main()
{
    gl_FragColor = colorVarying;
}
