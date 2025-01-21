#include "system.h"
#include "ALTERA_AVALON_PIO_REGS.h"
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <math.h>
#include <io.h>

// Paramètres de l'écran VGA
#define VGA_PIXEL_BASE 0xff203020  // Utilisation de VGA_Subsystem_VGA_Pixel_DMA_BASE
#define SCREEN_WIDTH 160
#define SCREEN_HEIGHT 120

// Définition des valeurs de mesure
#define MAX_ANGLE 180  		// Angle maximum
#define MIN_ANGLE 0    		// Angle minimum
#define MAX_DISTANCE 400	// Distance maximale de mesure

// Délai de 0.05 seconde (50 ms)
#define DELAY_US 50000

// Tableau pour stocker les valeurs historiques de distance (0-180 degrés)
int distance_history[MAX_ANGLE + 1] = {0};

// Définition des couleurs 16 bits (format RGB565)
#define COLOR_WHITE 0xFFFF
#define COLOR_GREEN 0x07E0
#define COLOR_RED   0xF800
#define COLOR_BLUE  0x001F
#define COLOR_BLACK 0x0000

#define DEG_TO_RAD(angle) ((angle) * M_PI / 180.0)

// Afficher la distance actuelle sur les LED
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

// Fonction pour dessiner un pixel
void vga_plot_pixel(int x, int y, uint8_t color) {
    if (x >= 0 && x < SCREEN_WIDTH && y >= 0 && y < SCREEN_HEIGHT) {
        int pixel_address = VGA_PIXEL_BASE + (y * SCREEN_WIDTH + x);
        IOWR_8DIRECT(pixel_address, 0, color);
    }
}

// Initialisation de l'écran VGA
void clear_screen() {
    for (int y = 0; y < SCREEN_HEIGHT; y++) {
        for (int x = 0; x < SCREEN_WIDTH; x++) {
        	vga_plot_pixel(x, y, COLOR_BLACK);  // Définir la couleur en noir
        }
    }
}

// Fonction pour dessiner une ligne (Algorithme de Bresenham)
void vga_draw_line(int x0, int y0, int x1, int y1, uint8_t color) {
    int dx = abs(x1 - x0);
    int dy = abs(y1 - y0);
    int sx = (x0 < x1) ? 1 : -1;
    int sy = (y0 < y1) ? 1 : -1;
    int err = dx - dy;

    while (1) {
        vga_plot_pixel(x0, y0, color);  // Dessiner le pixel actuel
        if (x0 == x1 && y0 == y1) break;  // Atteindre la fin, sortir de la boucle

        int e2 = 2 * err;
        if (e2 > -dy) {
            err -= dy;
            x0 += sx;
        }
        if (e2 < dx) {
            err += dx;
            y0 += sy;
        }
    }
}

// Dessiner la zone de balayage
void draw_scan_line(int angle, int obstacle_distance) {
    int x_center = SCREEN_WIDTH / 2;
    int y_center = SCREEN_HEIGHT - 1;

    double angle_rad = DEG_TO_RAD(angle);
    int x_obstacle = x_center + (int)(obstacle_distance * cos(angle_rad));
    int y_obstacle = y_center - (int)(obstacle_distance * sin(angle_rad));

    int x_max = x_center + (int)(MAX_DISTANCE * cos(angle_rad));
    int y_max = y_center - (int)(MAX_DISTANCE * sin(angle_rad));

    // Dessiner une ligne verte du centre au point d'obstacle
    vga_draw_line(x_center, y_center, x_obstacle, y_obstacle, COLOR_GREEN);

    // Continuer à dessiner une ligne rouge après le point d'obstacle
    vga_draw_line(x_obstacle, y_obstacle, x_max, y_max, COLOR_RED);

    // Dessiner le point d'obstacle en rouge
    vga_plot_pixel(x_obstacle, y_obstacle, COLOR_RED);
}

