; haribote-ipl
; TAB=4

CYLS	EQU		10				; どこまで読み込むか

		ORG		0x7c00			; このプログラムがどこに読み込まれるのか

; 以下は標準的なFAT12フォーマットフロッピーディスクのための記述

		JMP		entry
		DB		0x90
		DB		"HARIBOTE"		; ブートセクタの名前を自由に書いてよい（8バイト）
		DW		512				; 1セクタの大きさ（512にしなければいけない）
		DB		1				; クラスタの大きさ（1セクタにしなければいけない）
		DW		1				; FATがどこから始まるか（普通は1セクタ目からにする）
		DB		2				; FATの個数（2にしなければいけない）
		DW		224				; ルートディレクトリ領域の大きさ（普通は224エントリにする）
		DW		2880			; このドライブの大きさ（2880セクタにしなければいけない）
		DB		0xf0			; メディアのタイプ（0xf0にしなければいけない）
		DW		9				; FAT領域の長さ（9セクタにしなければいけない）
		DW		18				; 1トラックにいくつのセクタがあるか（18にしなければいけない）
		DW		2				; ヘッドの数（2にしなければいけない）
		DD		0				; パーティションを使ってないのでここは必ず0
		DD		2880			; このドライブ大きさをもう一度書く
		DB		0,0,0x29		; よくわからないけどこの値にしておくといいらしい
		DD		0xffffffff		; たぶんボリュームシリアル番号
		DB		"HARIBOTEOS "	; ディスクの名前（11バイト）
		DB		"FAT12   "		; フォーマットの名前（8バイト）
		RESB	18				; とりあえず18バイトあけておく

; プログラム本体

entry:
		MOV		AX,0			; 初始化
		MOV		SS,AX
		MOV		SP,0x7c00
		MOV		DS,AX

; ディスクを読む

		MOV		AX,0x0820           
		MOV		ES,AX             ; [ES:BX]将软盘的第二扇区里数据放到地址[ES:BX]开始的内存 
		;第一扇区是开机自动加载到内存0x7c00开始的内存也就是现在正在写的这个汇编文件会被
		;编译成机器码加载到ox7c00 0x00007c00-0x00007dff：读取引导扇区的地址 
		MOV		CH,0			; 柱面0
		MOV		DH,0			; 磁头0
		MOV		CL,2			; 扇区2

readloop:
		MOV		SI,0			;记录失败次数的寄存器
retry：
		MOV		AH,0x02			; AH=0x02 : 读磁盘
		MOV		AL,1			; 连续处理的扇区数
		MOV		BX,0
		MOV		DL,0x00			; A驱动器
		INT		0x13			; 调用bios内的例程
		JNC		next           ;jump if not carry flag（CF） cf=1  调用失败
		
		ADD		SI,1
		CMP		SI,5
		JAE		error                 ;jump if above or equal
		
		MOV 	AH,0x00
		MOV		DL,0x00
		INT		0x13                  ;重置驱动器
		JMP		retry

next:
		MOV		AX,ES              ;把内存地址后移0x200      512个字节
		ADD		AX,0x0020
		MOV 	ES,AX
		
		ADD		CL,1                ;以此类推了18个扇区，
		;我们已经把磁盘上C0-H0-S2到C0-H0-S18的512×17=8704字节的内容，装载到了内存的0x8200～0xa3ff处
		CMP		CL,18
		JBE		readloop            ;below or equal   小于或等于
		;取完正面18个扇区开始取反面
		
		MOV 	CL,1			;扇区1
		ADD		DH,1          	;磁头1
		CMP 	DH,2
		JB		readloop
		
		MOV		DH,0
		ADD		CH,1
		CMP		CH,CYLS
		JB		readloop




		MOV		[0x0ff0],CH		; 跳到复制进内存的系统代码去执行
		JMP		0xc200

error:
		MOV		SI,msg
putloop:
		MOV		AL,[SI]
		ADD		SI,1			; SIに1を足す
		CMP		AL,0
		JE		fin
		MOV		AH,0x0e			; 一文字表示ファンクション
		MOV		BX,15			; カラーコード
		INT		0x10			; ビデオBIOS呼び出し
		JMP		putloop
fin:
		HLT						; 何かあるまでCPUを停止させる
		JMP		fin				; 無限ループ
msg:
		DB		0x0a, 0x0a		; 改行を2つ
		DB		"load error"
		DB		0x0a			; 改行
		DB		0

		RESB	0x7dfe-$		; 0x7dfeまでを0x00で埋める命令

		DB		0x55, 0xaa
