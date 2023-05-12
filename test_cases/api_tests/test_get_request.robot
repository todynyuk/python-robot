*** Settings ***
Library    SeleniumLibrary
Library    RequestsLibrary
Library    JSONLibrary
Library    Collections
Library    String

*** Variables ***
${base_url}     https://reqres.in/


*** Test Cases ***
test_get_list_users
       [Tags]  maintainer=todynyuk
       Create Session    mysession    ${base_url}
       ${response}      get on session    mysession    api/users
       ${status_code}=      Convert To String    ${response.status_code}
       Should Be Equal      ${status_code}      200
       Log To Console    ${status_code}

test_get_request_and_validate_response
    [Tags]  maintainer=todynyuk
    Create Session  mysession  ${base_url}  verify=true
    ${response}=  GET On Session  mysession  /api/users    params=page=2
    Status Should Be  200  ${response}
    ${json_response}=  Convert String to JSON    ${response.content}
    ${contents}=  Get Value From Json    ${json_response}    page
    Log To Console    ${contents}
    ${contents}=    Convert To String    ${contents}
    ${contents}=  Remove String Using Regexp    ${contents}    ['\\[\\],]
    Should Be Equal    ${contents}    2
    ${header_value}=  Get From Dictionary    ${response.headers}    Content-Type
    Should Be Equal    ${header_value}    application/json; charset=utf-8

test_get_request_single_user_and_validate_response
    [Tags]  maintainer=todynyuk
    Create Session  mysession  ${base_url}  verify=true
    ${response}=  GET On Session  mysession  /api/users/2
    Status Should Be  200  ${response}
    ${id}=   Get Value From Json  ${response.json()}  data.id
    ${idFromList}=  Get From List   ${id}  0
    ${string_id}=    Convert To String     ${idFromList}
    Should Be Equal    ${string_id}    2

test_get_request_user_not_found_and_validate_response
    [Tags]  maintainer=todynyuk
    Create Session  mysession  ${base_url}  verify=true
    ${response}=  GET On Session  mysession  /api/users/23  expected_status=404
    Status Should Be  404  ${response}

test_post_request_and_validate_response
    [Tags]  maintainer=todynyuk
    Create Session  mysession  ${base_url}  verify=true
    ${body}=  Create Dictionary    name=Leena    job=SW Engineer    id=555
    Log To Console    ${body}
    ${response}=  POST On Session  mysession  /api/users/    data=${body}
    Status Should Be  201  ${response}
    ${id}=  Get Value From Json  ${response.json()}  id
    ${idFromList}=  Get From List   ${id}  0
    ${idFromListAsString}=  Convert To String  ${idFromList}
    Should be equal As Strings  ${idFromListAsString}  555

test_put_request_and_validate_response
    [Tags]  maintainer=todynyuk
    Create Session  mysession  ${base_url}  verify=true
    ${body}=  Create Dictionary    name=Raghad    job=SW Engineer    id=666
    Log To Console    ${body}
    ${response}=  PUT On Session  mysession  /api/users/2    data=${body}
    Status Should Be  200  ${response}

test_delete_request_and_validate_response
    [Tags]  maintainer=todynyuk
    Create Session  mysession  ${base_url}  verify=true
    ${response}=  DELETE On Session  mysession  /api/users/2
    Status Should Be  204  ${response}

test_get_request_with_delayed_response
    [Tags]  maintainer=todynyuk
    Create Session  mysession  ${base_url}  verify=true
    ${response}=  GET On Session  mysession  /api/users    params=delay=3
    Sleep    3s
    Status Should Be  200  ${response}

test_successful_register_and_validate_response
    [Tags]  maintainer=todynyuk
    Create Session  mysession  ${base_url}  verify=true
    ${body}=  Create Dictionary    email=eve.holt@reqres.in    password=pistol
    Log To Console    ${body}
    ${response}=  POST On Session  mysession  /api/register    data=${body}
    Status Should Be  200  ${response}
    Should Contain    ${response.json()}    id
    Should Contain    ${response.json()}    token

test_unsuccessful_register_request_and_validate_response
    [Tags]  maintainer=todynyuk
    Create Session  mysession  ${base_url}  verify=true
    ${body}=  Create Dictionary    email=sydney@fife
    Log To Console    ${body}
    ${response}=  POST On Session  mysession  /api/register    data=${body}    expected_status=400
    Status Should Be  400  ${response}

test_successful_login_request_and_validate_response
    [Tags]  maintainer=todynyuk
    Create Session  mysession  ${base_url}  verify=true
    ${body}=  Create Dictionary    email=eve.holt@reqres.in    password=cityslicka
    Log To Console    ${body}
    ${response}=  POST On Session  mysession  /api/login    data=${body}
    Status Should Be  200  ${response}
    Should Contain    ${response.json()}    token

test_unsuccessful_login_request_and_validate_response
    [Tags]  maintainer=todynyuk
    Create Session  mysession  ${base_url}  verify=true
    ${body}=  Create Dictionary    email=peter@klaven
    Log To Console    ${body}
    ${response}=  POST On Session  mysession  /api/login    data=${body}    expected_status=400
    Status Should Be  400  ${response}