*** Settings ***
Library    SeleniumLibrary

*** Variables ***

*** Test Cases ***
Test search keyword and verify search result on Google
    พิมพ์ facebook.com
    ใส่ username
    ใส่ password
    กด Enter
    ตรวจสอบ facebook

*** Keywords ***
พิมพ์ facebook.com
    Open Browser    https://facebook.com    chrome

ใส่ username
    Input Text    id:email    jirawadeelovely@hotmail.com
ใส่ password
    Input Text    id:pass    Jira0931402542.
กด Enter
    Press Keys    id:pass    RETURN

ตรวจสอบ facebook
    Page Should Contain    ผู้ติดต่อ

    Wait Until Element Is Enabled    xpath://div[@role="alertdialog"]
    Press Keys    xpath://div[@role="alertdialog"]    RETURN

    Wait Until Element Is Enabled    xpath://div[@class="m9osqain a5q79mjw jm1wdb64 k4urcfbm"]
    Press Keys    xpath://div[@class="m9osqain a5q79mjw jm1wdb64 k4urcfbm"]    RETURN

    Page Should Contain    Jirawadee

    Wait Until Element Is Enabled    xpath://div[@class="rq0escxv datstx6m k4urcfbm a8c37x1j"]
    Press Keys    xpath://div[@class="rq0escxv datstx6m k4urcfbm a8c37x1j"]    สวัสดี Robot Framework

    Wait Until Element Is Enabled    xpath://div[@class="oajrlxb2 s1i5eluu qu0x051f esr5mh6w e9989ue4 r7d6kgcz rq0escxv nhd2j8a9 pq6dq46d p7hjln8o kvgmc6g5 cxmmr5t8 oygrvhab hcukyx3x cxgpxx05 d1544ag0 sj5x9vvc tw6a2znq oqcyycmt esuyzwwr f1sip0of lzcic4wl l9j0dhe7 abiwlrkh p8dawk7l ehryuci6 bp9cbjyn beltcj47 p86d2i9g aot14ch1 kzx2olss rt8b4zig n8ej3o3l agehan2d sk4xxmp2 lrazzd5p gigivrx4 sf5mxxl7 g0qnabr5 lrwzeq9o iqfcb0g7 lsqurvkf id6903cd jq4qci2q m5l1wtfr taijpn5t sn7ne77z oqhjfihn bwm1u5wc"]
    Press Keys    xpath://div[@class="oajrlxb2 s1i5eluu qu0x051f esr5mh6w e9989ue4 r7d6kgcz rq0escxv nhd2j8a9 pq6dq46d p7hjln8o kvgmc6g5 cxmmr5t8 oygrvhab hcukyx3x cxgpxx05 d1544ag0 sj5x9vvc tw6a2znq oqcyycmt esuyzwwr f1sip0of lzcic4wl l9j0dhe7 abiwlrkh p8dawk7l ehryuci6 bp9cbjyn beltcj47 p86d2i9g aot14ch1 kzx2olss rt8b4zig n8ej3o3l agehan2d sk4xxmp2 lrazzd5p gigivrx4 sf5mxxl7 g0qnabr5 lrwzeq9o iqfcb0g7 lsqurvkf id6903cd jq4qci2q m5l1wtfr taijpn5t sn7ne77z oqhjfihn bwm1u5wc"]    RETURN