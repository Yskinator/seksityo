package com.example;

import org.junit.Before;
import org.junit.Test;
import org.junit.Assert;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.remote.DesiredCapabilities;
import org.openqa.selenium.remote.RemoteWebDriver;
import java.net.URL;



public class SeleniumTests {

	/*
		Define Saucelabs username and access key for the Remote Web Driver
	*/
	public static final String USERNAME = "Merloni";
	public static final String ACCESS_KEY = "30fb4b59-59c4-4a77-a157-0f6bc47fb001";
	public static final String URL = "http://" + USERNAME + ":" + ACCESS_KEY + "@ondemand.saucelabs.com:80/wd/hub";


//	@Before
//	public void defineWebDriverPath(){
//		String currentDir = System.getProperty("user.dir");
//		String chromeDriverLocation = currentDir + "/tools/chromedriver/chromedriver";
//		System.setProperty("webdriver.chrome.driver", chromeDriverLocation);
//	}

//	@Test
//	public void startLocalWebDriver(){
//		WebDriver driver = new ChromeDriver();
//
//		driver.navigate().to("http://seleniumsimplified.com");
//
//		Assert.assertTrue("title should start differently",
//				driver.getTitle().startsWith("Selenium Simplified"));
//
//		driver.close();
//		driver.quit();
//	}

	@Test
	public void startRemoteWebDriver() throws Exception {
		DesiredCapabilities caps = DesiredCapabilities.chrome();
		caps.setCapability("platform", "Windows XP");
		caps.setCapability("version", "43.0");

		WebDriver driver = new RemoteWebDriver(new URL(URL), caps);

		driver.navigate().to("http://seleniumsimplified.com");

		Assert.assertTrue("title should start differently",
				driver.getTitle().startsWith("Selenium Simplified"));

		driver.close();
		driver.quit();
	}
}




