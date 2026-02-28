*** Comments ***
# Test Data
# This file contains all test data variables used across test suites.

*** Variables ***
# Application URL
${BASE_URL}                  https://www.saucedemo.com/

# Test User Credentials
${VALID_USERNAME}            standard_user
${VALID_PASSWORD}            secret_sauce

# Restricted User Accounts
${LOCKED_USERNAME}           locked_out_user
${PROBLEM_USERNAME}          problem_user
${GLITCH_USERNAME}           performance_glitch_user
${ERROR_USERNAME}            error_user
${VISUAL_USERNAME}           visual_user

# Product Names
${PRODUCT_BACKPACK}          Sauce Labs Backpack
${PRODUCT_BIKE_LIGHT}        Sauce Labs Bike Light
${PRODUCT_BOLT_TSHIRT}       Sauce Labs Bolt T-Shirt
${PRODUCT_FLEECE_JACKET}     Sauce Labs Fleece Jacket
${PRODUCT_ONESIE}            Sauce Labs Onesie
${PRODUCT_RED_TSHIRT}        Test.allTheThings() T-Shirt (Red)

# Checkout Information
${CHECKOUT_FIRST_NAME}       John
${CHECKOUT_LAST_NAME}        Cruz
${CHECKOUT_POSTAL_CODE}      12345

# Expected Values
${EXPECTED_PRODUCT_COUNT}    6

# Error Messages
${ERR_LOCKED_USER}           Epic sadface: Sorry, this user has been locked out.
${ERR_INVALID_CREDS}         Epic sadface: Username and password do not match any user in this service
${ERR_EMPTY_USERNAME}        Epic sadface: Username is required
${ERR_EMPTY_PASSWORD}        Epic sadface: Password is required
${ERR_MISSING_FIRST_NAME}    Error: First Name is required
${ERR_MISSING_LAST_NAME}     Error: Last Name is required
${ERR_MISSING_POSTAL}        Error: Postal Code is required
