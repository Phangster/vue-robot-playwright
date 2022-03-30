*** Settings ***
Resource  ./resources/homeview.robot

*** Test Cases ***
Open Browser Page
    Open Webpage
    Fill Username
    Fill Password
    Click Login
    Check Title
    Check QR Code
    Check Iframe text