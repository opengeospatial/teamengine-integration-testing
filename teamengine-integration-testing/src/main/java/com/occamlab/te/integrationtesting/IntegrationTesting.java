package com.occamlab.te.integrationtesting;

import org.openqa.selenium.WebElement;
import org.testng.Assert;
import org.testng.annotations.Test;

public class IntegrationTesting extends BaseFixture{
	
	
/*	@BeforeTest
    public void  beforeTest(){
    	this.driver.get("http://localhost:8080/teamengine/");
    }*/
	
    @Test
    public void verifyGML32Test() {

        //driver.manage().timeouts().implicitlyWait(10, TimeUnit.SECONDS);

//        driver.get("http://cite.opengeospatial.org/te2/");
        

        String search_text = "Log In";
        //WebElement search_button = driver.findElement(By.name("btnK"));
        WebElement signIn_button = findElementByXpath("//*[@id=\"noColumn\"]/a[1]/span");
        waitUntilVisibilityOfElement("//*[@id=\"noColumn\"]/a[1]/span", 10);
        signIn_button.click();
        
        WebElement username = findElementByXpath("/html/body/form/p/input[1]");
        WebElement password = findElementByXpath("/html/body/form/p/input[2]");
        WebElement login_button = findElementByXpath("/html/body/form/p/input[3]");
        username.sendKeys("ogctest");
        password.sendKeys("ogctest");
        String text = login_button.getAttribute("value"); 
        login_button.click();
        
        WebElement createSession = findElementByXpath("/html/body/a");
        waitUntilVisibilityOfElement("/html/body/a", 15);
        createSession.click();
        
        waitUntilVisibilityOfElement("//*[@id=\"Organization\"]", 15);
        selectDropdownByValue("//*[@id=\"Organization\"]", "OGC");
        selectDropdownByValue("//*[@id=\"Standard\"]", "OGC_Geography Markup Language (GML)_3.2.1_1.26-SNAPSHOT");
        
        WebElement description = findElementByXpath("//*[@id=\"description\"]");
        description.sendKeys("");
        
        WebElement startNewSession = findElementByXpath("/html/body/form/input[1]");
        startNewSession.click();
        
        
        this.driver.switchTo().frame("te_test_panel");
        waitUntilVisibilityOfElement("//*[@id=\"gml-uri\"]", 10);
        WebElement iut = findElementByXpath("//*[@id='gml-uri']");
        iut.sendKeys("https://cite.deegree.org/deegree-webservices-3.4-RC3/services/gml321?service=WFS&request=GetFeature&Version=2.0.0&typenames=app:Autos");
      
        WebElement startExecution = findElementByXpath("/html/body/form/p/input[1]");
        startExecution.click();
        this.driver.switchTo().defaultContent();
        waitUntilVisibilityOfElement("/html/body/h3/font/div[6]", 30);
        
        WebElement getResult = findElementByXpath("/html/body/h3/font/div[6]");
        String resultCount = getResult.getText();
        String rCount = resultCount.split(":")[1];
        
        Assert.assertEquals(rCount, 0, "Test Failed!!!");
        
        Assert.assertEquals(text, search_text, "Text not found!");
    }
}
