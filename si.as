;---------------------------------------------------------------------------------------------
; ZONA I: Definicao de constantes
;         Pseudo-instrucao : EQU
;---------------------------------------------------------------------------------------------
; Misc Const
CR              EQU     0Ah
FIM_TEXTO       EQU     '@'
IO_READ         EQU     FFFFh
IO_WRITE        EQU     FFFEh
IO_STATUS       EQU     FFFDh
INITIAL_SP      EQU     FDFFh
CURSOR	        EQU     FFFCh
CURSOR_INIT     EQU	    FFFFh
RND_MASK		EQU		8016h	
LSB_MASK		EQU		0001h
ROW_POSITION	EQU	    0d
COL_POSITION	EQU	    0d
ROW_SHIFT	    EQU	    8d
COLUMN_SHIFT    EQU     8d
EOL				EQU		0d
DIGIT_CONVERTER EQU		48d
EASY_MODE		EQU		0d
HARD_MODE		EQU		1d

; Space Const
SHIELD			EQU		'#'
SHIELDS_Y		EQU		16d
SHIELDS_MAX_Y	EQU		19d
VACCUM			EQU		' '
SCORE_X			EQU		32d
SCORE_Y			EQU		23d
LIVES_X			EQU		44d
LIVES_Y			EQU		23d

; Clock
INT_MASK		EQU		FFFFh
INT_SET			EQU		FFFAh
TIMER_TIME		EQU		FFF6h
TIMER_INIT		EQU		FFF7h
TIMER_INTERVAL	EQU		1d
TIMER_ON		EQU		1d
TIMER_OFF		EQU		0d

; HUD Const
MENU_OP         EQU     0d
SPACE_OP        EQU     1d
GAMEOVER_OP     EQU     2d
WIN_OP			EQU		3d
START_ACTION	EQU		1d

; Ship Const
SHIP_NEUTRAL	EQU		0d
SHIP_LEFT		EQU		1d
SHIP_RIGHT		EQU		2d
SHIP_SHOOT		EQU		3d
SHIP_DEAD		EQU		4d
SHIP_MAX_X		EQU		75d
SHIP_MIN_X		EQU		0d
SHIP_ROW		EQU		22d
SHIP_SIZE		EQU		5d
SHIP_PART1		EQU		'/'
SHIP_PART2		EQU		'-'
SHIP_PART3		EQU		'^'
SHIP_PART4		EQU		'\'
SHIP_BULLET		EQU		'!'
BULLET_ON		EQU		1d
BULLET_OFF		EQU		0d

; Aliens Const
ALIEN1_1		EQU		'.'
ALIEN1_2		EQU		'~'
ALIEN1_1_ALT	EQU		','
ALIEN1_2_ALT	EQU		'^'
ALIEN2_1		EQU		'<'
ALIEN2_2		EQU		'o'
ALIEN2_3		EQU		'>'
ALIEN2_2_ALT	EQU		'O'
ALIEN3_1		EQU		'-'
ALIEN3_2		EQU		'x'
ALIEN3_3		EQU		'_'
ALIEN_BULLET	EQU		':'
ALIEN_ALIVE		EQU		'A'
ALIEN_DEAD		EQU		'D'
ALIEN_LEFT		EQU		0d
ALIEN_RIGHT		EQU		1d
ALIEN_TIME		EQU		3d
ALIEN_STOP		EQU		10d
ALIEN_MAX_X		EQU		78d
ALIEN_MIN_X		EQU		1d
ALIEN_MAX_Y		EQU		22d
ALIEN_ANIM		EQU		0d
ALIEN_ANIM_ALT	EQU		1d
ALIEN_SIZE		EQU		3d
ALIEN_ROW_SIZE	EQU		10d
ALIEN_NEXT_LINE	EQU		2d

;---------------------------------------------------------------------------------------------
; ZONE II: Definicao de variaveis
;          Pseudo-instrucoes : WORD - palavra (16 bits)
;                              STR  - sequencia de caracteres (cada ocupa 1 palavra: 16 bits).
;          Cada caracter ocupa 1 palavra
;---------------------------------------------------------------------------------------------
ORIG            8000h
; Misc Vars
difficulty		WORD	EASY_MODE																					; Dificuldade do jogo (Easy ou Hard)
clockState		WORD	TIMER_ON																					; Estado do clock (ON ou OFF)
ship			WORD	SHIP_DEAD																					; Condição da nave (Dead, Shoot, Left, Right, Neutral)
shipPosX		WORD	SHIP_MIN_X																					; Posição X da nave no space
bulletPosY		WORD	0d																							; Linha onde o tiro da nave no space
bulletPosX		WORD	0d																							; Coluna onde o tiro da nave no space
bullet			WORD	BULLET_OFF																					; Estado da bala da nave (ON ou OFF)
printOp         WORD    MENU_OP																						; Opção de display que será printada (Menu, Space, Gameover, Win)
start           WORD    1d                              															; Indicador de se o jogo começou ou não
row             WORD    0d                              															; Indexador de linha para display
column          WORD    0d                              															; Indexador de coluna para display
scoreCount      WORD    0d                            																; Contador da pontuação do jogo
liveCount       WORD    3d                         																    ; Contador de vida da nave
randomVar		WORD	A5A5h  																						; 1010 0101 1010 0101

; Aliens Vars
aliensRows		WORD	5d																							; A maior linha que tenha pelo menos um alien vivo
aliensPosX		WORD	1d																							; Posição X inicial do conjunto de aliens no space. Começa no 1 (no '~' do primeiro '.~.') e soma de 3 em 3 9x, sendo o max do conjunto de aliens o valor aliensPosX + 27
aliensReadyX	WORD	0d																							; Delimitador de início de colunas do aliensReady, pois se uma coluna de aliens morrer o valor aliensPosX é atualizado para a próxima e este será incrementado para mostrar que estamos partindo da próxima coluna.
aliensMaxPosX	WORD	28d																							; Posição X final do conjunto de aliens no space. É basicamente aliensPosX + 27 mas guardado para não ficar fazendo operação para ter ele o tempo todo.
aliensReadyXMax	WORD	9d																							; O mesmo que aliensReadyX mas para o aliensMaxPosX, sendo o final de aliensReady e começando de 9 de decrementando quando no final do conjunto uma coluna toda de aliens morre.
aliensPosY		WORD	0d																							; Posição Y inicial do conjunto de aliens no space. Começa no 0 e soma de 2 em 2 4x, sendo o max aliensPosY + 8
aliensMaxPosY	WORD	8d																							; Posição Y final do conjunto de aliens no space. É basicamente aliensPosY + 8 mas guardado para não ficar fazendo operação para ter ele o tempo todo.
alienBulletPosX	WORD	0d																							; Posição X da bala do alien (ALIEN_BULLET) no space.
alienBulletPosY	WORD	9d																							; Posição X da bala do alien (ALIEN_BULLET) no space.
alienMoveTimer	WORD	ALIEN_STOP																					; Timer de movimento do alien que vai diminuindo até achegar a 0 e executar a função, podendo ter valor inical alienMoveSpeed, que é tempo do timer, ou ALIEN_STOP que faz o timer parar totalmente, fazendo o alien parar de funcionar.
alienMoveSpeed	WORD	ALIEN_TIME																					; Ela é o tempo que o timer pega, diminui seu valor conforme os aliens vão morrendo.
alienDirection	WORD	ALIEN_RIGHT																					; Direção que o conjunto de aliens move no space
alienAnimType	WORD	ALIEN_ANIM_ALT																				; Forma que o alien vai assumir no próximo movimento dele, onde fica alternando entre duas formas
alienAliveCount WORD	50d																							; Quantidade de alines vivos.
selectedAlien	WORD	0d																							; Coluna de aliensReady selecionada para atirar
alienBullet		WORD	BULLET_OFF																					; Estado da bala do alien que atirou
aliensRow1		STR		'AAAAAAAAAA', EOL
aliensRow2		STR		'AAAAAAAAAA', EOL
aliensRow3		STR		'AAAAAAAAAA', EOL
aliensRow4		STR		'AAAAAAAAAA', EOL
aliensRow5		STR		'AAAAAAAAAA', EOL
aliensAlive		STR		aliensRow1, aliensRow2, aliensRow3, aliensRow4, aliensRow5, EOL								; Matriz que guarda o estado de vida (ALIEN_ALIVE ou ALIEN_DEAD) do alien, em relação com o conjunto de aliens
aliensReady		STR		5d, 5d, 5d, 5d, 5d, 5d, 5d, 5d, 5d, 5d														; String que guarda qual linha o alien de cada coluna está apto a atirar (em relação ao conjunto de aliens)

