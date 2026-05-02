%token A "dangling-a"
%token B
%left '+'
%%
start:
    /* empty */
  | mid B
  ;

mid:
    A { $<ival>$ = 1; } B
  ;
%%
