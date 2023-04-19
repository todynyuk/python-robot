*** Settings ***
Library  SeleniumLibrary
*** Variables ***
${browser}  chrome
${url}  https://rozetka.com.ua/ua/
${testurl}  https://testautomationpractice.blogspot.com/
${filter1}  Від дешевих до дорогих
${filter2}  Від дорогих до дешевих
${filter3}  Новинки
${correctSearch}    AGM A9
${incorrectSearch}    jhvjhjhjhv
${index}    1


*** Test Cases ***
DropDownFilterEnabledTest
    launchingBrowser    ${url}   ${browser}
    goToSmartphones
    clickDropdownMenu   ${filter1}
    Element Should Contain    //select[contains(@class,'select-css')]/option[1]    ${filter1}   Dropdown option not contains chosen text
    clickDropdownMenu   ${filter2}
    Element Should Contain    //select[contains(@class,'select-css')]/option[1]    ${filter2}   Dropdown option not contains chosen text
    clickDropdownMenu   ${filter3}
    Element Should Contain    //select[contains(@class,'select-css')]/option[1]    ${filter3}   Dropdown option not contains chosen text


CorrectSearchTest
    launchingBrowser    ${url}   ${browser}
    doSearch  ${correctSearch}
    Element Should Contain    //h1[contains(@class, 'catalog-heading')]    AGM A9   Page not contains search text
    Element Should Contain    //span[@class='goods-tile__title'][${index}]    AGM A9   Page not contains search text
    close browser

IncorrectSearchTest
    launchingBrowser    ${url}   ${browser}
    doSearch  ${incorrectSearch}
    element should be enabled   //span[@class='ng-star-inserted']
    close browser


AlertWindowTest
    launchingBrowser    ${testurl}   ${browser}
    click button    xpath://button[contains(text(),'Click Me')]
    alert should be present    Press a button!
    capture element screenshot    //p[@id='demo']   text.png
    Element Should Contain  //p[@id='demo']     You pressed OK!     Ok text not found in this page
    click button    xpath://button[contains(text(),'Click Me')]
    handle alert    dismiss
    capture page screenshot    website.png
    Element Should Contain  //p[@id='demo']     You pressed Cancel!     Cancel text not found in this page


*** Keywords ***
launchingBrowser
    [Arguments]     ${webUrl}   ${webBrowser}
    open browser    ${webUrl}   ${webBrowser}
    maximize browser window
    set selenium speed  2seconds

doSearch
    [Arguments]     ${searchValue}
    input text  xpath://input[@name='search']    ${searchValue}
    click element   xpath://button[contains(@class, 'button_color_green')]

clickCheckBox
    click element   xpath://a[@class='menu-categories__link' and contains(.,'Смартфони')]
    click element   xpath://a[contains(@class,'tile-cats__heading') and contains(.,'Мобільні')]
    click element   xpath://a[@data-id='Xiaomi']

goToSmartphones
    click element   xpath://a[@class='menu-categories__link' and contains(.,'Смартфони')]
    click element   xpath://a[contains(@class,'tile-cats__heading') and contains(.,'Мобільні')]

clickDropdownMenu
    [Arguments]    ${optionName}
    click element   xpath://select[contains(@class,'select-css')]/option[contains(text(),'${optionName}')]


