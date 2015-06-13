#include <avr/io.h>
#include <util/delay.h>

enum {
 BLINK_OFF_MS = 100,
 BLINK_ON_MS = 2000,
};

int main (void)
{
 /* set pin 5 of PORTB for output*/
 DDRB |= _BV(DDB5);

 while(1) {
  /* set pin 5 high to turn led on */
  PORTB |= _BV(PORTB5);
  _delay_ms(BLINK_ON_MS);

  /* set pin 5 low to turn led off */
  PORTB &= ~_BV(PORTB5);
  _delay_ms(BLINK_OFF_MS);
 }

 return 0;
}
