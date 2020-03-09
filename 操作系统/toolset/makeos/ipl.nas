; haribote-ipl
; TAB=4
	CYLS	EQU		10

		ORG		0x7c00			; ���̃v���O�������ǂ��ɓǂݍ��܂��̂�

; �ȉ��͕W���I��FAT12�t�H�[�}�b�g�t���b�s�[�f�B�X�N�̂��߂̋L�q

		JMP		entry
		DB		0x90
		DB		"HARIBOTE"		; �u�[�g�Z�N�^�̖��O�����R�ɏ����Ă悢�i8�o�C�g�j
		DW		512				; 1�Z�N�^�̑傫���i512�ɂ��Ȃ���΂����Ȃ��j
		DB		1				; �N���X�^�̑傫���i1�Z�N�^�ɂ��Ȃ���΂����Ȃ��j
		DW		1				; FAT���ǂ�����n�܂邩�i���ʂ�1�Z�N�^�ڂ���ɂ���j
		DB		2				; FAT�̌��i2�ɂ��Ȃ���΂����Ȃ��j
		DW		224				; ���[�g�f�B���N�g���̈�̑傫���i���ʂ�224�G���g���ɂ���j
		DW		2880			; ���̃h���C�u�̑傫���i2880�Z�N�^�ɂ��Ȃ���΂����Ȃ��j
		DB		0xf0			; ���f�B�A�̃^�C�v�i0xf0�ɂ��Ȃ���΂����Ȃ��j
		DW		9				; FAT�̈�̒����i9�Z�N�^�ɂ��Ȃ���΂����Ȃ��j
		DW		18				; 1�g���b�N�ɂ����̃Z�N�^�����邩�i18�ɂ��Ȃ���΂����Ȃ��j
		DW		2				; �w�b�h�̐��i2�ɂ��Ȃ���΂����Ȃ��j
		DD		0				; �p�[�e�B�V�������g���ĂȂ��̂ł����͕K��0
		DD		2880			; ���̃h���C�u�傫����������x����
		DB		0,0,0x29		; �悭�킩��Ȃ����ǂ��̒l�ɂ��Ă����Ƃ����炵��
		DD		0xffffffff		; ���Ԃ�{�����[���V���A���ԍ�
		DB		"HARIBOTEOS "	; �f�B�X�N�̖��O�i11�o�C�g�j
		DB		"FAT12   "		; �t�H�[�}�b�g�̖��O�i8�o�C�g�j
		RESB	18				; �Ƃ肠����18�o�C�g�����Ă���

; �v���O�����{��

entry:
		MOV		AX,0			; ���W�X�^������
		MOV		SS,AX
		MOV		SP,0x7c00
		MOV		DS,AX

; �f�B�X�N��ǂ�

		MOV		AX,0x0820           
		MOV		ES,AX              ;[ES:BX]��??�I����既?��??���n��??�I���� 
		;����搥?����?��?������0x7c00??�I������A��?�ݐ��ݎʓI?��??�������
		;??������?��??ox7c00           ox7c00 + 0x200 = ox7e00
		MOV		CH,0			; ����0
		MOV		DH,0			; ��?0
		MOV		CL,2			; ���2

readloop:
		MOV		SI,0			;??��?�����I�񑶊�
retry�F
		MOV		AH,0x02			; AH=0x02 : ??
		MOV		AL,1			; ��????���I��搔
		MOV		BX,0
		MOV		DL,0x00			; A??��
		INT		0x13			; ?�pbios��??����
		JNC		next           ;jump if not carry flag�iCF�j cf?1?�p��?
		
		ADD		SI,1
		CMP		SI,5
		JAE		error                 ;jump if above or equal
		
		MOV 	AH,0x00
		MOV		DL,0x00
		INT		0x13                  ;�d�u??��
		JMP		retry

next:
		MOV		AX,ES              ;�c�����n���@��0x200      512����?
		ADD		AX,0x0020
		MOV 	ES,AX
		
		ADD		CL,1                ;�ȍ�?��?��18�����C�A
		;��?��?�c��?��C0-H0-S2��C0-H0-S18�I512�~17=8 704��?�I���e�C��?���������I0x8200�`0xa3ff
		CMP		CL,18
		JBE		readloop            ;below or equal   ����������
		;?������18�����?�n?����
		
		MOV 	CL,1			;���1
		ADD		DH,1          	;��?1
		CMP 	DH,2
		JB		readloop
		
		MOV		DH,0
		ADD		CH,1
		CMP		CH,CYLS
		JB		readloop

fin:
		HLT						; ��������܂�CPU���~������
		JMP		fin				; �������[�v

error:
		MOV		SI,msg
putloop:
		MOV		AL,[SI]
		ADD		SI,1			; SI��1�𑫂�
		CMP		AL,0
		JE		fin
		MOV		AH,0x0e			; �ꕶ���\���t�@���N�V����
		MOV		BX,15			; �J���[�R�[�h
		INT		0x10			; �r�f�IBIOS�Ăяo��
		JMP		putloop
msg:
		DB		0x0a, 0x0a		; ���s��2��
		DB		"load error"
		DB		0x0a			; ���s
		DB		0

		RESB	0x7dfe-$		; 0x7dfe�܂ł�0x00�Ŗ��߂閽��

		DB		0x55, 0xaa
