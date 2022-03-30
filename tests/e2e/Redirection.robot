***Settings***
Library   Browser      jsextension=${CURDIR}/modules/modules.js

***Test Cases***
Hello
  New Page
  ${title}=  myGoToKeyword  https://playwright.dev
  Should be equal  ${title}  Fast and reliable end-to-end testing for modern web apps | Playwright