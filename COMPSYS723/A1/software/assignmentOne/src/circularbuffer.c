#include "../includes/circularbuffer.h"

/* Function for pushing frequency and rate of change values into a circular buffer*/

void circ_buf_push(circ_buf_t *c, TYPE data)
{
    int next;

    next = c->head + 1;  // next is where head will point to after this write.
    if (next >= c->maxlen)
        next = 0;

    c->buffer[c->head] = data;  // Load data and then move
    c->head = next;             // head to next data offset.
}

/* Function for retrieving frequency and rate of change values from a circular buffer*/
TYPE circ_buf_get(circ_buf_t *c, int idx) {
	int real_idx = (c->head + idx) % c->maxlen;
	return c->buffer[real_idx];
}


