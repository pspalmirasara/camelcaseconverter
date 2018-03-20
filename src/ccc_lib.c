#include <stdio.h>
#include "ccc_lib.h"
#include <string.h>

int tam_str;
int k;

void camelcase_to_underline(char *input, char *output) {

	tam_str = strlen(input);

	//Limpando a string para onde sera copiada
	for (k=0; k<200; k++){
		output[k] = '\0';
	}
	k = 0;

	//Transformando em underline
	input[0] = input[0] + 32;
	for (int i = 0; i<tam_str; i++){
		if ( input[i] >= 65 && input[i] <= 90 ){
			output[k] = '_';
			k++;
			output[k] = input[i] + 32;

		}else{
			output[k] = input[i];
		}
		k++;
	}

  return;
}

void underline_to_camelcase(char *input, char *output) {

	tam_str = strlen(input);

	//Colocando a primeira letra e as depois do underline em uppercase
	input[0] = input[0] - 32;
	for (int i = 0; i<tam_str; i++){
		if (input[i] == '_'){
			input[i+1] = input[i+1] - 32;
		}
	}

	//Limpando a string para onde sera copiada
	for (k=0; k<200; k++){
		output[k] = '\0';
	}
	k = 0;

	//Cria uma nova string sem os underline
	for (int i = 0; i<tam_str; i++){
		if (input[i] != '_'){
			output[k] = input[i];
			k++;
		}	
	}

  return;
}