; HUD menu
menu0           STR     '     _____                        _____                     _               _   ', EOL
menu1           STR     '    / ____|                      |_   _|                   | |             | |  ', EOL
menu2           STR     '   | (___  _ __   __ _  ___ ___    | |  _ ____   ____ _  __| | ___ _ __ ___| |  ', EOL
menu3           STR     '    \___ \| `_ \ / _` |/ __/ _ \   | | | `_ \ \ / / _` |/ _` |/ _ \ `__/ __| |  ', EOL
menu4           STR     '    ____) | |_) | (_| | (_|  __/  _| |_| | | \ V / (_| | (_| |  __/ |  \__ \_|  ', EOL
menu5           STR     '   |_____/| .__/ \__,_|\___\___| |_____|_| |_|\_/ \__,_|\__,_|\___|_|  |___(_)  ', EOL
menu6           STR     '          | |                                                                   ', EOL
menu7           STR     '          |_|                                                                   ', EOL
menu8           STR     '                                                                                ', EOL
menu9           STR     '                                                                                ', EOL
menu10          STR     '                                  .~. = 200                                     ', EOL
menu11          STR     '                                  <o> = 150                                     ', EOL
menu12          STR     '                                  -x_ = 100                                     ', EOL
menu13          STR     '                                                                                ', EOL
menu14          STR     '                                                                                ', EOL
menu15          STR     '                           ---------CONTROLS---------                           ', EOL
menu16          STR     '                          |       INT0: Shoot        |                          ', EOL
menu17          STR     '                          |       INT1: Left         |                          ', EOL
menu18          STR     '                          |       INT2: Right        |                          ', EOL
menu19          STR     '                          |  INT3: Toggle Difficulty |                          ', EOL
menu20          STR     '                           --------------------------                           ', EOL
menu21          STR     '                                                                                ', EOL
menu22          STR     '                                                                                ', EOL
menu23          STR     '                              Press INT0 to start                               ', EOL
menu            STR     menu0, menu1, menu2, menu3, menu4, menu5, menu6, menu7, menu8, menu9, menu10, menu11, menu12, menu13, menu14, menu15, menu16, menu17, menu18, menu19, menu20, menu21, menu22, menu23, EOL

; HUD Space
space0          STR     '.~..~..~..~..~..~..~..~..~..~.                                                  ', EOL
space1          STR     '                                                                                ', EOL
space2          STR     '<o><o><o><o><o><o><o><o><o><o>                                                  ', EOL
space3          STR     '                                                                                ', EOL
space4          STR     '<o><o><o><o><o><o><o><o><o><o>                                                  ', EOL
space5          STR     '                                                                                ', EOL
space6          STR     '-x_-x_-x_-x_-x_-x_-x_-x_-x_-x_                                                  ', EOL
space7          STR     '                                                                                ', EOL
space8          STR     '-x_-x_-x_-x_-x_-x_-x_-x_-x_-x_                                                  ', EOL
space9          STR     '                                                                                ', EOL
space10         STR     '                                                                                ', EOL
space11         STR     '                                                                                ', EOL
space12         STR     '                                                                                ', EOL
space13         STR     '                                                                                ', EOL
space14         STR     '                                                                                ', EOL
space15         STR     '                                                                                ', EOL
space16         STR     '        ###                 ###                 ###                 ###         ', EOL
space17         STR     '       #####               #####               #####               #####        ', EOL
space18         STR     '      #######             #######             #######             #######       ', EOL
space19         STR     '      ##   ##             ##   ##             ##   ##             ##   ##       ', EOL
space20         STR     '                                                                                ', EOL
space21         STR     '                                                                                ', EOL
space22         STR     '/-^-\                                                                           ', EOL
space23         STR     '                         Score: 0000 Lives: /-\ /-\ /-\                         ', EOL
space           STR     space0, space1, space2, space3, space4, space5, space6, space7, space8, space9, space10, space11, space12, space13, space14, space15, space16, space17, space18, space19, space20, space21, space22, space23, EOL

; HUD Gameover
gameover0       STR     '                          _____                                                 ', EOL
gameover1       STR     '                         / ____|                                                ', EOL
gameover2       STR     '                        | |  __  __ _ _ __ ___   ___                            ', EOL
gameover3       STR     '                        | | |_ |/ _` | `_ ` _ \ / _ \                           ', EOL
gameover4       STR     '                        | |__| | (_| | | | | | |  __/                           ', EOL
gameover5       STR     '                         \_____|\__,_|_| |_| |_|\___|                           ', EOL
gameover6       STR     '                            / __ \                                              ', EOL
gameover7       STR     '                           | |  | |_   _____ _ __                               ', EOL
gameover8       STR     '                           | |  | \ \ / / _ \ `__|                              ', EOL
gameover9       STR     '                           | |__| |\ V /  __/ |                                 ', EOL
gameover10      STR     '                            \____/  \_/ \___|_|                                 ', EOL
gameover11      STR     '                                                                                ', EOL
gameover12      STR     '                      RESTART THE PROGRAM TO PLAY AGAIN                         ', EOL
gameover        STR     gameover0, gameover1, gameover2, gameover3, gameover4, gameover5, gameover6, gameover7, gameover8, gameover9, gameover10, gameover11, gameover12, space13, space14, space15, space16, space17, space18, space19, space20, space21, space22, space23, EOL

; HUD Win
win0      		STR     '                            __     __                                           ', EOL
win1     		STR     '                            \ \   / /                                           ', EOL
win2     		STR     '                             \ \_/ /__  _   _                                   ', EOL
win3       		STR     '                              \   / _ \| | | |                                  ', EOL
win4     	  	STR     '                               | | (_) | |_| |                                  ', EOL
win5       		STR     '                         __    |_|\___/_\__,_| _                                ', EOL
win6      		STR     '                         \ \        / (_)     | |                               ', EOL
win7      		STR     '                          \ \  /\  / / _ _ __ | |                               ', EOL
win8       		STR     '                           \ \/  \/ / | | `_ \| |                               ', EOL
win9       		STR     '                            \  /\  /  | | | | |_|                               ', EOL
win10      		STR     '                             \/  \/   |_|_| |_(_)                               ', EOL
win11     		STR     '                                                                                ', EOL
win12      		STR     '                      RESTART THE PROGRAM TO PLAY AGAIN                         ', EOL
win        		STR     win0, win1, win2, win3, win4, win5, win6, win7, win8, win9, win10, win11, win12, space13, space14, space15, space16, space17, space18, space19, space20, space21, space22, space23, EOL

;---------------------------------------------------------------------------------------------
; ZONE III: Definicao de tabela de interrupcoes
;---------------------------------------------------------------------------------------------
ORIG            FE00h
INT0            WORD    spaceHandling                   ; Recomendado: Espaço
INT1            WORD    lShip                          	; Recomendado: A
INT2            WORD    rShip                          	; Recomendado: D
INT3			WORD	toggleDiff						; Recomendado: R

ORIG 			FE0Fh
INT15			WORD	clock							; Clock

;---------------------------------------------------------------------------------------------
; ZONE IV:      Codigo
;---------------------------------------------------------------------------------------------
ORIG            0000h
JMP             Main

;-------------------------------------------------------------------------------------------------------------------------------------------------
; FUNCTION:     Space Handling
; DESCRIPTION:  Funções que tomam conta do INT0 (Usado pela tecla de espaço) para indicar se é para começar o jogo ou realizar um tiro com a nave.
;-------------------------------------------------------------------------------------------------------------------------------------------------
spaceHandling:  DSI
                PUSH    R1
                MOV     R1, M[start]					; Verifica se começou o jogo para mudar de Handle
                CMP     R1, START_ACTION
                BR.Z   	spaceHandle1
                BR   	spaceHandle2

spaceHandle1:   MOV     M[start], R0					; Pressionou espaço, pega as variáveis necessárias para começar o jogo.
                MOV     R1, SPACE_OP
                MOV     M[printOp], R1					; Vai ser printado o space ao invés do menu
				MOV		R1, SHIP_NEUTRAL
				MOV 	M[ship], R1						; Nave consegue mover e atirar agora
				MOV		R1, M[alienMoveSpeed]
				MOV		M[alienMoveTimer], R1			; Alien consegue mover e atirar agora
                BR		spaceHandleEnd

