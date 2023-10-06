*** Settings ***
Library  SeleniumLibrary

*** Variables ***
${browser}  chrome
${testurl}  https://testautomationpractice.blogspot.com/

*** Test Cases ***
AlertWindowTest
    [Tags]  maintainer=todynyuk
    launchingBrowser    ${testurl}   ${browser}
    click button    xpath://button[contains(text(),'Click Me')]
    alert should be present    Press a button!
    capture element screenshot    //p[@id='demo']   text.png
    Element Should Contain  //p[@id='demo']     You pressed OK!     Ok text not found in this page
    click button    xpath://button[contains(text(),'Click Me')]
    handle alert    dismiss
    capture page screenshot    website.png
    Element Should Contain  //p[@id='demo']     You pressed Cancel!     Cancel text not found in this page
    [Teardown]  close browser

*** Keywords ***
launchingBrowser
    [Arguments]     ${webUrl}   ${webBrowser}
    open browser    ${webUrl}   ${webBrowser}
    maximize browser window
    set selenium speed  2seconds