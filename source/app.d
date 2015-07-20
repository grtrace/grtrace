module app;

import std.stdio;
import std.getopt;

private struct OptionsT
{
  bool verbose = false;
}
/// -
public OptionsT runtimeOptions;

void main(string[] args)
{
	auto optInfo = getopt(args,
    "verbose|v", "Outputs debug information", &runtimeOptions.verbose
  );
  if(optInfo.helpWanted)
  {
    defaultGetoptPrinter("General Relativity rayTracer",optInfo.options);
    return;
  }
}
