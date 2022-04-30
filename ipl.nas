; hello-os
; TAB=4

ORG 0x7c00			; 指明程序装载地址

JMP entry
DB 0x90
DB "MYOOOOOS"
DW 512
DB 1
DW 1
DB 2
DW 224
DW 2880
DB 0Xf0
DW 9
DW 18
DW 2
DD 0
DD 2880
DB 0,0,0x29
DD 0xffffffff
DB "my-------os"    ; 磁盘名称11字节
DB "FAT12   "       ; 磁盘格式名称8字节
RESB 18

; 程序主体
entry:
MOV AX,0			; 初始化寄存器
MOV SS,AX
MOV SP,0x7c00
MOV DS,AX
MOV ES,AX

MOV SI,msg

putloop:
MOV AL,[SI]
ADD SI,1			; 给SI加1
CMP AL,0
JE	fin
MOV	AH,0X0e			; 显示一个文字
MOV BX,15			; 指定字符颜色
INT 0x10			; 调用显卡BIOS
JMP	putloop

fin:
HLT
JMP fin

msg:
DB	0x0a,0x0a
DB	"test world test!!!!"
DB	0x0a
DB	0

RESB	0x7dfe-$	; 填写0x00直到0x001fe
DB	0x55,0xaa
