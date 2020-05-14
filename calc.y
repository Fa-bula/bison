/* Infix notation calculator--calc */

%{
#define YYSTYPE double
#include <math.h>
#include <stdio.h>
int  yylex   (void);
void yyerror (char const *);
%}

/* BISON Declarations */
%token NUM
%left '*' '/'			/* least priority */
%left '-' '+'
%left NEG			/* most priority negation--unary minus */

/* Grammar follows */
%%
input:    /* empty string */
        | input line
;

line:     '\n'
        | exp '\n'  { printf ("\t%.10g\n", $1); }
;

exp:      NUM                { $$ = $1;         }
        | exp '+' exp        { $$ = $1 + $3;    }
        | exp '-' exp        { $$ = $1 - $3;    }
        | exp '*' exp        { $$ = $1 * $3;    }
        | exp '/' exp        { $$ = $1 / $3;    }
        | '-' exp  %prec NEG { $$ = -$2;        }
        | '(' exp ')'        { $$ = $2;         }
;
%%

/* Lexical analyzer returns a double floating point  */
/* number on the stack and the token NUM, or the ASCII */
/* character read if not a number.  Skips all blanks */
/* and tabs, returns 0 for EOF. */

#include <ctype.h>

int yylex () {
  int c;

  /* skip white space  */
  while ((c = getchar ()) == ' ' || c == '\t')  
    ;
  /* process numbers   */
  if (c == '.' || isdigit (c))                
    {
      ungetc (c, stdin);
      scanf ("%lf", &yylval);
      return NUM;
    }
  /* return end-of-file  */
  if (c == EOF)                            
    return 0;
  /* return single chars */
  return c;                                
}

main () {
  yyparse ();
}

void yyerror (char const *s) {
    fprintf (stderr, "stderror: %s\n", s);     
}
