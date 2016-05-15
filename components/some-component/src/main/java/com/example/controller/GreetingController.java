package com.example.controller;

import com.example.model.Greeting;
import com.example.model.GreetingBuilder;
import com.example.service.GreetingService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.text.MessageFormat;

import static com.example.model.GreetingBuilder.greetingBuilder;

@RestController
@RequestMapping(value = "/greeting")
public class GreetingController {
    private static final Logger LOGGER = LoggerFactory.getLogger(GreetingController.class);
    private GreetingService greetingService;

    @Autowired
    public GreetingController(GreetingService greetingService) {
        this.greetingService = greetingService;
    }

    @RequestMapping("")
    public Greeting hello() {
        return greetingBuilder()
                .greeting(greetingService.greet())
                .build();
    }

    @RequestMapping(value = "/{name}")
    public Greeting hello(@PathVariable("name") String name) {
        return greetingBuilder().greeting(greetingService.greetByName(name)).build();
    }
}
