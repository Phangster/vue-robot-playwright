*** Settings ***
Library   Browser

*** Variables ***
${URL}              http://localhost:8080/
${CLICK_LOGIN}      //button[contains(text(), "Login")]
${USER_NAME}        bryan
${PASSWORD}         123456


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

Check Title
    Get Text     id=title    *=    Welcome

Check QR Code
    ${image_url} =   Get Property    img    src
    log to console  ${image_url}
    Grant Permissions    camera

Check Iframe text
    Get Text   id=iframe >>> id=header-title    ==    MY BLOG

Download File
    ${dl_promise}          Promise To Wait For Download    /path/to/download/file.name
    Click                \#file_download
    ${file_obj}=           Wait For  ${dl_promise}
    File Should Exist    ${file_obj}[saveAs]
    Should Be True       ${file_obj.suggestedFilename}

*** Test Cases ***
Open Browser Page
    Open Webpage
    Fill Username
    Fill Password
    Click Login
    Check Title
    Check QR Code
    Check Iframe text


#   New Browser    chromium    headless=false
#   New Context    viewport={'width': 1920, 'height': 1080}
#   New Page       http://localhost:8080/
#   Get Title      ==    vue-robot-playwright
#   Fill Text    css=input#username    bryan
#   Fill Text    css=input#password    123456
#   Click        css=button#login
#   Get Text     id=title    *=    Welcome 
