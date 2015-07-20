module app;

import std.stdio;
import std.getopt;
import scriptconfig;

private struct OptionsT
{
	bool verbose = false;
	string script = "raytrace.tcl";
}
/// -
public OptionsT runtimeOptions;

void main(string[] args)
{
	InitScripting(args[0]);
	auto optInfo = getopt(args,
		"verbose|v", "Outputs debug information", &runtimeOptions.verbose,
		"script|s", "Script to load the configuration from (default raytrace.tcl)", &runtimeOptions.script
		);
	if(optInfo.helpWanted)
	{
		defaultGetoptPrinter("General Relativity rayTracer options:",optInfo.options);
		return;
	}
	DoScript(runtimeOptions.script);
}
