*** Settings ***
Documentation    To validate the login form
Library    SeleniumLibrary
Library    String
Library    Collections
Test Setup    open the browser with the automation practice page url
Test Teardown    Close Browser
Resource    ../pageObjects/CommonResource.robot

*** Variables ***
#${alert}    css:.alert-danger

*** Test Cases ***
Validate child window functionality
    [Tags]    SMOKE
    click on child window link
    verify user is switched to child window
    grab the email id in the child window
    switch to parent window and enter the email

*** Keywords ***
click on child window link
    Click Element    css:a.blinkingText:nth-child(1)
    Sleep    5

verify user is switched to child window
    Switch Window    NEW
    Wait Until Element Is Visible    css:h1
    Element Text Should Be    css:h1    DOCUMENTS REQUEST

grab the email id in the child window
    Wait Until Element Is Visible    css:.red
    ${elementText} =    Get Text    css:.red
#    Please email us at mentor@rahulshettyacademy.com with below template to receive response
    @{words} =    Split String    ${elementText}    at
#    0 - Please email us  
#    1 - mentor@rahulshettyacademy.com with below templ
#    2 - e to receive response
    ${firstWord} =    Get From List    ${words}    1
#    mentor@rahulshettyacademy.com with below templ
    Log    ${firstWord}
    @{firstWordSplit} =    Split String    ${firstWord}
#    0 - mentor@rahulshettyacademy.com
#    1 - with below templ
    ${emailID} =    Get From List    ${firstWordSplit}    0
#    0 --> mentor@rahulshettyacademy.com
    Set Global Variable    ${emailID}

switch to parent window and enter the email
    Switch Window    MAIN
    Title Should Be    LoginPage Practise | Rahul Shetty Academy
    Input Text    id:username    ${emailID}

    