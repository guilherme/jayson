#include "jayson.h"

VALUE rb_mJayson;

void
Init_jayson(void)
{
  rb_mJayson = rb_define_module("Jayson");
}
