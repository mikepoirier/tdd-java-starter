package com.example.model;

public final class GreetingBuilder {
    private String greeting;

    private GreetingBuilder() {
        this.greeting = "";
    }

    public static GreetingBuilder greetingBuilder() {
        return new GreetingBuilder();
    }

    public GreetingBuilder greeting(String greeting) {
        this.greeting = greeting;
        return this;
    }

    public Greeting build() {
        Greeting greeting = new Greeting(this.greeting);
        return greeting;
    }
}
