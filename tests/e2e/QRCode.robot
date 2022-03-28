*** Settings ***
Library   Browser
Library   OCRLibrary

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
    # ${read_image} =    Read Image   ${image_url}
    # log to console  ${read_image}

*** Test Cases ***
Scenario: Login page
    Given Open Webpage
    And Fill Username
    And Fill Password
    When Click Login
    Then Check Title
    Then Check QR Code


#   New Browser    chromium    headless=false
#   New Context    viewport={'width': 1920, 'height': 1080}
#   New Page       http://localhost:8080/
#   Get Title      ==    vue-robot-playwright
#   Fill Text    css=input#username    bryan
#   Fill Text    css=input#password    123456
#   Click        css=button#login
#   Get Text     id=title    *=    Welcome 
