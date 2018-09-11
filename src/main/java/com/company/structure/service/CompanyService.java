package com.company.structure.service;

import com.company.structure.model.Company;
import com.company.structure.model.User;

import java.util.List;


public interface CompanyService {

    List<Company> listOfCompanies();

    Company findByName(String companyName);

    List<Company> findByOwner(User user);

    Company save(Company company);

    Company update(Company companyFromDB, Company company);

    void delete(Company company);
}
