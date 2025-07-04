*** Settings ***
Documentation    To validate the login form using common resource file
Library    SeleniumLibrary
Library    Collections
Library    ../customLibraries/Shop.py
Test Setup    open the browser with the automation practice page url
Test Teardown    close browser session
Resource    ../pageObjects/CommonResource.robot
Resource    ../pageObjects/LandingPage.robot
Resource    ../pageObjects/ShopPage.robot
Resource    ../pageObjects/CheckoutPage.robot
Resource    ../pageObjects/ConfirmationPage.robot

*** Variables ***
@{productsList}    Nokia Edge    Blackberry
${countryLocation}    India

*** Test Cases ***
Validate UnSuccessful login
    [Tags]    SMOKE
    LandingPage.Wait Until Element Is Visible In The Page
    LandingPage.Fill The Login Form    ${userName}    ${inValidPassword}
    LandingPage.Wait Until Alert Is Visible In The Page
    LandingPage.verify error message is correct

End to end ecommerce product validation
    [Tags]    REGRESSION
    LandingPage.Fill The Login Form    ${userName}    ${validPassword}
    ShopPage.Wait Until Element Is Visible In The Page
    ShopPage.Verify card titles in the page
    Add Items To Cart And Checkout    ${productsList}
#    Select the card    Nokia Edge
    CheckoutPage.verify items in the checkout page and proceed   ${productsList}
    ConfirmationPage.Enter The Country And Select Terms    ${countryLocation}
    ConfirmationPage.Purchase The Product And Confirm The Purchase

Validate the login functionality
    [Tags]    SMOKE    REGRESSION
    LandingPage.Fill the login form details

    
    