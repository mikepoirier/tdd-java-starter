package com.example.service;

import org.springframework.stereotype.Service;

import java.text.MessageFormat;
import java.util.Arrays;

@Service
public class GreetingService {

    public String greet() {
        return "Hello, World!";
    }

    public String greetByName(String name) {
        return MessageFormat.format("Hello, {0}!", capitalizeName(name));
    }

    private String capitalizeName(final String name) {
        return Arrays.stream(name.toLowerCase().split(" "))
                .map(part -> Character.toUpperCase(part.charAt(0)) + part.substring(1))
                .reduce("", (a, b) -> a + " " + b)
                .trim();
    }
}
