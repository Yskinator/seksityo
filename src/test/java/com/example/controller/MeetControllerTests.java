package com.example.controller;


import org.junit.Test;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.web.client.TestRestTemplate;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import java.util.Collections;


@SpringBootTest
public class MeetControllerTests {

    @Test
    public void meetControllerReturnsOk() throws Exception {
        String res = "";
        TestRestTemplate rest = new TestRestTemplate();
        ResponseEntity<String> response = rest.postForEntity("http://localhost:8080/ok", res, String.class, Collections.emptyMap());

        assert(response.getStatusCode() == HttpStatus.OK );
    }


}
