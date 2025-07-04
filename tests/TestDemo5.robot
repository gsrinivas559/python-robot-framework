*** Settings ***
Documentation    To validate the login form
Library    SeleniumLibrary
Library    DataDriver    file=resources/testData.csv    dialect=excel
Test Teardown    Close Browser
Test Template    Validate UnSuccessful login

*** Variables ***
${alert}    css:.alert-danger

*** Test Cases ***
Login with user ${username} and password ${password}    xyz    123456


*** Keywords ***
Validate UnSuccessful login
    [Arguments]    ${username}    ${password}
    open the browser with the automation practice page url
    fill the login form    ${username}    ${password}
    wait until it checks and displays error message
    verify error message is correct
    
open the browser with the automation practice page url
    Create Webdriver    Chrome
    Go To    https://rahulshettyacademy.com/loginpagePractise/

fill the login form
    [Arguments]    ${userName}    ${password}
    Input Text        id:username    ${userName}
    Input Password    id:password    ${password}
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