*** Settings ***
Library  SeleniumLibrary
*** Variables ***
${browser}  chrome
${testurl}  https://testautomationpractice.blogspot.com/
${table_xpath}  xpath://table[@name='BookTable']
*** Test Cases ***
TableValidationTest
    launchingBrowser    ${testurl}   ${browser}
    ${rows_counter}=    get element count    xpath://table[@name='BookTable']/tbody/tr
    ${cols_counter}=    get element count    xpath://table[@name='BookTable']/tbody/tr[1]/th

    should be equal    '${rows_counter}'  '7'
    should be equal    '${cols_counter}'  '4'

    log to console  ${rows_counter}
    log to console  ${cols_counter}

    ${data}=     get text    xpath://table[@name='BookTable']/tbody/tr[5]/td[1]
    log to console    ${data}
    table column should contain     ${table_xpath}    2   Author
    table row should contain     ${table_xpath}    4   Learn JS
    table cell should contain     ${table_xpath}    5   2   Mukesh
    table header should contain     ${table_xpath}    BookName
    close browser


*** Keywords ***
launchingBrowser
    [Arguments]     ${webUrl}   ${webBrowser}
    open browser    ${webUrl}   ${webBrowser}
    maximize browser window
    set selenium speed  2seconds