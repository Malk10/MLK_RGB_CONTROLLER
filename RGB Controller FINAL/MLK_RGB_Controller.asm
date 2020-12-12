
_Interrpcion:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;MLK_RGB_Controller.c,61 :: 		void Interrpcion() iv 0x0004 ics ICS_AUTO
;MLK_RGB_Controller.c,63 :: 		if(T0IF_bit)             // Verificar se houve estouro do Timer0
	BTFSS      T0IF_bit+0, BitPos(T0IF_bit+0)
	GOTO       L_Interrpcion0
;MLK_RGB_Controller.c,65 :: 		contadoraux2++;
	INCF       _contadoraux2+0, 1
;MLK_RGB_Controller.c,66 :: 		counter++;           // Incremente a variável counter
	INCF       _counter+0, 1
	BTFSC      STATUS+0, 2
	INCF       _counter+1, 1
;MLK_RGB_Controller.c,67 :: 		TMR0 = 0x06;         // Atribui valor inicial ao TMR0
	MOVLW      6
	MOVWF      TMR0+0
;MLK_RGB_Controller.c,68 :: 		T0IF_bit = 0x00;     // Zera a flag T0IF
	BCF        T0IF_bit+0, BitPos(T0IF_bit+0)
;MLK_RGB_Controller.c,73 :: 		}
L_Interrpcion0:
;MLK_RGB_Controller.c,76 :: 		if (TMR1IF_bit==1)
	BTFSS      TMR1IF_bit+0, BitPos(TMR1IF_bit+0)
	GOTO       L_Interrpcion1
;MLK_RGB_Controller.c,79 :: 		TMR1L=Lo(pwm_ini);
	MOVLW      255
	ANDWF      _pwm_ini+0, 0
	MOVWF      TMR1L+0
;MLK_RGB_Controller.c,80 :: 		TMR1H=Hi(pwm_ini);
	MOVF       _pwm_ini+1, 0
	MOVWF      R0+0
	CLRF       R0+1
	MOVLW      255
	ANDWF      R0+0, 0
	MOVWF      TMR1H+0
;MLK_RGB_Controller.c,81 :: 		TMR1ON_bit=0;  //Para o timer1 para garantir o PWM
	BCF        TMR1ON_bit+0, BitPos(TMR1ON_bit+0)
;MLK_RGB_Controller.c,82 :: 		pwm1_cont++;
	INCF       _pwm1_cont+0, 1
;MLK_RGB_Controller.c,83 :: 		pwm2_cont++;
	INCF       _pwm2_cont+0, 1
;MLK_RGB_Controller.c,84 :: 		pwm3_cont++;
	INCF       _pwm3_cont+0, 1
;MLK_RGB_Controller.c,86 :: 		switch (pwm1_caso)
	GOTO       L_Interrpcion2
;MLK_RGB_Controller.c,88 :: 		case ciclo1_p:
L_Interrpcion4:
;MLK_RGB_Controller.c,89 :: 		if (pwm1_cont>=ciclo1)
	MOVF       _ciclo1+0, 0
	SUBWF      _pwm1_cont+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_Interrpcion5
;MLK_RGB_Controller.c,91 :: 		if (ciclo1!=100) pwm1=0;
	MOVF       _ciclo1+0, 0
	XORLW      100
	BTFSC      STATUS+0, 2
	GOTO       L_Interrpcion6
	BCF        PORTB+0, 0
L_Interrpcion6:
;MLK_RGB_Controller.c,92 :: 		pwm1_cont=0;
	CLRF       _pwm1_cont+0
;MLK_RGB_Controller.c,93 :: 		ciclo1_=100-ciclo1;
	MOVF       _ciclo1+0, 0
	SUBLW      100
	MOVWF      _ciclo1_+0
;MLK_RGB_Controller.c,94 :: 		pwm1_caso=ciclo1_n;
	MOVLW      1
	MOVWF      _pwm1_caso+0
;MLK_RGB_Controller.c,95 :: 		}
L_Interrpcion5:
;MLK_RGB_Controller.c,96 :: 		break;
	GOTO       L_Interrpcion3
;MLK_RGB_Controller.c,97 :: 		case ciclo1_n:
L_Interrpcion7:
;MLK_RGB_Controller.c,98 :: 		if (pwm1_cont>=ciclo1_)
	MOVF       _ciclo1_+0, 0
	SUBWF      _pwm1_cont+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_Interrpcion8
;MLK_RGB_Controller.c,100 :: 		if (ciclo1_!=100) pwm1=1;
	MOVF       _ciclo1_+0, 0
	XORLW      100
	BTFSC      STATUS+0, 2
	GOTO       L_Interrpcion9
	BSF        PORTB+0, 0
L_Interrpcion9:
;MLK_RGB_Controller.c,101 :: 		pwm1_cont=0;
	CLRF       _pwm1_cont+0
;MLK_RGB_Controller.c,102 :: 		pwm1_caso=ciclo1_p;
	CLRF       _pwm1_caso+0
;MLK_RGB_Controller.c,103 :: 		}
L_Interrpcion8:
;MLK_RGB_Controller.c,104 :: 		break;
	GOTO       L_Interrpcion3
;MLK_RGB_Controller.c,106 :: 		} //switch
L_Interrpcion2:
	MOVF       _pwm1_caso+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_Interrpcion4
	MOVF       _pwm1_caso+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_Interrpcion7
L_Interrpcion3:
;MLK_RGB_Controller.c,110 :: 		switch (pwm2_caso)
	GOTO       L_Interrpcion10
;MLK_RGB_Controller.c,112 :: 		case ciclo2_p:
L_Interrpcion12:
;MLK_RGB_Controller.c,113 :: 		if (pwm2_cont>=ciclo2)
	MOVF       _ciclo2+0, 0
	SUBWF      _pwm2_cont+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_Interrpcion13
;MLK_RGB_Controller.c,115 :: 		if (ciclo2!=100) pwm2=0;
	MOVF       _ciclo2+0, 0
	XORLW      100
	BTFSC      STATUS+0, 2
	GOTO       L_Interrpcion14
	BCF        PORTB+0, 1
L_Interrpcion14:
;MLK_RGB_Controller.c,116 :: 		pwm2_cont=0;
	CLRF       _pwm2_cont+0
;MLK_RGB_Controller.c,117 :: 		ciclo2_=100-ciclo2;
	MOVF       _ciclo2+0, 0
	SUBLW      100
	MOVWF      _ciclo2_+0
;MLK_RGB_Controller.c,118 :: 		pwm2_caso=ciclo2_n;
	MOVLW      3
	MOVWF      _pwm2_caso+0
;MLK_RGB_Controller.c,119 :: 		}
L_Interrpcion13:
;MLK_RGB_Controller.c,120 :: 		break;
	GOTO       L_Interrpcion11
;MLK_RGB_Controller.c,122 :: 		case ciclo2_n:
L_Interrpcion15:
;MLK_RGB_Controller.c,123 :: 		if (pwm2_cont>=ciclo2_)
	MOVF       _ciclo2_+0, 0
	SUBWF      _pwm2_cont+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_Interrpcion16
;MLK_RGB_Controller.c,125 :: 		if (ciclo2_!=100)  pwm2=1;
	MOVF       _ciclo2_+0, 0
	XORLW      100
	BTFSC      STATUS+0, 2
	GOTO       L_Interrpcion17
	BSF        PORTB+0, 1
L_Interrpcion17:
;MLK_RGB_Controller.c,126 :: 		pwm2_cont=0;
	CLRF       _pwm2_cont+0
;MLK_RGB_Controller.c,127 :: 		pwm2_caso=ciclo2_p;
	MOVLW      2
	MOVWF      _pwm2_caso+0
;MLK_RGB_Controller.c,128 :: 		}
L_Interrpcion16:
;MLK_RGB_Controller.c,129 :: 		break;
	GOTO       L_Interrpcion11
