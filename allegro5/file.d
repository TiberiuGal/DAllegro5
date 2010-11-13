module allegro5.file;

import allegro5.path;
import allegro5.utf8;

version(Windows)
{
	alias long off_t;
}
else
{
	version(Tango)
	{
		import tango.stdc.posix.sys.types : off_t;
	}
	else
	{
		version(linux)
		{
			import std.c.linux.linux : off_t;
		}
		else
		{
			import std.c.freebsd.freebsd : off_t;
		}
	}
}

extern (C)
{
	struct ALLEGRO_FILE_INTERFACE
	{
		ALLEGRO_FILE* (*fi_fopen)(in char* path, in char* mode);
		void    (*fi_fclose)(ALLEGRO_FILE* handle);
		size_t  (*fi_fread)(ALLEGRO_FILE* f, void* ptr, size_t size);
		size_t  (*fi_fwrite)(ALLEGRO_FILE* f, in void* ptr, size_t size);
		bool    (*fi_fflush)(ALLEGRO_FILE* f);
		long    (*fi_ftell)(ALLEGRO_FILE* f);
		bool    (*fi_fseek)(ALLEGRO_FILE* f, long offset, int whence);
		bool    (*fi_feof)(ALLEGRO_FILE* f);
		bool    (*fi_ferror)(ALLEGRO_FILE* f);
		int     (*fi_fungetc)(ALLEGRO_FILE* f, int c);
		off_t   (*fi_fsize)(ALLEGRO_FILE* f);
	}
	
	struct ALLEGRO_FILE
	{
		const ALLEGRO_FILE_INTERFACE* vtable;
	}
	
	enum ALLEGRO_SEEK
	{
		ALLEGRO_SEEK_SET = 0,
		ALLEGRO_SEEK_CUR,
		ALLEGRO_SEEK_END
	}


	/* The basic operations. */
	ALLEGRO_FILE* al_fopen(in char* path, in char* mode);
	void al_fclose(ALLEGRO_FILE* f);
	size_t al_fread(ALLEGRO_FILE* f, void* ptr, size_t size);
	size_t al_fwrite(ALLEGRO_FILE* f, in void* ptr, size_t size);
	bool al_fflush(ALLEGRO_FILE* f);
	long al_ftell(ALLEGRO_FILE* f);
	bool al_fseek(ALLEGRO_FILE* f, long offset, int whence);
	bool al_feof(ALLEGRO_FILE* f);
	bool al_ferror(ALLEGRO_FILE* f);
	int al_fungetc(ALLEGRO_FILE* f, int c);
	long al_fsize(ALLEGRO_FILE* f);

	/* Convenience functions. */
	int al_fgetc(ALLEGRO_FILE* f);
	int al_fputc(ALLEGRO_FILE* f, int c);
	short al_fread16le(ALLEGRO_FILE* f);
	short al_fread16be(ALLEGRO_FILE* f);
	size_t al_fwrite16le(ALLEGRO_FILE* f, short w);
	size_t al_fwrite16be(ALLEGRO_FILE* f, short w);
	int al_fread32le(ALLEGRO_FILE* f, bool* ret_success);
	int al_fread32be(ALLEGRO_FILE* f, bool* ret_success);
	size_t al_fwrite32le(ALLEGRO_FILE* f, int l);
	size_t al_fwrite32be(ALLEGRO_FILE* f, int l);
	char* al_fgets(ALLEGRO_FILE* f, in char* p, size_t max);
	ALLEGRO_USTR* al_fget_ustr(ALLEGRO_FILE* f);
	int al_fputs(ALLEGRO_FILE* f, in char* p);

	/* Specific to stdio backend. */
	ALLEGRO_FILE* al_fopen_fd(int fd, in char* mode);
	ALLEGRO_FILE* al_make_temp_file(in char* tmpl,	ALLEGRO_PATH **ret_path);

	/* Thread-local state. */
	ALLEGRO_FILE_INTERFACE* al_get_new_file_interface();
	void al_set_new_file_interface(in ALLEGRO_FILE_INTERFACE* file_interface);
	void al_set_standard_file_interface();

}