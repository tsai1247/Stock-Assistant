Attribute VB_Name = "T4functions"





' �n�X
Public Declare PtrSafe Function log_out _
 Lib "C:\vba dll\t4.dll" _
() As Integer



' �n�J
Public Declare PtrSafe Function init_t4 _
 Lib "C:\vba dll\t4.dll" _
( ByVal login_id As String _
, ByVal login_pass As String _
, ByVal dll_path As String) As String
' login_id   : �n�JID   (�����Ҹ��B�۵M�H�B���q�νs)
' login_pass : �n�J�K�X (�D���ұK�X)
' dll_path   : ���w������|, �i�ť�



'�����U��Ҧ� (���ԤU��^��echo�P�_)
Public Declare Function change_echo Lib "C:\vba dll\t4.dll" _
() As String



' ���Ҥw�n�J���Ҥ��K�X�O�_���T
Public Declare PtrSafe Function verify_ca_pass Lib "C:\vba dll\t4.dll" _
( ByVal branch As String _
, ByVal account As String) As String
' branch         : �����q�N�X
' account        : ���ұb��



'----------------------------------------------------------------------------
' ���f�U��
Public Declare PtrSafe Function future_order Lib "C:\vba dll\t4.dll" _
( ByVal buy_or_sell As String _
, ByVal branch As String _
, ByVal account As String _
, ByVal code As String _
, ByVal price As String _
, ByVal amount As String _
, ByVal price_type As String _
, ByVal ordtype As String _
, ByVal octtype As String) As String
' buy_or_sell : "B" = �R�J, "S" = ��X
' branch      : �����q�N��
' account     : ���f�b��
' code        : �ӫ~�N��
' price       : ����
' amount      : �f��
' price type  : ����O�G "MKT"����, "LMT"����
' ordtype     : �e�U�O�G ROD / FOK / IOC
' octtype     : �ܧO�G "0" = �s��  "1" = ���� " "= �۰�  "6"= ��R



' ���f�R��
Public Declare PtrSafe Function future_cancel Lib "C:\vba dll\t4.dll" _
( ByVal branch As String _
, ByVal account As String _
, ByVal code As String _
, ByVal ord_seq As String _
, ByVal ord_num As String _
, ByVal none As String _
, ByVal pre_order As String) As String
' branch      : �����q�N��
' account     : ���f�b��
' code        : �ӫ~�N��
' ord_seq     : �����渹
' ord_num     : �e�U�渹
' none        : "" �O�d����
' pre_order   : "N" - �D�w����, " " - �w����



' ���f���
Public Declare PtrSafe Function future_change Lib "C:\vba dll\t4.dll" _
( ByVal org_seqno As String _
, ByVal org_ordno As String _
, ByVal branch As String _
, ByVal account As String _
, ByVal code As String _
, ByVal new_price As String _
, ByVal pre_order As String) As String
' org_seqno : ������Ѹ�
' org_ordno : ��e�U�Ѹ� (�w�����e�U)
' branch    : ��U�� �����q�N��
' account   : ��U�� �b��
' code      : ����f�ӫ~ (10�X)
' new_price : �s��
' pre_order : �O�_���w���� (P=�w����, N=�D�w����)



' ����v���
Public Declare PtrSafe Function option_change Lib "C:\vba dll\t4.dll" _
( ByVal org_seqno As String _
, ByVal org_ordno As String _
, ByVal branch As String _
, ByVal account As String _
, ByVal code As String _
, ByVal new_price As String _
, ByVal pre_order As String) As String
' org_seqno : ������Ѹ�
' org_ordno : ��e�U�Ѹ� (�w�����e�U)
' branch    : ��U�� �����q�N��
' account   : ��U�� �b��
' code      : ��ӫ~ (10�X)
' new_price : �s��
' pre_order : �O�_���w���� (P=�w����, N=�D�w����)




' ����v�U��
Public Declare PtrSafe Function option_order Lib "C:\vba dll\t4.dll" _
( ByVal buy_or_sell As String _
, ByVal branch As String _
, ByVal account As String _
, ByVal code As String _
, ByVal price As String _
, ByVal amount As String _
, ByVal price_type As String _
, ByVal ordtype As String _
, ByVal octtype As String _
, ByVal IsComp As String _
, ByVal bs2 As String _
, ByVal commodity2 As String) As String
' option_order �ꤺ����v�U��
'
' buy_or_sell : "B" = �R�J, "S" = ��X
' branch      : �����q�N��
' account     : ���f�b��
' code        : �ӫ~�N��
' price       :  ���� 6���
' amount      : �f�� 3���
' price type  : "MKT"����, "LMT"����
' type_1      : "IOC" or "ROD" or "FOK"
' type_2      : "0" �s��, "1" ����, " " �۰�
' ordtype     : "IOC" or "ROD" or "FOK"
' octtype     : "0" �s��, "1" ����, " " �۰�
' IsComp      : "S" �榡 , "C" �Ʀ�
' bs2         : �ĤG�ӫ~ �R�J / ��X
' commodity2  : �ĤG�ӫ~�N��



