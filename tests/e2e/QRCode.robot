*** Settings ***
Library   Browser      jsextension=${CURDIR}/modules/modules.js

*** Variables ***
${URL}              http://localhost:8080/
${CLICK_LOGIN}      //button[contains(text(), "Login")]
${USER_NAME}        bryan
${PASSWORD}         123456
${avatar}           css: div.qrcode > img

*** Keywords ***
Open Webpage
    New Browser    chromium    headless=false
    New Context    viewport={'width': 1920, 'height': 1080}
    New Page       ${URL}

Fill Username
    Fill Text    css=input#username   ${USER_NAME} 

Fill Password
    Fill Text    css=input#password   ${PASSWORD}

Click Login
    Click         ${CLICK_LOGIN}

Check QR Code
    # ${image_dom} =     Get Element    \#reader
    # log to console     ${image_dom}
    # Element Should Be Visible    ${avatar}
    ${image_url} =   Get Property    img    src
    # log to console  ${image_url}
    ${url}=   decodeQr    ${image_url}
    log to console        TESTING
    log to console        ${url}
    # Should be equal  ${url}    Fast and reliable end-to-end testing for modern web apps | Playwright
    # ${decoded_url}     Decode Qrcode    ${image_url}
    # log to console   TESTING
    # log to console  ${decoded_url}

Get URL Qr Code
    ${image_url} =   Get Property    img    src
    ${decoded_url}   Url To Image    ${image_url}
    log to console   TESTING2
    log to console   ${decoded_url}

Download QR code
    New Context             acceptDownloads=True
    ${dl_promise}           Promise To Wait For Download    /path/to/download/file.name
    ${image_url}=           Get Property    img    src
    ${file_object}=         Download    ${image_url}
    ${file_obj}=            Wait For  ${dl_promise}
    File Should Exist       ${file_obj}[saveAs]
    Should Be True          ${file_obj.suggestedFilename}

*** Test Cases ***
Scenario: Login page
    Given Open Webpage
    Then Fill Username
    And Fill Password
    When Click Login
    And Check QR Code
    # And Download QR code
    # And Get URL Qr Code
