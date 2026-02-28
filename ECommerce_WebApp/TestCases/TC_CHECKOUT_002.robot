*** Comments ***
# TC_CHECKOUT_002: Checkout - Price And Tax Validation
# Test suite for verifying checkout price calculations and totals.

*** Settings ***
Documentation    Validates that the checkout summary displays correct subtotals,
...              tax calculations, and total amounts, including price updates after product removal.

Library          SeleniumLibrary
Library          Collections

Resource         ../resources/keywords/common_keywords.resource
Resource         ../resources/keywords/login_keywords.resource
Resource         ../resources/keywords/inventory_keywords.resource
Resource         ../resources/keywords/cart_keywords.resource
Resource         ../resources/keywords/checkout_keywords.resource

Resource         ../data/test_data.resource
Resource         ../resources/locators/inventory_locators.resource
Resource         ../resources/locators/cart_locators.resource
Resource         ../resources/locators/checkout_locators.resource

Suite Setup      Setup Checkout With Multiple Products
Suite Teardown   Close Browser

*** Variables ***
${INITIAL_SUBTOTAL}    ${0}
${INITIAL_TAX}         ${0}
${INITIAL_TOTAL}       ${0}

*** Keywords ***
Setup Checkout With Multiple Products
    [Documentation]    Logs in, adds multiple products, and proceeds to checkout summary.
    Open Browser And Maximize    ${BASE_URL}
    Login To Application    ${VALID_USERNAME}    ${VALID_PASSWORD}
    Add Product To Cart By Button    ${ADD_BACKPACK_BTN}
    Add Product To Cart By Button    ${ADD_BIKE_LIGHT_BTN}
    Add Product To Cart By Button    ${ADD_BOLT_TSHIRT_BTN}
    Navigate To Cart
    Click Checkout Button
    Fill Checkout Information    ${CHECKOUT_FIRST_NAME}    ${CHECKOUT_LAST_NAME}    ${CHECKOUT_POSTAL_CODE}

*** Test Cases ***
TC_028: Verify Checkout Summary Subtotal
    [Documentation]    Confirms the checkout summary displays a valid subtotal amount.
    [Tags]    regression    checkout    pricing

    ${subtotal}=    Get Summary Subtotal
    Should Be True    ${subtotal} > 0
    Set Suite Variable    ${INITIAL_SUBTOTAL}    ${subtotal}
    Log    Checkout subtotal: $${subtotal}

TC_029: Verify Tax Calculation Is Present
    [Documentation]    Confirms the checkout summary includes a tax amount.
    [Tags]    regression    checkout    pricing

    ${tax}=    Get Summary Tax
    Should Be True    ${tax} > 0
    Set Suite Variable    ${INITIAL_TAX}    ${tax}
    Log    Tax amount: $${tax}

TC_030: Verify Total Equals Subtotal Plus Tax
    [Documentation]    Validates that the total amount equals the subtotal plus tax.
    [Tags]    regression    checkout    pricing

    ${total}=    Get Summary Total
    ${expected_total}=    Evaluate    round(${INITIAL_SUBTOTAL} + ${INITIAL_TAX}, 2)
    Should Be Equal As Numbers    ${total}    ${expected_total}    precision=2
    Set Suite Variable    ${INITIAL_TOTAL}    ${total}

TC_031: Verify Total Updates After Removing Product
    [Documentation]    Confirms the checkout total decreases after a product is removed from the cart.
    [Tags]    regression    checkout    pricing

    Cancel Checkout
    Navigate To Cart
    Remove Product From Cart By Name    ${REMOVE_BACKPACK_BTN}
    Click Checkout Button
    Fill Checkout Information    ${CHECKOUT_FIRST_NAME}    ${CHECKOUT_LAST_NAME}    ${CHECKOUT_POSTAL_CODE}
    ${updated_total}=    Get Summary Total
    Should Not Be Equal As Numbers    ${updated_total}    ${INITIAL_TOTAL}
    Should Be True    ${updated_total} < ${INITIAL_TOTAL}
    Log    Total updated from $${INITIAL_TOTAL} to $${updated_total}
