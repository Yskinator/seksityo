package com.example.controller;


import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.web.client.TestRestTemplate;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.test.context.junit4.SpringRunner;


import java.util.Collections;


@RunWith(SpringRunner.class)
@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
public class MeetControllerTests {

    @Autowired
    private TestRestTemplate restTemplate;

    @Test
    public void okTest(){
        String res = "";
        ResponseEntity<String> response = this.restTemplate.postForEntity("/ok", res, String.class, Collections.emptyMap());
        assert(response.getStatusCode() == HttpStatus.OK);
    }




}
