*** Settings ***
Documentation    To have all the page objects and keywords
Library    SeleniumLibrary
Resource    ../pageObjects/CommonResource.robot

*** Variables ***
${loginForm}    id:login-form
${alert}    css:.alert-danger

*** Keywords ***
wait until element is visible in the page
    CommonResource.Wait Until Element Is Visible In The Page    ${loginForm}

fill the login form
#    arguments should always be declared in 1st line
    [Arguments]    ${userName}    ${password}
    Input Text        id:username    ${userName}
    Input Password    id:password    ${password}
#    id: or css: or xpath: are optional
    Click Button    signInBtn

wait until alert is visible in the page
    CommonResource.Wait Until Element Is Visible In The Page    ${alert}

verify error message is correct
#    2 ways to validate
#    Method-1
#    ${alertMessage} =     Get Text    css:.alert-danger
#    Should Be Equal As Strings    ${alertMessage}    Incorrect username/password.
#    Method-2
    Element Text Should Be    ${alert}    Incorrect username/password.

Fill the login form details
    Input Text        id:username    rahulshettyacademy
    Input Password    id:password    learning
    Click Element    css:input[value='user']
    Wait Until Element Is Visible    css:.modal-body
    Click Element    css:#okayBtn
    Wait Until Element Is Not Visible    css:.modal-body
    Select From List By Label    css:select.form-control    Teacher
    Select Checkbox    terms
    Checkbox Should Be Selected    terms

accept alert if present
    Sleep    5
    ${IsAlertPresent}=  Run Keyword And Return Status    Alert Should Be Present
    Run Keyword If    ${IsAlertPresent}  Accept Alert    ELSE  Log To Console    No alert present

Handle Alert
    Handle Alert    accept