//
//  shadingTests.m
//  shadingTests
//
//  Created by Ariel on 2013-09-18.
//  Copyright (c) 2013 Liquid Sparks. All rights reserved.
//

#import "shadingTests.h"

#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES2/gl.h>
#import "LQSVertexShader.h"
#import "LQSFragmentShader.h"
#import "LQSGLShaderArray.h"
#import "LQSMultiShaderProgram.h"

@implementation shadingTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

const GLchar *vertexShaderSourceC = "attribute vec2 aPosition;\n\
attribute vec2 aTexCoord;\n\
uniform mat4 uMVPMatrix;\n\
varying highp vec2 vTexCoord;\n\
\n\
void main()\n\
{\n\
    gl_Position = uMVPMatrix * vec4(aPosition, 0.0, 1.0);\n\
    vTexCoord = aTexCoord;\n\
}\n\
";
const GLchar *fragmentShaderSourceC = "varying highp vec2 vTexCoord;\n\
highp vec4 getTexel(highp vec2 texCoord);\n\
\n\
void main()\n\
{\n\
    gl_FragColor = getTexel(vTexCoord);\n\
}\n\
\n\
";
const GLchar *fragmentShader2SourceC = "uniform sampler2D sTexture;\n\
\n\
highp vec4 getTexel(highp vec2 texCoord)\n\
{\n\
return texture2D(sTexture, texCoord);\n\
}\n\
";
const GLchar *fragmentShader3SourceC = "";

- (void)testMultiprograms
{
    EAGLContext *context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    NSAssert(context != nil, @"Failed to create ES context");
    EAGLContext *savedContext = [EAGLContext currentContext];
    [EAGLContext setCurrentContext:context];
    NSObject<ILQSGLShader> *vertexShader = [[LQSVertexShader alloc] initWithSource:vertexShaderSourceC context:context];
    STAssertNotNil(vertexShader, @"Vertex shader should compile fine");
    NSObject<ILQSGLShader> *fragmentShader = [[LQSFragmentShader alloc] initWithSource:fragmentShaderSourceC context:context];
    STAssertNotNil(fragmentShader, @"Fragment shader should compile fine");
    NSObject<ILQSGLShader> *fragmentShader2 = [[LQSFragmentShader alloc] initWithSource:fragmentShader2SourceC context:context];
    STAssertNotNil(fragmentShader2, @"Second fragment shader should compile fine");
    LQSGLShaderArray *shaderArray = [[LQSGLShaderArray alloc] init];
    [shaderArray addShader:vertexShader];
    [shaderArray addShader:fragmentShader];
    [shaderArray addShader:fragmentShader2];
    STAssertNoThrow([[LQSMultiShaderProgram alloc] initWithShaders:shaderArray context:context], @"Could not link program");
    [EAGLContext setCurrentContext:savedContext];
}

