module dbg.debug_new;

import derelict.glfw3.glfw3;
import glad.gl.all;
import glad.gl.loader;
import config;

import std.stdio, std.string, std.file;

string texture_vert_shader_code = 
"
#version 150\n
in vec2 vert\n
in vec2 tex_coord\n
out vec2 texture_coord\n
void main()\n
{\n
	gl_Position = vec4(vert, 0.0, 1.0);\n
	texture_coord = tex_coord;\n
}\n
";


string texture_frag_shader_code =
"
#version 150\n
in vec2 texture_coord\n
uniform sampler2D tex\n
out vec4 color\n
void main()\n
{\n
	color = texture(tex, texture_coord);\n
}\n
";

class VisualDebugger
{
	public static VisualDebugger inst;
	__gshared GLFWwindow* vis_window;
	__gshared GLFWwindow* img_window;
	
	private bool gl_loaded;
	
	//texture_draw, line_draw, vertex_draw
	GLuint[] programs;
	GLuint[] shaders;
	GLuint[] vaos;
	
	GLuint vbo_saved_rays;
	GLuint vbo_point_colors;
	float[] saved_rays; //x, y, z
	float[] point_colors; // r, g, b
	
	GLuint traced_texture;
	
	this()
	{
		if(inst is null)
		{
			inst = new VisualDebugger();
			if(cfgDebug)
			{
				//libraries
				DerelictGLFW3.load();
				glfwInit();
				
				//widows
				vis_window = makeWindow("GRTrace visualiser", cast(int)cfgResolutionX, cast(int)cfgResolutionY, true);
				img_window = makeWindow("GRTrace traced image", cast(int)cfgResolutionX, cast(int)cfgResolutionY, false, vis_window);
			
				//prepare pipeline programs
			}
		}
	}
	
	~this()
	{
		glfwTerminate();
	}
	
	static VisualDebugger get()
	{
		if(inst is null)
		{
			inst = new VisualDebugger();
		}
		return inst;
	}
	
	GLuint CompileShader(GLenum type, string file_name)
	{
		if(exists(file_name))
		{
			return CompileShader(type, cast(char[])read(file_name));
		}
		else
		{
			throw new Exception("Shader file : "~file_name~" does not exist");
		}
	}
	
	GLuint CompileShader(GLenum type, char[] code)
	{
		//create and compile shader
		GLuint shader = glCreateShader(type);
		glShaderSource(shader, 1, cast(const char**)&code, null);
		glCompileShader(shader);
		
		//check if operation was succesfull
		GLint status;
		glGetShaderiv(shader, GL_COMPILE_STATUS, &status);
		
		if(status == GL_FALSE)
		{
			//retrieve compilation log
			char[512] buffer;
			glGetShaderInfoLog(shader, 512, null, cast(char*)buffer);
			
			writefln("%s", buffer);
			
			throw new Exception("Unable to compile "~(type==GL_VERTEX_SHADER?"vertex":(type==GL_FRAGMENT_SHADER?"fragment":"geometry"))~" shader");
		}
		
		return shader;
	}
	
	void LoadTexture()
	{
		glGenTextures(1,&traced_texture);
		glBindTexture(GL_TEXTURE_2D, traced_texture);
		glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
		glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
		glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
		glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
		glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB8, cast(int)cfgResolutionX, cast(int)cfgResolutionY, 0, 
			GL_RGB, GL_UNSIGNED_BYTE, cast(ubyte*)(space.fullray.data.ptr));
	}
	
	GLFWwindow* makeWindow(string title, int width, int height, bool resize, GLFWwindow* share=null)
	{
		GLFWwindow* w;
		
		glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);
		glfwWindowHint(GLFW_OPENGL_FORWARD_COMPAT, GL_TRUE);
		glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 3);
		glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 2);
		glfwWindowHint(GLFW_DOUBLEBUFFER, GL_TRUE);
		glfwWindowHint(GLFW_RESIZABLE, (resize?GL_TRUE:GL_FALSE));
		glfwWindowHint(GLFW_VISIBLE, GL_TRUE);
		
		w = glfwCreateWindow(width, height, title.toStringz(), null, share);
		
		if(w is null)
		{
			throw new Exception("Couldn't create glfw3 window");
		}
		glfwMakeContextCurrent(w);
		if(!gl_loaded)
		{
			gl_loaded=true;
			if(!gladLoadGL())
			{
				throw new Exception("Couldn't load OpenGL functions");
			}
			if(cfgVerbose)
			{
				writeln("Loaded OpenGL ",GLVersion.major,".",GLVersion.minor);
			}
		}
		
		glClearColor(0, 0, 0, 1);
		
		return w;
	}
	
}