spaceHandle2:   MOV		R1, M[ship]
				CMP		R1, SHIP_DEAD
				BR.Z	spaceHandleEnd
				MOV		R1, M[bullet]
				CMP		R1, BULLET_ON					; Só uma bala por vez na tela
				BR.Z	spaceHandleEnd			
				MOV		R1, SHIP_SHOOT					; Ação de atirar para o estado da nave
				MOV		M[ship], R1

spaceHandleEnd:	POP     R1
                ENI
                RTI

;-----------------------------------------------------------------------------------------------------------------
; FUNCTION:     Move Ship
; DESCRIPTION:  Funções que fazem a nave se mover para a esquerda (l) e direita (r)
;-----------------------------------------------------------------------------------------------------------------
lShip:			DSI
				PUSH	R1
				MOV		R1, M[ship]
				CMP		R1, SHIP_DEAD
				BR.Z	endMoveShip
				MOV		R1, SHIP_LEFT					; Move o estado da nave para mover para a esquerda
				MOV		M[ship], R1
				BR		endMoveShip

rShip:			DSI
				PUSH	R1
				MOV		R1, M[ship]
				CMP		R1, SHIP_DEAD
				BR.Z	endMoveShip
				MOV		R1, SHIP_RIGHT					; Move o estado da nave para mover para a direita
				MOV		M[ship], R1
				BR		endMoveShip

endMoveShip:	POP		R1
				ENI
				RTI

;-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
; FUNCTION:     Toggle Difficulty
; DESCRIPTION:  Função que muda a dificuldade do jogo, onde ela basicamente desliga o timer e usa um loop na main para ficar mais difícil, pois o clock é lento, mesmo no setClock mais rápido possível.
;-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
toggleDiff:		DSI
				PUSH	R1
				MOV		R1, M[difficulty]
				CMP		R1, HARD_MODE
				BR.Z	setEasy

setHard:		MOV		R1, HARD_MODE
				MOV		M[difficulty], R1
				MOV		R1, TIMER_OFF
				BR		toggleDiffEnd

setEasy:		MOV		R1, EASY_MODE
				MOV		M[difficulty], R1
				MOV		R1, TIMER_ON

toggleDiffEnd:	MOV		M[clockState], R1
				CALL	setClock
				POP		R1
				ENI
				RTI

;---------------------------------------------------------------------------------------------
; FUNCTION:     clock
; DESCRIPTION:  Função que gerecia o clock do programa
;---------------------------------------------------------------------------------------------
clock:			CALL	clockFunctions
				CALL	setClock
				RTI

setClock:		PUSH	R1
				PUSH	R2

				MOV		R1, M[clockState]
				MOV		R2, TIMER_INTERVAL
				MOV		M[TIMER_TIME], R2
				MOV		M[TIMER_INIT], R1

				POP		R1
				POP		R2
				RET

clockFunctions:	DSI
				CALL	alienMove
				CALL	alienBulletMove
				CALL	shipAction
				CALL	bulletMove
				CALL    beginScrnPrint
				ENI
				RET

;---------------------------------------------------------------------------------------------
; FUNCTION:     Set Gameover/Win
; DESCRIPTION:  Função que define o jogo como 'You Lose'/'You Win'
;---------------------------------------------------------------------------------------------
setGameover:	PUSH	R1
				MOV		R1, GAMEOVER_OP				; Printa a tela de game over e para tudo
				BR		gameEnd

setWin:			PUSH 	R1
				MOV		R1, WIN_OP					; Printa a tela de you win e para tudo

gameEnd:		MOV		M[printOp], R1
				MOV		R1, SHIP_DEAD
				MOV		M[ship], R1
				MOV		R1, ALIEN_STOP
				MOV		M[alienMoveTimer], R1
				MOV		R1, BULLET_OFF
				MOV		M[bullet], R1
				MOV		M[alienBullet], R1
				POP		R1
				RET
;--------------------------------------------------------------------------------------------------
; FUNCTION: 	Alien Update Row
; DESCRIPTION:  Atualiza o posição máxima de Y dos aliens (aliensMoxPosY), como também (aliensRows)
;--------------------------------------------------------------------------------------------------
alienUpdateRow:	PUSH	R1							; Indexador da string de aliens ready
				PUSH	R2							; Conteúdo no index da string de aliensReady
				PUSH	R3							; Maior valor de aliensReady
				MOV		R1, R0
				MOV		R2, R0
				MOV		R3, R0

alienUpdRowLoop:CMP		R1, ALIEN_ROW_SIZE			; Ve se já passou por todo aliensReady
				JMP.Z	alienUpdMaxPosY
				MOV		R2, M[R1+aliensReady]		; Compara o valor de aliensReady (R2) com o maior valor obtido no momento (R3), se for maior R2 vira R3
				CMP		R2, R3
				CALL.P	newMaxRow
				INC		R1
				JMP		alienUpdRowLoop

newMaxRow:		MOV		R3, R2
				RET

updateY:		MOV		R1, M[aliensMaxPosY]
				SUB		R1, ALIEN_NEXT_LINE
				MOV		M[aliensMaxPosY], R1		; Bota o novo maior valor de Y do conjunto de aliens em relação a space
				DEC		R2
				MOV		M[aliensRows], R2			; Decrementa a linha de aliens em relação ao conjuto de aliens para ver se chega ao novo máximo (R3)
				JMP		alienUpdMaxPosY

alienUpdMaxPosY:MOV		R2, M[aliensRows]
				CMP		R2, R3						; Compara aliensRows (R2) com o novo valor máximo e verifica se está nele, se não atualiza novamente.
				JMP.P	updateY
alienUpdRowEnd:	POP		R3
				POP		R2
				POP		R1
				RET

;---------------------------------------------------------------------------------------------
; FUNCTION: 	Alien Update Column
; DESCRIPTION:  Atualiza o posição máxima e mínima de X dos aliens (aliensMox\MinPosX)
;---------------------------------------------------------------------------------------------
alienUpdateCln:	PUSH	R1							; R1 Recebe os aliensReadyX e aliensReadyXMax
				PUSH	R2							; R2 Recebe o valor da posição de R1 em aliensReady
				
alienUpdClnLoop:MOV		R1, M[aliensReadyX]
				MOV		R2, M[R1+aliensReady]
				CMP		R2, R0						; Se a coluna mínima relativa zerou, vai para a próxima
				JMP.Z	newMinCln

				MOV		R1, M[aliensReadyXMax]
				MOV		R2, M[R1+aliensReady]
				CMP		R2, R0
				JMP.Z	newMaxCln					; Se a coluna máxima relativa zerou, vai para a próxima

				POP		R2
				POP		R1
				RET

newMaxCln:		DEC		R1							; Próxima coluna máxima relativa
				MOV		M[aliensReadyXMax], R1
				MOV		R2, M[aliensMaxPosX]
				SUB		R2, ALIEN_SIZE				; Faz a correção do aliensMaxPosX
				MOV		M[aliensMaxPosX], R2
				JMP		alienUpdClnLoop

newMinCln:		INC		R1							; Próxima coluna mínima relativa
				MOV		M[aliensReadyX], R1
				MOV		R2, M[aliensPosX]
				ADD		R2, ALIEN_SIZE				; Faz a correção do aliensPosX
				MOV		M[aliensPosX], R2
				JMP		alienUpdClnLoop	

;---------------------------------------------------------------------------------------------
; FUNCTION:     Ship Action
; DESCRIPTION:  Funcao que gerecia a acao da nave
;---------------------------------------------------------------------------------------------
shipAction:		PUSH	R1
				PUSH	R2
				PUSH	R3
				PUSH	R4
				PUSH	R5

				MOV		R1, M[ship]
				CMP		R1, SHIP_DEAD				; Nave morta
				JMP.Z	shipActionEnd
				CMP		R1, SHIP_NEUTRAL			; Nave parada
				JMP.Z	shipActionEnd
				CMP		R1, SHIP_SHOOT				; Nave atirando
				JMP.Z	shipShoot
				JMP		beginShipWrite				; Nave se mexendo

