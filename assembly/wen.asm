	#��ʹ��˵��������SW21����ģʽ1������SW22����ģʽ2������SW23����ģʽ3��ģʽ3��ʹ��SW[5:0]ָ������λ��
	
	#���üĴ�����s0,s1��SW21,ģʽ1��,s2��SW22,ģʽ2��,s3��SW23,ģʽ3��,s4(temp),s5(temp2),s6(cnt1)��s8(last state),s11�������
	lui   s0,0xFFFFF
	li s11,0
Check:
	sw s11,0x60(s0)   #���
	add s4,zero,s11
	srli s4,s4,16
	sw s4,0x62(s0)
	
	li s6,0           #�ȴ�����
Wait:                     #�ȴ�����
	addi s6,s6,1      #�ȴ�����
	li   s4,1000000#ģ��10���ϰ�1000000      �ȴ�����
	bne  s6,s4,Wait   #�ȴ�����
	
	lw   s4,0x72(s0)  #��ȡSW�ĸ�8λ
	#li s4,0x80
	andi s3,s4,0x80   #��SW[23:21]�ֱ�д��s3/s2/s1
	andi s2,s4,0x40
	andi s1,s4,0x20
	bne  s1,zero,Mod1 #����SW��ֵ������ģʽ��ת
	bne  s2,zero,Mod2
	bne  s3,zero,Mod3
	li   s11,0        #δѡ���κ�ģʽ�������0�������¼������
	li   s8,0
	j    Check         
	
Mod1:	#ģʽ1
	#���üĴ�����s7������״̬��,s9����λ���֣�,s10����λ���֣�
	li  s4,1
	beq s8,s4,Norst1
	li  s8,1
	#ģʽ�Ѹı䣬���и�λ
	li s7,0
	li s9,0
	li s10,0
Norst1: #ģʽδ�ı䣬���踴λ
	#�ɵ���״̬���ȷ������״̬
	li s4,12
	bge s7,s4,Dark1
Light1:
	#���µ�״̬,ʹ���ĵƸ���
	add  s11,s9,s10
	slli s9,s9,1
	addi  s9,s9,1
	li s4,0x800000
	srli s10,s10,1
	add s10,s10,s4
	j Update1
Dark1:	
	#���µ�״̬,ʹ���ĵƸ���
	add s11,s9,s10
	srli s9,s9,1
	li s4,0x800000
	sub s10,s10,s4
	slli s10,s10,1
Update1:
	addi s7,s7,1      #���µ���״̬���s7
	li s4,25
	bne  s7,s4,Check
	li s7,1
	li s9,1
	li s10,0x800000
	j Check           #�����ж�
Mod2:   #ģʽ2
	#���üĴ�����s7������״̬��
	li s4,2
	beq s8,s4,Norst2
	li s8,2
	#ģʽ�Ѹı䣬���и�λ
	li s7,1
	li s11,0x800000
Norst2:#ģʽδ�ı䣬���踴λ
	li s4,24
	bge s7,s4,Dark2
Light2:#���µ�״̬,ʹ���ĵƸ���
	srli s11,s11,1
	li s4,0x800000
	add s11,s11,s4
	j Update2
Dark2:#���µ�״̬,ʹ���ĵƸ���
	srli s11,s11,1
Update2:
	addi s7,s7,1      #���µ���״̬���s7
	li s4,48
	bne  s7,s4,Check
	li s7,1
	li s11,0x800000
	j Check           #�����ж�
Mod3:   #ģʽ3
	#���üĴ�����t0����������,s9����������������
	li s4,3
	bne s8,s4,Rst3
	lw   t0,0x70(s0)#ȡSW�ĵ�6λ����Ϊ���� 
	bne t0,s9,Rst3
	j Norst3
Rst3:#ģʽ/�������Ѹı䣬���и�λ
	lw   t0,0x70(s0)#ȡSW�ĵ�6λ����Ϊ���� 
	add s9,t0,zero
	li s11,0
	li s5,0
	li s8,3
LoadNum:#���ݶ�ȡ�Ĳ��뿪�����룬���ó�ʼ���Ʋ���
	beq t0,zero,Norst3
	slli s11,s11,1
	addi s11,s11,1
	addi s5,s5,1
	bne s5,t0,LoadNum
Norst3:#ģʽδ�ı䣬���踴λ
	andi s4,s11,1
	slli s4,s4,23
	srli s11,s11,1
	add s11,s11,s4
	j Check           #�����ж�
