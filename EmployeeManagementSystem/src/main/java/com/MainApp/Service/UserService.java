package com.MainApp.Service;

import java.util.Optional;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import com.MainApp.Entity.User;
import com.MainApp.Repository.UserRepository;

import jakarta.mail.internet.MimeMessage;

@Service
public class UserService {

	
	@Autowired
	UserRepository uRepo;

    
	public String addUser(User u)
	{
		Optional<User> ou = uRepo.findById(u.getUsername());
		if(ou.isPresent())
		{
			return "UserName Already Exists..";
		}
		else
		{
			String code= UUID.randomUUID().toString();
			
			u.setEnable(false);
			u.setVerificationCode(code);
			
			uRepo.save(u);
			sendMail(u);
			return "SignUp Successfully..";
		}
		
	}

	@Autowired
	private JavaMailSender mailSender;
	
	public void sendMail(User u)
	{
		String from = "seedvimannagar@app.seedinfotech.com";
		String to = u.getEmail();
		String subject = "Account Verification";
		
		String content="Dear [[name]], <br>"
				+ "Please click the link given below to verify your Account"
				+ "<h1>"
				+ "<a href=\"[[url]]\" self=\"_blank\">VERIFY</a>"
				+ "</h1>"
				+ "Thank you...";
		
		content=content.replace("[[name]]", u.getUsername());
		String url="http://localhost:8081/verify?code="+u.getVerificationCode();
		content=content.replace("[[url]]", url);
		
		
		try
		{
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper helper = new MimeMessageHelper(message);
			
			helper.setFrom(from);
			helper.setTo(to);
			helper.setSubject(subject);
			helper.setText(content, true);
			
			mailSender.send(message);
			
		}
		catch (Exception e) 
		{
			System.out.println(e);
		}
		
	}
	
	
	
	
	public String  verify(String code)
	{
		User u = uRepo.findByVerificationCode(code);
		
		if(u != null)
		{
			u.setEnable(true);
			u.setVerificationCode(null);
			
			uRepo.save(u);
			return "Account verified Successfully, try login";
		}
		else
		{
			return "Your Account is already verified, Or Something went wrong";
		}
	}
	
	
	String res = "";
	public String checkUser(String username, String password)
	{
		User u = uRepo.findByUsernameAndPassword(username, password);
		
		if(u != null)
		{
			res = "exists";
			
			if(u.isEnable() == false)
			{
				res= "Your Account InActive, please Activate Your Account";
			}
		}
		else
		{
			res = "Invalid Credential";
		}
		return res;
	}
	
	
	
	
	
	
	
	
}
