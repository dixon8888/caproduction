*���ò���ԭʼ����

SET SAFETY OFF
SET TALK OFF

*BOM��e:\�����ļ�\�ɱ�Ԥ��\dgbom.dbf��

IF date()<={2006/10/26}

USE e:\glwj\chbys\dgbom.dbf EXCLUSIVE
ZAP
APPE FROM C:\DONGGUAN\CAPROD.DBF

replace all rawwide with 1360 for "R2" $ CAP_CODE OR "R4" $ CAP_CODE OR "R8" $ CAP_CODE OR "R9" $ CAP_CODE OR CAP_CODE="ZY-R" or cap_code="A455"
replace all rawwide with 1440 for "S" $ CAP_CODE OR "K" $ CAP_CODE OR "M" $ CAP_CODE OR "T" $ CAP_CODE
replace all rawwide with 609 for cap_code="U254" OR CAP_CODE="U264" OR CAP_CODE="U464" OR CAP_CODE="U366" OR CAP_CODE="U242" OR CAP_CODE="U254" OR CAP_CODE="U434" OR CAP_CODE="U162"
replace all rawwide with 1168 for cap_code="A275"  OR CAP_CODE="A277"
replace all rawwide with 1340 for cap_code="R801"
replace all rawwide with 1380 for cap_code="H231" OR CAP_CODE="H189" OR CAP_CODE="AH231"
replace all rawwide with 1420 for cap_code="FH231" OR CAP_CODE="FAH231"
replace all rawwide with 1450 for cap_code="P84F" 
replace all rawwide with 1430 for cap_code="S468"
replace all rawwide with 1480 for cap_code="R484"

brow for rawwide-wide<0

* ���㵥������

SCAN ALL
IF INT(RAWWIDE/WIDE)=1
REPLACE USEWIDE WITH WIDE+MIN((RAWWIDE-WIDE),80)
REPLACE USEAREA WITH USEWIDE*LENTH/1000000
endif

IF INT(RAWWIDE/WIDE)>1 AND INT(RAWWIDE/WIDE)<30
REPLACE USEWIDE WITH WIDE+(RAWWIDE-WIDE*INT(RAWWIDE/WIDE))/INT(RAWWIDE/WIDE)
REPLACE USEAREA WITH USEWIDE*LENTH/1000000
endif

IF INT(RAWWIDE/WIDE)>29
REPLACE USEWIDE WITH WIDE+(RAWWIDE-30*WIDE)/INT(RAWWIDE/WIDE)
REPLACE USEAREA WITH USEWIDE*LENTH/1000000
ENDIF

ENDSCAN

*�Ƕ��趨
replace all angle_d with VAL(SUBSTR(ANGLE,1,2))
*������ˮ����
*glue176: 32kg/46141m, mek: 140kg/46141m, re: 17.6kg/46141m

replace all glue_176 with 0.001*3*(32/46141)*wide/SIN(DTOR(angle_d)) for joint="NLK" OR JOINT="PLY" OR JOINT="FNLK" 
replace all glue_176 with 0.001*2*(32/46141)*wide/SIN(DTOR(angle_d)) for joint="NTS" OR JOINT="FTS"
replace all glue_176 with 3*0.001*3*(32/46141)*wide/SIN(DTOR(angle_d)) for group_no='E' and (cap_code='S468' or cap_code='R484')
replace all glue_176 with 3*0.001*2*(32/46141)*wide/SIN(DTOR(angle_d)) for group_no='E' and cap_code='P84F'


replace all GLUE_MEK with 0.001*3*(140/46141)*wide/SIN(DTOR(angle_d)) for joint="NLK" OR JOINT="PLY" OR JOINT="FNLK" OR JOINT="FNLK"
replace all glue_MEK with 0.001*2*(140/46141)*wide/SIN(DTOR(angle_d)) for joint="NTS" OR JOINT="FTS"
replace all GLUE_MEK with 3*0.001*3*(140/46141)*wide/SIN(DTOR(angle_d)) for group_no='E' and (cap_code='S468' or cap_code='R484')
replace all glue_MEK with 3*0.001*2*(140/46141)*wide/SIN(DTOR(angle_d)) for group_no='E' and cap_code='P84F'

