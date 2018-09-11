package com.company.structure.dao;

import com.company.structure.model.Company;
import com.company.structure.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CompanyRepository extends JpaRepository<Company,Long> {

    Company findByCompanyName(String companyName);

    List<Company> findByOwner(User user);

    List<Company> findAllByParent(String parentName);

}
