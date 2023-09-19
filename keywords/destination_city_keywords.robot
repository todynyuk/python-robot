*** Settings ***
Library  SeleniumLibrary

*** Keywords ***
clickDestinationCityByIndex
    [Arguments]     ${index}
    click element   xpath:(//a[contains(@class,'header-location')])[${index}]

