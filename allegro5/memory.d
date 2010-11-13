module allegro5.memory;

extern (C)
{
	struct ALLEGRO_MEMORY_INTERFACE
	{
		void *(*mi_malloc)(size_t n, int line, in char* file, in char* func);
		void (*mi_free)(void* ptr, int line, in char* file, in char* func);
		void *(*mi_realloc)(void* ptr, size_t n, int line, in char* file, in char* func);
		void *(*mi_calloc)(size_t count, size_t n, int line, in char* file, in char* func);
	}

	void al_set_memory_interface(ALLEGRO_MEMORY_INTERFACE* iface);
	
	void* al_malloc_with_context(size_t n, int line, in char* file, in char* func);
	void al_free_with_context(void* ptr, int line, in char* file, in char* func);
	void* al_realloc_with_context(void* ptr, size_t n, int line, in char* file, in char* func);
	void* al_calloc_with_context(size_t count, size_t n, int line, in char* file, in char* func);
	
	void* al_malloc(size_t n)
	{
		return al_malloc_with_context(n, 0, "", "");
	}
	void al_free(void* ptr)
	{
		al_free_with_context(ptr, 0, "", "");
	}
	void* al_realloc(void* ptr, size_t n)
	{
		return al_realloc_with_context(ptr, n, 0, "", "");
	}
	void* al_calloc(size_t count, size_t n)
	{
		return al_calloc_with_context(count, n, 0, "", "");
	}
}