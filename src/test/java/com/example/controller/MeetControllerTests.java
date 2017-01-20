package com.example.controller;


import org.junit.Before;
import org.junit.Test;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.web.servlet.MockMvc;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;
import static org.springframework.test.web.servlet.setup.MockMvcBuilders.standaloneSetup;

@SpringBootTest
public class MeetControllerTests {

    private MockMvc mockMvc;

    @Before
    public void setUp(){
        this.mockMvc = standaloneSetup(new MeetController()).build();

    }

    @Test
    public void meetControllerReturnsOk() throws Exception {
        this.mockMvc.perform(post("/ok")).andExpect(status().isOk());
    }


}
