*** Settings ***
Library    RequestsLibrary
Suite Setup    Create Session    alias=shopping    url=https://www.dminer.in.th

*** Variables ***
&{headers}    Content-Type=application/json    Accept=application/json

*** Test Cases ***
user ซื้อของเล่นให้ลูกสาว เลือกวิธีจัดส่งเป็น kerry ชำระเงินด้วยบัตรเครดิต visa และชำระเงินสำเร็จ
    Search
    Product Detail
    Submit Order
    Comfirm Payment

*** Keywords ***
Search
    ${response}=    Get Request    alias=shopping   uri=/api/v1/product    headers=&{headers} 
    Request Should Be Successful    ${response}
    Should Be Equal    ${response.json()['products'][1]['product_name']}    43 Piece dinner Set
    Should Be Equal As Numbers   ${response.json()['products'][1]['product_price']}    12.95
    ${productId}=    Set Variable    ${response.json()['products'][1]['id']}
    Set Test Variable    ${productId}


Product Detail
    ${response}=    Get Request    alias=shopping   uri=/api/v1/product/${productId}    headers=&{headers}
    Request Should Be Successful    ${response}
    Should Be Equal As Integers   ${response.json()['id']}    2
    Should Be Equal    ${response.json()['product_name']}    43 Piece dinner Set
    Should Be Equal As Numbers   ${response.json()['product_price']}    12.95
    Should Be Equal   ${response.json()['product_image']}    /43_Piece_dinner_Set.png
    Should Be Equal As Integers   ${response.json()['quantity']}    10
    Should Be Equal    ${response.json()['product_brand']}    CoolKidz
    

Submit Order
    ${data}=    To Json    {"cart" : [{ "product_id": 2,"quantity": 1}],"shipping_method" : "Kerry","shipping_address" : "405/37 ถ.มหิดล","shipping_sub_district" : "ต.ท่าศาลา","shipping_district" : "อ.เมือง","shipping_province" : "จ.เชียงใหม่","shipping_zip_code" : "50000","recipient_name" : "ณัฐญา ชุติบุตร","recipient_phone_number" : "0970809292"}
    ${response}=    Post Request    alias=shopping    uri=/api/v1/order    headers=&{headers}    json=${data}
    Request Should Be Successful    ${response}
    Should Be Equal As Integers    ${response.json()['order_id']}    8004359122
    Should Be Equal As Numbers    ${response.json()['total_price']}    14.95
    ${orderId}=    Set Variable    ${response.json()['order_id']}
    Should Be Equal As Integers     ${orderId}    8004359122
    Set Test Variable    ${orderId}

Comfirm Payment
    ${data}=    To Json    {"order_id" : 8004359122,"payment_type" : "credit","type" : "visa","card_number" : "4719700591590995","cvv" : "752","expired_month" : 7,"expired_year" : 20,"card_name" : "Karnwat Wongudom","total_price" : 14.95}
    Should Be Equal As Integers    ${data['order_id']}     ${orderId}
    ${response}=    Post Request    alias=shopping    uri=/api/v1/confirmPayment    headers=&{headers}    json=${data}
    Request Should Be Successful    ${response}
    Should Be Equal    ${response.json()['notify_message']}    วันเวลาที่ชำระเงิน 1/3/2020 13:30:00 หมายเลขคำสั่งซื้อ 8004359122 คุณสามารถติดตามสินค้าผ่านช่องทาง Kerry หมายเลข 1785261900