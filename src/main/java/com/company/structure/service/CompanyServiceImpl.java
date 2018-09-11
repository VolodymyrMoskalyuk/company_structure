package com.company.structure.service;

import com.company.structure.dao.CompanyRepository;
import com.company.structure.model.Company;
import com.company.structure.model.User;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CompanyServiceImpl implements CompanyService {

    @Autowired
    private CompanyRepository companyRepository;

    @Override
    public List<Company> listOfCompanies() {
        return companyRepository.findAll();
    }

    @Override
    public Company findByName(String companyName) {
        return companyRepository.findByCompanyName(companyName);
    }

    @Override
    public List<Company> findByOwner(User user) {
        return companyRepository.findByOwner(user);
    }

    @Override
    public Company save(Company company) {
        if (company.getParent().equals("")) {
            company.setParent("none");
        }
        company.setChildEarnings(Long.valueOf(0));
        company.setTotalAmount(company.getChildEarnings() + company.getEarnings());
        companyRepository.save(company);
        setParentTotalAmount(company);
        return company;
    }

    @Override
    public Company update(Company companyFromDB, Company company) {

        if (!company.getParent().equalsIgnoreCase(companyFromDB.getParent()) &&
                !companyFromDB.getParent().equalsIgnoreCase("none")) {
            setParentTotalAmount(changeChildAmount(companyFromDB));
        }
//        for (Company child : companyRepository.findAllByParent(company.getCompanyName())) {
//            child.setParent("none");
//        }

        company.setTotalAmount(company.getChildEarnings() + company.getEarnings());
        BeanUtils.copyProperties(company, companyFromDB, "id");
        companyRepository.save(companyFromDB);
        setParentTotalAmount(companyFromDB);

        return companyFromDB;
    }

    @Override
    public void delete(Company company) {
        for (Company child : companyRepository.findAllByParent(company.getCompanyName())) {
            child.setParent("none");
        }
        if (!company.getParent().equalsIgnoreCase("none")) {
            Company parentCompany = changeChildAmount(company);
            setParentTotalAmount(parentCompany);
        }
        companyRepository.delete(company);

    }

    private Company changeChildAmount(Company company) {
        Company parentCompany = companyRepository.findByCompanyName(company.getParent());
        parentCompany.setChildEarnings(parentCompany.getChildEarnings() - company.getTotalAmount());
        parentCompany.setTotalAmount(parentCompany.getChildEarnings() + parentCompany.getEarnings());
        return parentCompany;
    }


    private void setParentTotalAmount(Company company) {
        while (!company.getParent().equalsIgnoreCase("none")) {

            Company nextParentCompany = companyRepository.findByCompanyName(company.getParent());
            setChildAmount(company, nextParentCompany);
            nextParentCompany.setTotalAmount(nextParentCompany.getChildEarnings() + nextParentCompany.getEarnings());
            companyRepository.save(nextParentCompany);

            company = nextParentCompany;

            if (company.getParent().equalsIgnoreCase("none")) break;
        }
    }

    private void setChildAmount(Company company, Company parentCompany) {

        if ((parentCompany.getChildEarnings() < company.getTotalAmount()) || (parentCompany.getChildEarnings() > company.getTotalAmount())) {
            parentCompany.setChildEarnings(getAmount(company.getParent()));
        } else {
            parentCompany.setChildEarnings(parentCompany.getChildEarnings());
        }
    }

    private Long getAmount(String parentName) {
        Long amount = 0L;
        List<Company> companyList = companyRepository.findAllByParent(parentName);
        for (Company company : companyList) {
            amount = amount + company.getTotalAmount();
        }
        return amount;
    }
}
