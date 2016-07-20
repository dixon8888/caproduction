close all
SET SAFE OFF
CLEAR
SET TALK OFF
SET EXAC ON
*************
SELE 1
USE C:\DONGGUAN\CAORDER
SELE 2
USE C:\DONGGUAN\CAPROD
SELE 3
USE C:\DONGGUAN\CATRACK
**copy to c:\temp\kctrack for order_no='KC' and inspe_date={//}
SELE 5
USE C:\DONGGUAN\STOCK\CASTOCK
COPY TO C:\TEMP\CASTOCK FOR 'KC'$BIN_NO
USE
************** 
**sele 4
**use C:\DONGGUAN\kctrack
**zap
**appe from c:\temp\kctrack
**dele all for 'CANCEL'$ca_status
**pack
**repl all qty with prod_qty
**appe from c:\temp\castock
**inde on p_no to c:\temp\t
**total on p_no to c:\temp\castock1 fields qty
**sele 4
**use c:\temp\castock1
**sele 6
**use c:\dongguan\kcorder
**zap
**appe from c:\dongguan\kcqty
**go top
**do while not eof()
**sele 4
**scan
**if p_no=f.p_no and qty<f.l_qty 
**sele 6
**scat memv
**m.order_no='KC'
**m.order_qty=qty-d.qty
**m.bill_to='KC'
**m.order_date=date()
**m.ship_date=date()+7
**m.od_memo='KC'
**gath memv
**sele 4
**endif
**if p_no=f.p_no and qty>=f.l_qty
**sele 6
**scat memv fields order_no,od_memo
**m.order_no='dele'
**m.od_memo='dele'
**gath memv fields order_no,od_memo
**sele 4
**endif
**endscan
**sele 6
**if order_no=' '
**scat memv 
**m.order_no='KC'
**m.order_qty=qty
**m.bill_to='KC'
**m.order_date=date()
**m.ship_date=date()+7
**m.od_memo='KC'
**gath memv
**endif
**skip
**enddo
**use 
**sele 4
**use c:\dongguan\kcorder
**dele all for order_no='dele'
**pack
**scan
**if floor(order_qty/50)=0
**endif
**if floor(order_qty/50)#0
**repl order_qty with floor(order_qty/50)*50
**endif
**endscan
**repl all p_no with ' '
**use
*************
**sele 1
**use c:\dongguan\caorder
**appe from c:\dongguan\kcorder
*************
SELE 2
use c:\dongguan\caprod
COPY TO C:\TEMP\CAPROD 
SELE 4
USE C:\TEMP\CAPROD
REPL ALL SPEC WITH ALLT(CAP_CODE)+' '+'P'+ALLT(GRIT)+' '+ALLT(STR(WIDE))+'*'+ALLT(STR(LENTH)) 
REPL ALL SPEC WITH ALLT(CAP_CODE)+' '+'Z'+ALLT(GRIT)+' '+ALLT(STR(WIDE))+'*'+ALLT(STR(LENTH)) FOR ALLT(CAP_CODE)='R888'
INDE ON SPEC TO C:\TEMP\T
SELE 1
use c:\dongguan\caorder
REPL ALL SPEC WITH ALLT(CAP_CODE)+' '+'P'+ALLT(GRIT)+' '+ALLT(STR(WIDE))+'*'+ALLT(STR(LENTH)) FOR P_NO=' '
REPL ALL SPEC WITH ALLT(CAP_CODE)+' '+'Z'+ALLT(GRIT)+' '+ALLT(STR(WIDE))+'*'+ALLT(STR(LENTH)) FOR P_NO=' ' AND ALLT(CAP_CODE)='R888'
INDE ON SPEC TO C:\TEMP\TT
SET RELA TO SPEC INTO D
SET SKIP TO D
REPL ALL JOINT WITH D.JOINT FOR SPEC=D.SPEC AND JOINT=' ' AND D.SPECIAL='N'
REPL ALL JOINT WITH D.JOINT FOR SPEC=D.SPEC AND JOINT=' ' AND D.SPECIAL='Y'
SET RELA TO
SCAN
DO CASE
   CASE DJOINT='LAP'
   IF (JOINT='NTS' OR JOINT='MTS' OR JOINT='FTS')
   ELSE
   REPL JOINT WITH ' '
   ENDIF
   CASE DJOINT='BUTT'
   IF (JOINT='NORLOK' OR JOINT='FNORLOK' OR JOINT='PLYWELD')
   ELSE
   REPL JOINT WITH' '   
   ENDIF
   ENDCASE   
ENDSCAN
CLOSE ALL
*************
SELE 2
use c:\dongguan\caprod
REPL ALL SPEC WITH ALLT(CAP_CODE)+' '+'P'+ALLT(GRIT)+' '+ALLT(STR(WIDE))+'*'+ALLT(STR(LENTH))+'/'+ALLT(JOINT) 
REPL ALL SPEC WITH ALLT(CAP_CODE)+' '+'Z'+ALLT(GRIT)+' '+ALLT(STR(WIDE))+'*'+ALLT(STR(LENTH))+'/'+ALLT(JOINT) FOR ALLT(CAP_CODE)='R888'
INDE ON SPEC TO C:\TEMP\T
SELE 1
use c:\dongguan\caorder
REPL ALL SPEC WITH ALLT(CAP_CODE)+' '+'P'+ALLT(GRIT)+' '+ALLT(STR(WIDE))+'*'+ALLT(STR(LENTH))+'/'+ALLT(JOINT) FOR P_NO=' '
REPL ALL SPEC WITH ALLT(CAP_CODE)+' '+'Z'+ALLT(GRIT)+' '+ALLT(STR(WIDE))+'*'+ALLT(STR(LENTH))+'/'+ALLT(JOINT) FOR P_NO=' ' AND ALLT(CAP_CODE)='R888'
SET RELA TO SPEC INTO B
REPL ALL P_NO WITH B.P_NO FOR SPEC=B.SPEC AND P_NO=' ' AND B.OK='*'
SET RELA TO
*************
SELE 4
USE c:\DONGGUAN\CA_NO
SELE 1
use c:\dongguan\caorder
GO TOP
DO WHILE NOT EOF()
IF CA_NO=' ' AND NOTE=' ' AND P_NO#' ' 
SELE 4
CA=CA_NO+1
REPL CA_NO WITH CA
SELE 1
REPL CA_NO WITH ALLT('CA')+ALLT(STR(CA)) 
REPL NOTE WITH '张觉民' 
REPL INPUT_DATE WITH DATE()
ENDIF
SKIP 
ENDDO 
COPY TO C:\TEMP\TEMORDER FOR ALLT(NOTE)='张觉民'
REPL ALL NOTE WITH '已转单' FOR ALLT(NOTE)='张觉民' 

**************
SELE 3
use c:\dongguan\catrack
COPY STRU TO C:\TEMP\TEMTRACK 
SELE 2
use c:\dongguan\caprod
INDE ON P_NO TO C:\TEMP\T
SELE 4
USE C:\TEMP\TEMTRACK 
APPE FROM C:\TEMP\TEMORDER
INDE ON P_NO TO C:\TEMP\TT
SET RELA TO P_NO INTO B
REPL ALL GROUP_NO WITH B.GROUP_NO,PATCH WITH B.PATCH,ANGLE WITH B.ANGLE,HQJ WITH B.HQJ,MBJ WITH B.MBJ,PRESS WITH B.PRESS,PACK WITH B.PACK,CASE_NO WITH B.CASE_NO FOR P_NO=B.P_NO
REPL ALL JOINT WITH B.JOINT FOR P_NO=B.P_NO AND JOINT=' '
SET RELA TO
***
REPL ALL PROD_QTY WITH ORDER_QTY
REPL ALL PRINT_DATE WITH DATE() 
REPL ALL CA_STATUS WITH '库存' FOR ORDER_NO='KC'
USE
***************
SELE 5
USE C:\TEMP\CASTOCK
INDE ON P_NO TO C:\TEMP\T
TOTAL ON P_NO TO C:\TEMP\CASTOCK1 FIELDS QTY
USE C:\TEMP\CASTOCK1
SELE 4
USE C:\TEMP\TEMTRACK
GO TOP
DO WHILE NOT EOF()
SELE 5
SCAN
IF P_NO=D.P_NO AND ALLT(D.ORDER_NO)#'KC' AND QTY>0
SELE 4
DO CASE
   CASE PROD_QTY>E.QTY
        REPL PROD_QTY WITH PROD_QTY-E.QTY
        SCAT MEMV
        M.PROD_QTY=E.QTY
        M.CA_STATUS='Applied'
        INSERT BLANK
        GATH MEMV
        REPL CA_BATCH WITH '0/0'
        SELE 5
        REPL QTY WITH 0
        SELE 4
   CASE PROD_QTY<=E.QTY
        REPL CA_STATUS WITH 'Applied'
        REPL CA_BATCH WITH '0/0'
        SELE 5
        REPL QTY WITH QTY-D.PROD_QTY
        SELE 4
ENDCASE                
SELE 5
ENDIF
ENDSCAN
SELE 4
SKIP
ENDDO
USE
***************
SELE 4
USE C:\TEMP\TEMTRACK
COPY TO C:\TEMP\FDTEMT FOR PROD_QTY>300 AND CA_BATCH#'0/0'
DELE ALL FOR PROD_QTY>300 AND CA_BATCH#'0/0'
PACK
*REPL ALL CA_BATCH WITH ' '
REPL ALL CA_BATCH WITH '1/1' FOR CA_BATCH#'0/0' AND PROD_QTY<=300
USE
SELE 4
USE C:\TEMP\FDTEMT 
GO TOP
DO WHILE NOT EOF()
IF PROD_QTY>300
DELE
SCAT MEMV
FDNO=PROD_QTY/300
STORE PROD_QTY TO T 
J=FLOOR(FDNO) 
R=CEILING(FDNO)
STORE 1 TO I
STORE 1 TO K
S=0
FOR FD =I TO J STEP K
S=S+1
INSE BLANK
M.CA_BATCH=ALLT(STR(S))+ALLT('/')+ALLT(STR(R))
M.PROD_QTY=300
GATH MEMV
T=T-300
ENDFOR
INSE BLANK
M.CA_BATCH=ALLT(STR(R))+ALLT('/')+ALLT(STR(R))
M.PROD_QTY=T
GATH MEMV
ENDIF
SKIP
ENDDO
PACK
USE
SELE 4
USE C:\TEMP\TEMTRACK
APPE FROM C:\TEMP\FDTEMT
DELE ALL FOR PROD_QTY=0
PACK
COPY TO C:\DONGGUAN\CAPRINT
USE
***************
SELE 3
use C:\dongguan\catrack
APPE FROM C:\TEMP\TEMTRACK
COPY TO C:\TEMP\CABD  
***************
SELE 4
USE C:\TEMP\CABD 
DELE ALL FOR ORDER_NO='KC'
PACK
REPL ALL INSPE_QTY WITH PROD_QTY FOR INSPE_DATE={//} 
INDE ON CA_NO TO C:\TEMP\T
TOTAL ON CA_NO TO C:\DONGGUAN\CABD FIELDS INSPE_QTY
SELE 4
USE C:\DONGGUAN\CABD 
REPL ALL CA_BATCH WITH ' '
GO TOP
SCAN
IF ORDER_QTY>INSPE_QTY    
SCAT MEMV FIELDS PROD_QTY,INPUT_DATE
M.PROD_QTY=ORDER_QTY-INSPE_QTY
M.INPUT_DATE=DATE()
GATH MEMV FIELDS PROD_QTY,INPUT_DATE 
ELSE
DELE
ENDIF
ENDSCAN
PACK
USE

SELE 4
USE C:\TEMP\CABD SHARE
GO TOP
SCAN
PO=AT('/',CA_BATCH)
A=LEFT(CA_BATCH,(PO-1))
B=RIGHT(CA_BATCH,(6-PO))
IF A>B
DELE
ENDIF
ENDSCAN
INDE ON CA_NO TO C:\TEMP\T
SELE 5
USE C:\DONGGUAN\CABD SHARE
GO TOP
DO WHILE NOT EOF()
STORE CA_NO TO CANO
SELE 4
GO TOP
SET EXAC OFF
SEEK(CANO)
IF FOUND()
COUNT ALL TO NO FOR CA_NO=CANO AND CA_BATCH#'0/0'
COUNT ALL TO NNO FOR CA_NO=CANO AND DELE()=.F. AND CA_BATCH#'0/0'
SELE 5
REPL CA_BATCH WITH ALLT(STR(NO+1))+ALLT('/')+ALLT(STR(NNO))
ENDIF
SELE 5
SKIP
ENDDO
REPL ALL SM WITH 0,YLQX WITH 0,START_DATE WITH {//},DOWN_DATE WITH {//},CUT_WIDE WITH 0,CUT_LENTH WITH 0,CUT_QTY WITH 0,TIME WITH 0,INSPE_DATE WITH {//},CUT_QTY WITH 0,INSPE_QTY WITH 0,STOCK_DATE WITH {//},STOCK_QTY WITH 0,ASN_SHIP WITH {//},DELIVE_QTY WITH 0,INVOICE_NO WITH ' ',CA_STATUS WITH '补单'
repl all print_date with date()
USE

SELE 3
use C:\dongguan\catrack
appe from C:\dongguan\cabd
REPL ALL CA_CODE WITH SUBSTR(CA_NO,3,6)+"-"+ALLT(CA_BATCH)
***************
SELE 4
use c:\dongguan\caprint
appe from c:\dongguan\cabd
SELE 1
USE C:\DONGGUAN\CAORDER 
COPY TO C:\DONGGUAN\NOP_NO FIELDS SPEC,CAP_CODE,GRIT,WIDE,LENTH,JOINT,DJOINT FOR P_NO=' ' 
close all
SET TALK ON
SET SAFE ON
SET EXAC OFF
RETURN

