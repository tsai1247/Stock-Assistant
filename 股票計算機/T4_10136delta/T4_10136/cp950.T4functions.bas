Attribute VB_Name = "T4functions"





' 登出
Public Declare PtrSafe Function log_out _
 Lib "C:\vba dll\t4.dll" _
() As Integer



' 登入
Public Declare PtrSafe Function init_t4 _
 Lib "C:\vba dll\t4.dll" _
( ByVal login_id As String _
, ByVal login_pass As String _
, ByVal dll_path As String) As String
' login_id   : 登入ID   (身分證號、自然人、公司統編)
' login_pass : 登入密碼 (非憑證密碼)
' dll_path   : 指定執行路徑, 可空白



'切換下單模式 (等候下單回應echo與否)
Public Declare Function change_echo Lib "C:\vba dll\t4.dll" _
() As String



' 驗證已登入憑證之密碼是否正確
Public Declare PtrSafe Function verify_ca_pass Lib "C:\vba dll\t4.dll" _
( ByVal branch As String _
, ByVal account As String) As String
' branch         : 分公司代碼
' account        : 憑證帳戶



'----------------------------------------------------------------------------
' 期貨下單
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
' buy_or_sell : "B" = 買入, "S" = 賣出
' branch      : 分公司代號
' account     : 期貨帳戶
' code        : 商品代號
' price       : 價格
' amount      : 口數
' price type  : 價格別： "MKT"市價, "LMT"限價
' ordtype     : 委託別： ROD / FOK / IOC
' octtype     : 倉別： "0" = 新倉  "1" = 平倉 " "= 自動  "6"= 當沖



' 期貨刪單
Public Declare PtrSafe Function future_cancel Lib "C:\vba dll\t4.dll" _
( ByVal branch As String _
, ByVal account As String _
, ByVal code As String _
, ByVal ord_seq As String _
, ByVal ord_num As String _
, ByVal none As String _
, ByVal pre_order As String) As String
' branch      : 分公司代號
' account     : 期貨帳號
' code        : 商品代號
' ord_seq     : 網路單號
' ord_num     : 委託單號
' none        : "" 保留未用
' pre_order   : "N" - 非預約單, " " - 預約單



' 期貨改價
Public Declare PtrSafe Function future_change Lib "C:\vba dll\t4.dll" _
( ByVal org_seqno As String _
, ByVal org_ordno As String _
, ByVal branch As String _
, ByVal account As String _
, ByVal code As String _
, ByVal new_price As String _
, ByVal pre_order As String) As String
' org_seqno : 原網路書號
' org_ordno : 原委託書號 (已接受委託)
' branch    : 原下單 分公司代號
' account   : 原下單 帳戶
' code      : 原期貨商品 (10碼)
' new_price : 新價
' pre_order : 是否為預約單 (P=預約單, N=非預約單)



' 選擇權改價
Public Declare PtrSafe Function option_change Lib "C:\vba dll\t4.dll" _
( ByVal org_seqno As String _
, ByVal org_ordno As String _
, ByVal branch As String _
, ByVal account As String _
, ByVal code As String _
, ByVal new_price As String _
, ByVal pre_order As String) As String
' org_seqno : 原網路書號
' org_ordno : 原委託書號 (已接受委託)
' branch    : 原下單 分公司代號
' account   : 原下單 帳戶
' code      : 原商品 (10碼)
' new_price : 新價
' pre_order : 是否為預約單 (P=預約單, N=非預約單)




' 選擇權下單
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
' option_order 國內選擇權下單
'
' buy_or_sell : "B" = 買入, "S" = 賣出
' branch      : 分公司代號
' account     : 期貨帳號
' code        : 商品代號
' price       :  價格 6位數
' amount      : 口數 3位數
' price type  : "MKT"市價, "LMT"限價
' type_1      : "IOC" or "ROD" or "FOK"
' type_2      : "0" 新倉, "1" 平倉, " " 自動
' ordtype     : "IOC" or "ROD" or "FOK"
' octtype     : "0" 新倉, "1" 平倉, " " 自動
' IsComp      : "S" 單式 , "C" 複式
' bs2         : 第二商品 買入 / 賣出
' commodity2  : 第二商品代號



