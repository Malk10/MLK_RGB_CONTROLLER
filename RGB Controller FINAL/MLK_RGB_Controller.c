/*MLK RGB Controller
por Arthur Caviquioli, Novembro de 2020
MCU:pic16f628a  clock:20MHz*/

#define Lo(param) param & 0xff;
#define Hi(param) (param >>8) & 0xff;

sbit pwm1 at portb.b0;
sbit pwm2 at portb.b1;
sbit pwm3 at portb.b2;

sbit LCD_RS at RA0_bit;
sbit LCD_EN at RB3_bit;
sbit LCD_D4 at RB4_bit;
sbit LCD_D5 at RB5_bit;
sbit LCD_D6 at RB6_bit;
sbit LCD_D7 at RB7_bit;
sbit LCD_RS_Direction at TRISA0_bit;
sbit LCD_EN_Direction at TRISB3_bit;
sbit LCD_D4_Direction at TRISB4_bit;
sbit LCD_D5_Direction at TRISB5_bit;
sbit LCD_D6_Direction at TRISB6_bit;
sbit LCD_D7_Direction at TRISB7_bit;

const unsigned int  pwm_frec=200;  //Frequencia do PWM
const unsigned long cristal=Clock_kHz();
//5.5 é o fator de correçao do pwm
const float pwm_reg=65536.0 - 5.5 -(cristal*1000.0/(8.0*100.0*pwm_frec)); //calcula  o valor do pwm
unsigned int pwm_ini;
enum casos_pwm{ciclo1_p,ciclo1_n,ciclo2_p,ciclo2_n,ciclo3_p,ciclo3_n};
char pwm1_caso=ciclo1_p;
char pwm2_caso=ciclo2_p;
char pwm3_caso=ciclo3_p;
char pwm1_cont=0,pwm2_cont=0,pwm3_cont=0,ciclo1,ciclo2,ciclo3,ciclo1_,ciclo2_,ciclo3_;
unsigned int counter = 0;
char auxSTR[] = "      ";
bit contador;
char red=0;
char green=0;
char blue=0;
char contadoraux=0;
char contadoraux2=0;
char brilho=100;
char brilhoaux =100;
char brilhopasso=5;
char ciclo=0;
char timer5=0;
char timer4=0;
char menuIndex=0;
char menuindexant=0;
char passoSpeed=5;
char speed=5;
bit fbt4p;
bit fbt4h;
bit fbt5p;
bit fbt5h;
bit f2bt;
bit menuPrinc;
bit fcor;

