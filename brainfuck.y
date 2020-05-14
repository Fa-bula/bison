/* Simplest Context free grammar (0^n1^n) */
 
%{
#define YYSTYPE char         // Type of input
int  yylex   (void);
void yyerror (char const *);
#include <stdio.h>
int i = 0;
char arr[30000];
%}

 

/* Terminals of the grammar */
%token next
%token prev
%token inc
%token dec
%token print
%token loop_begin
%token loop_end 

/* Grammar rules and actions follow */
%% 
     INPUT: INPUT LINE '\n' | {printf("begin\n");};
 LINE: 
     | LINE next {++i;}
     | LINE prev {--i;}
     | LINE inc {++arr[i];}
     | LINE dec {--arr[i];}
     | LINE print {printf("%d\n", arr[i]);}
;
%%


/* Lexical analyser */
#include <ctype.h>
#include <stdio.h>
int yylex (void) {
    int c;
    /* Skip white space  */
    while ((c = getchar ()) == ' ' || c == '\t');

    /* Process symbols  */
    if (c == '>') {
        return next;
    } else if (c == '<') {
	return prev;
    } else if (c == '+') {
	return inc;
    } else if (c == '-') {
	return dec;
    } else if (c == '.') {
	return print;
    } else if (c == '[') {
	return loop_begin;
    } else if (c == ']') {
	return loop_end;
    } else if (c == EOF)
	return 0;
    /* Return a single char.  */
    return c;
}

/* Called by yyparse on error.  */
void yyerror (char const *s) {
    fprintf (stderr, "stderror: %s\n", s);     
}


int main (void) {
    return yyparse ();
}
