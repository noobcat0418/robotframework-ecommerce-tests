*** Comments ***
# TC_CHECKOUT_003: Checkout - Form Validation
# Test suite for verifying checkout form validation and error handling.

*** Settings ***
Documentation    Validates that the checkout form correctly handles missing required fields
...              and displays appropriate validation error messages.

Library          SeleniumLibrary

Resource         ../resources/keywords/common_keywords.resource
Resource         ../resources/keywords/login_keywords.resource
Resource         ../resources/keywords/inventory_keywords.resource
Resource         ../resources/keywords/cart_keywords.resource
Resource         ../resources/keywords/checkout_keywords.resource

Resource         ../data/test_data.resource
Resource         ../resources/locators/inventory_locators.resource
Resource         ../resources/locators/cart_locators.resource
Resource         ../resources/locators/checkout_locators.resource

Suite Setup      Setup Cart For Checkout Validation
Suite Teardown   Close Browser
Test Setup       Navigate To Checkout Form

*** Keywords ***
Setup Cart For Checkout Validation
    [Documentation]    Logs in and adds a product to the cart.
    Open Browser And Maximize    ${BASE_URL}
    Login To Application    ${VALID_USERNAME}    ${VALID_PASSWORD}
    Add Product To Cart By Button    ${ADD_BACKPACK_BTN}

Navigate To Checkout Form
    [Documentation]    Navigates to the checkout information form.
    Navigate To Cart
    Click Checkout Button

Verify Checkout Error Message
    [Documentation]    Verifies that the checkout form displays the expected error message.
    [Arguments]    ${expected_message}
    Wait Until Element Is Visible    ${CHECKOUT_ERROR_MESSAGE}    ${DEFAULT_TIMEOUT}
    ${actual_message}=    Get Text    ${CHECKOUT_ERROR_MESSAGE}
    Should Contain    ${actual_message}    ${expected_message}

*** Test Cases ***
TC_032: Checkout With Missing First Name
    [Documentation]    Verifies error message when first name is not provided during checkout.
    [Tags]    regression    checkout    validation

    Wait Until Element Is Visible    ${CHECKOUT_CONTINUE_BTN}    ${DEFAULT_TIMEOUT}
    Input Text    ${CHECKOUT_LAST_NAME_INPUT}    ${CHECKOUT_LAST_NAME}
    Input Text    ${CHECKOUT_POSTAL_CODE_INPUT}    ${CHECKOUT_POSTAL_CODE}
    Click Button    ${CHECKOUT_CONTINUE_BTN}
    Verify Checkout Error Message    First Name is required

TC_033: Checkout With Missing Last Name
    [Documentation]    Verifies error message when last name is not provided during checkout.
    [Tags]    regression    checkout    validation

    Wait Until Element Is Visible    ${CHECKOUT_CONTINUE_BTN}    ${DEFAULT_TIMEOUT}
    Input Text    ${CHECKOUT_FIRST_NAME_INPUT}    ${CHECKOUT_FIRST_NAME}
    Input Text    ${CHECKOUT_POSTAL_CODE_INPUT}    ${CHECKOUT_POSTAL_CODE}
    Click Button    ${CHECKOUT_CONTINUE_BTN}
    Verify Checkout Error Message    Last Name is required

TC_034: Checkout With Missing Postal Code
    [Documentation]    Verifies error message when postal code is not provided during checkout.
    [Tags]    regression    checkout    validation

    Wait Until Element Is Visible    ${CHECKOUT_CONTINUE_BTN}    ${DEFAULT_TIMEOUT}
    Input Text    ${CHECKOUT_FIRST_NAME_INPUT}    ${CHECKOUT_FIRST_NAME}
    Input Text    ${CHECKOUT_LAST_NAME_INPUT}    ${CHECKOUT_LAST_NAME}
    Click Button    ${CHECKOUT_CONTINUE_BTN}
    Verify Checkout Error Message    Postal Code is required

TC_035: Cancel Checkout And Return To Cart
    [Documentation]    Verifies that cancelling checkout returns the user to the cart page.
    [Tags]    regression    checkout    navigation

    Cancel Checkout
    Wait Until Element Is Visible    ${CHECKOUT_BTN}    ${DEFAULT_TIMEOUT}
