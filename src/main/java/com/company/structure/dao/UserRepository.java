package com.company.structure.dao;

import com.company.structure.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRepository extends JpaRepository<User,Long> {

    User findByUserName(String userName);

    User findByEmail(String email);
}
