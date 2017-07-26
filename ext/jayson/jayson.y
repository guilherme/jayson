%{
 typedef void * yyscan_t;
 #include <stdio.h>
 #include <stdlib.h>
 #include <ruby.h>
 #include "jayson.h"
 #include "jayson.lexer.h"
 void yyerror(YYLTYPE *locp, yyscan_t scanner, VALUE *object, char const *msg);
%}
%define api.value.type {VALUE}
%define api.pure full
%define parse.error verbose
%define api.token.prefix {TOK_}
%locations

%lex-param {yyscan_t scanner}
%parse-param {yyscan_t scanner}{VALUE *object}

%token NUMBER
%token STRING
%token OBJ_START
%token OBJ_END

%%
program: OBJ_START OBJ_END { *object = rb_hash_new(); };
%%

void yyerror(YYLTYPE *locp, yyscan_t scanner, VALUE *object, char const *msg)
{
 fprintf(stderr, "%s\n", msg);
}


VALUE rb_mJayson;

static VALUE parse(VALUE self, VALUE source);

void
Init_jayson(void)
{
  rb_mJayson = rb_define_module("Jayson");
  rb_define_singleton_method(rb_mJayson, "parse", parse, 1);
}

static VALUE parse(VALUE self, VALUE source)
{
    yyscan_t scanner;
    VALUE object = Qnil;
    int retval = 0;

    if(rb_obj_is_kind_of(source, rb_cString) != Qtrue){

        rb_raise(rb_eTypeError, "source must be a kind of String");
    }

    if(yylex_init(&scanner) == 0){

        if(yy_scan_bytes((const char *)RSTRING_PTR(source), RSTRING_LEN(source), scanner)){

            retval = yyparse(scanner, &object);
        }

        yylex_destroy(scanner);

        switch(retval){
        case 0:
            break;
        case 1: /* syntax error */
        case 2: /* memory exhaustion - most likely running out of stack */
            rb_bug("parsing error");
            break;
        default:
            rb_bug("unexpected return code");
            break;
        }
    }

    return object;
}
