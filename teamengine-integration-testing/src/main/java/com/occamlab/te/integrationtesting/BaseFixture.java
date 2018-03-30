package com.occamlab.te.integrationtesting;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.firefox.FirefoxOptions;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.Select;
import org.openqa.selenium.support.ui.WebDriverWait;
import org.testng.annotations.AfterClass;
import org.testng.annotations.BeforeClass;

public class BaseFixture {

	protected WebDriver driver;
	protected String environment = null;
	protected String organization = null;
	protected String standard = null;
	protected String iut = null;
	protected boolean headlessMode;

	@BeforeClass
	public void beforeClass() {
		System.setProperty("webdriver.gecko.driver",
				"C:\\geckodriver\\geckodriver.exe");
		// Set Firefox Headless mode as TRUE
		readProperties();
		FirefoxOptions options = new FirefoxOptions();
		options.setHeadless(headlessMode);
		driver = new FirefoxDriver(options);
		if (environment == null) {
			throw new NullPointerException("Environment value is null!!");
		}
		driver.get("http://cite.opengeospatial.org/te2/");

	}

	@AfterClass
	public void afterClass() {
		driver.quit();
	}

	/**
	 * Find the requested WebElement using Xpath.
	 * 
	 * @param xpath
	 * @return WebElement object.
	 */

	public WebElement findElementByXpath(String xpath) {
		WebElement webElement = null;
		if (null != xpath) {
			webElement = driver.findElement(By.xpath(xpath));
		} else {
			throw new NullPointerException("Web Element xpath is null.");
		}
		return webElement;
	}

	/**
	 * The WebDriver will wait until the requested element have to
	 * appear/present on page in given wait time.
	 * 
	 * @param xpath
	 *            Get element from WebDriver.
	 * @param waitTime
	 *            Timeout in seconds.
	 */
	public void waitUntilVisibilityOfElement(String xpath, int waitTime) {

		WebDriverWait driverWait = new WebDriverWait(driver, waitTime);
		driverWait.until(ExpectedConditions.visibilityOfElementLocated(By
				.xpath(xpath)));
	}

	/**
	 * Select element from the dropdown list using value.
	 * 
	 * @param xpath
	 *            Used to get WebElement.
	 * @param value
	 *            Used to select the element from the list.
	 */
	public void selectDropdownByValue(String xpath, String value) {

		Select selectElement = new Select(findElementByXpath(xpath));
		selectElement.selectByValue(value);
	}

	/**
	 * Read Properties from config.properties file.
	 * 
	 */
	public void readProperties() {
		InputStream input = null;
		Properties prop = new Properties();
		try {

			input = getClass().getClassLoader().getResourceAsStream(
					"config.properties");
			// load a properties file
			prop.load(input);

			environment = prop.getProperty("environment");
			organization = prop.getProperty("organization");
			standard = prop.getProperty("standard");
			iut = prop.getProperty("iut");
			headlessMode = (null != prop.getProperty("headlessMode") && prop.getProperty("headlessMode").equals("true")) ? true : false;

		} catch (IOException ex) {
			ex.printStackTrace();
		} finally {
			if (input != null) {
				try {
					input.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
	}

}