- (void)testMultipleShaders
{
    EAGLContext *context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    STAssertNotNil(context, @"Failed to create ES context");
    EAGLContext *savedContext = [EAGLContext currentContext];
    [EAGLContext setCurrentContext:context];
    {
        GLuint vertexShaderName;
        GLuint fragmentShaderName;
        GLuint fragmentShader2Name;
        GLuint fragmentShader3Name;
        {
            GLuint shaderName = glCreateShader(GL_VERTEX_SHADER);
            STAssertTrue(shaderName != 0, @"Failed to create shader");
            vertexShaderName = shaderName;
            glShaderSource(shaderName, 1, &vertexShaderSourceC, nil);
            glCompileShader(shaderName);
            {
                int compileStatus = 0;
                glGetShaderiv(shaderName, GL_COMPILE_STATUS, &compileStatus);
                if (compileStatus == GL_FALSE)
                {
                    int logLength = 0;
                    glGetShaderiv(shaderName, GL_INFO_LOG_LENGTH, &logLength);
                    if (logLength != 0)
                    {
                        char *log = malloc(sizeof(char) * (uint)logLength);
                        glGetShaderInfoLog(shaderName, logLength, NULL, log);
                        STFail(@"Could not compile shader log: %s", log);
                        free(log);
                    }
                    else// if (logLength == 0)
                    {
                        STFail(@"Could not compile shader");
                    }
                }
            }
        }
        {
            GLuint shaderName = glCreateShader(GL_FRAGMENT_SHADER);
            STAssertTrue(shaderName != 0, @"Failed to create shader");
            fragmentShaderName = shaderName;
            glShaderSource(shaderName, 1, &fragmentShaderSourceC, nil);
            glCompileShader(shaderName);
            {
                int compileStatus = 0;
                glGetShaderiv(shaderName, GL_COMPILE_STATUS, &compileStatus);
                if (compileStatus == GL_FALSE)
                {
                    int logLength = 0;
                    glGetShaderiv(shaderName, GL_INFO_LOG_LENGTH, &logLength);
                    if (logLength != 0)
                    {
                        char *log = malloc(sizeof(char) * (uint)logLength);
                        glGetShaderInfoLog(shaderName, logLength, NULL, log);
                        STFail(@"Could not compile shader log: %s", log);
                        free(log);
                    }
                    else// if (logLength == 0)
                    {
                        STFail(@"Could not compile shader");
                    }
                }
            }
        }
        {
            GLuint shaderName = glCreateShader(GL_FRAGMENT_SHADER);
            STAssertTrue(shaderName != 0, @"Failed to create shader");
            fragmentShader2Name = shaderName;
            glShaderSource(shaderName, 1, &fragmentShader2SourceC, nil);
            glCompileShader(shaderName);
            {
                int compileStatus = 0;
                glGetShaderiv(shaderName, GL_COMPILE_STATUS, &compileStatus);
                if (compileStatus == GL_FALSE)
                {
                    int logLength = 0;
                    glGetShaderiv(shaderName, GL_INFO_LOG_LENGTH, &logLength);
                    if (logLength != 0)
                    {
                        char *log = malloc(sizeof(char) * (uint)logLength);
                        glGetShaderInfoLog(shaderName, logLength, NULL, log);
                        STFail(@"Could not compile shader log: %s", log);
                        free(log);
                    }
                    else// if (logLength == 0)
                    {
                        STFail(@"Could not compile shader");
                    }
                }
            }
        }
        {
            GLuint shaderName = glCreateShader(GL_FRAGMENT_SHADER);
            STAssertTrue(shaderName != 0, @"Failed to create shader");
            fragmentShader3Name = shaderName;
            glShaderSource(shaderName, 1, &fragmentShader3SourceC, nil);
            glCompileShader(shaderName);
            {
                int compileStatus = 0;
                glGetShaderiv(shaderName, GL_COMPILE_STATUS, &compileStatus);
                if (compileStatus == GL_FALSE)
                {
                    int logLength = 0;
                    glGetShaderiv(shaderName, GL_INFO_LOG_LENGTH, &logLength);
                    if (logLength != 0)
                    {
                        char *log = malloc(sizeof(char) * (uint)logLength);
                        glGetShaderInfoLog(shaderName, logLength, NULL, log);
                        STFail(@"Could not compile shader log: %s", log);
                        free(log);
                    }
                    else// if (logLength == 0)
                    {
                        STFail(@"Could not compile shader");
                    }
                }
            }
        }
        {
            GLuint programName = glCreateProgram();
            NSAssert(programName != 0, @"Failed to create program");
            glAttachShader(programName, vertexShaderName);
            glAttachShader(programName, fragmentShaderName);
            glAttachShader(programName, fragmentShader2Name);
            glAttachShader(programName, fragmentShader3Name);
            glLinkProgram(programName);
            {
                int linkStatus = 0;
                glGetProgramiv(programName, GL_LINK_STATUS, &linkStatus);
                if (linkStatus == GL_FALSE)
                {
                    int logLength = 0;
                    glGetProgramiv(programName, GL_INFO_LOG_LENGTH, &logLength);
                    if (logLength != 0)
                    {
                        char *log = malloc(sizeof(char) * (uint)logLength);
                        glGetProgramInfoLog(programName, logLength, NULL, log);
                        STFail(@"Could not link shader program log: %s",log);
                        free(log);
                    }
                    else// if (logLength == 0)
                    {
                        STFail(@"Could not link shader program");
                    }
                }
            }
        }
    }
    [EAGLContext setCurrentContext:savedContext];
}

@end
