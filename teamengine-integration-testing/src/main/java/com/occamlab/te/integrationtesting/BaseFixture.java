package com.occamlab.te.integrationtesting;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.Select;
import org.openqa.selenium.support.ui.WebDriverWait;
import org.testng.annotations.AfterClass;
import org.testng.annotations.BeforeClass;

public class BaseFixture {
	
	protected WebDriver driver;

    @BeforeClass
    public void beforeClass() {
    	System.setProperty("webdriver.gecko.driver", "C:\\geckodriver\\geckodriver.exe");
        driver = new FirefoxDriver();
        driver.get("http://localhost:8080/teamengine/");
    }

    @AfterClass
    public void afterClass() {
        driver.quit();
    }
    
    
    /**
     * Find the requested WebElement using Xpath.
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
	 * 			Get element from WebDriver.
	 * @param waitTime
	 * 			Timeout in seconds.
	 */
	public void waitUntilVisibilityOfElement(String xpath, int waitTime) {

		WebDriverWait driverWait = new WebDriverWait(driver, waitTime);
		driverWait.until(ExpectedConditions.visibilityOfElementLocated(By
				.xpath(xpath)));
	}
	
	/**
	 * Select element from the dropdown list using value.
	 * @param xpath
	 * 			Used to get WebElement.
	 * @param value
	 * 			Used to select the element from the list.
	 */
	public void selectDropdownByValue(String xpath, String value){
		
        Select selectOrganization= new Select(findElementByXpath(xpath));
        selectOrganization.selectByValue(value);
		
	}
	
}
