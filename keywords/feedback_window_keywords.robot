*** Settings ***
Library  SeleniumLibrary
Library    String
Library    Collections
Variables    ../page_objects/feedback_window_locators.py

*** Keywords ***
check_switching_photos
    [Arguments]    ${element_count}
    ${counter}=  set variable    0
      FOR   ${index}  IN RANGE  ${element_count}
           @{element_list} =  Get WebElements    ${photo_indicator_item_list}
           ${elem}  Get Element Attribute    ${element_list}[${index}]    class
           ${contains}=    Run Keyword And Return Status    Should Contain    ${elem}    active
            IF    ${contains}== ${True}
                ${counter}=     evaluate    ${counter} + 1
            ELSE
                ${counter}=     evaluate    ${counter} + 0
            END
            click element    ${button_next_photo}
     END
    [Return]    ${counter}
