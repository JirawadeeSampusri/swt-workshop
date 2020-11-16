*** Settings ***
Library    RequestsLibrary
Suite Setup    Create Session    alias=shopping    url=https://dminer.in.th
*** Variables ***
&{headers}    Content-Type=application/json    accept=application/json
${id}    2
# special case for JSON use & instead of $
*** Test Cases ***
Test user order a toy for his/her daughter succeed by visa shipping via kerry
    Search
    Product Detail
    Submit Order
    Confirm Payment
*** Keywords ***
Search
    ${resp}=    Get Request    alias=shopping    uri=/api/v1/product
    Request Should Be Successful    ${resp}
    Should Be Equal As Integers    ${resp.json()["total"]}    2
    Should Be Equal    ${resp.json()["products"][1]["product_name"]}    43 Piece dinner Set
    Should Be Equal As Numbers    ${resp.json()["products"][1]["product_price"]}    12.95
    Should Be Equal    ${resp.json()["products"][1]["product_image"]}    /43_Piece_dinner_Set.png

Product Detail
    ${resp}=    Get Request    alias=shopping    uri=/api/v1/product/2    headers=${headers}
    Request Should Be Successful    ${resp}
    Should Be Equal As Integers    ${resp.json()["id"]}    2
    Should Be Equal    ${resp.json()["product_name"]}    43 Piece dinner Set
    Should Be Equal As Numbers    ${resp.json()["product_price"]}    12.95
    Should Be Equal    ${resp.json()["product_image"]}    /43_Piece_dinner_Set.png
    Should Be Equal As Integers    ${resp.json()["quantity"]}    10
    Should Be Equal    ${resp.json()["product_brand"]}    CoolKidz

Submit Order
    ${data}    To Json    {"cart" : [{ "product_id": 2,"quantity": 1}],"shipping_method" : "Kerry","shipping_address" : "405/37 ถ.มหิดล","shipping_sub_district" : "ต.ท่าศาลา","shipping_district" : "อ.เมือง","shipping_province" : "จ.เชียงใหม่","shipping_zip_code" : "50000","recipient_name" : "ณัฐญา ชุติบุตร","recipient_phone_number" : "0970809292"}
    ${resp}=    Post Request    alias=shopping    uri=/api/v1/order    headers=${headers}    json=${data}
    Request Should Be Successful    ${resp}
    Should Be Equal As Integers    ${resp.json()["order_id"]}    8004359122
    ${ORDER_ID} =    Set Variable    ${resp.json()["order_id"]}
    Set Test Variable    ${ORDER_ID}
    Should Be Equal As Numbers    ${resp.json()["total_price"]}    14.95

Confirm Payment
    ${data}    To Json    {"order_id" : ${ORDER_ID},"payment_type" : "credit","type" : "visa","card_number" : "4719700591590995","cvv" : "752","expired_month" : 7,"expired_year" : 20,"card_name" : "Karnwat Wongudom","total_price" : 14.95}
    ${resp}=    Post Request    alias=shopping    uri=/api/v1/confirmPayment    headers=${headers}    json=${data}
    Request Should Be Successful    ${resp}
    Should Be Equal    ${resp.json()["notify_message"]}    วันเวลาที่ชำระเงิน 1/3/2020 13:30:00 หมายเลขคำสั่งซื้อ 8004359122 คุณสามารถติดตามสินค้าผ่านช่องทาง Kerry หมายเลข 1785261900

