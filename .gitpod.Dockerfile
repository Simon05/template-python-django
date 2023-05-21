FROM gitpod/workspace-full

# Install Chrome
RUN curl -sS -o - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
RUN echo "deb http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google-chrome.list
RUN sudo apt update
RUN sudo apt install -y google-chrome-stable

# Install ChromeDriver
RUN CHROME_VERSION=$(google-chrome-stable --version | awk '{print $3}' | awk -F "." '{print $1}') \
    && CHROME_DRIVER_VERSION=$(curl -sS https://chromedriver.storage.googleapis.com/LATEST_RELEASE_${CHROME_VERSION}) \
    && wget -O /tmp/chromedriver.zip https://chromedriver.storage.googleapis.com/${CHROME_DRIVER_VERSION}/chromedriver_linux64.zip \
    && sudo unzip /tmp/chromedriver.zip chromedriver -d /usr/local/bin/ \
    && sudo chmod +x /usr/local/bin/chromedriver

# Install Python dependencies
RUN pip install selenium

# Start the IDE
CMD ["bash", "-c", "gp sync && code /workspace"]
