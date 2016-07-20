
ACCEPT '                输入定单号码(如CA0307-080):  ' TO P1
ACCEPT '                输入客户代码(如C000023):  ' TO q1
ACCEPT '                输入工作方式(屏幕观看V 打印P):  ' TO r1
P=UPPE(P1)
Q=UPPE(q1)
R=UPPE(r1)

IF R='V'
SET DEVICE TO SCREEN 
ENDIF
IF R='P'
SET DEVICE TO PRINT
ENDIF
SET CENTURY ON

use c:\dongguan\出库单\customer

IF  'C'$q 

scan for q$cust_no 

@4,20 SAY '圣戈班磨料磨具(上海)有限公司东莞分厂' FONT '宋体',16
@6,40 SAY '发货单 (CA)' FONT '宋体',16
@8,10 SAY '客户编号：'+cust_no  FONT '宋体',11
@8,65 SAY '定单号码:'+P FONT '宋体',11
@9,10 SAY '客户税号:' FONT '宋体',11
@9,65 SAY '出帐日期:' FONT '宋体',11
@10,10 SAY '客户名称:'+cust_name FONT '宋体',11
@10,65 SAY '发票号码:' FONT '宋体',11
@11,10 SAY '到货地址:'+add FONT '宋体',11
@11,65 SAY '发票日期:' FONT '宋体',11
@12,10 SAY '电话:'+tel FONT '宋体',11
@12,65 SAY '提货日期:' FONT '宋体',11
@13,65 SAY '联系人:'+person FONT '宋体',11
@14,15 SAY '出货方式:  火车慢件/火车快件/中铁快运/公路/送货/(自提)' FONT '宋体',11
@15,15 SAY '包装方式:  木箱/(纸箱)' FONT '宋体',11
@15,65 SAY '用途:  样品(销售)' FONT '宋体',11
@16,15 SAY '运费结算:应收/自付/到付' FONT '宋体',11
@16,65 SAY '发货日期:' FONT '宋体',11
 
endscan

ENDIF 
 
IF  !'C'$q 

@4,20 SAY '圣戈班磨料磨具(上海)有限公司东莞分厂' FONT '宋体',16
@6,40 SAY '发货单 (CA)' FONT '宋体',16
@8,10 SAY '客户编号：'  FONT '宋体',11
@8,65 SAY '定单号码:'+P FONT '宋体',11
@9,10 SAY '客户税号:' FONT '宋体',11
@9,65 SAY '出帐日期:' FONT '宋体',11
@10,10 SAY '客户名称:' FONT '宋体',11
@10,65 SAY '发票号码:' FONT '宋体',11
@11,10 SAY '到货地址:' FONT '宋体',11
@11,65 SAY '发票日期:' FONT '宋体',11
@12,10 SAY '电话:' FONT '宋体',11
@12,65 SAY '提货日期:' FONT '宋体',11
@13,65 SAY '联系人:' FONT '宋体',11
@14,15 SAY '出货方式:  火车慢件/火车快件/中铁快运/公路/送货/(自提)' FONT '宋体',11
@15,15 SAY '包装方式:  木箱/(纸箱)' FONT '宋体',11
@15,65 SAY '用途:  样品(销售)' FONT '宋体',11
@16,15 SAY '运费结算:应收/自付/到付' FONT '宋体',11
@16,65 SAY '发货日期:' FONT '宋体',11

ENDIF
 
i=18

USE C:\DONGGUAN\CATRACK.DBF

@i,5   SAY '┏━━━━━━┯━━━━┯━━━━┯━━┯━━━━┯━━━━┯━━━━┯━━━┯━━━━┓' FONT '宋体',11

@i+1,5 SAY '┃  工作单号  │产品号　│　材料  │粒度│ 宽(mm) │ 长(mm) │　数量  │ 箱数 │箱子代号┃' FONT '宋体',11

IF 'CA'$P OR 'KC'$P 
 
SCAN FOR P$ORDER_NO AND !('CANCEL'$OD_MEMO OR 'cancel'$OD_MEMO)

@i+2,5 SAY '┠──────┼────┼────┼──┼────┼────┼────┼───┼────┨' FONT '宋体',11

A=LEN (ALLT(CA_CODE))
B=LEN (ALLT(P_NO))
C=LEN (ALLT(CAP_CODE))
D=LEN (ALLT(GRIT))
E=LEN (ALLT(STR(WIDE)))
F=LEN (ALLT(STR(LENTH)))
G=LEN (ALLT(STR(PROD_QTY)))
A1=12-A
B1=8-B
C1=8-C
D1=4-D
E1=8-E
F1=6-F
G1=8-G


@i+3,5 SAY '┃'+ALLT(SUBS(CA_CODE,1,12))+SPACE(A1)+'│'+ALLT(SUBS(P_NO,1,8))+SPACE(B1)+'│'+ALLT(SUBS(CAP_CODE,1,8))+SPACE(C1)+'│'+ALLT(SUBS(GRIT,1,6))+SPACE(D1)+'│'+ALLT(STR(WIDE,7,0))+SPACE(E1)+'│'+ALLT(STR(LENTH,7,1))+SPACE(F1)+'│'+ALLT(STR(PROD_QTY,7,0))+SPACE(G1)+'│'+'      │        ┃' FONT '宋体',11  

i=i+2
ENDSCAN

DO WHILE i<=42

@i+2,5 SAY '┠──────┼────┼────┼──┼────┼────┼────┼───┼────┨' FONT '宋体',11


@i+3,5 SAY '┃            │    　  │　      │    │        │        │        │      │        ┃' FONT '宋体',11

i=i+2
ENDDO


@i+2,5 SAY '┠──────┼────┼────┼──┼────┼────┼────┼───┼────┨' FONT '宋体',11

@i+3,5 SAY '┃            │    　  │　      │    │        │        │        │      │        ┃' FONT '宋体',11

@i+4,5 SAY '┗━━━━━━┷━━━━┷━━━━┷━━┷━━━━┷━━━━┷━━━━┷━━━┷━━━━┛' FONT '宋体',11

ENDIF

IF !'CA'$P  

@i+2,5 SAY '┠──────┼────┼────┼──┼────┼────┼────┼───┼────┨' FONT '宋体',11

@i+3,5 SAY '┃            │    　  │　      │    │        │        │        │      │        ┃' FONT '宋体',11

i=i+2

DO WHILE i<=42

@i+2,5 SAY '┠──────┼────┼────┼──┼────┼────┼────┼───┼────┨' FONT '宋体',11


@i+3,5 SAY '┃            │    　  │　      │    │        │        │        │      │        ┃' FONT '宋体',11

i=i+2
ENDDO


@i+2,5 SAY '┠──────┼────┼────┼──┼────┼────┼────┼───┼────┨' FONT '宋体',11

@i+3,5 SAY '┃            │    　  │　      │    │        │        │        │      │        ┃' FONT '宋体',11

@i+4,5 SAY '┗━━━━━━┷━━━━┷━━━━┷━━┷━━━━┷━━━━┷━━━━┷━━━┷━━━━┛' FONT '宋体',11

ENDIF


@i+6,6 SAY '总箱数:' FONT '宋体',11
@i+7,6 SAY '总重量:' FONT '宋体',11
@i+7,55 SAY '余下转库存' FONT '宋体',11
@i+8,6 SAY '总金额:' FONT '宋体',11
@i+9,5 SAY '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━' FONT '宋体',11
@i+11,6 SAY '销售员' FONT '宋体',11
@i+11,40 SAY '客户服务部' FONT '宋体',11
@i+11,68 SAY '库存控制' FONT '宋体',11
@i+13,6 SAY '仓库发货' FONT '宋体',11
@i+13,40 SAY '受货人' FONT '宋体',11
@i+13,68 SAY '备注' FONT '宋体',11
@i+15,6 SAY '第一联:  开出门单  第二联:  仓库发货  第三联:  客户留存  第四联:  客户验收回单' FONT '宋体',11

IF R='P'
SET DEVICE TO SCREEN
SET PRINTER TO LPT1.DOS
ENDIF
IF R='V'
ENDIF
RETURN