' 選擇權刪單
Public Declare PtrSafe Function option_cancel Lib "C:\vba dll\t4.dll" _
( ByVal branch As String _
, ByVal account As String _
, ByVal code As String _
, ByVal ord_seq As String _
, ByVal ord_num As String _
, ByVal octtype As String _
, ByVal pre_order As String) As String
' branch     : 分公司代號
' account    : 期貨帳號
' code       : 商品代號
' ord_seq    : 網路單號
' ord_num    : 委託單號
' octtype    : "0" 新倉, "1" 平倉, " " 自動
' pre_order  : "N" - 非預約單, " " - 預約單



'----------------------------------------------------------------------------
' 證券下單 (權證、上櫃、上櫃權證)
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

' buy_or_sell : "B"=買入, "S"=賣出, "F"=先賣
' branch      : 分公司代號
' account     : 帳號
' code        : 股票代號
' ord_type    :
'               "P0" 定盤現股, "P3" 定盤融資, "P4" 定盤融卷
'               "00" 整股現股, "03" 整股融資, "04" 整股融卷
'               "20" 零股
'
' price       : 價格
' amount      : 張數
' price_type  :
'               " " 限價, "2" 漲停, "3" 跌停
'




' 證券刪單
Public Declare PtrSafe Function stock_cancel Lib "C:\vba dll\t4.dll" _
( ByVal buy_or_sell As String _
, ByVal branch As String _
, ByVal account As String _
, ByVal code As String _
, ByVal ord_type As String _
, ByVal ord_seq As String _
, ByVal ord_num As String _
, ByVal pre_order As String) As String
' buy_or_sell : "B" = 買入, "S" = 賣出
' branch      : 分公司代號
' account     : 帳號
' code        : 股票代號
' ord_type :
'              "P0" 定盤現股, "P3" 定盤融資, "P4" 定盤融卷
'              "00" 整股現股, "03" 整股融資, "04" 整股融卷
'              "20" 零股
'
' ord_seq   :  網路單號
' ord_num   :  委託單號
'
'   pre_order : "N" - 非預約單, " " - 預約單


' 證券改價
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


' 查詢 server info (連線主機位址)
Public Declare PtrSafe Function show_ip Lib "C:\vba dll\t4.dll" _
() As String



' 查詢 dll version (元件版號)
Public Declare PtrSafe Function show_version Lib "C:\vba dll\t4.dll" _
() As String



' 查詢下單帳號
Public Declare PtrSafe Function show_list2 Lib "C:\vba dll\t4.dll" _
() As String



' 登錄憑證驗章 (根據帳戶別，期貨與證券分開)
Public Declare PtrSafe Function add_acc_ca Lib "C:\vba dll\t4.dll" _
( ByVal branch As String _
, ByVal account As String _
, ByVal acc_id As String _
, ByVal acc_ca_path As String _
, ByVal acc_ca_pass As String) As String



' 取
Public Declare PtrSafe Function get_response_log Lib "C:\vba dll\t4.dll" _
() As String



' 
Public Declare PtrSafe Function check_response_buffer Lib "C:\vba dll\t4.dll" _
() As Long



' 註冊主動回報
Public Declare PtrSafe Function do_register Lib "C:\vba dll\t4.dll" _
( ByVal YesNo As Integer ) As Integer



' 證券損益查詢
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



' 證券損益匯總
Public Declare PtrSafe Function stock_balance_sum Lib "C:\vba dll\t4.dll" _
( ByVal branch As String _
, ByVal acct As String _
, ByVal ttype As String _
, ByVal action As String ) As String



' 證券損益明細
Public Declare PtrSafe Function stock_balance_detail Lib "C:\vba dll\t4.dll" _
( ByVal branch As String _
, ByVal acct As String _
, ByVal stock As String _
, ByVal ttype As String ) As String



' 期權查詢
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



' 期權未平倉查詢
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
' gubn : 0:單一帳號 1:群組
' group name : 群組 name
'
'  branch : 分公司代號
'  account : 帳號
'
' 商品類別type_1 : 0:all ;1:Future ;2:Option ;3:USD
' 顯示方式type_2 : 0:明細 1.匯整
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



' 解決 VB/VBA 計算 字元、位元組 長度問題
' 輸入指定的 Bytes 數，回傳字元數
Public Function GetLengFromBytes(ByVal s As String, ByVal leng As Variant) As Variant

    Dim wch As Integer    ' 用來判斷是 WCHAR 還是 CHAR
    Dim x As Long         ' 計算字元數
    Dim lengB As Long     ' 計算 BYTE 長度
    
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
