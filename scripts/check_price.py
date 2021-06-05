import selenium
from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.support.ui import Select
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver import Chrome

# returns a floating point value storing the current price
def get_price():
    # navigates the chrome webpage through the publix store selection
    driver = Chrome()
    driver.get("https://www.publix.com/pd/publix-chicken-tender-sub/BMO-DSB-100011?ch=18.2.1.&oeo=true")
    driver.implicitly_wait(5)
    choose_store = driver.find_element_by_class_name("cta.button")
    choose_store.click()
    location_field = driver.find_element_by_id("input_ZIPorCity,Stateorstorenumber42")
    location_field.send_keys("32817")
    search_button = driver.find_element_by_name("Store Search Button")
    search_button.click()
    driver.implicitly_wait(5)
    store_selection = driver.find_element_by_class_name("choose-store-button.button.small")
    store_selection.click()
    driver.implicitly_wait(5)

    # price should now be visible
    starts_at_price = driver.find_element_by_class_name("price")
    starts_at_price = driver.find_element_by_class_name("price") # run this line twice or everything breaks
    price = float(starts_at_price.text[-4:]) # last 4 characters are the price

    driver.close()
    return price