' ����v�R��
Public Declare PtrSafe Function option_cancel Lib "C:\vba dll\t4.dll" _
( ByVal branch As String _
, ByVal account As String _
, ByVal code As String _
, ByVal ord_seq As String _
, ByVal ord_num As String _
, ByVal octtype As String _
, ByVal pre_order As String) As String
' branch     : �����q�N��
' account    : ���f�b��
' code       : �ӫ~�N��
' ord_seq    : �����渹
' ord_num    : �e�U�渹
' octtype    : "0" �s��, "1" ����, " " �۰�
' pre_order  : "N" - �D�w����, " " - �w����



'----------------------------------------------------------------------------
' �Ҩ�U�� (�v�ҡB�W�d�B�W�d�v��)
Public Declare PtrSafe Function stock_order Lib "C:\vba dll\t4.dll" _
( ByVal buy_or_sell As String _
, ByVal branch As String _
, ByVal account As String _
, ByVal code As String _
, ByVal ord_type As String _
, ByVal price As String _
, ByVal amount As String _
, ByVal price_type As String) As String

Public Declare PtrSafe Function stock_order2 Lib "C:\vba dll\t4.dll" _
( ByVal buy_or_sell As String _
, ByVal branch As String _
, ByVal account As String _
, ByVal code As String _
, ByVal ord_type As String _
, ByVal price As String _
, ByVal amount As String _
, ByVal price_type As String _
, ByVal ordknd As String ) As String

' buy_or_sell : "B"=�R�J, "S"=��X, "F"=����
' branch      : �����q�N��
' account     : �b��
' code        : �Ѳ��N��
' ord_type    :
'               "P0" �w�L�{��, "P3" �w�L�ĸ�, "P4" �w�L�Ĩ�
'               "00" ��Ѳ{��, "03" ��ѿĸ�, "04" ��ѿĨ�
'               "20" �s��
'
' price       : ����
' amount      : �i��
' price_type  :
'               " " ����, "2" ����, "3" �^��
'




' �Ҩ�R��
Public Declare PtrSafe Function stock_cancel Lib "C:\vba dll\t4.dll" _
( ByVal buy_or_sell As String _
, ByVal branch As String _
, ByVal account As String _
, ByVal code As String _
, ByVal ord_type As String _
, ByVal ord_seq As String _
, ByVal ord_num As String _
, ByVal pre_order As String) As String
' buy_or_sell : "B" = �R�J, "S" = ��X
' branch      : �����q�N��
' account     : �b��
' code        : �Ѳ��N��
' ord_type :
'              "P0" �w�L�{��, "P3" �w�L�ĸ�, "P4" �w�L�Ĩ�
'              "00" ��Ѳ{��, "03" ��ѿĸ�, "04" ��ѿĨ�
'              "20" �s��
'
' ord_seq   :  �����渹
' ord_num   :  �e�U�渹
'
'   pre_order : "N" - �D�w����, " " - �w����


' �Ҩ���
Public Declare PtrSafe Function stock_change Lib "C:\vba dll\t4.dll" _
( ByVal buy_or_sell As String _
, ByVal branch As String _
, ByVal account As String _
, ByVal code As String _
, ByVal ord_type As String _
, ByVal ord_seq As String _
, ByVal ord_num As String _
, ByVal pre_order As String _
, ByVal ordknd As String _
, ByVal price As String _
, ByVal price_type As String ) As String


' �d�� server info (�s�u�D����})
Public Declare PtrSafe Function show_ip Lib "C:\vba dll\t4.dll" _
() As String



' �d�� dll version (���󪩸�)
Public Declare PtrSafe Function show_version Lib "C:\vba dll\t4.dll" _
() As String



' �d�ߤU��b��
Public Declare PtrSafe Function show_list2 Lib "C:\vba dll\t4.dll" _
() As String



' �n�������糹 (�ھڱb��O�A���f�P�Ҩ���})
Public Declare PtrSafe Function add_acc_ca Lib "C:\vba dll\t4.dll" _
( ByVal branch As String _
, ByVal account As String _
, ByVal acc_id As String _
, ByVal acc_ca_path As String _
, ByVal acc_ca_pass As String) As String



' ��
Public Declare PtrSafe Function get_response_log Lib "C:\vba dll\t4.dll" _
() As String



' 
Public Declare PtrSafe Function check_response_buffer Lib "C:\vba dll\t4.dll" _
() As Long



' ���U�D�ʦ^��
Public Declare PtrSafe Function do_register Lib "C:\vba dll\t4.dll" _
( ByVal YesNo As Integer ) As Integer



