package com.company.structure.controller;

import com.company.structure.model.Role;
import com.company.structure.model.User;
import com.company.structure.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/user")
@PreAuthorize("hasAuthority('ADMIN')")
public class UserController {

    @Autowired
    private UserService userService;

    @GetMapping
    @PreAuthorize("hasAuthority('ADMIN')")
    public String list(@RequestParam(required = false, defaultValue = "") String filter, Model model) {
        List<User> users;
        List<User> search = new ArrayList<>();
        User userFromDB = userService.findByUserName(filter);

        if (!filter.equals("") && !filter.isEmpty() && userFromDB != null) {
            search.add(userFromDB);
            users = search;
        } else {
            users = userService.getAllUsers();
            if (userFromDB == null && !filter.equals("")) {
                model.addAttribute("filterError", "Can`t find user with this name");
            }
        }

        model.addAttribute("users", users);
        model.addAttribute("filter", filter);

        return "users";
    }

    @GetMapping("{user}")
    public String userEditForm(@PathVariable User user, Model model) {
        model.addAttribute("user", user);
        model.addAttribute("roles", Role.values());
        return "userEdit";
    }

    @PostMapping
    public String userSave(@RequestParam String userName,
                           @RequestParam Map<String, String> form,
                           @RequestParam("userId") User user,
                           @RequestParam boolean active) {

        userService.save(user, userName, form, active);
        return "redirect:/user";
    }

    @GetMapping("profile")
    @PreAuthorize("hasAnyAuthority('USER', 'ADMIN')")
    public String getProfile(Model model, @AuthenticationPrincipal User user) {
        model.addAttribute("username", user.getUsername());
        model.addAttribute("email", user.getEmail());
        return "profile";
    }

    @PostMapping("profile")
    @PreAuthorize("hasAnyAuthority('USER', 'ADMIN')")
    public String updateProfile(@AuthenticationPrincipal User user, @RequestParam String password,
                                @RequestParam String passwordConfirmation,
                                @RequestParam String email, Model model) {

        boolean isConfirmEmpty = StringUtils.isEmpty(passwordConfirmation);
        boolean isPasswordDifferent = password.equals(passwordConfirmation);

        if ((isConfirmEmpty && !password.equals("")) || !isPasswordDifferent) {
            if (isConfirmEmpty) {
                model.addAttribute("passwordConfirmationError", "Password confirmation can`t be empty");
            }

            if (!isPasswordDifferent) {
                model.addAttribute("passwordError", "Passwords are different!");
            }
            model.addAttribute("user", user);
            return "profile";
        }


        userService.updateProfile(user, password, passwordConfirmation, email);
        model.addAttribute("user" , user);
        model.addAttribute("newEmail" , email);
        return "profile";
    }

    @GetMapping("delete/{id}")
    public String delete(@PathVariable("id") User user) {
        userService.delete(user);
        return "redirect:/user";
    }

}
