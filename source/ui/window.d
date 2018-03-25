module ui.window;

import config;

static if (GRTRACE_HAS_UI)
	 : import derelict.opengl3.gl3;
import dbg.glhelpers;
import dbg.dispatcher;
import dbg.draws;
import std.stdio, std.string, std.file, std.math, std.exception;
import std.string, std.format, std.algorithm, std.array, std.range;
import scene.camera, scene.scenemgr, math;
import std.conv;
import dlangui;
import ui.scenepanel;

private enum string DML_WELCOME = import("ui/welcome.dml");

enum UIActions : int
{
	quit = 1,
	menuFile
}

class UIMain : AppFrame
{
	Window window;
	TabWidget tabWidget;
	GrtraceScenePanel gsp;

	private this(Window w)
	{
		this.window = w;
		this._appName = "GRTrace_GUI";
		super();
	}

	void requestExit()
	{
		this.window.close();
	}

	override protected MainMenu createMainMenu()
	{
		MenuItem items = new MenuItem();
		items.add(new MenuItem(new Action(UIActions.menuFile, "File"d)));
		return new MainMenu(items);
	}

	override protected ToolBarHost createToolbars()
	{
		ToolBarHost tbh = new ToolBarHost;
		ToolBar tb = tbh.getOrAddToolbar("apptoolbar");
		tb.addButtons([new Action(UIActions.quit, "Quit"d)]);
		return tbh;
	}

	override protected StatusLine createStatusLine()
	{
		StatusLine sl = new StatusLine;
		return sl;
	}

	override protected Widget createBody()
	{
		tabWidget = new TabWidget();
		tabWidget.layoutWidth = FILL_PARENT;
		tabWidget.layoutHeight = FILL_PARENT;

		Widget welcomePane = parseML(DML_WELCOME);
		tabWidget.addTab(welcomePane, "Welcome"d);

		gsp = new GrtraceScenePanel();
		tabWidget.addTab(gsp, "Scene view"d);

		tabWidget.selectTab(1);

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
		uiMain.gsp.requestFocus();
		Platform.instance.enterMessageLoop();
	}

	override bool handleAction(const Action a)
	{
		switch (a.id) with (UIActions)
		{
		case quit:
			requestExit();
			break;
		default:
			break;
		}
		return true;
	}
}

__gshared UIMain uiMain;

void runUI()
{
	if (uiMain is null)
	{
		UIMain.run();
	}
}
