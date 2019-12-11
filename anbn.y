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
S: A B {$$ = $1; printf("S->AB\nn = %d\n", $1);};
B: '\n' {printf("B->eps\n");};
A: ZERO A ONE {$$ = $2 + 1; printf("A -> 0A1\n");} | ZERO ONE {$$ = 1; printf("A->01\n");};
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
