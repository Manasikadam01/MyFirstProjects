package com.MainApp.Service;

import java.io.FileOutputStream;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Optional;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.MainApp.Entity.Employee;
import com.MainApp.Repository.EmployeeRepository;

@Service
public class EmployeeService {
	
	@Autowired
	EmployeeRepository eRepo;
	
	public void addEmployee(Employee e, MultipartFile picture)
	{
		String pictureName=picture.getOriginalFilename();
		
		e.setPictureName(pictureName);
		
		if(pictureName.isEmpty())
		{
			Employee e1 = eRepo.findById(e.getId()).get();
			e.setPictureName(e1.getPictureName());
		}
			
		eRepo.save(e);
		
		InputStream is = null;
		FileOutputStream fos=null;
		try
		{
			is = picture.getInputStream();
			byte[] b = is.readAllBytes();
			
			
			String path = "Z:\\adv java 11pm to 2pm 17th march 2025\\spring boot\\EmployeeManagementSystem\\src\\main\\webapp\\images\\"+pictureName;
			fos = new FileOutputStream(path);
			fos.write(b);
		
		}
		catch (Exception ee)
		{
			System.out.println(ee);
		}
		finally {
			try
			{
				is.close();
				fos.close();
			}
			catch (Exception e1) 
			{
				System.out.println(e1);
			}
		}
		
	}
	
	
	
	public List<Employee> readEmployee(String username)
	{
		List<Employee> l = eRepo.findByUsername(username);
		return l;
	}
	
	public void deleteEmployee(int id)
	{
		eRepo.deleteById(id);
	}
	
	
	public List<Employee> readEmployeeByid(int id)
	{
		Optional<Employee> oe = eRepo.findById(id);
		if(oe.isPresent())
		{
			return List.of(oe.get());
		}
		else
		{
			return new ArrayList<Employee>();
		}
	}
	
	
	
	
	
	public Set<String> readDesignation()
	{
		List<Employee> l = eRepo.findAll();
		
		Set<String> designations = new HashSet<>();
		
		for(Employee e: l)
		{
			designations.add(e.getDesignation());
		}
		
		return designations;
	}
	
	
	public List<Employee> readEmployeeByDesignation(String des)
	{
		return eRepo.findByDesignation(des);
	}
	
	
	
 
}
