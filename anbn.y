/* Simplest Context free grammar (0^n1^n) */
 
%{
    #define YYSTYPE char         // Type of input
    int  yylex   (void);
    void yyerror (char const *);
    #include <stdio.h>
%}

 

/* Terminals of the grammar */
%token ZERO
%token ONE

/* Grammar rules and actions follow */
%% 
    /* input -> input line | e */
    /* input -- starting symbol */
    input:    input line |  
                         { printf ("\n\t This program expecting string as 0^n1^n\n"); }
    ;

    /* line -> '\n' | exp '\n' */
    line:    '\n'        { printf ("\t empty line was introduced\n"); } |
             exp '\n'    { printf ("\t n = %i\n", $1); }
    ;
 
    /* exp -> ZERO exp ONE */
    exp:    ZERO exp ONE   { $$ = $2 + 1; } |  
            ZERO ONE       { $$ = 1; }
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
    if (c == '0') {
        return ZERO;
    } else if (c == '1') {
	return ONE;
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
