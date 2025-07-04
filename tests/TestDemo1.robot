*** Settings ***
Documentation    To validate the login form
Library    SeleniumLibrary
Test Teardown    Close Browser

*** Variables ***
${alert}    css:.alert-danger

*** Test Cases ***
Validate UnSuccessful login
    [Tags]    SMOKE
    open the browser with the automation practice page url
    fill the login form
    wait until it checks and displays error message
    verify error message is correct

*** Keywords ***
open the browser with the automation practice page url
    Create Webdriver    Chrome
    Go To    https://rahulshettyacademy.com/loginpagePractise/

fill the login form
    Input Text        id:username    testuser
#    using Input Password - entered values will not get logged in the logs
#    Input Text - entered values will be logged in the logs
    Input Password    id:password    test123
    Click Button    signInBtn

wait until it checks and displays error message
    Wait Until Element Is Visible    ${alert}
    
verify error message is correct
#    2 ways to validate
#    Method-1
#    ${alertMessage} =     Get Text    css:.alert-danger
#    Should Be Equal As Strings    ${alertMessage}    Incorrect username/password.
#    Method-2
    Element Text Should Be    ${alert}    Incorrect username/password.