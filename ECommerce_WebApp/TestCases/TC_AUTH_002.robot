*** Comments ***
# TC_AUTH_002: Authentication - Error Handling
# Test suite for verifying login error scenarios and account restrictions.

*** Settings ***
Documentation    Validates that the application correctly handles invalid login attempts,
...              locked accounts, and missing credentials with appropriate error messages.

Library          SeleniumLibrary

Resource         ../resources/keywords/common_keywords.resource
Resource         ../resources/keywords/login_keywords.resource

Resource         ../data/test_data.resource
Resource         ../resources/locators/login_locators.resource

Suite Setup      Open Browser And Maximize    ${BASE_URL}
Suite Teardown   Close Browser
Test Setup       Go To    ${BASE_URL}

*** Test Cases ***
TC_004: Verify Locked Account Cannot Access Application
    [Documentation]    Confirms that a locked user account is denied access with proper error message.
    [Tags]    regression    authentication    negative

    Wait For Element And Input Text    ${LOGIN_USERNAME_INPUT}    ${LOCKED_USERNAME}
    Input Text    ${LOGIN_PASSWORD_INPUT}    ${VALID_PASSWORD}
    Click Button    ${LOGIN_BUTTON}
    Verify Login Error Message    Sorry, this user has been locked out

TC_005: Verify Error On Invalid Password
    [Documentation]    Confirms that an invalid password displays the correct error message.
    [Tags]    regression    authentication    negative

    Wait For Element And Input Text    ${LOGIN_USERNAME_INPUT}    ${VALID_USERNAME}
    Input Text    ${LOGIN_PASSWORD_INPUT}    invalid_password
    Click Button    ${LOGIN_BUTTON}
    Verify Login Error Message    Username and password do not match

TC_006: Verify Error When Username Is Empty
    [Documentation]    Confirms that submitting the form with an empty username shows a validation error.
    [Tags]    regression    authentication    validation

    Wait Until Element Is Visible    ${LOGIN_BUTTON}    ${DEFAULT_TIMEOUT}
    Input Text    ${LOGIN_PASSWORD_INPUT}    ${VALID_PASSWORD}
    Click Button    ${LOGIN_BUTTON}
    Verify Login Error Message    Username is required

TC_007: Verify Error When Password Is Empty
    [Documentation]    Confirms that submitting the form with an empty password shows a validation error.
    [Tags]    regression    authentication    validation

    Wait For Element And Input Text    ${LOGIN_USERNAME_INPUT}    ${VALID_USERNAME}
    Click Button    ${LOGIN_BUTTON}
    Verify Login Error Message    Password is required
