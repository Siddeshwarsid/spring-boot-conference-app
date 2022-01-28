package com.example.conferencedemo.controllers;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1/crash")
public class CrashController {
    @GetMapping("/boom")
    public String triggerCrash() {
        throw new RuntimeException("Controller to demonstrate explode of system");
    }
}
