#include <avr/io.h>
#include <avr/interrupt.h>
#include <util/delay.h>

#define PULSE_MIN         100
#define PULSE_MAX         200
#define PULSE_MID         1500

static inline void init_servo(void) {
  TCCR1A |= (1 << WGM11);
  TCCR1B |= (1 << WGM12) | (1 << WGM13);
  TCCR1B |= (1 << CS10);  /* /1 prescaling -- counting in microseconds */
  ICR1 = 4999;                                    /* TOP value = 20ms */
  TCCR1A |= (1 << COM1A1);              /* Direct output on PB1 / OC1A */
  DDRB |= (1 << PB1);                            /* set pin for output */
}

int main (void)
{

  init_servo();

  while(1) {
    OCR1A = PULSE_MIN;
    _delay_ms(500);

    OCR1A = PULSE_MAX;
    _delay_ms(1000);
  }

  return 0;
}
