from robot.api.deco import library, keyword
from robot.libraries.BuiltIn import BuiltIn


@library
class Shop:

    def __init__(self):
        self.selLib = BuiltIn().get_library_instance("SeleniumLibrary")

    @keyword
    def hello_world(self):
        print("Hello")

    @keyword
    def add_items_to_cart_and_checkout(self, productsList):
        print("Items adding to cart")
        # the keyword names will be changed from space to underscore while using robot keywords in python
        # Eg: Get Webelements --> get_webelements
        # the method names should be small case only
        i  = 1
        productTitles = self.selLib.get_webelements("css:.card-title")
        for productTitle in productTitles:
            if productTitle.text in productsList:
                self.selLib.click_element("xpath:(//div[@class='card-footer'])["+str(i)+"]/button")
            i = i + 1
        self.selLib.click_element("css:li.active a")

