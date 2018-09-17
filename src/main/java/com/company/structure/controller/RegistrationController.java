package com.company.structure.controller;

import com.company.structure.model.User;
import com.company.structure.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

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
    public String addUser(@Valid User user, BindingResult bindingResult, Model model,
                          @RequestParam("passwordConfirmation") String passwordConfirmation) {

        User userFromDb = userService.findByUserName(user.getUsername());
        User userByEmail = userService.findByEmail(user.getEmail());

        boolean isConfirmEmpty = StringUtils.isEmpty(passwordConfirmation);
        boolean isPasswordDifferent = user.getPassword().equals(passwordConfirmation);

        if (isConfirmEmpty) {
            model.addAttribute("passwordConfirmationError", "Password confirmation can`t be empty");
        }

        if (!isPasswordDifferent) {
            model.addAttribute("passwordError", "Passwords are different!");
        }

        if (bindingResult.hasErrors()|| isConfirmEmpty || !isPasswordDifferent) {
            Map<String, String> errors = ControllerUtils.getErrors(bindingResult);
            model.mergeAttributes(errors);
            return "registration";
        }

        if (userByEmail != null) {
            model.addAttribute("emailError", "This email specified by other user!!!");
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
