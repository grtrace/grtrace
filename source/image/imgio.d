module image.imgio;

import image.memory;
import image.imageformats;
import std.stdio;

void WriteImage(Image im, string path)
{
	write_image(path, im.w, im.h, im.data, 3);
}

Image ReadImage(string path)
{
	IFImage im = read_image(path, 3);
	Image r = new Image(im.w, im.h);
	if(im.c == ColFmt.RGB)
	{
		r.data[] = im.pixels[];
	}
	else
	{
		assert(0);
	}
	return r;
}
