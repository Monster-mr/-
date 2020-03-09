; haribote-ipl
; TAB=4

		ORG		0x7c00			; bios中断将第一个扇区512字节复制到的内存地址

; 软盘的格式?有名字等的信息

		JMP		entry ;只有这一句是程序（用于跳转程序主体） 下面的是软盘描述
		DB		0x90
		DB		"HARIBOTE"		; 
		DW		512				; 
		DB		1				; 
		DW		1				; 
		DB		2				; 
		DW		224				; 
		DW		2880			; 
		DB		0xf0			; 
		DW		9				; 
		DW		18				;
		DW		2				; 
		DD		0				; 
		DD		2880			; 
		DB		0,0,0x29		; 
		DB		"HARIBOTEOS "	; 
		DB		"FAT12   "		; 
		RESB	18				; 

; 程序主体

entry:
		MOV		AX,0			;初始化寄存器
		MOV		SS,AX           ;0x16 + 0x7c00  SS:SP 堆栈操作
		MOV		SP,0x7c00
		MOV		DS,AX

; 加载0-0-2到内存的es：bx

		MOV		AX,0x0820
		MOV		ES,AX
		MOV		CH,0			; 柱面0
		MOV		DH,0			; 磁头0
		MOV		CL,2			; 扇区2
readloop:		;循环
		MOV		SI,0			; 失敗回数を数えるレジスタ
retry:
		MOV		AH,0x02			; AH=0x02 : 读盘
		MOV		AL,1			; 读一个扇区
		MOV		BX,0
		MOV		DL,0x00			; 指定A驱动器
		INT		0x13			; 调用bios中断函数
		JNC		next			; not carry调用成功跳转next
		ADD		SI,1			; SIに1を足す
		CMP		SI,5			; SIと5を比較
		JAE		error			; SI >= 5 だったらerrorへ
		MOV		AH,0x00         ;失败后磁盘调用重置
		MOV		DL,0x00			; Aドライブ
		INT		0x13			; ドライブのリセット
		JMP		retry			;重置后再次尝试读盘
next:
		MOV		AX,ES			; アドレスを0x200進める
		ADD		AX,0x0020
		MOV		ES,AX			; 将es加0x0020个地址
		ADD		CL,1			; 读18个扇区   0-0-(2~18)
		CMP		CL,18			; 
		JBE		readloop		; CL <= 18 だったらreadloopへ

; 読み終わったけどとりあえずやることないので寝る

fin:
		HLT						; 终止
		JMP		fin				; 停留不退出
;此处以下为
error:
		MOV		SI,msg
putloop:
		MOV		AL,[SI]
		ADD		SI,1			; SIに1を足す
		CMP		AL,0
		JE		fin
		MOV		AH,0x0e			; 显示一个文字
		MOV		BX,15			; 字符颜色
		INT		0x10			; 调用显卡显示
		JMP		putloop
msg:
		DB		0x0a, 0x0a		; 换行
		DB		"load error"
		DB		0x0a			; 改行
		DB		0

		RESB	0x7dfe-$		; 00填充剩余空间

		DB		0x55, 0xaa
