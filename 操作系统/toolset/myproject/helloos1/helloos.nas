;hello-os 
;TAB=4
		ORG		0x7c00		;指明程序的装载地址
		
;以下用于记述标准FAT12格式的软盘

		JMP		entry
		DB		0x90
		
		