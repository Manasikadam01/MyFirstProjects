package com.MainApp.Controller;

import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.multipart.MultipartFile;

import com.MainApp.Entity.Employee;
import com.MainApp.Service.EmployeeService;

import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
 
@Controller
@MultipartConfig
public class EmployeeCrud {

	@Autowired
	EmployeeService eService;
	
	@RequestMapping(value = "/home")
	public String showHome(Model model, HttpServletRequest req)
	{
		String username=(String)req.getSession().getAttribute("token");
		
		List<Employee> l = eService.readEmployee(username);
		model.addAttribute("l", l);
		
		Set<String> des = eService.readDesignation();
		model.addAttribute("des", des);
		
		return "home";
	}
	
	@RequestMapping(value = "/add-employee")
	public String handleAddEmployee(
	@ModelAttribute Employee e, @RequestPart("picture") MultipartFile picture
	)
	{
		eService.addEmployee(e, picture);
		return "redirect:/home";
	}
	
	
	
	@RequestMapping(value = "/delete-employee")
	public String handleDeleteEmployee(@RequestParam("id") int id)
	{
		eService.deleteEmployee(id);
		return "redirect:/home";
	}
	
	
	@RequestMapping(value = "/search-employee")
	public String handleSearchEmployee(
	@RequestParam("id") int id, Model model
	)
	{
		List<Employee> l = eService.readEmployeeByid(id);
		model.addAttribute("l", l);
		
		Set<String> des = eService.readDesignation();
		model.addAttribute("des", des);
		
		return "home";
	}
	
	
	@RequestMapping(value = "/remove-filter")
	public String handleRemoveFilter()
	{
		return "redirect:/home";
	}
	
	
	@RequestMapping(value = "get-employee")
	public String handleGetEmployee(@RequestParam("id") int id, HttpServletRequest req)
	{
		List<Employee> l = eService.readEmployeeByid(id);
		Employee e = l.get(0);
		
		HttpSession s = req.getSession();
		s.setAttribute("e", e);
		
		return "redirect:/home";
	}
	
	
	@RequestMapping(value = "/filter")
	public String handleFileter(@RequestParam("des") String desig, Model model)
	{
		List<Employee> l = eService.readEmployeeByDesignation(desig);
		model.addAttribute("l", l);
		
		Set<String> des = eService.readDesignation();
		model.addAttribute("des", des);
		return "home";
	}
	
	
	
	
	
	
	
	
}
