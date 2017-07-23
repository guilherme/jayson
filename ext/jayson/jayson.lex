%{
#include <stdlib.h>
#include <ruby.h>
void yyerror(char *);
#include "jayson.h"
%}

%option bison-locations
%option reentrant
%option fast
%option nounput noyywrap noinput

OBJECT \{\}
DIGIT [0-9]+
DIGIT1 [1-9]+
DIGITS ({DIGIT}{DIGIT}*)
FRAC .{DIGITS}
E [eE][+-]?
EXP E?{DIGITS}
INT -?({DIGIT}|{DIGIT1}{DIGITS})

CHAR [A-Za-z0-9 ]+

%%
\"{CHAR}*\" {
  *yylval = rb_str_new(&yytext[1], yyleng-2U);
  return TOK_STRING;
}
({INT}|{INT}{FRAC}|{INT}{EXP}|{INT}{FRAC}{EXP}) {
  *yylval = rb_str_new(&yytext[1], yyleng-2U);
  return TOK_NUMBER;
}
{OBJECT} {
  *yylval = rb_str_new(&yytext[1], yyleng-2U);
  return TOK_OBJECT;
}
%%