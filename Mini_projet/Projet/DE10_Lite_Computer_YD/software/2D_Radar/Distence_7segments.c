/*
 * "Hello World" example.
 *
 * This example prints 'Hello from Nios II' to the STDOUT stream. It runs on
 * the Nios II 'standard', 'full_featured', 'fast', and 'low_cost' example
 * designs. It runs with or without the MicroC/OS-II RTOS and requires a STDOUT
 * device in your system's hardware.
 * The memory footprint of this hosted application is ~69 kbytes by default
 * using the standard reference design.
 *
 * For a reduced footprint version of this template, and an explanation of how
 * to reduce the memory footprint for a given application, see the
 * "small_hello_world" template.
 *
 */
#include "system.h"
#include "ALTERA_AVALON_PIO_REGS.h"
#include <unistd.h>
#include <stdio.h>
#include <io.h>

int LED_Choisir(int nombre) {
	int hex = 0;

	switch (nombre) {
		case 0: hex = 0x3F; break;
		case 1: hex = 0x06; break;
		case 2: hex = 0x5B; break;
		case 3: hex = 0x4F; break;
		case 4: hex = 0x66; break;
		case 5: hex = 0x6D; break;
		case 6: hex = 0x7D; break;
		case 7: hex = 0x07; break;
		case 8: hex = 0x7F; break;
		case 9: hex = 0x6F; break;
		default: hex = 0x00; 		// Valeur par défaut
	}
	return hex;
}

int main () {
	int centaine, dizaine, unite, reste;

		while (1) {
			int distance = 0;
			/*
			int distance = IORD(TELEMETRE_US_AVALON_0_BASE, 0);

			// Validation de la distance
			if (distance < 0 || distance > 999) {
				printf("Erreur: Valeur de distance invalide: %d\n", distance);
				distance = 0;
			}
			*/

			printf("distance: %d cm \n", distance);

			// Pour afficher la distance sur les afficheurs 7-segments
			centaine = distance/100;	// 百位数
			reste = distance%100;		// 余数
			dizaine = reste/10;			// 十位数
			unite = reste%10;			// 个位数

			//IOWR_ALTERA_AVALON_PIO_DATA(LEDS_BASE + 0,  LED_Choisir(unite));
			//IOWR_ALTERA_AVALON_PIO_DATA(LEDS_BASE + 4,  LED_Choisir(dizaine));
			//IOWR_ALTERA_AVALON_PIO_DATA(LEDS_BASE + 8,  LED_Choisir(centaine));
			//IOWR_ALTERA_AVALON_PIO_DATA(LEDS_BASE + 12, 0x3F); // On ne l'utilise pas pour afficher le chiffre
			//IOWR_ALTERA_AVALON_PIO_DATA(LEDS_BASE + 16, 0x3F); // On ne l'utilise pas pour afficher le chiffre
			//IOWR_ALTERA_AVALON_PIO_DATA(LEDS_BASE + 20, 0x3F); //On ne l'utilise pas pour afficher le chiffre
		  }

	  return 0;
}
