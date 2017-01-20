/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.example.controller;

import org.springframework.http.HttpStatus;
import static org.springframework.http.RequestEntity.method;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.mvc.AbstractController;



/**
 *
 * @author villtann
 */
@Controller
public class MeetController {

    @RequestMapping(value = "/ok", method = RequestMethod.POST)
    @ResponseStatus(value = HttpStatus.OK)
    public void sendAnOK() {
    }
    
}
