import requests
from bs4 import BeautifulSoup
from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.common.by import By

# URL of the webpage to scrape
url = "XXX"

# Configure the Selenium webdriver
driver_path = "path_to_chromedriver"
service = Service(driver_path)
driver = webdriver.Chrome(service=service)

# Open the webpage using Selenium
driver.get(url)

# Find all the icons and click on them to navigate to the animation detail page
icons = driver.find_elements(By.CLASS_NAME, "icon")
for icon in icons:
    icon.click()

# Get the current page source after clicking on the icons
page_source = driver.page_source

# Create a BeautifulSoup object to parse the HTML content
soup = BeautifulSoup(page_source, "html.parser")

# Find all the anchor tags that contain the animation URLs
animation_links = soup.find_all("a", class_="animation-card__link")

# Extract the URLs from the anchor tags
urls = []
for link in animation_links:
    animation_url = link["href"]
    urls.append(animation_url)

# Print the list of generated URLs
for url in urls:
    print(url)

# Close the Selenium webdriver
driver.quit()