;---------------------------------------------------------------------------------------------
; SUB FUNCTION:Ship Shoot
; DESCRIPTION:  Função que faz a nave atirar, ligando o bullet e botando sua posição
;---------------------------------------------------------------------------------------------
shipShoot:		MOV		R1, BULLET_ON				; Muda a variável da bala para ON para a bala poder se mover
				MOV		M[bullet], R1
				MOV		R1, SHIP_ROW				; Configurando a linha inicial da bala, ela moverá para a frente da nave quando entrar no bulletMove
				MOV		M[bulletPosY], R1
				MOV		R1, M[shipPosX]				; Configurando a coluna inicial da bala, que será duas colunas depois da posição nave (que é definida pela parte '/' da nave)
				ADD		R1, 2d
				MOV		M[bulletPosX], R1
				MOV		R1, SHIP_NEUTRAL
				MOV		M[ship], R1
				JMP		shipActionEnd

;---------------------------------------------------------------------------------------------
; SUB FUNCTION: Ship Write
; DESCRIPTION:  Função que escreve a nave no space de acordo com sua direção
;---------------------------------------------------------------------------------------------
beginShipWrite:	MOV		R1, M[shipPosX]
				MOV		R5, SHIP_ROW
				JMP		shipLDirection

shipLDirection:	MOV		R2, M[ship]						; Vê qual direção a nave quer ir
				CMP		R2, SHIP_LEFT
				BR.NZ	shipRDirection
				CMP		R1,	SHIP_MIN_X					; Vê se chegou no início da tela
				JMP.Z	shipActionEnd
				DEC		R1		
				BR		shipWrite

shipRDirection:	CMP		R1,	SHIP_MAX_X					; Vê se chegou no final da tela
				JMP.Z	shipActionEnd
				INC		R1
				BR		shipWrite

shipWrite:		MOV		M[shipPosX], R1					; Escreve a nave em space
				MOV 	R3, R0

shipWriteLoop:	CMP		R3, SHIP_SIZE
				JMP.Z	shipWriteEnd
				MOV		R1, M[shipPosX]
				ADD		R1, R3
				MOV		R2, M[R5+space]
				ADD		R2, R1
				CALL	chooseShipPart
				MOV		M[R2], R4
				INC		R3
				JMP		shipWriteLoop

shipWriteEnd: 	MOV		R1, M[shipPosX]
				CALL	shipLDirEnd
				MOV		R2, M[R5+space]
				ADD		R2, R1
				MOV		R4, VACCUM
				MOV		M[R2], R4
				MOV		R1, SHIP_NEUTRAL
				MOV 	M[ship], R1
				JMP		shipActionEnd

shipLDirEnd:	MOV		R2, M[ship]
				CMP		R2, SHIP_LEFT
				BR.NZ	shipRDirEnd
				ADD		R1, R3
				RET

shipRDirEnd:	DEC		R1
				RET

; Vai analisar R3 para ver qual parte ele está e copiará para R4
chooseShipPart: CMP		R3, 0d
				BR.Z	shipPart1
				CMP		R3, 1d
				BR.Z	shipPart2
				CMP		R3, 2d
				BR.Z	shipPart3
				CMP		R3, 3d
				BR.Z	shipPart2
				CMP		R3, 4d
				BR.Z	shipPart4

shipPart1:		MOV		R4, SHIP_PART1
				RET
shipPart2:		MOV		R4, SHIP_PART2
				RET
shipPart3:		MOV		R4, SHIP_PART3
				RET
shipPart4:		MOV		R4, SHIP_PART4
				RET

shipActionEnd:	POP		R5
				POP		R4
				POP		R3
				POP		R2
				POP		R1
				RET

;---------------------------------------------------------------------------------------------
; FUNCTION:     alienBulletMove
; DESCRIPTION:  Função que faz a bala do alien se mover
;---------------------------------------------------------------------------------------------
alienBulletMove:PUSH	R1
				PUSH	R2
				PUSH	R3
				PUSH	R4

				MOV		R1, M[alienBullet]
				CMP		R1, BULLET_OFF							; Não tem bala então sai
				JMP.Z	alienBulletMEnd

				CALL	getAlnBlltAddr
				MOV		R3, M[R3]
				CMP		R3, ALIEN_BULLET						; Confirma se ainda é uma bala na posição antiga para apagar (Pode ser que apareça um alien na frente)
				CALL.Z	eraseAlnBullet

				MOV		R1, M[alienBulletPosY]

				CMP		R1, 22d									; Final do space para a bala do alien
				JMP.Z	alnBlltFinish

				INC		R1
				MOV		M[alienBulletPosY], R1

alnBulletCheck:	CALL	getAlnBlltAddr
				MOV		R4, M[R3]
				CMP		R4, VACCUM								 ;Vê se não tem nada
				JMP.Z	alnBlltWrite
				CMP		R4, SHIELD								; Vê se é shield
				JMP.Z	alnBulletShield
				CMP		R1, SHIP_ROW							; A condição alnBlltShip só valerá se a bala checar algo na linha da nave (COMO A PRÓPRIA NAVE)
				JMP.NZ	alnBlltWrite

alnBlltShip:	MOV		R1, M[liveCount]
				DEC		R1
				MOV		M[liveCount], R1
				CALL	updateLives
				CMP		R1, 0d
				CALL.Z	setGameover

alnBlltFinish:	MOV		R1, BULLET_OFF
				MOV		M[alienBullet], R1
alienBulletMEnd:POP		R4
				POP		R3
				POP		R2
				POP		R1
				RET

getAlnBlltAddr:	PUSH	R1									; Guarda o endereço da bala em R3
				PUSH	R2
				MOV		R1, M[alienBulletPosX]
				MOV		R2, M[alienBulletPosY]
				MOV		R3, M[R2+space]
				ADD		R3, R1
				POP		R2
				POP		R1
				RET

alnBlltWrite:	MOV		R4, ALIEN_BULLET					; Escreve a bala do alien
				MOV		M[R3], R4
				JMP		alienBulletMEnd

alnBulletShield:CALL	eraseAlnBullet						; Uso da função para excluir o escudo ao invés da bala
				JMP		alnBlltFinish						; Desliga a bala

eraseAlnBullet: PUSH	R3									; Apaga a bala do alien em space
				PUSH	R4
				MOV		R4, VACCUM
				CALL	getAlnBlltAddr						; R3 vai ter o endereço da bala
				MOV		M[R3], R4
				POP		R4
				POP		R3
				RET

;---------------------------------------------------------------------------------------------
; FUNCTION:     updateLives
; DESCRIPTION:  Atualiza a quantidade de vidas
;---------------------------------------------------------------------------------------------
updateLives:	PUSH	R1
				PUSH	R2								; Indexador de vidas
				PUSH	R3								; Posição da vida em space

				MOV		R1, LIVES_Y
				MOV		R3, M[R1+space]
				MOV		R1, LIVES_X
				ADD		R3, R1
				MOV		R2, R0
				MOV		R1, M[liveCount]

updateLivesLoop:CMP		R1, R2							; Vê se chegou na vida que será diminuída
				JMP.Z	updateLivesEnd
				INC		R2
				ADD		R3, 4d 							; Indo até a outra vida em space
				BR		updateLivesLoop

