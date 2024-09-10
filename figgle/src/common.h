#define da(T, name)                                                            \
  typedef struct {                                                             \
    T *items;                                                                  \
    size_t count;                                                              \
    size_t capacity;                                                           \
  } name;

#define da_append(da, item)                                                    \
  do {                                                                         \
    if ((da)->count >= (da)->capacity) {                                       \
      (da)->capacity = (da)->capacity == 0 ? 256 : (da)->capacity * 2;         \
      (da)->items =                                                            \
          realloc((da)->items, (da)->capacity * sizeof(*(da)->items));         \
    }                                                                          \
                                                                               \
    (da)->items[(da)->count++] = (item);                                       \
  } while (0)