;MLK_RGB_Controller.c,131 :: 		} //switch
L_Interrpcion10:
	MOVF       _pwm2_caso+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L_Interrpcion12
	MOVF       _pwm2_caso+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_Interrpcion15
L_Interrpcion11:
;MLK_RGB_Controller.c,134 :: 		switch (pwm3_caso)
	GOTO       L_Interrpcion18
;MLK_RGB_Controller.c,136 :: 		case ciclo3_p:
L_Interrpcion20:
;MLK_RGB_Controller.c,137 :: 		if (pwm3_cont>=ciclo3)
	MOVF       _ciclo3+0, 0
	SUBWF      _pwm3_cont+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_Interrpcion21
;MLK_RGB_Controller.c,139 :: 		if (ciclo3!=100)  pwm3=0;
	MOVF       _ciclo3+0, 0
	XORLW      100
	BTFSC      STATUS+0, 2
	GOTO       L_Interrpcion22
	BCF        PORTB+0, 2
L_Interrpcion22:
;MLK_RGB_Controller.c,140 :: 		pwm3_cont=0;
	CLRF       _pwm3_cont+0
;MLK_RGB_Controller.c,141 :: 		ciclo3_=100-ciclo3;
	MOVF       _ciclo3+0, 0
	SUBLW      100
	MOVWF      _ciclo3_+0
;MLK_RGB_Controller.c,142 :: 		pwm3_caso=ciclo3_n;
	MOVLW      5
	MOVWF      _pwm3_caso+0
;MLK_RGB_Controller.c,143 :: 		}
L_Interrpcion21:
;MLK_RGB_Controller.c,144 :: 		break;
	GOTO       L_Interrpcion19
;MLK_RGB_Controller.c,146 :: 		case ciclo3_n:
L_Interrpcion23:
;MLK_RGB_Controller.c,147 :: 		if (pwm3_cont>=ciclo3_)
	MOVF       _ciclo3_+0, 0
	SUBWF      _pwm3_cont+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_Interrpcion24
;MLK_RGB_Controller.c,149 :: 		if (ciclo3_!=100) pwm3=1;
	MOVF       _ciclo3_+0, 0
	XORLW      100
	BTFSC      STATUS+0, 2
	GOTO       L_Interrpcion25
	BSF        PORTB+0, 2
L_Interrpcion25:
;MLK_RGB_Controller.c,150 :: 		pwm3_cont=0;
	CLRF       _pwm3_cont+0
;MLK_RGB_Controller.c,151 :: 		pwm3_caso=ciclo3_p;
	MOVLW      4
	MOVWF      _pwm3_caso+0
;MLK_RGB_Controller.c,152 :: 		}
L_Interrpcion24:
;MLK_RGB_Controller.c,153 :: 		break;
	GOTO       L_Interrpcion19
;MLK_RGB_Controller.c,155 :: 		} //switch
L_Interrpcion18:
	MOVF       _pwm3_caso+0, 0
	XORLW      4
	BTFSC      STATUS+0, 2
	GOTO       L_Interrpcion20
	MOVF       _pwm3_caso+0, 0
	XORLW      5
	BTFSC      STATUS+0, 2
	GOTO       L_Interrpcion23
L_Interrpcion19:
;MLK_RGB_Controller.c,157 :: 		TMR1ON_bit=1;  //Dispara o timer1
	BSF        TMR1ON_bit+0, BitPos(TMR1ON_bit+0)
;MLK_RGB_Controller.c,158 :: 		TMR1IF_bit=0;
	BCF        TMR1IF_bit+0, BitPos(TMR1IF_bit+0)
;MLK_RGB_Controller.c,159 :: 		}
L_Interrpcion1:
;MLK_RGB_Controller.c,161 :: 		}
L_end_Interrpcion:
L__Interrpcion145:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _Interrpcion

_readButton:

;MLK_RGB_Controller.c,164 :: 		void readButton(){
;MLK_RGB_Controller.c,168 :: 		fbt5p=0;
	BCF        _fbt5p+0, BitPos(_fbt5p+0)
;MLK_RGB_Controller.c,169 :: 		fbt5h=0;
	BCF        _fbt5h+0, BitPos(_fbt5h+0)
;MLK_RGB_Controller.c,170 :: 		fbt4p=0;
	BCF        _fbt4p+0, BitPos(_fbt4p+0)
;MLK_RGB_Controller.c,171 :: 		fbt4h=0;
	BCF        _fbt4h+0, BitPos(_fbt4h+0)
;MLK_RGB_Controller.c,172 :: 		f2bt=0;
	BCF        _f2bt+0, BitPos(_f2bt+0)
;MLK_RGB_Controller.c,174 :: 		if(Button(&PORTA,4,1,1)){
	MOVLW      PORTA+0
	MOVWF      FARG_Button_port+0
	MOVLW      4
	MOVWF      FARG_Button_pin+0
	MOVLW      1
	MOVWF      FARG_Button_time_ms+0
	MOVLW      1
	MOVWF      FARG_Button_active_state+0
	CALL       _Button+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_readButton26
;MLK_RGB_Controller.c,175 :: 		timer4++;
	INCF       _timer4+0, 1
;MLK_RGB_Controller.c,176 :: 		if(timer4<20){fbt4=1;}
	MOVLW      20
	SUBWF      _timer4+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_readButton27
	BSF        readButton_fbt4_L0+0, BitPos(readButton_fbt4_L0+0)
L_readButton27:
;MLK_RGB_Controller.c,178 :: 		}
L_readButton26:
;MLK_RGB_Controller.c,179 :: 		if(timer4==10){                     //segurado
	MOVF       _timer4+0, 0
	XORLW      10
	BTFSS      STATUS+0, 2
	GOTO       L_readButton28
;MLK_RGB_Controller.c,180 :: 		fbt4=0;
	BCF        readButton_fbt4_L0+0, BitPos(readButton_fbt4_L0+0)
;MLK_RGB_Controller.c,181 :: 		fbt4h=1;
	BSF        _fbt4h+0, BitPos(_fbt4h+0)
;MLK_RGB_Controller.c,182 :: 		fbt4p=0;
	BCF        _fbt4p+0, BitPos(_fbt4p+0)
;MLK_RGB_Controller.c,183 :: 		}
L_readButton28:
;MLK_RGB_Controller.c,184 :: 		if(Button(&PORTA,4,1,0)&&fbt4==1){ //presionado
	MOVLW      PORTA+0
	MOVWF      FARG_Button_port+0
	MOVLW      4
	MOVWF      FARG_Button_pin+0
	MOVLW      1
	MOVWF      FARG_Button_time_ms+0
	CLRF       FARG_Button_active_state+0
	CALL       _Button+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_readButton31
	BTFSS      readButton_fbt4_L0+0, BitPos(readButton_fbt4_L0+0)
	GOTO       L_readButton31
L__readButton131:
;MLK_RGB_Controller.c,185 :: 		fbt4=0;
	BCF        readButton_fbt4_L0+0, BitPos(readButton_fbt4_L0+0)
;MLK_RGB_Controller.c,186 :: 		fbt4p=1;
	BSF        _fbt4p+0, BitPos(_fbt4p+0)
;MLK_RGB_Controller.c,187 :: 		}
L_readButton31:
;MLK_RGB_Controller.c,189 :: 		if(Button(&PORTA,4,1,0)){ //solto
	MOVLW      PORTA+0
	MOVWF      FARG_Button_port+0
	MOVLW      4
	MOVWF      FARG_Button_pin+0
	MOVLW      1
	MOVWF      FARG_Button_time_ms+0
	CLRF       FARG_Button_active_state+0
	CALL       _Button+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_readButton32
;MLK_RGB_Controller.c,190 :: 		timer4=0;
	CLRF       _timer4+0
;MLK_RGB_Controller.c,191 :: 		}
L_readButton32:
;MLK_RGB_Controller.c,194 :: 		if(Button(&PORTA,5,1,1)){
	MOVLW      PORTA+0
	MOVWF      FARG_Button_port+0
	MOVLW      5
	MOVWF      FARG_Button_pin+0
	MOVLW      1
	MOVWF      FARG_Button_time_ms+0
	MOVLW      1
	MOVWF      FARG_Button_active_state+0
	CALL       _Button+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_readButton33
;MLK_RGB_Controller.c,195 :: 		timer5++;
	INCF       _timer5+0, 1
;MLK_RGB_Controller.c,196 :: 		if(timer5<20){fbt5=1;}
	MOVLW      20
	SUBWF      _timer5+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_readButton34
	BSF        readButton_fbt5_L0+0, BitPos(readButton_fbt5_L0+0)
L_readButton34:
;MLK_RGB_Controller.c,198 :: 		}
L_readButton33:
;MLK_RGB_Controller.c,199 :: 		if(timer5==10){                     //segurado
	MOVF       _timer5+0, 0
	XORLW      10
	BTFSS      STATUS+0, 2
	GOTO       L_readButton35
;MLK_RGB_Controller.c,200 :: 		fbt5=0;
	BCF        readButton_fbt5_L0+0, BitPos(readButton_fbt5_L0+0)
;MLK_RGB_Controller.c,201 :: 		fbt5h=1;
	BSF        _fbt5h+0, BitPos(_fbt5h+0)
;MLK_RGB_Controller.c,202 :: 		fbt5p=0;
	BCF        _fbt5p+0, BitPos(_fbt5p+0)
;MLK_RGB_Controller.c,203 :: 		}
L_readButton35:
;MLK_RGB_Controller.c,204 :: 		if(Button(&PORTA,5,1,0)&&fbt5==1){ //presionado
	MOVLW      PORTA+0
	MOVWF      FARG_Button_port+0
	MOVLW      5
	MOVWF      FARG_Button_pin+0
	MOVLW      1
	MOVWF      FARG_Button_time_ms+0
	CLRF       FARG_Button_active_state+0
	CALL       _Button+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_readButton38
	BTFSS      readButton_fbt5_L0+0, BitPos(readButton_fbt5_L0+0)
	GOTO       L_readButton38
L__readButton130:
;MLK_RGB_Controller.c,205 :: 		fbt5=0;
	BCF        readButton_fbt5_L0+0, BitPos(readButton_fbt5_L0+0)
;MLK_RGB_Controller.c,206 :: 		fbt5p=1;
	BSF        _fbt5p+0, BitPos(_fbt5p+0)
;MLK_RGB_Controller.c,207 :: 		}
L_readButton38:
;MLK_RGB_Controller.c,209 :: 		if(Button(&PORTA,5,1,0)){ //solto
	MOVLW      PORTA+0
	MOVWF      FARG_Button_port+0
	MOVLW      5
	MOVWF      FARG_Button_pin+0
	MOVLW      1
	MOVWF      FARG_Button_time_ms+0
	CLRF       FARG_Button_active_state+0
	CALL       _Button+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_readButton39
;MLK_RGB_Controller.c,210 :: 		timer5=0;
	CLRF       _timer5+0
;MLK_RGB_Controller.c,211 :: 		}
L_readButton39:
;MLK_RGB_Controller.c,213 :: 		if(Button(&PORTA,5,1,1)&&Button(&PORTA,4,1,1)){faux=1;}
	MOVLW      PORTA+0
	MOVWF      FARG_Button_port+0
	MOVLW      5
	MOVWF      FARG_Button_pin+0
	MOVLW      1
	MOVWF      FARG_Button_time_ms+0
	MOVLW      1
	MOVWF      FARG_Button_active_state+0
	CALL       _Button+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_readButton42
	MOVLW      PORTA+0
	MOVWF      FARG_Button_port+0
	MOVLW      4
	MOVWF      FARG_Button_pin+0
	MOVLW      1
	MOVWF      FARG_Button_time_ms+0
	MOVLW      1
	MOVWF      FARG_Button_active_state+0
	CALL       _Button+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_readButton42
L__readButton129:
	BSF        readButton_faux_L0+0, BitPos(readButton_faux_L0+0)
L_readButton42:
;MLK_RGB_Controller.c,214 :: 		if(Button(&PORTA,5,1,0)&&Button(&PORTA,4,1,0)&&faux==1){
	MOVLW      PORTA+0
	MOVWF      FARG_Button_port+0
	MOVLW      5
	MOVWF      FARG_Button_pin+0
	MOVLW      1
	MOVWF      FARG_Button_time_ms+0
	CLRF       FARG_Button_active_state+0
	CALL       _Button+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_readButton45
	MOVLW      PORTA+0
	MOVWF      FARG_Button_port+0
	MOVLW      4
	MOVWF      FARG_Button_pin+0
	MOVLW      1
	MOVWF      FARG_Button_time_ms+0
	CLRF       FARG_Button_active_state+0
	CALL       _Button+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_readButton45
	BTFSS      readButton_faux_L0+0, BitPos(readButton_faux_L0+0)
	GOTO       L_readButton45
L__readButton128:
;MLK_RGB_Controller.c,215 :: 		faux=0;
	BCF        readButton_faux_L0+0, BitPos(readButton_faux_L0+0)
;MLK_RGB_Controller.c,216 :: 		fbt4p=0;
	BCF        _fbt4p+0, BitPos(_fbt4p+0)
;MLK_RGB_Controller.c,217 :: 		fbt5p=0;
	BCF        _fbt5p+0, BitPos(_fbt5p+0)
;MLK_RGB_Controller.c,218 :: 		fbt4h=0;
	BCF        _fbt4h+0, BitPos(_fbt4h+0)
;MLK_RGB_Controller.c,219 :: 		fbt4h=0;
	BCF        _fbt4h+0, BitPos(_fbt4h+0)
;MLK_RGB_Controller.c,220 :: 		f2bt=1;
	BSF        _f2bt+0, BitPos(_f2bt+0)
;MLK_RGB_Controller.c,221 :: 		}
L_readButton45:
;MLK_RGB_Controller.c,222 :: 		}
L_end_readButton:
	RETURN
; end of _readButton

_functionButton:

