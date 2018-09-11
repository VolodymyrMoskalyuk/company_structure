package com.company.structure.controller;

import com.company.structure.model.Company;
import com.company.structure.model.User;
import com.company.structure.service.CompanyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/company")
public class CompanyController {

    @Autowired
    private CompanyService companyService;

    @GetMapping
    @PreAuthorize("hasAuthority('ADMIN')")
    public String list(@RequestParam(required = false, defaultValue = "") String filter, Model model) {
        List<Company> companies;
        List<Company> search = new ArrayList<>();

        if (!filter.equals("") && !filter.isEmpty()) {
            search.add(companyService.findByName(filter));
            companies = search;
        } else {
            companies = companyService.listOfCompanies();
        }

        model.addAttribute("companies", companies);
        model.addAttribute("filter", filter);

        return "companies";
    }

    @GetMapping
    @RequestMapping("/own_companies")
    @PreAuthorize("hasAnyAuthority('USER', 'ADMIN')")
    public String userCompanies(@AuthenticationPrincipal User user, Model model) {
        List<Company> companyList = companyService.findByOwner(user);
        model.addAttribute("companies", companyList);

        return "userCompanies";
    }

    @GetMapping("{company}")
    @PreAuthorize("hasAuthority('USER')")
    public String companyEditForm(@PathVariable Company company, Model model) {
        model.addAttribute("company", company);

        return "companyEditor";
    }

    @PostMapping
    @PreAuthorize("hasAnyAuthority('USER')")
    public String create(@AuthenticationPrincipal User user,
                         @Valid Company company,
                         BindingResult bindingResult, Model model) {

        if (bindingResult.hasErrors()) {
            Map<String, String> errorMap = ControllerUtils.getErrors(bindingResult);
            model.mergeAttributes(errorMap);
        } else if (company.getEarnings() == null) {
            model.addAttribute("earningsError", "You must enter earnings");
            model.addAttribute("company", company);
        } else {
            model.addAttribute("company", null);
            company.setOwner(user);
            companyService.save(company);
        }

        List<Company> companyList = companyService.findByOwner(user);
        model.addAttribute("companies", companyList);
        return "userCompanies";
    }


    @PostMapping("{id}")
    @PreAuthorize("hasAuthority('USER')")
    public String update(@PathVariable("id") Company companyFromDb, Company company,
                         @AuthenticationPrincipal User user, Model model) {

        Company byName = companyService.findByName(company.getParent());

        if (byName == null && !company.getParent().equalsIgnoreCase("none")) {
            model.addAttribute("parentError", "This company isn`t in our system!!!");
            return "companyEditor";
        } else {

            company.setOwner(companyFromDb.getOwner());
            companyService.update(companyFromDb, company);

            List<Company> companyList = companyService.findByOwner(user);
            model.addAttribute("companies", companyList);

            return "redirect:/company/own_companies";
        }
    }

    @GetMapping("delete/{id}")
    @PreAuthorize("hasAnyAuthority('USER')")
    public String delete(@PathVariable("id") Company company) {
        companyService.delete(company);
        return "redirect:/company/own_companies";
    }

}