' �Ҩ�l�q�d��
Public Declare PtrSafe Function stock_balance_qry Lib "C:\vba dll\t4.dll" _
( ByVal flag As String _
, ByVal leng As String _
, ByVal nekst As String _
, ByVal prev As String _
, ByVal gubn As String _
, ByVal group_name As String _
, ByVal branch As String _
, ByVal acct As String _
, ByVal time_out As String) As String



' �Ҩ�l�q���`
Public Declare PtrSafe Function stock_balance_sum Lib "C:\vba dll\t4.dll" _
( ByVal branch As String _
, ByVal acct As String _
, ByVal ttype As String _
, ByVal action As String ) As String



' �Ҩ�l�q����
Public Declare PtrSafe Function stock_balance_detail Lib "C:\vba dll\t4.dll" _
( ByVal branch As String _
, ByVal acct As String _
, ByVal stock As String _
, ByVal ttype As String ) As String



' ���v�d��
Public Declare PtrSafe Function fo_order_qry2 Lib "C:\vba dll\t4.dll" _
( ByVal branch As String _
, ByVal acct As String _
, ByVal code As String _
, ByVal ord_match_flag As String _
, ByVal ord_type As String _
, ByVal oct_type As String _
, ByVal is_daily As String _
, ByVal start_date As String _
, ByVal end_date As String _
, ByVal preorder As String _
, ByVal source As String) As String



' ���v�����ܬd��
Public Declare PtrSafe Function fo_unsettled_qry Lib "C:\vba dll\t4.dll" _
( ByVal flag As String _
, ByVal leng As String _
, ByVal nekst As String _
, ByVal prev As String _
, ByVal gubn As String _
, ByVal group_name As String _
, ByVal branch As String _
, ByVal acct As String _
, ByVal type_1 As String _
, ByVal type_2 As String _
, ByVal time_out As String) As String
' fo_unsettled_qry
'
' gubn : 0:��@�b�� 1:�s��
' group name : �s�� name
'
'  branch : �����q�N��
'  account : �b��
'
' �ӫ~���Otype_1 : 0:all ;1:Future ;2:Option ;3:USD
' ��ܤ覡type_2 : 0:���� 1.�׾�
' time_out



' 
Public Declare PtrSafe Function fo_get_hist_info Lib "C:\vba dll\t4.dll" _
( ByVal branch As String _
, ByVal acct As String _
, ByVal sdate As String _
, ByVal edate As String ) As String



' 
Public Declare PtrSafe Function get_response Lib "C:\vba dll\t4.dll" _
() As String



' 
Public Declare PtrSafe Function fo_get_day_info Lib "C:\vba dll\t4.dll" _
( ByVal branch As String _
, ByVal acct As String) As String



' 
Public Declare PtrSafe Function timer_response_log Lib "C:\vba dll\t4.dll" _
() As String



Public Declare PtrSafe Function parse_response _
    Lib "C:\vba dll\t4.dll" _
( ByVal response As String _
, ByRef seqn As String _
, ByRef branch As String , ByRef account As String _
, ByRef ord_no As String , ByRef ord_seq As String _
, ByRef code As String _
, ByRef ord_type As String _
, ByRef ord_class As String _
, ByRef place_price As String _
, ByRef matched_price As String _
, ByRef ordknd As String _
, ByRef volume As String _
, ByRef time As String _
, ByRef status As String _
, ByRef errno As String , ByRef err As String _
, ByRef web_id As String _
, ByRef account_s As String _
, ByRef oct As String _
, ByRef ord_time As String , ByRef agent_id As String _
, ByRef price_type As String , ByRef tr_fld As String _
, ByRef matched_seqn As String _
, ByRef func_seqn As String _
, ByRef mprice_flag As String _
) As Long


Public Declare PtrSafe Function parse_reply _
  Lib "C:\vba dll\t4.dll" _
( ByVal reply As String _
, ByRef branch As String _
, ByRef account As String _
, ByRef ord_no As String _
, ByRef ord_seq As String _
, ByRef code As String _
, ByRef place_price As String _
, ByRef matched_price As String _
, ByRef volume As String _
, ByRef time As String _
, ByRef status As String _
, ByRef err As String _
, ByRef ord_type As String _
, ByRef place_type As String _
, ByRef ord_knd As String _
) As Long



' �ѨM VB/VBA �p�� �r���B�줸�� ���װ��D
' ��J���w�� Bytes �ơA�^�Ǧr����
Public Function GetLengFromBytes(ByVal s As String, ByVal leng As Variant) As Variant

    Dim wch As Integer    ' �ΨӧP�_�O WCHAR �٬O CHAR
    Dim x As Long         ' �p��r����
    Dim lengB As Long     ' �p�� BYTE ����
    
    x = 0
    lengB = 0
    Do While lengB < leng
        wch = AscW(Mid(s, x + 1, 1))
        If wch < 0 Or wch >= 128 Then
            lengB = lengB + 2
        Else
            lengB = lengB + 1
        End If
    
        x = x + 1
    Loop

    GetLengFromBytes = x
End Function
