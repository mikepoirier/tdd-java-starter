package com.example.service;

import org.junit.Before;
import org.junit.Test;

import static org.hamcrest.Matchers.*;
import static org.junit.Assert.*;

public class GreetingServiceTest {

    private GreetingService service;

    @Before
    public void setUp() throws Exception {
        service = new GreetingService();
    }

    @Test
    public void greet_returnsHelloWorld() throws Exception {
        assertThat(service.greet(), is(equalTo("Hello, World!")));
    }

    @Test
    public void greetByName_returnsHelloAndTheNameProperlyCapitlized() throws Exception {
        assertThat(service.greetByName("Some Name"), is(equalTo("Hello, Some Name!")));
        assertThat(service.greetByName("some Name"), is(equalTo("Hello, Some Name!")));
        assertThat(service.greetByName("Some name"), is(equalTo("Hello, Some Name!")));
        assertThat(service.greetByName("some name"), is(equalTo("Hello, Some Name!")));
        assertThat(service.greetByName("SOME NAME"), is(equalTo("Hello, Some Name!")));
    }
}