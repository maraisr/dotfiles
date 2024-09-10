#ifndef COMMON_H
#define COMMON_H

#include <stddef.h>

typedef struct {
    void** items;
    size_t count;
    size_t capacity;
} DA;

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

#endif // COMMON_H
