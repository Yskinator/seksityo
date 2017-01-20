package com.example;

import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;
import org.junit.Assert;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;

public class SeleniumTests {

	@Before
	public void defineWebDriverPath(){
		String currentDir = System.getProperty("user.dir");
		String chromeDriverLocation = currentDir + "/tools/chromedriver/chromedriver";
		System.setProperty("webdriver.chrome.driver", chromeDriverLocation);
	}

	@Test
	public void startWebDriver(){
		WebDriver driver = new ChromeDriver();

		driver.navigate().to("http://seleniumsimplified.com");

		Assert.assertTrue("title should start differently",
				driver.getTitle().startsWith("Selenium Simplified"));

		driver.close();
		driver.quit();
	}

}
