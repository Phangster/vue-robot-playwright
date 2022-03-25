*** Settings ***
Library   Browser

*** Test Cases ***
Starting a browser with a page
  New Browser    chromium    headless=false
  New Context    viewport={'width': 1920, 'height': 1080}
  New Page       http://localhost:8080/about
  Get Text     css=.about    *=    This is an about page
