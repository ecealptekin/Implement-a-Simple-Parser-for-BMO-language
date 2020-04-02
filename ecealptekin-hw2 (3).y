%{
#include <stdio.h>
#include <stdlib.h>
int yylex();
void yyerror(const char *msg)
{
   printf("%s\n", msg);
}
%}

%token tINTTYPE tINTVECTORTYPE tINTMATRIXTYPE tREALTYPE tREALVECTORTYPE tREALMATRIXTYPE tTRANSPOSE tIDENT tDOTPROD tIF tENDIF tREALNUM tINTNUM tAND tOR tGT tLT tGTE tLTE tNE tEQ

%left tTRANSPOSE
%left tDOTPROD
%left '*' '/'
%left '+' '-'
%left tAND
%left tOR
 
%%

prog:  stmtlst
;
stmtlst: stmtlst stmt
       | stmt     
; 
stmt: decl
    | asgn
    | if 
;
decl: type vars '=' expr ';'
;
type: tINTTYPE
    | tINTVECTORTYPE
    | tINTMATRIXTYPE
    | tREALTYPE
    | tREALVECTORTYPE
    | tREALMATRIXTYPE
;
vars: tIDENT ',' tIDENT
    | tIDENT               
;
asgn: tIDENT '=' expr ';'                     
;
if: tIF '(' bool ')' stmtlst tENDIF            
;
expr: value
    | vectorLit
    | matrixLit
    | expr '+' expr
    | expr '-' expr
    | expr '*' expr
    | expr '/' expr
    | expr tDOTPROD expr
    | transpose  
;
transpose: tTRANSPOSE '(' expr ')'
;
vectorLit: '[' row ']'  
;
matrixLit: '[' rows ']'
;
row: value
   | value ',' row              
;
rows: row ';' row
    | row ';' rows       
;
value: tINTNUM
     | tREALNUM
     | tIDENT       
;
bool: comp
    | bool tAND bool
    | bool tOR bool
;
comp: tIDENT relation tIDENT
;
relation: tEQ
        | tNE
        | tLTE
        | tGTE
        | tLT
        | tGT
;

%%
int main(){
     
     if(yyparse()) {
     printf("ERROR\n");  
     }
     else{
     printf("OK\n");
     }
     
}
