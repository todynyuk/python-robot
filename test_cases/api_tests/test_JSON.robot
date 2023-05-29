*** Settings ***
Library           JSONLibrary
Library           os
Library           Collections

*** Test Cases ***
test__get_single_user_from_JSON
    ${jsonfile}=    load json from file    ${EXECDIR}/resources/api/get/rs_single.json
    ${get_email}=    Get Value From Json    ${jsonfile}    $.data.email
    log to console    ${get_email[0]}
    should be equal    ${get_email[0]}    janet.weaver@reqres.in

test_get_list_users_from_JSON
    ${jsonfile}=    load json from file    ${EXECDIR}/resources/api/get/rs_list.json
    ${get_email}=    Get Value From Json    ${jsonfile}    $.data[1].email
    log to console    ${get_email[0]}
    should be equal    ${get_email[0]}    janet.weaver@reqres.