// Tester l'affichage VGA
void test_vga_display() {
    for (int y = 0; y < SCREEN_HEIGHT; y++) {
        for (int x = 0; x < SCREEN_WIDTH; x++) {
            vga_plot_pixel(x, y, (x % 2 == 0) ? COLOR_BLUE : COLOR_GREEN);
        }
    }
    printf("Test VGA terminé\n");
}

// Fonction principale
int main() {
    printf("Initialisation VGA\n");
    clear_screen();
    printf("Écran effacé\n");

    test_vga_display();
    usleep(DELAY_US*2);
    clear_screen();

    // Essayer de dessiner un pixel unique, si réussi, l'adresse est correcte
    vga_plot_pixel(10, 10, COLOR_RED);
    vga_plot_pixel(11, 11, COLOR_RED);
    vga_plot_pixel(12, 12, COLOR_RED);
    vga_plot_pixel(200, 200, COLOR_RED);
    vga_plot_pixel(100, 100, COLOR_RED);
    printf("Pixel rouge dessiné à (100, 100)\n");

    // Sortie de débogage
    printf("VGA_PIXEL_BASE: 0x%08X\n", VGA_PIXEL_BASE);
    printf("Adresse du pixel: 0x%08X\n", VGA_PIXEL_BASE + (100 * SCREEN_WIDTH + 100) * 2);

    // Vérifier le registre de contrôle du VGA
    volatile int *vga_ctrl = (int *)VGA_PIXEL_BASE;
    printf("Registre de contrôle VGA: 0x%08X\n", *vga_ctrl);

    // Vérifier le registre d'état du VGA
    volatile int *vga_status = (int *)(VGA_PIXEL_BASE + 0x4);
    printf("Registre d'état VGA: 0x%08X\n", *vga_status);

    // Vérifier la résolution du VGA
    volatile int *vga_resolution = (int *)(VGA_PIXEL_BASE + 0x8);
    int screen_x = *vga_resolution & 0xFFFF;
    int screen_y = (*vga_resolution >> 16) & 0xFFFF;
    printf("Résolution VGA: %d x %d\n", screen_x, screen_y);

    int centaine, dizaine, unite, reste;
    int hex3_hex0;  		// Variable pour stocker les 4 affichages en 7 segments
    int angle = 0;          // Angle actuel du servomoteur
    int step = 1;           // Pas de rotation

    while (1) {
        // Écrire le nouvel angle dans l'IP du servomoteur
        IOWR(SERVO_0_BASE, 0, angle);

        // Lire les données de mesure du capteur ultrasonique (en cm)
        int distance = IORD(TELEMETRE_US_AVALON_0_BASE, 0) / 2;

        // Vérifier si la distance est valide
        if (distance < 0 || distance > 400) {
            distance = distance_history[angle];  // Conserver la valeur précédente
        } else {
            distance_history[angle] = distance;  // Stocker la nouvelle valeur
        }

        // Afficher la distance sur les afficheurs 7 segments
        centaine = distance / 100;
        reste = distance % 100;
        dizaine = reste / 10;
        unite = reste % 10;

        // Convertir chaque chiffre en code d'affichage 7 segments et les combiner
        hex3_hex0 = (LED_Choisir(centaine) << 16) |
                    (LED_Choisir(dizaine) << 8) |
                    (LED_Choisir(unite) << 0);

        // Afficher le résultat sur le port HEX3_HEX0
        IOWR_ALTERA_AVALON_PIO_DATA(HEX3_HEX0_BASE, hex3_hex0);

        // Afficher l'angle et la distance actuels sur la console
        printf("%d degré -> %d cm \n", angle, distance);

        // Dessiner les informations sur l'obstacle
        draw_scan_line(angle, distance_history[angle]);

        // Délai de 0.05 seconde
        usleep(DELAY_US);

        // Mettre à jour l'angle : rotation horaire jusqu'à 180 degrés, puis rotation antihoraire jusqu'à 0 degré
        if (angle == MAX_ANGLE) {
            step = -1;
        } else if (angle == MIN_ANGLE) {
            step = 1;
        }
        angle += step;
    }

    return 0;
}