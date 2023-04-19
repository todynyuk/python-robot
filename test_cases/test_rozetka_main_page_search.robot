*** Settings ***
Library  SeleniumLibrary
Resource    ../resources/search_keywords.robot
*** Variables ***
${browser}  chrome
${url}  https://rozetka.com.ua/ua/
${correctSearch}    AGM A9
${incorrectSearch}    jhvjhjhjhv

*** Test Cases ***
CorrectSearchTest
    [Tags]    rozetka_search
    launchingBrowser    ${url}   ${browser}
    inputSearchField  ${correctSearch}
    clickSearchButton
    verifySearchTitle   ${correctSearch}
    verifyProductTitle  ${correctSearch}
    [Teardown]  close browser

IncorrectSearchTest
    [Tags]    rozetka_search
    launchingBrowser    ${url}   ${browser}
    inputSearchField  ${incorrectSearch}
    clickSearchButton
    verifyNotFoundText
    [Teardown]  close browser
