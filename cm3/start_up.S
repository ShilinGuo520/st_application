    .syntax unified                                                                                                                                    
    .cpu cortex-m3
    .fpu softvfp
    .thumb

LED0 = 0x40010C0C
RCC_APB2ENR = 0x40021018
GPIOA_CRH = 0x40010C04



__Vectors:
				.word	0x20005000              
                .word   (Reset_Handler + 1)
                    
Reset_Handler:
                BL LED_Init
MainLoop:
		        BL LED_ON
                BL Delay
                BL LED_OFF
                BL Delay
                
                B MainLoop
             
LED_Init:
                PUSH {R0,R1, LR}
                
                LDR R0,=RCC_APB2ENR
                ORR R0,R0,#0x08
                LDR R1,=RCC_APB2ENR
                STR R0,[R1]
                
                LDR R0,=GPIOA_CRH
                BIC R0,R0,#0xFFFFFFFF
                LDR R1,=GPIOA_CRH
                STR R0,[R1]
                
                LDR R0,=GPIOA_CRH
                ORR R0,R0,#0x33333333
                LDR R1,=GPIOA_CRH
                STR R0,[R1]
                
                LDR R0,=0xffff
                LDR R1,=LED0
                STR R0,[R1]
             
                POP {R0,R1,PC}
LED_ON:
                PUSH {R0,R1, LR}    
                
                LDR R0,=0x0
                LDR R1,=LED0
                STR R0,[R1]
             
                POP {R0,R1,PC}
             
LED_OFF:
                PUSH {R0,R1, LR}    
                
                LDR R0,=0xffff
                LDR R1,=LED0
                STR R0,[R1]
             
                POP {R0,R1,PC}             
             
Delay:
                PUSH {R0,R1, LR}
                
                MOVS R0,#0
                MOVS R1,#0
                MOVS R2,#0
                
DelayLoop0:
                ADDS R0,R0,#1

                CMP R0,#330
                BCC DelayLoop0
                
                MOVS R0,#0
                ADDS R1,R1,#1
                CMP R1,#330
                BCC DelayLoop0

                MOVS R0,#0
                MOVS R1,#0
                ADDS R2,R2,#1
                CMP R2,#15
                BCC DelayLoop0
                
                
                POP {R0,R1,PC}    
