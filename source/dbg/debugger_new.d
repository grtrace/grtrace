module dbg.debug_new;

import derelict.glfw3.glfw3;
import glad.gl.all;
import glad.gl.loader;

import std.stdio, std.string, std.file, std.math;

import config, scene.camera, scene.scenemgr, math;

class VisualDebugger
{
	public static VisualDebugger inst;
	__gshared GLFWwindow* vis_window;
	__gshared GLFWwindow* img_window;
	
	private bool gl_loaded;
	
	//texture_draw, line_draw, vertex_draw
	GLuint[immutable string] programs;
	GLint[immutable string] uniforms;
	GLuint[immutable string] shaders;
	GLuint[immutable string] vaos;
	
	GLuint vbo_saved_rays;
	GLuint vbo_point_colors;
	float[] saved_rays; //x, y, z
	float[] point_colors; // r, g, b
	
	GLuint vbo_texture;
	immutable float[] texture_verts = 
	[-1.0f, -1.0f, 0.0f, 0.0f,
	1.0f, -1.0f, 1.0f, 0.0f,
	1.0f, 1.0f, 1.0f, 1.0f,
	-1.0f, 1.0f, 0.0f, 1.0f];
	GLuint traced_texture;
	
	WorldSpace space;
	ICamera camera;
	
	float[16] view_matrix;
	float[16] proj_matrix;
	
	Quaternion rotation;
	
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
				
				//windows
				vis_window = makeWindow("GRTrace visualiser", cast(int)cfgResolutionX, cast(int)cfgResolutionY, true);
				img_window = makeWindow("GRTrace traced image", cast(int)cfgResolutionX, cast(int)cfgResolutionY, false, vis_window);
			
				glfwMakeContextCurrent(img_window);
				//prepare "traced image"
				//compile shaders
				shaders["img_vec"] = CompileShader(GL_VERTEX_SHADER, import("image/vertex_shader.glsl"));
				shaders["img_frag"] = CompileShader(GL_FRAGMENT_SHADER, import("image/fragment_shader.glsl"));
				
				//create program
				GLuint tex_prog = glCreateProgram();
				glAttachShader(tex_prog, shaders["img_vec"]);
				glAttachShader(tex_prog, shaders["img_frag"]);
				glLinkProgram(tex_prog);
				programs["img"] = tex_prog;
				
				//setup VAO
				GLuint tex_vao;
				glGenVertexArrays(1, &tex_vao);
				glBindVertexArray(tex_vao);
				vaos["img_tex"] = tex_vao;
				
				//prepare VBO
				glGenBuffers(1, &vbo_texture);
				glBindBuffer(GL_ARRAY_BUFFER, vbo_texture);
				glBufferData(GL_ARRAY_BUFFER, texture_verts.sizeof, cast(void*)texture_verts, GL_STATIC_DRAW);
				
				//setup input format
				GLint tex_vert_atrib = glGetAttribLocation(tex_prog, "vert");
				glEnableVertexAttribArray(tex_vert_atrib);
				glVertexAttribPointer(tex_vert_atrib, 2, GL_FLOAT, GL_FALSE, 4*float.sizeof, cast(void*)0);
				
				GLint tex_tex_attrib = glGetAttribLocation(tex_prog, "tex_coord");
				glEnableVertexAttribArray(tex_tex_attrib);
				glVertexAttribPointer(tex_vert_atrib, 2, GL_FLOAT, GL_FALSE, 4*float.sizeof, cast(void*)(2*float.sizeof));
				
				//prepare "visualizer"
				glfwMakeContextCurrent(vis_window);
				glEnable(GL_DEPTH_TEST);
				
				//create line drawing program
				shaders["lines_vec"] = CompileShader(GL_VERTEX_SHADER, import("lines/vertex_shader.glsl"));
				//TODO:Fix the opengl bindings
				shaders["lines_geo"] = CompileShader(GL_GEOMETRY_SHADER_EXT, import("lines/geometry_shader.glsl"));
				shaders["lines_frag"] = CompileShader(GL_FRAGMENT_SHADER, import("lines/fragment_shader.glsl"));
				
				GLuint lines_prog = glCreateProgram();
				glAttachShader(lines_prog, shaders["lines_vec"]);
				glAttachShader(lines_prog, shaders["lines_geo"]);
				glAttachShader(lines_prog, shaders["lines_frag"]);
				glLinkProgram(lines_prog);
				
				//generate VBO for ray drawing
				glGenBuffers(1, &vbo_saved_rays);
				glGenBuffers(1, &vbo_point_colors);
				
				//generate VAO for ray drawing
				GLuint lines_vao;
				glGenVertexArrays(1, &lines_vao);
				glBindVertexArray(lines_vao);
				vaos["lines_ray"] = lines_vao;
				
				//setup input format
				glBindBuffer(GL_ARRAY_BUFFER, vbo_saved_rays);
				GLint lines_pos = glGetAttribLocation(lines_prog, "position");
				glEnableVertexAttribArray(lines_pos);
				glVertexAttribPointer(lines_pos, 3, GL_FLOAT, GL_FALSE, cast(void*)(3*float.sizeof), cast(void*)0);
				
				glBindBuffer(GL_ARRAY_BUFFER, vbo_point_colors);
				GLint lines_col = glGetAttribLocation(lines_prog, "color");
				glEnableVertexAttribArray(lines_col);
				glVertexAttribPointer(lines_col, 3, GL_FLOAT, GL_FALSE, cast(void*)(3*float.sizeof), cast(void*)0);
				
				//setup uniforms
				uniforms["lines_model_mat"] = glGetUniformLocation(lines_prog, "model");
				uniforms["lines_view_mat"] = glGetUniformLocation(lines_prog, "view");
				uniforms["lines_proj_mat"] = glGetUniformLocation(lines_prog, "proj");
				uniforms["lines_viewport_2f"] = glGetUniformLocation(lines_prog, "viewport_size");
				uniforms["lines_line_thickness_1f"] = glGetUniformLocation(lines_prog, "line_thickness");
				
			}
		}
	}
	
	~this()
	{
		glfwDestroyWindow(img_window);
		glfwDestroyWindow(vis_window);
		
		foreach(GLuint i; programs)
		{
			glDeleteProgram(i);
		}
		foreach(GLuint i; shaders)
		{
			glDeleteShader(i);
		}
		
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
	
	void SetupPerspectivicProjection(float fov, float aspect, float z_near, float z_far)
	{
		//TODO: move to matrix
		proj_matrix[0] = 1.0f/(aspect*tan(fov/2));
		proj_matrix[1] = proj_matrix[2] = proj_matrix[3] = proj_matrix[4] = 0;
		proj_matrix[5] = 1.0f/tan(fov/2);
		proj_matrix[6] = proj_matrix[7] = proj_matrix[8] = proj_matrix[9] = 0;
		proj_matrix[10] = z_far/(z_far-z_near);
		proj_matrix[11] = (z_near*z_far)/(z_far-z_near);
		proj_matrix[12] = proj_matrix[13] = proj_matrix[15] = 0;
		proj_matrix[14] = -1;
		
		//pass the projection matrix to shaders
		glUniformMatrix4fv(uniforms["lines_proj_mat"], 1, GL_FALSE, cast(float*)proj_matrix);
	}
	
	void FlushRayPositionDataToGPU()
	{
		glBindBuffer(GL_VERTEX_ARRAY, vbo_saved_rays);
		glBufferData(GL_VERTEX_ARRAY, saved_rays.sizeof, cast(GLvoid*)saved_rays, GL_DYNAMIC_DRAW); 
	}
	
	void FlushRayColorDataToGPU()
	{
		glBindBuffer(GL_VERTEX_ARRAY, vbo_point_colors);
		glBufferData(GL_VERTEX_ARRAY, point_colors.sizeof, cast(GLvoid*)point_colors, GL_DYNAMIC_DRAW);
	}
	
	void Start()
	{
		space = cast(WorldSpace)(cfgSpace);
		camera = cast(ICamera)(cfgSpace.camera);
		if(!cfgDebug)return;
		
		LoadTexture();
		
		SetupPerspectivicProjection(45.0f, 1.0f, 0.1f, 100.0f);
		
		while(!(glfwWindowShouldClose(img_window)||glfwWindowShouldClose(vis_window)))
		{
			//traced image
			glfwMakeContextCurrent(img_window);
			glClear(GL_COLOR_BUFFER_BIT);
			
			glUseProgram(programs["img"]);
			glBindVertexArray(vaos["img_tex"]);
			glBindTexture(GL_TEXTURE_2D, traced_texture);
			glDrawArrays(GL_QUADS, 0, 4);
			
			glfwSwapBuffers(img_window);
			
			//visualizer
			glfwMakeContextCurrent(vis_window);
			glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
			
			if(saved_rays.length != 0)
			{
				glUseProgram(programs["lines"]);
				glBindVertexArray(vaos["lines_ray"]);
				
				glUniform1f(uniforms["lines_line_thickness_1f"], 1.0f);
				glUniform2f(uniforms["lines_viewport_2f"], cast(GLfloat)cfgResolutionX, cast(GLfloat)cfgResolutionY);
				glUniformMatrix4fv(uniforms["lines_view_mat"], 1, GL_FALSE, cast(float*)view_matrix);
				glUniformMatrix4fv(uniforms["lines_model_mat"], 1, GL_FALSE, cast(float*)Matrix4!(float).Identity().vals);
				
				glDrawArrays(GL_LINE_STRIP, 0, cast(GLint)saved_rays.length/3);
			}
			
			glfwSwapBuffers(vis_window);
			
			glfwPollEvents();
		}
	}
	
}