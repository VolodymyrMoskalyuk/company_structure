package com.company.structure.controller;

import com.company.structure.model.User;
import com.company.structure.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import javax.validation.Valid;
import java.util.Map;

@Controller
public class RegistrationController {

    @Autowired
    private UserService userService;

    @GetMapping("/registration")
    public String registration() {

        return "registration";
    }

    @PostMapping("/registration")
    public String addUser(@Valid User user, BindingResult bindingResult, Model model) {

        User userFromDb = userService.findByUserName(user.getUsername());

        if (user.getPassword() != null && !user.getPassword().equals(user.getPasswordConfirmation())) {
            model.addAttribute("passwordError", "Passwords are different!");
        }

        if (bindingResult.hasErrors()) {
            Map<String, String> errors = ControllerUtils.getErrors(bindingResult);
            model.mergeAttributes(errors);

            return "registration";
        }

        if (userFromDb != null) {
            model.addAttribute("message", "Sorry, but user with this name exists!!!");
            return "registration";
        }

        userService.addUser(user);
        model.addAttribute("success", "User successfully registered");

        return "registrationSuccess";
    }
}
