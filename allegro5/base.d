module allegro5.base;

version (Tango) {
	import tango.math.Math;
}
else {
	import std.math;
}

const int ALLEGRO_VERSION      = 4;
const int ALLEGRO_SUB_VERSION	 = 9;
const int ALLEGRO_WIP_VERSION	 = 23;
const int ALLEGRO_RELEASE_NUMBER = 0;
const char[] ALLEGRO_VERSION_STR = "4.9.23 (SVN)";
const char[] ALLEGRO_DATE_STR	 = "2010";
const int ALLEGRO_DATE         =  20100926;  /* yyyymmdd */

extern (C)
{
	uint al_get_allegro_version();
	int al_run_main(int argc, char **argv, int function(int, char **) fn);
}

const int ALLEGRO_VERSION_INT =
	 ((ALLEGRO_VERSION << 24) | (ALLEGRO_SUB_VERSION << 16) | 
	 (ALLEGRO_WIP_VERSION << 8) | ALLEGRO_RELEASE_NUMBER);

version (Tango) {
	alias tango.math.Math.PI ALLEGRO_PI;
}
else {
	alias std.math.PI ALLEGRO_PI;
}

int AL_ID(char a, char b, char c, char d)
{
	return (a << 24) | (b << 16) | (c << 8) | d;
}