void Interrpcion() iv 0x0004 ics ICS_AUTO
 {
      if(T0IF_bit)             // Verificar se houve estouro do Timer0
     {
         contadoraux2++;
         counter++;           // Incremente a variável counter
         TMR0 = 0x06;         // Atribui valor inicial ao TMR0
         T0IF_bit = 0x00;     // Zera a flag T0IF
           /*if(counter>7000){
           counter=0;
           //contador++;
         }*/
     }


     if (TMR1IF_bit==1)
     {

        TMR1L=Lo(pwm_ini);
        TMR1H=Hi(pwm_ini);
        TMR1ON_bit=0;  //Para o timer1 para garantir o PWM
        pwm1_cont++;
        pwm2_cont++;
        pwm3_cont++;

      switch (pwm1_caso)
     {
       case ciclo1_p:
                      if (pwm1_cont>=ciclo1)
                       {
                       if (ciclo1!=100) pwm1=0;
                        pwm1_cont=0;
                        ciclo1_=100-ciclo1;
                        pwm1_caso=ciclo1_n;
                       }
                    break;
        case ciclo1_n:
                      if (pwm1_cont>=ciclo1_)
                       {
                      if (ciclo1_!=100) pwm1=1;
                        pwm1_cont=0;
                        pwm1_caso=ciclo1_p;
                      }
                    break;

     } //switch



      switch (pwm2_caso)
     {
       case ciclo2_p:
                      if (pwm2_cont>=ciclo2)
                       {
                      if (ciclo2!=100) pwm2=0;
                         pwm2_cont=0;
                        ciclo2_=100-ciclo2;
                        pwm2_caso=ciclo2_n;
                       }
                    break;

        case ciclo2_n:
                      if (pwm2_cont>=ciclo2_)
                       {
                      if (ciclo2_!=100)  pwm2=1;
                         pwm2_cont=0;
                         pwm2_caso=ciclo2_p;
                       }
                    break;

     } //switch


      switch (pwm3_caso)
     {
       case ciclo3_p:
                      if (pwm3_cont>=ciclo3)
                       {
                      if (ciclo3!=100)  pwm3=0;
                         pwm3_cont=0;
                        ciclo3_=100-ciclo3;
                        pwm3_caso=ciclo3_n;
                       }
                    break;

        case ciclo3_n:
                      if (pwm3_cont>=ciclo3_)
                       {
                       if (ciclo3_!=100) pwm3=1;
                         pwm3_cont=0;
                         pwm3_caso=ciclo3_p;
                       }
                    break;

     } //switch

        TMR1ON_bit=1;  //Dispara o timer1
        TMR1IF_bit=0;
     }

 }


 void readButton(){
         bit faux;
         bit fbt4;
         bit fbt5;
         fbt5p=0;
         fbt5h=0;
         fbt4p=0;
         fbt4h=0;
         f2bt=0;
        //Botao A4
        if(Button(&PORTA,4,1,1)){
          timer4++;
          if(timer4<20){fbt4=1;}

        }
        if(timer4==10){                     //segurado
          fbt4=0;
          fbt4h=1;
          fbt4p=0;
        }
        if(Button(&PORTA,4,1,0)&&fbt4==1){ //presionado
          fbt4=0;
          fbt4p=1;
        }

      if(Button(&PORTA,4,1,0)){ //solto
      timer4=0;
      }

      //Botao A5
        if(Button(&PORTA,5,1,1)){
          timer5++;
          if(timer5<20){fbt5=1;}

        }
        if(timer5==10){                     //segurado
          fbt5=0;
          fbt5h=1;
          fbt5p=0;
        }
        if(Button(&PORTA,5,1,0)&&fbt5==1){ //presionado
          fbt5=0;
          fbt5p=1;
        }

      if(Button(&PORTA,5,1,0)){ //solto
      timer5=0;
      }
      
      if(Button(&PORTA,5,1,1)&&Button(&PORTA,4,1,1)){faux=1;}
      if(Button(&PORTA,5,1,0)&&Button(&PORTA,4,1,0)&&faux==1){
       faux=0;
       fbt4p=0;
       fbt5p=0;
       fbt4h=0;
       fbt4h=0;
       f2bt=1;
      }
}

 void functionButton(){
    if(menuPrinc==1){
        if(fbt4p==1){
         fbt4p=0;
         menuIndex++;
        }
        if(fbt5p==1){
         fbt5p=0;
         menuIndex--;
        }
        if(menuIndex==4){
         menuIndex=0;
        }
        if(menuIndex==255){
         menuIndex=3;
        }
        if(fbt5h==1&&menuindex!=0){
          fbt5h=0;
          menuIndex=5;
        }
        if(fbt4h==1&&(menuIndex==1||(menuindex==2&&fcor==1))){
          fbt4h=0;
          menuIndex=6;
        }
        if(fcor==0 && f2bt==1 &&(menuIndex==2)){
           f2bt=0;
           fcor=1;
        }
        if(fcor==1 && f2bt==1 && (menuIndex==2)){
          f2bt=0;
          fcor=0;
          lcd_out(1,16," ");
        }
    }
  }

 void cicloEffect(char speedint,char max){
   switch(ciclo){
   case 0:
        green+=speedint;
        if(green>=max){ciclo++;}
    break;
    case 1:
        red-=speedint;
        if(red<=speedint){ciclo++;red=0;}
    break;
    case 2:
        blue+=speedint;
        if(blue>=max){ciclo++;}
    break;
    case 3:
        green-=speedint;
        if(green<=speedint){ciclo++;green=0;}
    break;
    case 4:
        red+=speedint;
        if(red>=max){ciclo++;}
    break;
    case 5:
        blue-=speedint;
        if(blue<=speedint){ciclo=0;blue=0;}
    break;
    }
  }
  
 void fadeEffect(char red1, char green1,char blue1){

       if(contador==1){
         if(brilho==0&&fcor==0){
           red=red1;
           green=green1;
           blue=blue1;
         }
         if(brilho>0){
           brilho-=brilhopasso;
           if(brilho>100){brilho=0;}
           delay_ms(25);
          }
          else{delay_ms(125);contador=0;}//mudanca
        }
        if(contador==0&&brilho<brilhoaux){
          brilho+=brilhopasso;
         delay_ms(25);
        }
        else{contador=1;} //mudanca
  }

  char atualizaAux(int index, char aux, char max, char min){
      if(f2bt==1){
       f2bt=0;
       menuIndex=index;
       delay_ms(50);
      }
      if(Button(&PORTA,4,1,1)&&aux<max){
       fbt4p=0;
       if(timer4>5&&aux<max-5){aux+=5;}
       else{aux++;}
      }
      if(Button(&PORTA,5,1,1)&&aux>min){
       fbt5p=0;
       if(timer5>5&&aux>5){aux-=5;}
       else{aux--;}
      }
      inttostr(aux,auxSTR);
      lcd_out(2,1,auxSTR);
      return aux;
  }

 void ajustaBrilho(){
   if(menuindex!=0){
     ciclo1=(red*brilho/255);
     ciclo2=(green*brilho/255);
     ciclo3=(blue*brilho/255);
    }
  }

 void printRGB(){

        inttostr(blue,auxSTR);
        lcd_out(2,11,auxSTR);
        inttostr(green,auxSTR);
        lcd_out(2,7,auxSTR);
        inttostr(red,auxSTR);
        lcd_out(2,3,auxSTR);
        lcd_out(2,1,"RGB:");
  }

  controlMenu(){
      if(menuindex!=menuindexant){
       lcd_cmd(_LCD_CLEAR);
       menuindexant=menuindex;
      }
      switch(menuIndex){
        case 0://off
        menuPrinc=1;
         lcd_out(1,4,"Desligado!");
         ciclo1=0;
         ciclo2=0;
         ciclo3=0;
        break;
        case 1://fixo
        brilho=brilhoaux;
        menuPrinc=1;
        lcd_out(1,5,"Cor fixa");
        printRGB();
        break;
        case 3://ciclo
        menuPrinc=1;
        //lcd_out(1,1,"");
        brilho=brilhoaux;
        lcd_out(1,1,"Ciclo espectral!");
        printRGB();
        cicloEffect(speed,256-speed);
        if(fbt4h==1){fbt4h=0;menuindex=9;}
        break;
        case 2://fade
        menuPrinc=1 ;
        lcd_out(1,5,"Pulsante");
        printRGB();
        fadeEffect(contadoraux,pwm1_cont,contadoraux2);
        if(fcor==1){lcd_out(1,16,"F");}
        break;
        case 5://brilho
        menuPrinc=0 ;
        lcd_out(1,1,"Brilho:");
        brilho=atualizaAux(1,brilho,100,0);
        brilhoaux=brilho;
        brilhopasso=(brilho/20)+1;
        break;
        case 6://red
        menuPrinc=0 ;
        lcd_out(1,1,"Red:");
        red=atualizaAux(7,red,255,0);
        break;
        case 7://green
        menuPrinc=0 ;
        lcd_out(1,1,"Green:");
        green=atualizaAux(8,green,255,0);
        break;
        case 8://blue
        menuPrinc=0 ;
        lcd_out(1,1,"Blue:");
        blue=atualizaAux(1,blue,255,0);
        break;
        case 9:
        menuPrinc=0 ;
        lcd_out(1,1,"Speed:");
        Speed=atualizaAux(3,Speed,255,1);
        passoSpeed=Speed;
        break;
      }
  }

void main() {
  trisa=0b00110000; //pinos A4 e A5 como entradas digitais e o restante como saidas
  trisb=0;
  portb=0;
  INTCON=0b01000000;
  OPTION_REG = 0x82;
  pwm_ini=pwm_reg;
  TMR1L=Lo(pwm_ini);
  TMR1H=Hi(pwm_ini);

  //preescalador = 1
  T1CKPS1_bit=0;
  T1CKPS0_bit=0;

  TMR1IF_bit=0;
  TMR1IE_bit=1;
  TMR1ON_bit=1;
  GIE_bit=1;
  PEIE_bit = 0x01;           // Habilitar a interrupção por periféricos
  T0IE_bit = 0x01;           // Habilitar a interrupção estouro TMR0
  TMR0 = 0x06;

  //Dispara em alto
  pwm1=1;
  pwm2=1;
  pwm3=1;

  ciclo1=0; //Red
  ciclo2=0; //Green
  ciclo3=0; //Blue

  Lcd_Init();
  lcd_cmd(_LCD_CURSOR_OFF) ;

  while(1){
    readButton();
    controlMenu();
    functionButton();
    ajustaBrilho();
    contadoraux++;
  }
}