;MLK_RGB_Controller.c,224 :: 		void functionButton(){
;MLK_RGB_Controller.c,225 :: 		if(menuPrinc==1){
	BTFSS      _menuPrinc+0, BitPos(_menuPrinc+0)
	GOTO       L_functionButton46
;MLK_RGB_Controller.c,226 :: 		if(fbt4p==1){
	BTFSS      _fbt4p+0, BitPos(_fbt4p+0)
	GOTO       L_functionButton47
;MLK_RGB_Controller.c,227 :: 		fbt4p=0;
	BCF        _fbt4p+0, BitPos(_fbt4p+0)
;MLK_RGB_Controller.c,228 :: 		menuIndex++;
	INCF       _menuIndex+0, 1
;MLK_RGB_Controller.c,229 :: 		}
L_functionButton47:
;MLK_RGB_Controller.c,230 :: 		if(fbt5p==1){
	BTFSS      _fbt5p+0, BitPos(_fbt5p+0)
	GOTO       L_functionButton48
;MLK_RGB_Controller.c,231 :: 		fbt5p=0;
	BCF        _fbt5p+0, BitPos(_fbt5p+0)
;MLK_RGB_Controller.c,232 :: 		menuIndex--;
	DECF       _menuIndex+0, 1
;MLK_RGB_Controller.c,233 :: 		}
L_functionButton48:
;MLK_RGB_Controller.c,234 :: 		if(menuIndex==4){
	MOVF       _menuIndex+0, 0
	XORLW      4
	BTFSS      STATUS+0, 2
	GOTO       L_functionButton49
;MLK_RGB_Controller.c,235 :: 		menuIndex=0;
	CLRF       _menuIndex+0
;MLK_RGB_Controller.c,236 :: 		}
L_functionButton49:
;MLK_RGB_Controller.c,237 :: 		if(menuIndex==255){
	MOVF       _menuIndex+0, 0
	XORLW      255
	BTFSS      STATUS+0, 2
	GOTO       L_functionButton50
;MLK_RGB_Controller.c,238 :: 		menuIndex=3;
	MOVLW      3
	MOVWF      _menuIndex+0
;MLK_RGB_Controller.c,239 :: 		}
L_functionButton50:
;MLK_RGB_Controller.c,240 :: 		if(fbt5h==1&&menuindex!=0){
	BTFSS      _fbt5h+0, BitPos(_fbt5h+0)
	GOTO       L_functionButton53
	MOVF       _menuIndex+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_functionButton53
L__functionButton137:
;MLK_RGB_Controller.c,241 :: 		fbt5h=0;
	BCF        _fbt5h+0, BitPos(_fbt5h+0)
;MLK_RGB_Controller.c,242 :: 		menuIndex=5;
	MOVLW      5
	MOVWF      _menuIndex+0
;MLK_RGB_Controller.c,243 :: 		}
L_functionButton53:
;MLK_RGB_Controller.c,244 :: 		if(fbt4h==1&&(menuIndex==1||(menuindex==2&&fcor==1))){
	BTFSS      _fbt4h+0, BitPos(_fbt4h+0)
	GOTO       L_functionButton60
	MOVF       _menuIndex+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L__functionButton135
	MOVF       _menuIndex+0, 0
	XORLW      2
	BTFSS      STATUS+0, 2
	GOTO       L__functionButton136
	BTFSS      _fcor+0, BitPos(_fcor+0)
	GOTO       L__functionButton136
	GOTO       L__functionButton135
L__functionButton136:
	GOTO       L_functionButton60
L__functionButton135:
L__functionButton134:
;MLK_RGB_Controller.c,245 :: 		fbt4h=0;
	BCF        _fbt4h+0, BitPos(_fbt4h+0)
;MLK_RGB_Controller.c,246 :: 		menuIndex=6;
	MOVLW      6
	MOVWF      _menuIndex+0
;MLK_RGB_Controller.c,247 :: 		}
L_functionButton60:
;MLK_RGB_Controller.c,248 :: 		if(fcor==0 && f2bt==1 &&(menuIndex==2)){
	BTFSC      _fcor+0, BitPos(_fcor+0)
	GOTO       L_functionButton63
	BTFSS      _f2bt+0, BitPos(_f2bt+0)
	GOTO       L_functionButton63
	MOVF       _menuIndex+0, 0
	XORLW      2
	BTFSS      STATUS+0, 2
	GOTO       L_functionButton63
L__functionButton133:
;MLK_RGB_Controller.c,249 :: 		f2bt=0;
	BCF        _f2bt+0, BitPos(_f2bt+0)
;MLK_RGB_Controller.c,250 :: 		fcor=1;
	BSF        _fcor+0, BitPos(_fcor+0)
;MLK_RGB_Controller.c,251 :: 		}
L_functionButton63:
;MLK_RGB_Controller.c,252 :: 		if(fcor==1 && f2bt==1 && (menuIndex==2)){
	BTFSS      _fcor+0, BitPos(_fcor+0)
	GOTO       L_functionButton66
	BTFSS      _f2bt+0, BitPos(_f2bt+0)
	GOTO       L_functionButton66
	MOVF       _menuIndex+0, 0
	XORLW      2
	BTFSS      STATUS+0, 2
	GOTO       L_functionButton66
L__functionButton132:
;MLK_RGB_Controller.c,253 :: 		f2bt=0;
	BCF        _f2bt+0, BitPos(_f2bt+0)
;MLK_RGB_Controller.c,254 :: 		fcor=0;
	BCF        _fcor+0, BitPos(_fcor+0)
;MLK_RGB_Controller.c,255 :: 		lcd_out(1,16," ");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      16
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_MLK_RGB_Controller+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MLK_RGB_Controller.c,256 :: 		}
L_functionButton66:
;MLK_RGB_Controller.c,257 :: 		}
L_functionButton46:
;MLK_RGB_Controller.c,258 :: 		}
L_end_functionButton:
	RETURN
; end of _functionButton

_cicloEffect:

;MLK_RGB_Controller.c,260 :: 		void cicloEffect(char speedint,char max){
;MLK_RGB_Controller.c,261 :: 		switch(ciclo){
	GOTO       L_cicloEffect67
;MLK_RGB_Controller.c,262 :: 		case 0:
L_cicloEffect69:
;MLK_RGB_Controller.c,263 :: 		green+=speedint;
	MOVF       FARG_cicloEffect_speedint+0, 0
	ADDWF      _green+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	MOVWF      _green+0
;MLK_RGB_Controller.c,264 :: 		if(green>=max){ciclo++;}
	MOVF       FARG_cicloEffect_max+0, 0
	SUBWF      R1+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_cicloEffect70
	INCF       _ciclo+0, 1
L_cicloEffect70:
;MLK_RGB_Controller.c,265 :: 		break;
	GOTO       L_cicloEffect68
;MLK_RGB_Controller.c,266 :: 		case 1:
L_cicloEffect71:
;MLK_RGB_Controller.c,267 :: 		red-=speedint;
	MOVF       FARG_cicloEffect_speedint+0, 0
	SUBWF      _red+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	MOVWF      _red+0
;MLK_RGB_Controller.c,268 :: 		if(red<=speedint){ciclo++;red=0;}
	MOVF       R1+0, 0
	SUBWF      FARG_cicloEffect_speedint+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_cicloEffect72
	INCF       _ciclo+0, 1
	CLRF       _red+0
L_cicloEffect72:
;MLK_RGB_Controller.c,269 :: 		break;
	GOTO       L_cicloEffect68
;MLK_RGB_Controller.c,270 :: 		case 2:
L_cicloEffect73:
;MLK_RGB_Controller.c,271 :: 		blue+=speedint;
	MOVF       FARG_cicloEffect_speedint+0, 0
	ADDWF      _blue+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	MOVWF      _blue+0
;MLK_RGB_Controller.c,272 :: 		if(blue>=max){ciclo++;}
	MOVF       FARG_cicloEffect_max+0, 0
	SUBWF      R1+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_cicloEffect74
	INCF       _ciclo+0, 1
L_cicloEffect74:
;MLK_RGB_Controller.c,273 :: 		break;
	GOTO       L_cicloEffect68
;MLK_RGB_Controller.c,274 :: 		case 3:
L_cicloEffect75:
;MLK_RGB_Controller.c,275 :: 		green-=speedint;
	MOVF       FARG_cicloEffect_speedint+0, 0
	SUBWF      _green+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	MOVWF      _green+0
;MLK_RGB_Controller.c,276 :: 		if(green<=speedint){ciclo++;green=0;}
	MOVF       R1+0, 0
	SUBWF      FARG_cicloEffect_speedint+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_cicloEffect76
	INCF       _ciclo+0, 1
	CLRF       _green+0
L_cicloEffect76:
;MLK_RGB_Controller.c,277 :: 		break;
	GOTO       L_cicloEffect68
;MLK_RGB_Controller.c,278 :: 		case 4:
L_cicloEffect77:
;MLK_RGB_Controller.c,279 :: 		red+=speedint;
	MOVF       FARG_cicloEffect_speedint+0, 0
	ADDWF      _red+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	MOVWF      _red+0
;MLK_RGB_Controller.c,280 :: 		if(red>=max){ciclo++;}
	MOVF       FARG_cicloEffect_max+0, 0
	SUBWF      R1+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_cicloEffect78
	INCF       _ciclo+0, 1
L_cicloEffect78:
;MLK_RGB_Controller.c,281 :: 		break;
	GOTO       L_cicloEffect68
;MLK_RGB_Controller.c,282 :: 		case 5:
L_cicloEffect79:
;MLK_RGB_Controller.c,283 :: 		blue-=speedint;
	MOVF       FARG_cicloEffect_speedint+0, 0
	SUBWF      _blue+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	MOVWF      _blue+0
;MLK_RGB_Controller.c,284 :: 		if(blue<=speedint){ciclo=0;blue=0;}
	MOVF       R1+0, 0
	SUBWF      FARG_cicloEffect_speedint+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_cicloEffect80
	CLRF       _ciclo+0
	CLRF       _blue+0
L_cicloEffect80:
;MLK_RGB_Controller.c,285 :: 		break;
	GOTO       L_cicloEffect68
;MLK_RGB_Controller.c,286 :: 		}
L_cicloEffect67:
	MOVF       _ciclo+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_cicloEffect69
	MOVF       _ciclo+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_cicloEffect71
	MOVF       _ciclo+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L_cicloEffect73
	MOVF       _ciclo+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_cicloEffect75
	MOVF       _ciclo+0, 0
	XORLW      4
	BTFSC      STATUS+0, 2
	GOTO       L_cicloEffect77
	MOVF       _ciclo+0, 0
	XORLW      5
	BTFSC      STATUS+0, 2
	GOTO       L_cicloEffect79
L_cicloEffect68:
;MLK_RGB_Controller.c,287 :: 		}
L_end_cicloEffect:
	RETURN
