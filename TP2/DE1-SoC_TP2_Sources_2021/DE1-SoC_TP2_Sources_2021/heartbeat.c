// "Simple.c"
// Ce programme simple permet de tester les périphériques de votre système
// en lisant les différentes entrées et en écrivant sur les différentes sorties

#include <stdio.h>
#include <stdlib.h>
#include "altera_avalon_pwm.h"
#include "system.h"
#include "unistd.h"

#define PI 3.14

int main() {
  
    float angle = 0;                  // 当前角度（弧度制）
    float duty_cycle = 0;             // 当前占空比
    const float step = 0.05;          // 每次角度增加的步长
    const int max_pwm = 255;          // PWM 占空比最大值（0-255）

    printf("LED Breathing Effect Started\n");

    while (1) {
        // 计算当前角度的正弦值，并转换为 0 到 1 的范围
        duty_cycle = (sin(angle) + 1) / 2.0;  // 将 [-1, 1] 转换为 [0, 1]

        // 将占空比转换为 PWM 值
        int pwm_value = (int)(duty_cycle * max_pwm);

        // 写入 PWM 占空比寄存器
        IOWR_ALTERA_AVALON_PWM_DUTY(AVALON_PWM_INST_BASE, pwm_value);

        // 增加角度，模拟时间推进
        angle += step;
        if (angle >= 2 * PI) {
            angle = 0;  // 重置角度，循环正弦波
        }

        usleep(10000);  // 10 ms 延时
    }

    return 0;
}
