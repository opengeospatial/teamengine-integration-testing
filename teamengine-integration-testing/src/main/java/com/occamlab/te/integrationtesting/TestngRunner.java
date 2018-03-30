package com.occamlab.te.integrationtesting;

import java.util.ArrayList;
import java.util.List;

import org.testng.TestListenerAdapter;
import org.testng.TestNG;


public class TestngRunner {

	public static void main(String[] args) {
		List<String> suites = new ArrayList<String>();
		TestListenerAdapter tla = new TestListenerAdapter();
        TestNG driver = new TestNG();
        driver.addListener(tla);
        suites.add("src/main/resources/testng.xml");
        driver.setTestSuites(suites);
        driver.setVerbose(0);
        driver.setUseDefaultListeners(true);
        driver.run();
	}

}
