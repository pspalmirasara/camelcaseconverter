%{
#include <stdio.h>
#include "ccc_lib.h"
#include <string.h>

int tam_str;
int k;
char nova_str[200];
char strings_printar[1000][200];
int num_strings = 0;
int tem_erro = 0; //0 - não tem erro, 1 - tem erro
int espacos_inicio = 0; //numero de espacos no inicio para ser printado
int eh_inicio = 1; //sempre que comecar com uma string, essa variavel sera 0
		   //caso contrario, essa variavel sera um e servira para contar o numero de espacos no inicio

%}

UNDERLINE (([a-z]+[_])+[a-z]+)+
CAMELCASE ([A-Z][a-z]*)+

%%


[\ ]+ { //Caso de haver espacos brancos no inicio
	if (eh_inicio == 1){
		espacos_inicio = strlen(yytext);
	}
}

{CAMELCASE}{UNDERLINE} {  //PALAVRAS QUE GERAM ERRO
	eh_inicio = 0;
	tem_erro = 1;
}

{UNDERLINE}{CAMELCASE} {  //PALAVRAS QUE GERAM ERRO
	eh_inicio = 0;
	tem_erro = 1;
}

{UNDERLINE}{CAMELCASE}{UNDERLINE}[!]* {  //PALAVRAS QUE GERAM ERRO
	eh_inicio = 0;
	tem_erro = 1;
}

{UNDERLINE}[\ ]* { //UNDERLINE
	eh_inicio = 0;

	underline_to_camelcase(yytext, nova_str);

	strcpy (strings_printar[num_strings], nova_str);
	num_strings++;

}

[A-Z][a-z]+[\ ]* {  //PALAVRAS QUE NAO PRECISAM SER MODIFICADAS
	eh_inicio = 0;
	strcpy (strings_printar[num_strings], yytext);
	num_strings++;
}

{CAMELCASE}[\ ]* { //CAMELCASE
	eh_inicio = 0;

	camelcase_to_underline(yytext, nova_str);

	strcpy (strings_printar[num_strings], nova_str);
	num_strings++;

}

[a-zA-Z]+[\ ]* {  //PALAVRAS QUE NAO PRECISAM SER MODIFICADAS
	eh_inicio = 0;
	strcpy (strings_printar[num_strings], yytext);
	num_strings++;
}

<<EOF>> {
	if(tem_erro == 0){ //printa as saidas se nao ha erro

		if (num_strings==0){ //Caso de nao haver nenhuma string, ainda eh necessario printar o \n
			printf("\n");
		}

		if (espacos_inicio != 0){
			for(int i =0; i<espacos_inicio; i++){
				printf(" ");
			}
		}
		for (int i = 0; i<num_strings; i++){
			if (i == (num_strings-1)){
				printf("%s\n",strings_printar[i]);
			}else{
				printf("%s",strings_printar[i]);
			}
		}

	}else{ //printa "ERRO" caso haja algum erro
		printf("ERRO\n");
	}
	return 0;
}

[[:space:]]+ ;
[[:^space:]]+ ;
[.\n]*


%%
int main() {
  yylex();
  return 0;
}