updateLivesEnd:	MOV		R1, VACCUM						; Apaga a vida :(
				MOV		M[R3], R1
				INC		R3
				MOV		M[R3], R1
				INC		R3
				MOV		M[R3], R1
				INC		R3

				POP		R3
				POP		R2
				POP		R1
				RET

;---------------------------------------------------------------------------------------------
; FUNCTION:     alienMove
; DESCRIPTION:  Função que faz os aliens se moverem, basicamente é excluido a linha de aliens e printado de volta na nova posição
;---------------------------------------------------------------------------------------------
alienMove:		PUSH    R1
                PUSH    R2
				PUSH 	R3
				PUSH 	R4

				MOV		R1, M[alienMoveTimer]
				CMP		R1, ALIEN_STOP				; Alien não precisa se mover
				JMP.Z	alienMoveEnd
				CMP		R1, 0d						; Se deu zero realiza a função de diminuir o timer, se não der move o alien
				JMP.NZ	decreaseATimer
				MOV		R1, M[alienMoveSpeed]		; Reseta o timer
				MOV		M[alienMoveTimer], R1

				CALL	eraseAliens
				MOV		R1, M[alienDirection]
				CMP		R1, ALIEN_RIGHT				; Vê em qual direção o alien está indo
				JMP.Z	alienRight
				JMP		alienLeft

; Usa R1 (Posição X do alien no space) e R2 (Index Y do alien no conjunto de aliens) e Retorna R3 (Posição X e Y do alien no space)
getAlienAddress:PUSH	R4							; Resultado da conversão de linha do alien para posição Y no space
				PUSH	R5							; Indexador de linha do alien
				MOV		R4, M[aliensPosY]			; Recebe a posição inicial do space
				MOV		R5, R0						; Começa com o valor zero
getAlienALoop:	CMP		R5, R2						; Verifica se já ultrapassou a linha onde o R2 se encontra
				JMP.Z	getAlienAEnd
				ADD		R4, ALIEN_NEXT_LINE			; Adiciona de 2 em 2 enquanto muda de linha de alien
				INC		R5
				JMP		getAlienALoop
getAlienAEnd:	MOV		R3, M[R4+space]				; Endereçamento de R3 com a linha atual (R4) e a coluna atual (R1)
				ADD		R3, R1
				POP		R5
				POP		R4
				RET

writeAlien:		PUSH 	R4							; Endereço da parte
				PUSH 	R5							; Parte do alien
				PUSH	R6							; Tipo de parte do alien
				DEC		R1							; Vai para o 'começo' do alien pois o endereço da coluna do alien é o meio dele
				MOV		R4, R0						; Endereço da parte é definida como 0 até 2

writeAlienLoop:	CMP		R4, 3d
				JMP.Z 	writeAlienEnd
				CALL	getAlienAddress				; Endereço da parte do alien a ser escrita está em R3
				MOV		R6, M[alienAnimType]
				CALL	chooseAlien					; Função que escolhe o alien e suas partes que será usado para escrever na string
				MOV		M[R3], R5
				INC		R1
				INC		R4
				JMP		writeAlienLoop

chooseAlien: 	CMP		R2, 0d						; Linha 0 alien 1: .~. Alt: ,^,
				CALL.Z	alien1Part
				CMP		R2, 1d						; Linha 1 alien 2: <o> Alt: <O>
				CALL.Z	alien2Part
				CMP		R2, 2d						; Linha 2 alien 2: <o> Alt: <O>
				CALL.Z	alien2Part
				CMP		R2, 3d						; Linha 3 alien 3: -x_ Alt: _x-
				CALL.Z	alien3Part
				CMP		R2, 4d						; Linha 4 alien 3: -x_ Alt: _x-
				CALL.Z	alien3Part
				RET

alien1Part:		CMP		R4, 0d
				JMP.Z	alien1Part1
				CMP		R4, 1d
				JMP.Z	alien1Part2
				CMP		R4, 2d
				JMP.Z	alien1Part1
alien1Part1:	CMP		R6, ALIEN_ANIM_ALT
				JMP.Z	alien1Part1Alt	
				MOV		R5, ALIEN1_1
				RET
alien1Part1Alt:	MOV		R5, ALIEN1_1_ALT
				RET
alien1Part2:	CMP		R6, ALIEN_ANIM_ALT
				JMP.Z	alien1Part2Alt	
				MOV		R5, ALIEN1_2
				RET	
alien1Part2Alt:	MOV		R5, ALIEN1_2_ALT
				RET

alien2Part:		CMP		R4, 0d
				JMP.Z	alien2Part1
				CMP		R4, 1d
				JMP.Z	alien2Part2
				CMP		R4, 2d
				JMP.Z	alien2Part3
alien2Part1:	MOV		R5, ALIEN2_1
				RET
alien2Part2:	CMP		R6, ALIEN_ANIM_ALT
				JMP.Z	alien2Part2Alt	
				MOV		R5, ALIEN2_2
				RET
alien2Part2Alt:	MOV		R5, ALIEN2_2_ALT
				RET
alien2Part3:	MOV		R5, ALIEN2_3
				RET	

alien3Part:		CMP		R4, 0d
				JMP.Z	alien3Part1
				CMP		R4, 1d
				JMP.Z	alien3Part2
				CMP		R4, 2d
				JMP.Z	alien3Part3
alien3Part1:	CMP		R6, ALIEN_ANIM_ALT
				JMP.Z	alien3Part1Alt
alien3Part3Alt: MOV		R5, ALIEN3_1
				RET
alien3Part2:	MOV		R5, ALIEN3_2
				RET
alien3Part3:	CMP		R6, ALIEN_ANIM_ALT
				JMP.Z	alien3Part3Alt
alien3Part1Alt:	MOV		R5, ALIEN3_3
				RET	

writeAlienEnd:	SUB		R1, 2d						; Colocar R1 (Coluna do alien) de volta a posição onde estava
				POP		R6
				POP		R5
				POP		R4
				RET

getAlienColumn:	PUSH	R4							; Resultado da conversão de coluna do alien para posição X do space
				PUSH	R5							; Indexador de coluna do alien
				PUSH	R6
				MOV		R4, M[aliensPosX]			; Recebe a posição inicial do space
				MOV		R5, M[aliensReadyX]			; Começa com a primeira coluna de aliens vivo
				BR		getAlienCLoop

getAlienCLoop:	CMP		R4, R1						; Verifica se já chegou na coluna onde o R1 (Endereço da coluna do alien no space) se encontra
				BR.Z	getAlienCEnd
				ADD		R4, ALIEN_SIZE				; Adiciona de 3 em 3 para ir para o próximo alien
				INC		R5
				BR		getAlienCLoop
getAlienCEnd:	MOV		R3, R5						; Copiando o resultado para R3
				POP		R6
				POP		R5
				POP		R4
				RET

alienRight:		MOV		R1, M[aliensMaxPosX]		; R1 recebe a posição X do alien no space, que começará do final até o início para evitar erros de exclusão
				CMP		R1, ALIEN_MAX_X				; Verifica se já chegou no final da linha
				JMP.Z	alienRtoL					; É realizada o movimento para baixo
				MOV		R2, M[aliensPosX]
				INC		R1							; Nova posição final a esquerda da anterior
				INC		R2							; Nova posicao inicial a esquerda da anterior
				MOV		M[aliensMaxPosX], R1		; Guarda a nova posição final
				MOV		M[aliensPosX], R2			; Guarda a nova posição inicial
				MOV		R2, R0						; Linha de alien atual

alienRightLoop:	CMP		R2, M[aliensRows]			; Verifica se checou todas as linhas de alien
				JMP.Z	alienAnimChange
				CALL	getAlienColumn				; Converte a posição X do alien no space para a posição do alien em string (coluna 0 até coluna 9), R3 tem a coluna do alien
				MOV		R4, M[R2+aliensAlive]		; R4 Vai para a linha do aliensAlive
				ADD		R4, R3						; R4 vai para a coluna do aliensAlive
				MOV		R4, M[R4]					; Pega o caractere
				CMP		R4, ALIEN_DEAD				; Verifica se o alien da posição está vivo, se for NZ está mas se for Z não está
				CALL.NZ	writeAlien					; Realizado a escrita do alien na posição
				CMP		R1, M[aliensPosX]			; Verifica se já está no última coluna de alien
				JMP.Z	alienRightNL				; Se estiver vai para a próvima linha
				SUB		R1, 3d						; Vai para o próximo alien
				JMP		alienRightLoop
alienRightNL:	INC		R2							; Próxima linha de aliens
				MOV		R1, M[aliensMaxPosX]		; Volta para a posição x final
				JMP		alienRightLoop

alienLeft:		MOV		R1, M[aliensPosX]			; R1 recebe a posição X do alien no space, que começará do início até o final
				CMP		R1, ALIEN_MIN_X				; Verifica se já chegou no início da linha
				JMP.Z	alienLtoR					; É realizada o movimento para baixo
				MOV		R2, M[aliensMaxPosX]
				DEC		R1							; Nova posição inicial a esquerda
				DEC		R2							; Nova posicao final a esquerda
				MOV		M[aliensPosX], R1			; Guarda a nova posição inicial
				MOV		M[aliensMaxPosX], R2		; Guarda a nova posição final
				MOV		R2, R0						; Linha de alien atual

alienLeftLoop:	CMP		R2, M[aliensRows]			; Verifica se checou todas as linhas de alien
				JMP.Z	alienAnimChange
				CALL	getAlienColumn				; Converte a posição X do alien no space para a posição do alien em string (coluna 0 até coluna 9), R3 tem a coluna do alien
				MOV		R4, M[R2+aliensAlive]		; R4 Vai para a linha do aliensAlive
				ADD		R4, R3						; R4 vai para a coluna do aliensAlive
				MOV		R4, M[R4]					; Pega o caractere
				CMP		R4, ALIEN_DEAD				; Verifica se o alien da posição está vivo, se for NZ está mas se for Z não está
				CALL.NZ	writeAlien					; Realizado a escrita do alien na posição
				CMP		R1, M[aliensMaxPosX]		; Verifica se já está no última coluna de alien
				JMP.Z	alienLeftNL					; Se estiver vai para a próvima linha
				ADD		R1, 3d						; Vai para o próximo alien
				JMP		alienLeftLoop
alienLeftNL:	INC		R2							; Próxima linha de aliens
				MOV		R1, M[aliensPosX]			; Volta para a posição x inicial
				JMP		alienLeftLoop


eraseAlien:		PUSH	R4
				PUSH	R5							; Contém o caractere vácuo
				DEC		R1							; Vai para o 'começo' do alien pois o endereco da coluna do alien é o meio dele
				MOV		R4, R0						; Endereço da parte é definida como 0 ate 2

eraseAlienLoop:	CMP		R4, 3d	
				JMP.Z 	eraseAlienEnd
				CALL	getAlienAddress				; Endereço da parte do alien a ser removida está em R3
				MOV		R5, VACCUM
				MOV		M[R3], R5					; Substituição da parte por vácuo
				INC		R1
				INC		R4
				JMP		eraseAlienLoop

eraseAlienEnd:	SUB		R1, 2d						; Retornar R1 para a posição X que estava
				POP		R5
				POP		R4
				RET

eraseAliens:	PUSH	R1
				PUSH 	R2
				PUSH 	R3
				PUSH	R4
				MOV		R1, M[aliensPosX]			; A exclusão é do começo da coluna de aliens até o final dela
				MOV		R2, R0

eraseAliensLoop:CMP		R2, M[aliensRows]			; Verifica se checou todas as linhas de alien
				JMP.Z	eraseAliensEnd
				CALL	getAlienColumn				; Converte a posição X do alien no space para a posição do alien em string (coluna 0 até coluna 9), R3 tem a coluna do alien
				MOV		R4, M[R2+aliensAlive]		; R4 Vai para a linha do aliensAlive
				ADD		R4, R3						; R4 vai para a coluna do aliensAlive
				MOV		R4, M[R4]
				CMP		R4, ALIEN_DEAD				; Verifica se o alien da posição está vivo, se for NZ está mas se for Z não está
				CALL.NZ	eraseAlien					; Realizado a exclusão do alien na posição
				CMP		R1, M[aliensMaxPosX]		; Verifica se já está no última coluna de alien
				JMP.Z	eraseAliensNL				; Se estiver vai para a próvima linha
				ADD		R1, 3d						; Vai para o próximo alien
				JMP		eraseAliensLoop

eraseAliensNL:	INC		R2							; Próxima linha de aliens
				MOV		R1, M[aliensPosX]			; Volta para a posição x inicial
				JMP		eraseAliensLoop

eraseAliensEnd:	POP		R4
				POP		R3
				POP		R2
				POP		R1
				RET

alienIncrementY:MOV		R1, M[aliensMaxPosY]		; Altera a posicão máxima de Y dos aliens
				INC		R1
				MOV		M[aliensMaxPosY], R1

				CMP		R1, SHIELDS_Y				; Verifica se vai colidir com os escudos
				CALL.Z	beginErseShield				; Se sim, os escudos quebrarão

				CMP		R1, SHIP_ROW				; Verifica se vai chegar na posição Y da nave
				CALL.Z	setGameover					; Se Chegou, game over

				MOV		R1, M[aliensPosY]			; Incrementa a posicão mínima de Y dos aliens
				INC		R1
				MOV		M[aliensPosY], R1

				RET

alienRtoL:		MOV		R1, ALIEN_LEFT				; Muda a direção dos aliens
				MOV		M[alienDirection], R1
				CALL	alienIncrementY				; Incrementa Y e faz checks
				JMP		alienLeft					; Vai para função que move os aliens a direita

alienLtoR:		MOV		R1, ALIEN_RIGHT				; Muda a direção dos aliens
				MOV		M[alienDirection], R1
				CALL	alienIncrementY
				JMP		alienRight

alienAnimChange:MOV		R1, M[alienAnimType]		;Mudar de animação, basicamente ficar alternando
				CMP		R1, ALIEN_ANIM
				JMP.Z   alienAnimAlt
alienAnim:		MOV		R1, ALIEN_ANIM
				BR		alienAnimEnd

alienAnimAlt:	MOV		R1, ALIEN_ANIM_ALT
				BR		alienAnimEnd

alienAnimEnd:	MOV		M[alienAnimType], R1		; Guarda a nova animação
				MOV		R1, M[alienBullet]
				CMP		R1, BULLET_OFF				; Verifica se existe uma bala na tela ainda
				CALL.Z	alienShoot					; Se não, realize outro tiro
				JMP		alienMoveEnd

decreaseATimer:	MOV		R1, M[alienMoveTimer]		; Decrementador de timer
				DEC		R1
				MOV		M[alienMoveTimer], R1

alienMoveEnd:	POP		R4
				POP		R3
				POP		R2
				POP		R1
				RET

;---------------------------------------------------------------------------------------------
; FUNCTION:     Alien Shoot
; DESCRIPTION:  Faz um dos aliensReady atirar uma bala na tela por vez
;---------------------------------------------------------------------------------------------
alienShoot:		CALL	randomReady					;Pega um alien aleatório que está vivo em aliensReady
				PUSH	R1
				PUSH	R2
				PUSH	R3
				MOV		R1, M[selectedAlien]
				MOV		R1, M[R1+aliensReady]		; Acha ele em aliens ready
				DEC		R1							; Decrementa para respeitar a indexação (0 a 4 ao invés de 1 a 5) 
				MOV		R2, M[aliensPosX]
				MOV		R3, M[aliensReadyX]

alienShootLoopX:CMP		R3, M[selectedAlien]		; Descobre onde está a coluna do alien
				JMP.Z	alienShootY
				ADD		R2, ALIEN_SIZE				; Próximo alien
				INC		R3
				JMP		alienShootLoopX

alienShootY:	MOV		M[alienBulletPosX], R2
				MOV		R2, M[aliensPosY]
				MOV		R3, R0

alienShootLoopY:CMP		R1, R3						; Descobre onde está a linha do alien
				JMP.Z	alienShootEnd
				ADD		R2, ALIEN_NEXT_LINE			; Próxima linha de aliens no space
				INC		R3
				JMP		alienShootLoopY

alienShootEnd:	MOV		M[alienBulletPosY], R2		; Não precisa incrementar linha pois o alienBulletMove já vai fazer isso
				MOV		R1, BULLET_ON				; Altera o estado da bala do alien como ON
				MOV		M[alienBullet], R1
				POP		R3
				POP		R2
				POP		R1
				RET

;---------------------------------------------------------------------------------------------
; FUNCTION:     Bullet Move
; DESCRIPTION:  Faz as balas se moverem
;---------------------------------------------------------------------------------------------
bulletMove:		PUSH	R1
				PUSH	R3

				MOV		R1, M[bullet]				; Verificando se há bala no space para poder mover
				CMP		R1, BULLET_OFF
				JMP.Z	bulletMoveEnd

				CALL	getBulletAdress
				MOV		R3, M[R3]

				CMP		R3, ALIEN_BULLET		
				CALL.Z	bulletsCollide				; Pode ser que a bala do alien só apareça nesse check ao invés do bulletCheck (Motivos: timing ferrado)

				CMP		R3, SHIP_BULLET
				CALL.Z	eraseBullet					; Remove a bala da posição antiga, se não estiver na posição da nave

				MOV		R1, M[bulletPosY]			; R1 SEMPRE vai ter a posição Y da bala

				CMP		R1, 0d						; Verifica se chegou no fim da tela
				JMP.Z	bulletFinish

				DEC		R1							; Nova posição da bala
				MOV		M[bulletPosY], R1
				CALL	bulletCheck
				JMP		bulletMoveEnd

bulletCheck:	PUSH	R2
				PUSH	R3
				PUSH	R4
				CALL	getBulletAdress
				MOV		R4, M[R3]
				CMP		R4, VACCUM					; Se não tiver nada WRITE
				JMP.Z	bulletWrite
				CMP		R4, SHIELD					; Se tiver escudo...
				JMP.Z	shieldCheck
				CMP		R4, ALIEN_BULLET			; Se tiver uma bala de alien....
				JMP.Z	bulletsCollide
				JMP		alienCheck					; Se não for ninguém acima então é alien

bulletCheckEnd:	POP		R4
				POP		R3
				POP		R2
				RET

bulletsCollide:	CALL	eraseAlnBullet				; Exclui a bala da nave
				MOV		R4, BULLET_OFF				; Desliga as duas balas
				MOV		M[alienBullet], R4
				MOV		M[bullet], R4
				JMP		bulletCheckEnd

shieldCheck:	CALL	eraseBullet					; Um uso da função para excluir o escudo
				MOV		R4, BULLET_OFF				; Desliga o estado da bala
				MOV		M[bullet], R4
				JMP		bulletCheckEnd

alienCheck:		CALL	eraseAliens					; Limpa os aliens para não sobrar resíduos
				CALL	getAlienRHit				; Agora R2 tem a posição da linha do alien em relação ao conjunto de aliens (0 até 4)
				MOV		R3, M[bulletPosX]			; R3 tem a coluna da bala
				CALL	getAlienCHit				; Agora R3 tem a posição da coluna do alien em relação ao conjunto de aliens (0 até 9

				MOV		R4, M[R2+aliensAlive]		; R4 tem a linha de aliensAlive
				ADD		R4, R3						; R4 tem a coluna de aliensAlive

				CALL	killAlien					; Bota o alien como morto, triste dia ;_;

				CALL	addScore					; Atualiza o score de acordo com o alien acertado

				CALL	updAliensReady				; Atualiza o aliens ready

				CALL	alienUpdateRow				; Atualiza a quantidade de linhas de aliens
				MOV		R1, M[aliensRows]			; Verifica se todas as linhas de aliens foram eliminadas
				
				CALL	alienUpdateCln				; Atualiza a quantidade de colunas

				MOV		M[alienMoveTimer], R0		; Realiza o print denovo dos aliens sem alterar o timer que está com o clock
				CMP		R1, 0d
				CALL.Z	setWin						; Vence o jogo
				CALL	alienMove

				MOV		R4, BULLET_OFF
				MOV		M[bullet], R4
				JMP		bulletCheckEnd

killAlien:		PUSH	R5							; Um PUSH/POP do R5 pois quero guardar o ALIEN_DEAD e atualizar o alienAliveCount

				MOV		R5, ALIEN_DEAD
				MOV		M[R4], R5					; Substitui por ALIEN_DEAD
				MOV		R5, M[alienAliveCount]		; Diminui a quantidade de alien alive
				DEC		R5
				MOV		M[alienAliveCount], R5

				CMP		R5, 34d						; Se estiver com aproximadamente 2/3 de aliens vivos, aumenta a velocidade
				CALL.Z	increaseSpeed
				CMP		R5, 17d						; Se estiver com aproximadamente 1/3 de aliens vivos, aumenta ainda mais a velocidade
				CALL.Z	increaseSpeed

				POP		R5
				RET

; Recebe R2, que vai estar com o valor da linha do alien em relação ao conjunto de aliens
addScore:		PUSH	R5
				MOV		R5, M[scoreCount]

				CMP		R2, 0d						; .~.
				CALL.Z  alien1Score
				CMP		R2, 1d						; <o>
				CALL.Z  alien2Score
				CMP		R2, 2d						; <o>
				CALL.Z  alien2Score
				CMP		R2, 3d						; _x-
				CALL.Z  alien3Score
				CMP		R2, 4d						; _x-s
				CALL.Z  alien3Score

				MOV		M[scoreCount], R5
				POP		R5

				CALL	updateScore
				RET

alien1Score:	ADD		R5, 200d
				RET

alien2Score:	ADD		R5, 150d
				RET

alien3Score:	ADD		R5, 100d
				RET

;getAlienRowHit R2 recebe a posição da linha do alien em relação ao conjunto de aliens (0 até 4)
getAlienRHit:	PUSH	R4							; Posição Y no space da linha de alien
				PUSH	R5							; Indexador de Y
				MOV		R4, M[aliensPosY]
				MOV		R5, R0

getAlienRHLoop: CMP		R4, R1
				BR.Z	getAlienRHEnd

				INC		R5
				ADD		R4, ALIEN_NEXT_LINE
				BR		getAlienRHLoop

getAlienRHEnd: 	MOV		R2, R5
				POP		R5
				POP		R4
				RET

;getAlienColumnHit R3 recebe a posição da coluna do alien em relação ao conjunto de aliens (0 até 9)
getAlienCHit:	PUSH	R4							; Posição X no space da linha de alien
				PUSH	R5							; Indexador de coluna do alien
				PUSH	R6							; Contagem de partes
				MOV		R4, M[aliensPosX]			; Recebe a posição inicial da linha de aliens
				DEC		R4							; Vai para a posição da primeira parte de alien
				MOV		R5, M[aliensReadyX]			; Começa com a primeira coluna de aliens viva
				
				MOV		R6, R0						; Começa na primeira parte do alien (Pois é onde é registrado a posição do alien)

getAlienCHLoop:	CMP		R6, ALIEN_SIZE				; Verifica se está na última parte de um alien
				BR.Z	nextAlien

				CMP		R4, R3						; Verifica se já chegou na coluna onde o R3 (Endereço da coluna da bala no space) se encontra
				BR.Z	getAlienCHEnd

				INC		R4							; Próxima posição X
				INC		R6							; Próxima parte
				BR		getAlienCHLoop

nextAlien:		MOV		R6, R0						; Reseta o contador de parte do alien
				INC		R5							; Próximo alien
				BR		getAlienCHLoop

getAlienCHEnd:	MOV		R3, R5						; Copiando o resultado para R3
				POP		R6
				POP		R5
				POP		R4
				RET

; Vai atualizar os aliens que estiverem vivos (aliens ready)

rstAliensReady:	PUSH	R1							; Indexador de coluna do aliensReady
				MOV		R1, R0						; Coluna inicial começará com o valor iniical 0

rstAliensRLoop:	CMP		R1, ALIEN_ROW_SIZE			; Tamanho de aliensReady
				BR.Z	rstAliensREnd

				MOV		M[R1+aliensReady], R0		; Copia o valor zero para a posição R1 de aliensReady
				INC		R1							; Próxima coluna
				BR		rstAliensRLoop	

rstAliensREnd:	POP		R1
				RET

newAlienReady:	INC		R2							; Para respeitar o alinhamento de aliensReady
				MOV		M[R1+aliensReady], R2		; Registra a linha que o alien está vivo no alines alive
				DEC		R2							; Volta para seu estado original
				RET

updAliensReady:	CALL	rstAliensReady				; Isso vai zerar o aliens Ready para fazer esse novo aliens ready
				PUSH	R1
				PUSH	R2
				PUSH	R3
				MOV		R1, R0						; Coluna inicial começará com o valor iniical 0
				MOV		R2, R0 						; Linha inical é a primeira linha do conjunto de aliens
				
updAlienRLoop:	MOV		R3, M[R2+aliensAlive]
				CMP		R3, EOL						; Verifica se chegou no fim do ultima linha de aliensAlive
				BR.Z	updAlienREnd

				ADD		R3, R1
				MOV		R3, M[R3]
				CMP		R3, EOL						; Verifica se chegou na ultima coluna de aliensAlive
				BR.Z	updAlienRNL					; Nova linha

				CMP		R3, ALIEN_ALIVE
				CALL.Z	newAlienReady

				INC		R1
				BR		updAlienRLoop

updAlienRNL:	MOV		R1, R0
				INC		R2
				BR		updAlienRLoop

updAlienREnd:	POP		R3
				POP		R2
				POP		R1
				RET

; Guarda em R3 o endereço da bala da nave
getBulletAdress:PUSH	R1
				PUSH	R2
				MOV		R1, M[bulletPosY]
				MOV		R2, M[bulletPosX]			; Obtém em R2 a coluna
				MOV		R3, M[R1+space]				; R3 obtém a linha
				ADD		R3, R2						; R3 obtém a coluna
				POP		R2
				POP		R1
				RET

; Escreve a bala da nave
bulletWrite:	MOV		R4, SHIP_BULLET
				MOV		M[R3], R4
				JMP		bulletCheckEnd

; Apaga a bala da nave
eraseBullet:	PUSH	R3							; Vai conter o endereço da bala
				PUSH	R4							; Vai conter o caractere do vácuo
				MOV		R4, VACCUM
				CALL	getBulletAdress				; R3 Vai ter o endereço da bala
				MOV		M[R3], R4
				POP		R4
				POP		R3
				RET

bulletFinish:	MOV		R1, BULLET_OFF
				MOV		M[bullet], R1	
bulletMoveEnd:	POP		R3
				POP		R1
				RET

;---------------------------------------------------------------------------------------------
; FUNCTION:     Increase Speed
; DESCRIPTION:  Aumenta a velocidade de movimento dos aliens
;---------------------------------------------------------------------------------------------
increaseSpeed:	PUSH	R2							; Aumenta a velocidade decrementando o valor inicial que o timer recebe
				MOV		R2, M[alienMoveSpeed]
				DEC		R2
				MOV		M[alienMoveSpeed], R2
				POP		R2
				RET

;---------------------------------------------------------------------------------------------
; FUNCTION:     Erase Shield
; DESCRIPTION:  Remove os escudos '#' do space
;---------------------------------------------------------------------------------------------
beginErseShield:PUSH	R1
				PUSH	R2
				PUSH	R3
				PUSH	R4
				MOV		R1, SHIELDS_Y				; R1 começa com o valor inicial da linha de escudos
				MOV		R2, 0d						; R2 começa com a primeira coluna da linha de escudos

eraseShieldLoop:CMP		R1, SHIELDS_MAX_Y			; Verifica se já passamos por todas as linhas com escudos
				BR.P	eraseShieldEnd
				MOV		R3, M[R1+space]				; Obtém o endereço da linha
				ADD		R3, R2						; Obtém o endereço da coluna
				MOV		R4, M[R3]					; R4 contém o conteúdo de R3
				CMP		R4, EOL						; Se for EOL próxima linha
				BR.Z	eraseShieldNL
				CMP		R4, SHIELD					; Se for um escudo remove
				CALL.Z	eraseShield
				INC		R2							; Próxima coluna
				BR		eraseShieldLoop

eraseShieldNL:	MOV		R2, 0d						; Reseta a coluna
				INC		R1							; Incrementa a linha
				BR		eraseShieldLoop

eraseShield:	MOV		R4, VACCUM					; Substitui por vácuo
				MOV		M[R3], R4
				RET

eraseShieldEnd:	POP		R4
				POP		R3
				POP		R2
				POP		R1
				RET

;---------------------------------------------------------------------------------------------
; FUNCTION:     Update Score
; DESCRIPTION:  Atualiza o score d\na tela de acordo com sua variável inteira
;---------------------------------------------------------------------------------------------
updateScore:	PUSH	R1								; Pontuação no formato inteiro
				PUSH	R2								; Posição da pontuação no space
				PUSH	R3								; Magnitude do score e guarda resto.

				; Milhar
				MOV		R1, SCORE_Y
				MOV		R2, M[R1+space]
				ADD		R2, SCORE_X						; Posição inicial da pontuação no space (Começa no milhar)

				MOV		R1, M[scoreCount]
				MOV		R3, 1000d
				DIV		R1, R3
				ADD		R1, DIGIT_CONVERTER				; Converte o digito para sua forma em char
				MOV		M[R2], R1						; Guarda na posição
				
				; Centena
				INC		R2								; Posição da centena da pontuação no space

				MOV		R1, R3							; Recebe o resto que sobrou
				MOV		R3, 100d
				DIV		R1, R3
				ADD		R1, DIGIT_CONVERTER				; Converte o digito para sua forma em char
				MOV		M[R2], R1						; Guarda na posição
				
				; Dezena
				INC		R2								; Posição da dezena da pontuaço no space

				MOV		R1, R3							; Recebe o resto que sobrou
				MOV		R3, 10d
				DIV		R1, R3
				ADD		R1, DIGIT_CONVERTER				; Converte o digito para sua forma em char
				MOV		M[R2], R1						; Guarda na posição
				
				POP		R3	
				POP		R2
				POP		R1
				RET

;---------------------------------------------------------------------------------------------
; FUNCTION:     Random Ready
; DESCRIPTION:  Escolhe um alien ready para atirar
;---------------------------------------------------------------------------------------------
randomReady:	PUSH	R1								; Pega aleatoriamente um alien se seja capaz de atirar
				PUSH	R2
				
randomReadyLoop:CALL	random
				MOV		R2, ALIEN_ROW_SIZE
				MOV		R1, M[randomVar]
				DIV		R1, R2							; Divide o randomVar pelo tamanho de aliensReady para pegar um valor entre (0 e 9)
				MOV		R1, M[R2+aliensReady]
				CMP		R1, R0							; Verifica se a coluna de aliensReady está viva
				BR.Z	randomReadyLoop

				MOV		M[selectedAlien], R2
				POP		R2
				POP		R1
				RET

random:			PUSH	R1
				MOV		R1, LSB_MASK
				AND		R1, M[randomVar] 				; R1 = bit menos significativo de M[randomVar]
				BR.Z	rndRotate
				MOV		R1, RND_MASK
				XOR		M[randomVar], R1

rndRotate:		ROR		M[randomVar], 1d
				POP		R1
				RET
;---------------------------------------------------------------------------------------------
; FUNCTION:     screenPrint
; DESCRIPTION:  Print das strings na janela
;---------------------------------------------------------------------------------------------
beginScrnPrint:	PUSH	R1
				PUSH	R2
				PUSH	R3
				PUSH	R4
				PUSH	R5
				
screenPrintLoop:MOV	    R1, M[row]						; Começo da linha
				MOV		R2, M[column]					; Começo da coluna
				
				MOV		R3, M[row]						; Movimentação do mouse em R3
				SHL		R3, ROW_SHIFT	
				OR 		R3, M[column]
				MOV		M[CURSOR], R3

				CALL	chooseOp						; Escolha da tela a fazer o print
				
				CMP		R4, EOL							; Verificar se terminou de printar o mapa
				JMP.Z	screenPrintEnd

				ADD		R4, M[column]					; Consegue o endereço onde vai printar
				MOV		R5, M[R4]						; Pega o char do endereço

				CMP		R5, EOL							; Verifica se chegou no fim da linha para ir para uma próxima
				JMP.Z	screenPrintNL
				
				MOV		M[IO_WRITE], R5 				; Imprime ao caractere
				INC		M[column]						; Próxima coluna da linha
				JMP		screenPrintLoop

screenPrintNL:	INC		M[row]							; Incrementa a linha
				MOV		M[column], R0					; Volta para a priemira coluna
				JMP		screenPrintLoop

screenPrintEnd: MOV		M[row], R0						; Reseta os valores
				MOV		M[column], R0
				POP		R5
				POP		R4
				POP		R3
				POP		R2
				POP		R1
				RET

chooseOp:		PUSH	R2								; Esolhe a opção que vai printar
				MOV		R2, M[printOp]
				CMP		R2, MENU_OP
				BR.Z	menuOp
				CMP		R2, SPACE_OP
				BR.Z	spaceOp
				CMP		R2, GAMEOVER_OP
				BR.Z	gameoverOp
				CMP		R2, WIN_OP
				BR.Z	winOp
menuOp:			MOV		R4, M[R1+menu]
				BR		endChooseOp
spaceOp:		MOV		R4, M[R1+space]
				BR		endChooseOp
gameoverOp:		MOV		R4, M[R1+gameover]
				BR		endChooseOp
winOp:			MOV		R4, M[R1+win]
				BR		endChooseOp
endChooseOp:	POP		R2
				RET
;---------------------------------------------------------------------------------------------
; FUNCTION: Main
; DESCRIPTION: Função principal do codigo
;---------------------------------------------------------------------------------------------
Main:           MOV	    R1, INITIAL_SP
                MOV	    SP, R1                              ; Inicializar a pilha
                MOV	    R1, CURSOR_INIT		                ; Inicializar o cursor com CURSOR_INIT
                MOV	    M[CURSOR], R1

                CALL    beginScrnPrint

				MOV		R1, TIMER_ON
				MOV		M[clockState], R1
				CALL	setClock
				MOV		R1, INT_MASK
				MOV		M[INT_SET], R1
				
				ENI

; Timer estava lento mesmo no modo mais rápido, então inventei o loop na main chamado de Hard Mode, que é beeeem mais rápido.
hardMode:		MOV		R1, M[difficulty]				; Vê se o hard mode está ativado
				CMP		R1, HARD_MODE
				CALL.Z	clockFunctions					; Chama as funções do clock
				MOV     R1, M[alienAliveCount]
                MOV     R2, 10000
                MUL     R1, R2
delay:			DEC 	R1								; Hard mode estava muito rápido, então botei um delay
                CMP		R1, R0
                BR.Z	delay
				BR		hardMode

Cycle:          BR      Cycle
Halt:           BR      Halt