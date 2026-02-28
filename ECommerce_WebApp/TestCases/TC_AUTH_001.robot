*** Comments ***
# TC_AUTH_001: Authentication - Valid Login
# Test suite for verifying successful user authentication scenarios.

*** Settings ***
Documentation    Validates that authorized users can successfully log in
...              and access the product catalog.

Library          SeleniumLibrary
Library          Collections

Resource         ../resources/keywords/common_keywords.resource
Resource         ../resources/keywords/login_keywords.resource
Resource         ../resources/keywords/inventory_keywords.resource

Resource         ../data/test_data.resource
Resource         ../resources/locators/inventory_locators.resource

Suite Setup      Open Browser And Maximize    ${BASE_URL}
Suite Teardown   Close Browser

*** Test Cases ***
TC_001: Login With Standard User Credentials
    [Documentation]    Verifies that a user with valid credentials can successfully log in.
    [Tags]    smoke    authentication    login

    Login To Application    ${VALID_USERNAME}    ${VALID_PASSWORD}
    Wait Until Element Is Visible    ${INVENTORY_ITEM}    ${DEFAULT_TIMEOUT}

TC_002: Verify Product Catalog Loads After Login
    [Documentation]    Verifies that the product catalog page is displayed after successful login.
    [Tags]    smoke    authentication    products

    Verify Products Are Displayed

TC_003: Verify Correct Number Of Products Displayed
    [Documentation]    Confirms the expected number of products are shown on the catalog page.
    [Tags]    regression    authentication    products

    Verify Products Count    ${EXPECTED_PRODUCT_COUNT}