; end of _cicloEffect

_fadeEffect:

;MLK_RGB_Controller.c,289 :: 		void fadeEffect(char red1, char green1,char blue1){
;MLK_RGB_Controller.c,291 :: 		if(contador==1){
	BTFSS      _contador+0, BitPos(_contador+0)
	GOTO       L_fadeEffect81
;MLK_RGB_Controller.c,292 :: 		if(brilho==0&&fcor==0){
	MOVF       _brilho+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_fadeEffect84
	BTFSC      _fcor+0, BitPos(_fcor+0)
	GOTO       L_fadeEffect84
L__fadeEffect139:
;MLK_RGB_Controller.c,293 :: 		red=red1;
	MOVF       FARG_fadeEffect_red1+0, 0
	MOVWF      _red+0
;MLK_RGB_Controller.c,294 :: 		green=green1;
	MOVF       FARG_fadeEffect_green1+0, 0
	MOVWF      _green+0
;MLK_RGB_Controller.c,295 :: 		blue=blue1;
	MOVF       FARG_fadeEffect_blue1+0, 0
	MOVWF      _blue+0
;MLK_RGB_Controller.c,296 :: 		}
L_fadeEffect84:
;MLK_RGB_Controller.c,297 :: 		if(brilho>0){
	MOVF       _brilho+0, 0
	SUBLW      0
	BTFSC      STATUS+0, 0
	GOTO       L_fadeEffect85
;MLK_RGB_Controller.c,298 :: 		brilho-=brilhopasso;
	MOVF       _brilhopasso+0, 0
	SUBWF      _brilho+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	MOVWF      _brilho+0
;MLK_RGB_Controller.c,299 :: 		if(brilho>100){brilho=0;}
	MOVF       R1+0, 0
	SUBLW      100
	BTFSC      STATUS+0, 0
	GOTO       L_fadeEffect86
	CLRF       _brilho+0
L_fadeEffect86:
;MLK_RGB_Controller.c,300 :: 		delay_ms(25);
	MOVLW      163
	MOVWF      R12+0
	MOVLW      85
	MOVWF      R13+0
L_fadeEffect87:
	DECFSZ     R13+0, 1
	GOTO       L_fadeEffect87
	DECFSZ     R12+0, 1
	GOTO       L_fadeEffect87
;MLK_RGB_Controller.c,301 :: 		}
	GOTO       L_fadeEffect88
L_fadeEffect85:
;MLK_RGB_Controller.c,302 :: 		else{delay_ms(125);contador=0;}//mudanca
	MOVLW      4
	MOVWF      R11+0
	MOVLW      44
	MOVWF      R12+0
	MOVLW      171
	MOVWF      R13+0
L_fadeEffect89:
	DECFSZ     R13+0, 1
	GOTO       L_fadeEffect89
	DECFSZ     R12+0, 1
	GOTO       L_fadeEffect89
	DECFSZ     R11+0, 1
	GOTO       L_fadeEffect89
	NOP
	NOP
	BCF        _contador+0, BitPos(_contador+0)
L_fadeEffect88:
;MLK_RGB_Controller.c,303 :: 		}
L_fadeEffect81:
;MLK_RGB_Controller.c,304 :: 		if(contador==0&&brilho<brilhoaux){
	BTFSC      _contador+0, BitPos(_contador+0)
	GOTO       L_fadeEffect92
	MOVF       _brilhoaux+0, 0
	SUBWF      _brilho+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_fadeEffect92
L__fadeEffect138:
;MLK_RGB_Controller.c,305 :: 		brilho+=brilhopasso;
	MOVF       _brilhopasso+0, 0
	ADDWF      _brilho+0, 1
;MLK_RGB_Controller.c,306 :: 		delay_ms(25);
	MOVLW      163
	MOVWF      R12+0
	MOVLW      85
	MOVWF      R13+0
L_fadeEffect93:
	DECFSZ     R13+0, 1
	GOTO       L_fadeEffect93
	DECFSZ     R12+0, 1
	GOTO       L_fadeEffect93
;MLK_RGB_Controller.c,307 :: 		}
	GOTO       L_fadeEffect94
L_fadeEffect92:
;MLK_RGB_Controller.c,308 :: 		else{contador=1;} //mudanca
	BSF        _contador+0, BitPos(_contador+0)
L_fadeEffect94:
;MLK_RGB_Controller.c,309 :: 		}
L_end_fadeEffect:
	RETURN
; end of _fadeEffect

_atualizaAux:

;MLK_RGB_Controller.c,311 :: 		char atualizaAux(int index, char aux, char max, char min){
;MLK_RGB_Controller.c,312 :: 		if(f2bt==1){
	BTFSS      _f2bt+0, BitPos(_f2bt+0)
	GOTO       L_atualizaAux95
;MLK_RGB_Controller.c,313 :: 		f2bt=0;
	BCF        _f2bt+0, BitPos(_f2bt+0)
;MLK_RGB_Controller.c,314 :: 		menuIndex=index;
	MOVF       FARG_atualizaAux_index+0, 0
	MOVWF      _menuIndex+0
;MLK_RGB_Controller.c,315 :: 		delay_ms(50);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      69
	MOVWF      R12+0
	MOVLW      169
	MOVWF      R13+0
L_atualizaAux96:
	DECFSZ     R13+0, 1
	GOTO       L_atualizaAux96
	DECFSZ     R12+0, 1
	GOTO       L_atualizaAux96
	DECFSZ     R11+0, 1
	GOTO       L_atualizaAux96
	NOP
	NOP
;MLK_RGB_Controller.c,316 :: 		}
L_atualizaAux95:
;MLK_RGB_Controller.c,317 :: 		if(Button(&PORTA,4,1,1)&&aux<max){
	MOVLW      PORTA+0
	MOVWF      FARG_Button_port+0
	MOVLW      4
	MOVWF      FARG_Button_pin+0
	MOVLW      1
	MOVWF      FARG_Button_time_ms+0
	MOVLW      1
	MOVWF      FARG_Button_active_state+0
	CALL       _Button+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_atualizaAux99
	MOVF       FARG_atualizaAux_max+0, 0
	SUBWF      FARG_atualizaAux_aux+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_atualizaAux99
L__atualizaAux143:
;MLK_RGB_Controller.c,318 :: 		fbt4p=0;
	BCF        _fbt4p+0, BitPos(_fbt4p+0)
;MLK_RGB_Controller.c,319 :: 		if(timer4>5&&aux<max-5){aux+=5;}
	MOVF       _timer4+0, 0
	SUBLW      5
	BTFSC      STATUS+0, 0
	GOTO       L_atualizaAux102
	MOVLW      5
	SUBWF      FARG_atualizaAux_max+0, 0
	MOVWF      R1+0
	CLRF       R1+1
	BTFSS      STATUS+0, 0
	DECF       R1+1, 1
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      R1+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__atualizaAux151
	MOVF       R1+0, 0
	SUBWF      FARG_atualizaAux_aux+0, 0
L__atualizaAux151:
	BTFSC      STATUS+0, 0
	GOTO       L_atualizaAux102
L__atualizaAux142:
	MOVLW      5
	ADDWF      FARG_atualizaAux_aux+0, 1
	GOTO       L_atualizaAux103
L_atualizaAux102:
;MLK_RGB_Controller.c,320 :: 		else{aux++;}
	INCF       FARG_atualizaAux_aux+0, 1
L_atualizaAux103:
;MLK_RGB_Controller.c,321 :: 		}
L_atualizaAux99:
;MLK_RGB_Controller.c,322 :: 		if(Button(&PORTA,5,1,1)&&aux>min){
	MOVLW      PORTA+0
	MOVWF      FARG_Button_port+0
	MOVLW      5
	MOVWF      FARG_Button_pin+0
	MOVLW      1
	MOVWF      FARG_Button_time_ms+0
	MOVLW      1
	MOVWF      FARG_Button_active_state+0
	CALL       _Button+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_atualizaAux106
	MOVF       FARG_atualizaAux_aux+0, 0
	SUBWF      FARG_atualizaAux_min+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_atualizaAux106
L__atualizaAux141:
;MLK_RGB_Controller.c,323 :: 		fbt5p=0;
	BCF        _fbt5p+0, BitPos(_fbt5p+0)
;MLK_RGB_Controller.c,324 :: 		if(timer5>5&&aux>5){aux-=5;}
	MOVF       _timer5+0, 0
	SUBLW      5
	BTFSC      STATUS+0, 0
	GOTO       L_atualizaAux109
	MOVF       FARG_atualizaAux_aux+0, 0
	SUBLW      5
	BTFSC      STATUS+0, 0
	GOTO       L_atualizaAux109
L__atualizaAux140:
	MOVLW      5
	SUBWF      FARG_atualizaAux_aux+0, 1
	GOTO       L_atualizaAux110
L_atualizaAux109:
;MLK_RGB_Controller.c,325 :: 		else{aux--;}
	DECF       FARG_atualizaAux_aux+0, 1
L_atualizaAux110:
;MLK_RGB_Controller.c,326 :: 		}
L_atualizaAux106:
;MLK_RGB_Controller.c,327 :: 		inttostr(aux,auxSTR);
	MOVF       FARG_atualizaAux_aux+0, 0
	MOVWF      FARG_IntToStr_input+0
	CLRF       FARG_IntToStr_input+1
	MOVLW      _auxSTR+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;MLK_RGB_Controller.c,328 :: 		lcd_out(2,1,auxSTR);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _auxSTR+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MLK_RGB_Controller.c,329 :: 		return aux;
	MOVF       FARG_atualizaAux_aux+0, 0
	MOVWF      R0+0
;MLK_RGB_Controller.c,330 :: 		}
L_end_atualizaAux:
	RETURN
; end of _atualizaAux

_ajustaBrilho:

;MLK_RGB_Controller.c,332 :: 		void ajustaBrilho(){
;MLK_RGB_Controller.c,333 :: 		if(menuindex!=0){
	MOVF       _menuIndex+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_ajustaBrilho111
;MLK_RGB_Controller.c,334 :: 		ciclo1=(red*brilho/255);
	MOVF       _red+0, 0
	MOVWF      R0+0
	MOVF       _brilho+0, 0
	MOVWF      R4+0
	CALL       _Mul_8X8_U+0
	MOVLW      255
	MOVWF      R4+0
	CLRF       R4+1
	CALL       _Div_16x16_S+0
	MOVF       R0+0, 0
	MOVWF      _ciclo1+0
;MLK_RGB_Controller.c,335 :: 		ciclo2=(green*brilho/255);
	MOVF       _green+0, 0
	MOVWF      R0+0
	MOVF       _brilho+0, 0
	MOVWF      R4+0
	CALL       _Mul_8X8_U+0
	MOVLW      255
	MOVWF      R4+0
	CLRF       R4+1
	CALL       _Div_16x16_S+0
	MOVF       R0+0, 0
	MOVWF      _ciclo2+0
;MLK_RGB_Controller.c,336 :: 		ciclo3=(blue*brilho/255);
	MOVF       _blue+0, 0
	MOVWF      R0+0
	MOVF       _brilho+0, 0
	MOVWF      R4+0
	CALL       _Mul_8X8_U+0
	MOVLW      255
	MOVWF      R4+0
	CLRF       R4+1
	CALL       _Div_16x16_S+0
	MOVF       R0+0, 0
	MOVWF      _ciclo3+0
;MLK_RGB_Controller.c,337 :: 		}
L_ajustaBrilho111:
;MLK_RGB_Controller.c,338 :: 		}
L_end_ajustaBrilho:
	RETURN
; end of _ajustaBrilho

_printRGB:

;MLK_RGB_Controller.c,340 :: 		void printRGB(){
;MLK_RGB_Controller.c,342 :: 		inttostr(blue,auxSTR);
	MOVF       _blue+0, 0
	MOVWF      FARG_IntToStr_input+0
	CLRF       FARG_IntToStr_input+1
	MOVLW      _auxSTR+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;MLK_RGB_Controller.c,343 :: 		lcd_out(2,11,auxSTR);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      11
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _auxSTR+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MLK_RGB_Controller.c,344 :: 		inttostr(green,auxSTR);
	MOVF       _green+0, 0
	MOVWF      FARG_IntToStr_input+0
	CLRF       FARG_IntToStr_input+1
	MOVLW      _auxSTR+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;MLK_RGB_Controller.c,345 :: 		lcd_out(2,7,auxSTR);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      7
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _auxSTR+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MLK_RGB_Controller.c,346 :: 		inttostr(red,auxSTR);
	MOVF       _red+0, 0
	MOVWF      FARG_IntToStr_input+0
	CLRF       FARG_IntToStr_input+1
	MOVLW      _auxSTR+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;MLK_RGB_Controller.c,347 :: 		lcd_out(2,3,auxSTR);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      3
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _auxSTR+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MLK_RGB_Controller.c,348 :: 		lcd_out(2,1,"RGB:");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_MLK_RGB_Controller+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MLK_RGB_Controller.c,349 :: 		}
L_end_printRGB:
	RETURN
; end of _printRGB

_controlMenu:

;MLK_RGB_Controller.c,351 :: 		controlMenu(){
;MLK_RGB_Controller.c,352 :: 		if(menuindex!=menuindexant){
	MOVF       _menuIndex+0, 0
	XORWF      _menuindexant+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_controlMenu112
;MLK_RGB_Controller.c,353 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MLK_RGB_Controller.c,354 :: 		menuindexant=menuindex;
	MOVF       _menuIndex+0, 0
	MOVWF      _menuindexant+0
;MLK_RGB_Controller.c,355 :: 		}
L_controlMenu112:
;MLK_RGB_Controller.c,356 :: 		switch(menuIndex){
	GOTO       L_controlMenu113
;MLK_RGB_Controller.c,357 :: 		case 0://off
L_controlMenu115:
;MLK_RGB_Controller.c,358 :: 		menuPrinc=1;
	BSF        _menuPrinc+0, BitPos(_menuPrinc+0)
;MLK_RGB_Controller.c,359 :: 		lcd_out(1,4,"Desligado!");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      4
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr3_MLK_RGB_Controller+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MLK_RGB_Controller.c,360 :: 		ciclo1=0;
	CLRF       _ciclo1+0
;MLK_RGB_Controller.c,361 :: 		ciclo2=0;
	CLRF       _ciclo2+0
;MLK_RGB_Controller.c,362 :: 		ciclo3=0;
	CLRF       _ciclo3+0
;MLK_RGB_Controller.c,363 :: 		break;
	GOTO       L_controlMenu114
;MLK_RGB_Controller.c,364 :: 		case 1://fixo
L_controlMenu116:
;MLK_RGB_Controller.c,365 :: 		brilho=brilhoaux;
	MOVF       _brilhoaux+0, 0
	MOVWF      _brilho+0
;MLK_RGB_Controller.c,366 :: 		menuPrinc=1;
	BSF        _menuPrinc+0, BitPos(_menuPrinc+0)
;MLK_RGB_Controller.c,367 :: 		lcd_out(1,5,"Cor fixa");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      5
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr4_MLK_RGB_Controller+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MLK_RGB_Controller.c,368 :: 		printRGB();
	CALL       _printRGB+0
;MLK_RGB_Controller.c,369 :: 		break;
	GOTO       L_controlMenu114
;MLK_RGB_Controller.c,370 :: 		case 3://ciclo
L_controlMenu117:
;MLK_RGB_Controller.c,371 :: 		menuPrinc=1;
	BSF        _menuPrinc+0, BitPos(_menuPrinc+0)
;MLK_RGB_Controller.c,373 :: 		brilho=brilhoaux;
	MOVF       _brilhoaux+0, 0
	MOVWF      _brilho+0
;MLK_RGB_Controller.c,374 :: 		lcd_out(1,1,"Ciclo espectral!");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr5_MLK_RGB_Controller+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MLK_RGB_Controller.c,375 :: 		printRGB();
	CALL       _printRGB+0
;MLK_RGB_Controller.c,376 :: 		cicloEffect(speed,256-speed);
	MOVF       _speed+0, 0
	MOVWF      FARG_cicloEffect_speedint+0
	MOVF       _speed+0, 0
	SUBLW      0
	MOVWF      FARG_cicloEffect_max+0
	CALL       _cicloEffect+0
;MLK_RGB_Controller.c,377 :: 		if(fbt4h==1){fbt4h=0;menuindex=9;}
	BTFSS      _fbt4h+0, BitPos(_fbt4h+0)
	GOTO       L_controlMenu118
	BCF        _fbt4h+0, BitPos(_fbt4h+0)
	MOVLW      9
	MOVWF      _menuIndex+0
L_controlMenu118:
;MLK_RGB_Controller.c,378 :: 		break;
	GOTO       L_controlMenu114
;MLK_RGB_Controller.c,379 :: 		case 2://fade
L_controlMenu119:
;MLK_RGB_Controller.c,380 :: 		menuPrinc=1 ;
	BSF        _menuPrinc+0, BitPos(_menuPrinc+0)
;MLK_RGB_Controller.c,381 :: 		lcd_out(1,5,"Pulsante");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      5
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr6_MLK_RGB_Controller+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MLK_RGB_Controller.c,382 :: 		printRGB();
	CALL       _printRGB+0
;MLK_RGB_Controller.c,383 :: 		fadeEffect(contadoraux,pwm1_cont,contadoraux2);
	MOVF       _contadoraux+0, 0
	MOVWF      FARG_fadeEffect_red1+0
	MOVF       _pwm1_cont+0, 0
	MOVWF      FARG_fadeEffect_green1+0
	MOVF       _contadoraux2+0, 0
	MOVWF      FARG_fadeEffect_blue1+0
	CALL       _fadeEffect+0
;MLK_RGB_Controller.c,384 :: 		if(fcor==1){lcd_out(1,16,"F");}
	BTFSS      _fcor+0, BitPos(_fcor+0)
	GOTO       L_controlMenu120
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      16
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr7_MLK_RGB_Controller+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
L_controlMenu120:
;MLK_RGB_Controller.c,385 :: 		break;
	GOTO       L_controlMenu114
;MLK_RGB_Controller.c,386 :: 		case 5://brilho
L_controlMenu121:
;MLK_RGB_Controller.c,387 :: 		menuPrinc=0 ;
	BCF        _menuPrinc+0, BitPos(_menuPrinc+0)
;MLK_RGB_Controller.c,388 :: 		lcd_out(1,1,"Brilho:");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr8_MLK_RGB_Controller+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MLK_RGB_Controller.c,389 :: 		brilho=atualizaAux(1,brilho,100,0);
	MOVLW      1
	MOVWF      FARG_atualizaAux_index+0
	MOVLW      0
	MOVWF      FARG_atualizaAux_index+1
	MOVF       _brilho+0, 0
	MOVWF      FARG_atualizaAux_aux+0
	MOVLW      100
	MOVWF      FARG_atualizaAux_max+0
	CLRF       FARG_atualizaAux_min+0
	CALL       _atualizaAux+0
	MOVF       R0+0, 0
	MOVWF      _brilho+0
;MLK_RGB_Controller.c,390 :: 		brilhoaux=brilho;
	MOVF       R0+0, 0
	MOVWF      _brilhoaux+0
;MLK_RGB_Controller.c,391 :: 		brilhopasso=(brilho/20)+1;
	MOVLW      20
	MOVWF      R4+0
	CALL       _Div_8X8_U+0
	INCF       R0+0, 0
	MOVWF      _brilhopasso+0
;MLK_RGB_Controller.c,392 :: 		break;
	GOTO       L_controlMenu114
;MLK_RGB_Controller.c,393 :: 		case 6://red
L_controlMenu122:
;MLK_RGB_Controller.c,394 :: 		menuPrinc=0 ;
	BCF        _menuPrinc+0, BitPos(_menuPrinc+0)
;MLK_RGB_Controller.c,395 :: 		lcd_out(1,1,"Red:");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr9_MLK_RGB_Controller+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MLK_RGB_Controller.c,396 :: 		red=atualizaAux(7,red,255,0);
	MOVLW      7
	MOVWF      FARG_atualizaAux_index+0
	MOVLW      0
	MOVWF      FARG_atualizaAux_index+1
	MOVF       _red+0, 0
	MOVWF      FARG_atualizaAux_aux+0
	MOVLW      255
	MOVWF      FARG_atualizaAux_max+0
	CLRF       FARG_atualizaAux_min+0
	CALL       _atualizaAux+0
	MOVF       R0+0, 0
	MOVWF      _red+0
;MLK_RGB_Controller.c,397 :: 		break;
	GOTO       L_controlMenu114
;MLK_RGB_Controller.c,398 :: 		case 7://green
L_controlMenu123:
;MLK_RGB_Controller.c,399 :: 		menuPrinc=0 ;
	BCF        _menuPrinc+0, BitPos(_menuPrinc+0)
;MLK_RGB_Controller.c,400 :: 		lcd_out(1,1,"Green:");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr10_MLK_RGB_Controller+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MLK_RGB_Controller.c,401 :: 		green=atualizaAux(8,green,255,0);
	MOVLW      8
	MOVWF      FARG_atualizaAux_index+0
	MOVLW      0
	MOVWF      FARG_atualizaAux_index+1
	MOVF       _green+0, 0
	MOVWF      FARG_atualizaAux_aux+0
	MOVLW      255
	MOVWF      FARG_atualizaAux_max+0
	CLRF       FARG_atualizaAux_min+0
	CALL       _atualizaAux+0
	MOVF       R0+0, 0
	MOVWF      _green+0
;MLK_RGB_Controller.c,402 :: 		break;
	GOTO       L_controlMenu114
;MLK_RGB_Controller.c,403 :: 		case 8://blue
L_controlMenu124:
;MLK_RGB_Controller.c,404 :: 		menuPrinc=0 ;
	BCF        _menuPrinc+0, BitPos(_menuPrinc+0)
;MLK_RGB_Controller.c,405 :: 		lcd_out(1,1,"Blue:");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr11_MLK_RGB_Controller+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MLK_RGB_Controller.c,406 :: 		blue=atualizaAux(1,blue,255,0);
	MOVLW      1
	MOVWF      FARG_atualizaAux_index+0
	MOVLW      0
	MOVWF      FARG_atualizaAux_index+1
	MOVF       _blue+0, 0
	MOVWF      FARG_atualizaAux_aux+0
	MOVLW      255
	MOVWF      FARG_atualizaAux_max+0
	CLRF       FARG_atualizaAux_min+0
	CALL       _atualizaAux+0
	MOVF       R0+0, 0
	MOVWF      _blue+0
;MLK_RGB_Controller.c,407 :: 		break;
	GOTO       L_controlMenu114
;MLK_RGB_Controller.c,408 :: 		case 9:
L_controlMenu125:
;MLK_RGB_Controller.c,409 :: 		menuPrinc=0 ;
	BCF        _menuPrinc+0, BitPos(_menuPrinc+0)
;MLK_RGB_Controller.c,410 :: 		lcd_out(1,1,"Speed:");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr12_MLK_RGB_Controller+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MLK_RGB_Controller.c,411 :: 		Speed=atualizaAux(3,Speed,255,1);
	MOVLW      3
	MOVWF      FARG_atualizaAux_index+0
	MOVLW      0
	MOVWF      FARG_atualizaAux_index+1
	MOVF       _speed+0, 0
	MOVWF      FARG_atualizaAux_aux+0
	MOVLW      255
	MOVWF      FARG_atualizaAux_max+0
	MOVLW      1
	MOVWF      FARG_atualizaAux_min+0
	CALL       _atualizaAux+0
	MOVF       R0+0, 0
	MOVWF      _speed+0
;MLK_RGB_Controller.c,412 :: 		passoSpeed=Speed;
	MOVF       R0+0, 0
	MOVWF      _passoSpeed+0
;MLK_RGB_Controller.c,413 :: 		break;
	GOTO       L_controlMenu114
;MLK_RGB_Controller.c,414 :: 		}
L_controlMenu113:
	MOVF       _menuIndex+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_controlMenu115
	MOVF       _menuIndex+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_controlMenu116
	MOVF       _menuIndex+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_controlMenu117
	MOVF       _menuIndex+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L_controlMenu119
	MOVF       _menuIndex+0, 0
	XORLW      5
	BTFSC      STATUS+0, 2
	GOTO       L_controlMenu121
	MOVF       _menuIndex+0, 0
	XORLW      6
	BTFSC      STATUS+0, 2
	GOTO       L_controlMenu122
	MOVF       _menuIndex+0, 0
	XORLW      7
	BTFSC      STATUS+0, 2
	GOTO       L_controlMenu123
	MOVF       _menuIndex+0, 0
	XORLW      8
	BTFSC      STATUS+0, 2
	GOTO       L_controlMenu124
	MOVF       _menuIndex+0, 0
	XORLW      9
	BTFSC      STATUS+0, 2
	GOTO       L_controlMenu125
L_controlMenu114:
;MLK_RGB_Controller.c,415 :: 		}
L_end_controlMenu:
	RETURN
