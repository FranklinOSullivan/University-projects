/*
 * circularbuffer.h
 *
 *  Created on: Apr 16, 2024
 *      Author: dylan
 */

#ifndef CIRCULARBUFFER_H_
#define CIRCULARBUFFER_H_

#include <stdint.h>
#define TYPE double

typedef struct {
	TYPE * const buffer;
    int head;
    const int maxlen;
} circ_buf_t;

#define CIRC_BUF_DEF(name,size)                \
	TYPE name##_data_space[size];            \
    circ_buf_t name = {                     \
        .buffer = name##_data_space,         \
        .head = 0,                           \
        .maxlen = size                       \
    }

void circ_buf_push(circ_buf_t *c, TYPE data);
TYPE circ_buf_get(circ_buf_t *c, int idx);

#endif /* CIRCULARBUFFER_H_ */
