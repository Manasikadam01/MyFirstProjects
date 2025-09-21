

package com.MainApp.Controller;

import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.MainApp.Entity.Employee;
import com.MainApp.Entity.User;
import com.MainApp.Service.EmployeeService;
import com.MainApp.Service.UserService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class UserSignUpLoginLogout {
	
	@Autowired
	UserService uService;
	
	@Autowired
	EmployeeService eService;
	
	@RequestMapping(value = "/signup")
	public String showSignUp()
	{
		return "signup";
	}
	
	
	@RequestMapping(value = "/user-signup")
	public String handleUserSignup(
	@ModelAttribute User u, HttpServletRequest req
	)
	{
		String res = uService.addUser(u);
		
		HttpSession s = req.getSession();
		s.setAttribute("msg", res);
		
		return "redirect:/signup";
	}
	
	
	@RequestMapping(value = "/verify")
	public String handleVerify(
	@Param("code") String code,
	HttpServletRequest req
	)
	{
		String res = uService.verify(code);
		HttpSession s = req.getSession();
		
		s.setAttribute("msg", res);
		
		return "verification";
	}
	
	
	
	@RequestMapping(value = "/signin")
	public String showSignin()
	{
		return "signin";
	}
	
	
	@RequestMapping(value = "/user-signin")
	public String handleUserSignin(
	@RequestParam("username") String username, @RequestParam("password") String password,
	HttpServletRequest req, Model model
	)
	{
		String res = uService.checkUser(username, password);
		HttpSession s = req.getSession();
		
		s.setAttribute("msg", res);
		
		if(res.equals("exists"))
		{
			List<Employee> l = eService.readEmployee(username);
			model.addAttribute("l", l);
			
			Set<String> des = eService.readDesignation();
			model.addAttribute("des", des);
			
			
			s.setAttribute("token", username);
			return "home";
		}
		else
		{
			return "redirect:/signin";
		}
	}
	
	@RequestMapping(value = "/user-signout")
	public String handleUserSignout(
	HttpServletRequest req
	)
	{
		HttpSession s = req.getSession();
		s.removeAttribute("token");
		
		s.setAttribute("msg", "You Have SignOut Successfully..");
		return "redirect:/signin";
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

}
