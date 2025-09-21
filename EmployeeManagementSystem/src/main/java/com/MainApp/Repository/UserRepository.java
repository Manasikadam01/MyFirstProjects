package com.MainApp.Repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.MainApp.Entity.User;

@Repository
public interface UserRepository extends JpaRepository<User, String>{
	
	User findByVerificationCode(String code);
	
	User findByUsernameAndPassword(String username, String password);

}
