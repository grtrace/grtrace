module app;

import std.stdio;
import std.getopt;
import scriptconfig;
import config;

void main(string[] args)
{
	InitScripting(args[0]);
	auto optInfo = getopt(args,
		"verbose|v", "Outputs debug information", &cfgVerbose,
		"script|s", "Script to load the configuration from (default raytrace.tcl)", &cfgScript
		);
	if(optInfo.helpWanted)
	{
		defaultGetoptPrinter("General Relativity rayTracer options:",optInfo.options);
		return;
	}
	DoScript(cfgScript);
	writefln("Rendering to an %dx%d image",cfgResolutionX,cfgResolutionY);
}