; end of _controlMenu

_main:

;MLK_RGB_Controller.c,417 :: 		void main() {
;MLK_RGB_Controller.c,418 :: 		trisa=0b00110000; //pinos A4 e A5 como entradas digitais e o restante como saidas
	MOVLW      48
	MOVWF      TRISA+0
;MLK_RGB_Controller.c,419 :: 		trisb=0;
	CLRF       TRISB+0
;MLK_RGB_Controller.c,420 :: 		portb=0;
	CLRF       PORTB+0
;MLK_RGB_Controller.c,421 :: 		INTCON=0b01000000;
	MOVLW      64
	MOVWF      INTCON+0
;MLK_RGB_Controller.c,422 :: 		OPTION_REG = 0x82;
	MOVLW      130
	MOVWF      OPTION_REG+0
;MLK_RGB_Controller.c,423 :: 		pwm_ini=pwm_reg;
	MOVLW      125
	MOVWF      _pwm_ini+0
	MOVLW      255
	MOVWF      _pwm_ini+1
;MLK_RGB_Controller.c,424 :: 		TMR1L=Lo(pwm_ini);
	MOVLW      125
	MOVWF      TMR1L+0
;MLK_RGB_Controller.c,425 :: 		TMR1H=Hi(pwm_ini);
	MOVF       _pwm_ini+1, 0
	MOVWF      R0+0
	CLRF       R0+1
	MOVLW      255
	ANDWF      R0+0, 0
	MOVWF      TMR1H+0
;MLK_RGB_Controller.c,428 :: 		T1CKPS1_bit=0;
	BCF        T1CKPS1_bit+0, BitPos(T1CKPS1_bit+0)
;MLK_RGB_Controller.c,429 :: 		T1CKPS0_bit=0;
	BCF        T1CKPS0_bit+0, BitPos(T1CKPS0_bit+0)
;MLK_RGB_Controller.c,431 :: 		TMR1IF_bit=0;
	BCF        TMR1IF_bit+0, BitPos(TMR1IF_bit+0)
;MLK_RGB_Controller.c,432 :: 		TMR1IE_bit=1;
	BSF        TMR1IE_bit+0, BitPos(TMR1IE_bit+0)
;MLK_RGB_Controller.c,433 :: 		TMR1ON_bit=1;
	BSF        TMR1ON_bit+0, BitPos(TMR1ON_bit+0)
;MLK_RGB_Controller.c,434 :: 		GIE_bit=1;
	BSF        GIE_bit+0, BitPos(GIE_bit+0)
;MLK_RGB_Controller.c,435 :: 		PEIE_bit = 0x01;           // Habilitar a interrupção por periféricos
	BSF        PEIE_bit+0, BitPos(PEIE_bit+0)
;MLK_RGB_Controller.c,436 :: 		T0IE_bit = 0x01;           // Habilitar a interrupção estouro TMR0
	BSF        T0IE_bit+0, BitPos(T0IE_bit+0)
;MLK_RGB_Controller.c,437 :: 		TMR0 = 0x06;
	MOVLW      6
	MOVWF      TMR0+0
;MLK_RGB_Controller.c,440 :: 		pwm1=1;
	BSF        PORTB+0, 0
;MLK_RGB_Controller.c,441 :: 		pwm2=1;
	BSF        PORTB+0, 1
;MLK_RGB_Controller.c,442 :: 		pwm3=1;
	BSF        PORTB+0, 2
;MLK_RGB_Controller.c,444 :: 		ciclo1=0; //Red
	CLRF       _ciclo1+0
;MLK_RGB_Controller.c,445 :: 		ciclo2=0; //Green
	CLRF       _ciclo2+0
;MLK_RGB_Controller.c,446 :: 		ciclo3=0; //Blue
	CLRF       _ciclo3+0
;MLK_RGB_Controller.c,448 :: 		Lcd_Init();
	CALL       _Lcd_Init+0
;MLK_RGB_Controller.c,449 :: 		lcd_cmd(_LCD_CURSOR_OFF) ;
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MLK_RGB_Controller.c,451 :: 		while(1){
L_main126:
;MLK_RGB_Controller.c,452 :: 		readButton();
	CALL       _readButton+0
;MLK_RGB_Controller.c,453 :: 		controlMenu();
	CALL       _controlMenu+0
;MLK_RGB_Controller.c,454 :: 		functionButton();
	CALL       _functionButton+0
;MLK_RGB_Controller.c,455 :: 		ajustaBrilho();
	CALL       _ajustaBrilho+0
;MLK_RGB_Controller.c,456 :: 		contadoraux++;
	INCF       _contadoraux+0, 1
;MLK_RGB_Controller.c,457 :: 		}
	GOTO       L_main126
;MLK_RGB_Controller.c,458 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