replace all glue_RE with 0.001*3*(17.6/46141)*wide/SIN(DTOR(angle_d)) for joint="NLK" OR JOINT="PLY" OR JOINT="FNLK" OR JOINT="FNLK"
replace all glue_RE with 0.001*2*(17.6/46141)*wide/SIN(DTOR(angle_d)) for joint="NTS" OR JOINT="FTS"
replace all glue_RE with 3*0.001*3*(17.6/46141)*wide/SIN(DTOR(angle_d)) for group_no='E' and (cap_code='S468' or cap_code='R484')
replace all glue_RE with 3*0.001*2*(17.6/46141)*wide/SIN(DTOR(angle_d)) for group_no='E' and cap_code='P84F'



*����PATCH����,��15%waste  ��λ����
replace all patch_tape with 1.15*wide/SIN(DTOR(angle_d)) for joint="NLK" OR JOINT="PLY" OR JOINT="FNLK" OR JOINT="FNORLOK"
replace all patch_tape with 3*1.15*wide/SIN(DTOR(angle_d)) for group_no='E' and (cap_code='S468' or cap_code='R484')


*�����װ��������
Replace all p_box with  1/VAL(SUBSTR(PACK,1,4)) for group_no<>"R" AND GROUP_NO#'E'
Replace all p_board with 0 
*p_paper��λKg/PIECE
*����Norax,ֻ��ֽ��Ͱ�װ��

Replace all p_paper with 0  for "U" $ CAP_CODE
Replace all p_bag with 0.00148   for "U" $ CAP_CODE
*���ڿ���С��300��ɰ����ֻ�ð�װ�䣬Norax ����(Norax ���˰�װ���⣬���ð�װ��) 

Replace all p_paper with 0  for   wide<300
Replace all p_bag   with 0  for   wide<300 and not ("U" $ CAP_CODE)
 
Replace all p_paper with 0.00696  for   wide>=300 and wide<=600 
Replace all p_bag   with 0.002664  for   wide>=300 and wide<=600 
*���ڿ��ȴ���600�����ȴ���180,ͬʱ��51���ֺ�73��������Ĥ
*PPE 51cm 55.5g/m,73cm 73.5g/m,ţƤֽ53��(1346mm)174g/m

Replace all p_paper with 0  for   wide>600 and wide<=1000 and VAL(grit)>=180 and group_no<>"R"
Replace all p_bag   with  0.01806 for  wide>600 and wide<=1000 and VAL(grit)>=180 and group_no<>"R"

Replace all p_paper with 0.025854  for   wide>600 and wide<=1000 and VAL(grit)<180  and VAL(grit)>=100 and group_no<>"R"
Replace all p_paper with  0.051709 for  wide>600 and wide<=1000 and VAL(grit)<=80 and group_no<>"R"
Replace all p_bag with 0.00777  for   wide>600 and wide<=1000 and VAL(grit)<180  and VAL(grit)>=100 and group_no<>"R"
Replace all p_bag with  0.01554 for  wide>600 and wide<=1000 and VAL(grit)<=80 and group_no<>"R"

Replace all p_paper with 0  for  wide>1000 and VAL(grit)>=180 and group_no<>"R"
Replace all p_bag   with  0.031485 for wide>1000 and VAL(grit)>=180 and group_no<>"R"
Replace all p_paper with 0.0522  for  wide>1000 and VAL(grit)>=100 and VAL(grit)<180 and group_no<>"R"
Replace all p_bag with 0.0094  for  wide>1000 and VAL(grit)>=100 and VAL(grit)<180 and group_no<>"R"
Replace all p_paper with 0.1044  for  wide>1000 and  VAL(grit)<=80 and group_no<>"R"
Replace all p_bag with 0.01887  for  wide>1000 and VAL(grit)<=80 and group_no<>"R"


Replace all p_label with 2/VAL(SUBSTR(PACK,1,4))for group_no<>"R" AND GROUP_NO#'E'
Replace all p_label with 2 for group_no="R" AND WIDE>300
Replace all p_box with  1/VAL(SUBSTR(PACK,1,4)) for group_no="R" AND WIDE <=300
Replace all p_label with  2/VAL(SUBSTR(PACK,1,4)) for group_no="R" AND WIDE <=300

Replace all p_nail with 8/VAL(SUBSTR(PACK,1,4))  for group_no<>"R" AND GROUP_NO#'E'
Replace all p_nail with 8/VAL(SUBSTR(PACK,1,4))  for group_no="R" AND WIDE <=300

ELSE
clear
?'    �����ѹ���!!'
cancel

ENDIF

CLOSE ALL
SET SAFETY ON
SET TALK ON
