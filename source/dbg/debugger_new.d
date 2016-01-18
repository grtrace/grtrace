module dbg.debugger_new;

import glad.gl.all;
import glad.gl.loader;
import derelict.glfw3.glfw3;

import std.stdio, std.string, std.file, std.math, std.exception;

import config, scene.camera, scene.scenemgr, math;

/// -
class TooLowGLVersion : Error
{
    ///-
	this()
	{
		super("You've got too low OpenGL version. 3.3 is required.");
	}
}

/// Class responsible for visual debugging
class VisualHelper
{
    private __gshared VisualHelper _inst;
    shared static this()
    {
        _inst = new VisualHelper();
    }
    private this()
    {
    }
    /// -
    public static @property VisualHelper instance()
    {
        return _inst;
    }
    /// -
    public void initialize()
    {
        
    }
    
    private GLFWwindow* rwin;
    private int winx,winy;
    
    /// Starts the graphical part of the debugger
    public void runGraphics()
    {
        DerelictGLFW3.load();
        glfwInit();
        setupWindow();
        while(!glfwWindowShouldClose(rwin))
        {
            resetGl();
            glClear(GL_DEPTH_BUFFER_BIT | GL_COLOR_BUFFER_BIT);
            glfwSwapBuffers(rwin);
        }
    }
    
    private void resetGl()
    {
        glClearColor(0, 0, 0, 1);
        glViewport(0, 0, winx, winy);
        glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
        glEnable(GL_BLEND);
    }
    
    private void setupWindow()
    {
        glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 3);
        glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 3);
        glfwWindowHint(GLFW_FOCUSED, GL_TRUE);
        glfwWindowHint(GLFW_SRGB_CAPABLE, GL_TRUE);
        glfwWindowHint(GLFW_DOUBLEBUFFER, GL_TRUE);
        glfwWindowHint(GLFW_OPENGL_FORWARD_COMPAT, GL_TRUE);
        glfwWindowHint(GLFW_CONTEXT_RELEASE_BEHAVIOR, GLFW_RELEASE_BEHAVIOR_NONE);
        glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);
        glfwWindowHint(GLFW_RESIZABLE, GL_TRUE);
        glfwWindowHint(GLFW_VISIBLE, GL_TRUE);
        int W = cast(int)cfgResolutionX;
        int H = cast(int)cfgResolutionY;
        winx = W;
        winy = H;
        rwin = glfwCreateWindow(W,H,"GrTrace Visual Helper",null,null);
        if(!rwin)
        {
            throw new TooLowGLVersion();
        }
        glfwMakeContextCurrent(rwin);
        glfwSwapInterval(1);
        if (!gladLoadGL())
        {
            throw new TooLowGLVersion();
        }
        if (GLVersion.major < 3)
        {
            throw new TooLowGLVersion();
        }
        if ((GLVersion.major == 3) && (GLVersion.minor < 3))
        {
            throw new TooLowGLVersion();
        }
        glfwSwapBuffers(rwin);
        glfwSetMouseButtonCallback(rwin, &coreMouseButton);
        glfwSetScrollCallback(rwin, &coreScroll);
        glfwSetCursorPosCallback(rwin, &coreMouseMove);
        glfwSetCharCallback(rwin, &coreChar);
        glfwSetKeyCallback(rwin, &coreKey);
        glfwSetFramebufferSizeCallback(rwin, &coreSize);
    }
    
    ///-
    public bool modLShift = false;
    ///-
    public bool modRShift = false;
    ///-
    public bool modLAlt = false;
    ///-
    public bool modRAlt = false;
    ///-
    public bool modLCtrl = false;
    ///-
    public bool modRCtrl = false;

    // Updates the modifier key variables.
    private void updateMods()
    {
        int t;
        t = glfwGetKey(rwin, GLFW_KEY_LEFT_SHIFT);
        modLShift = (t == GLFW_PRESS);
        t = glfwGetKey(rwin, GLFW_KEY_RIGHT_SHIFT);
        modRShift = (t == GLFW_PRESS);
        t = glfwGetKey(rwin, GLFW_KEY_LEFT_ALT);
        modLAlt = (t == GLFW_PRESS);
        t = glfwGetKey(rwin, GLFW_KEY_RIGHT_ALT);
        modRAlt = (t == GLFW_PRESS);
        t = glfwGetKey(rwin, GLFW_KEY_LEFT_CONTROL);
        modLCtrl = (t == GLFW_PRESS);
        t = glfwGetKey(rwin, GLFW_KEY_RIGHT_CONTROL);
        modRCtrl = (t == GLFW_PRESS);
    }
    
    /// -
    public void onMouseButton(int button, int state, int x, int y)
    {
        
    }
    
    /// -
    public void onMouseMove(int x, int y)
    {
        
    }
    
    /// -
    public void onScroll(double axis, double dir)
    {
        
    }
    
    /// -
    public void onChar(dchar ch)
    {
        
    }
    
    /// -
    public void onKey(int id, int state)
    {
        
    }
    
    /// -
    public void onResize(int w, int h)
    {
        glViewport(0,0,w,h);
        winx = w;
        winy = h;
    }
}

extern (C) void coreMouseButton(GLFWwindow* w, int btn, int type, int modkeys) nothrow
{
	try
	{
		double xd, yd;
		glfwGetCursorPos(w, &xd, &yd);
		int x = cast(int) xd, y = cast(int) yd;
		VisualHelper.instance.onMouseButton(btn,type,x,y);
	}
	catch (Throwable o)
	{
	}
}

extern (C) void coreMouseMove(GLFWwindow* w, double x, double y) nothrow
{
	try
	{
		VisualHelper.instance.onMouseMove(cast(int)x,cast(int)y);
	}
	catch (Throwable o)
	{
	}
}

extern (C) void coreScroll(GLFWwindow* w, double axis, double dir) nothrow
{
	try
	{
		VisualHelper.instance.onScroll(axis,dir);
	}
	catch (Throwable o)
	{
	}
}

extern (C) void coreChar(GLFWwindow* w, uint ch) nothrow
{
	try
	{
		VisualHelper.instance.onChar(cast(dchar)ch);
	}
	catch (Throwable o)
	{
	}
}

extern (C) void coreKey(GLFWwindow* w, int id, int scan, int state, int mods) nothrow
{
	try
	{
        VisualHelper.instance.onKey(id, state);
	}
	catch (Throwable o)
	{
	}
}

extern (C) void coreSize(GLFWwindow* win, int w, int h) nothrow
{
	if ((w == 0) || (h == 0))
		return;
	try
	{
		VisualHelper.instance.onResize(w,h);
	}
	catch (Throwable o)
	{
	}
}

