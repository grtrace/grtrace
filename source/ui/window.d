module ui.window;

import config;
static if(GRTRACE_HAS_UI):

import glad.gl.all;
import glad.gl.loader;
import dbg.glhelpers;
import dbg.dispatcher;
import dbg.draws;
import std.stdio, std.string, std.file, std.math, std.exception;
import std.string, std.format, std.algorithm, std.array, std.range;
import scene.camera, scene.scenemgr, math;
import std.conv;
import dlangui;

private enum string DML_WELCOME = import("ui/welcome.dml");

class UIMain : AppFrame
{
	Window window;
	TabWidget tabWidget;

	private this(Window w)
	{
		this.window = w;
		this._appName = "GRTrace_GUI";
		super();
	}

	override protected MainMenu createMainMenu()
	{
		MenuItem items = new MenuItem();
		items.add(new MenuItem(new Action(1, "File")));
		return new MainMenu(items);
	}

	override protected ToolBarHost createToolbars()
	{
		ToolBarHost tbh = new ToolBarHost;
		return tbh;
	}

	override protected StatusLine createStatusLine()
	{
		StatusLine sl = new StatusLine;
		sl.addChild(new TextWidget("st1", "Hello, GRTrace!"d));
		return sl;
	}

	override protected Widget createBody()
	{
		tabWidget = new TabWidget();
		tabWidget.layoutWidth = FILL_PARENT;
		tabWidget.layoutHeight = FILL_PARENT;

		Widget welcomePane = parseML(DML_WELCOME);
		tabWidget.addTab(welcomePane, "Welcome");

		return tabWidget;
	}
	
	private static void run()
	{
		overrideScreenDPI(cast(int) cfgUiDpi);
		Platform.instance.GLVersionMajor = 3;
		Platform.instance.GLVersionMinor = 3;
		Platform.instance.uiLanguage = "en";
		FontManager.hintingMode = HintingMode.AutoHint;
		FontManager.minAnitialiasedFontSize = 0;
		FontManager.subpixelRenderingMode = SubpixelRenderingMode.None;

		Window window = Platform.instance.createWindow("GRTrace", null);

		uiMain = new UIMain(window);
		window.mainWidget = uiMain;

		window.show();
		Platform.instance.enterMessageLoop();
	}
}

__gshared UIMain uiMain;

void runUI()
{
	if(uiMain is null)
	{
		UIMain.run();
	}
}
