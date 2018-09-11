package com.company.structure.controller;

import com.company.structure.model.Company;
import com.company.structure.model.Role;
import com.company.structure.model.User;
import com.company.structure.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@Controller
@RequestMapping("/user")
@PreAuthorize("hasAuthority('ADMIN')")
public class UserController {

    @Autowired
    private UserService userService;

    @GetMapping
    public String userList(Model model) {
        model.addAttribute("users", userService.findAll());
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
                                @RequestParam String confPassword, @RequestParam String email) {
        userService.updateProfile(user, password, confPassword, email);
        return "redirect:/user/profile";
    }

    @GetMapping("delete/{id}")
    public String delete(@PathVariable("id") User user) {
        userService.delete(user);
        return "redirect:/user";
    }

}
