package com.example;

import java.io.BufferedReader;
import java.io.InputStreamReader;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@SpringBootApplication
@RestController
public class DemoApplication {

	public static void main(String[] args) {
		SpringApplication.run(DemoApplication.class, args);
	}

	@RequestMapping("/fortran")
	public String procCall(@RequestParam(value="name", defaultValue="hello_world") String name) throws Exception {
	  return runExec(name);
	}

  private String runExec(String name) throws Exception {

		String program = "/source/";

		//Process proc = new ProcessBuilder("echo", "hello").start();
		Process proc = new ProcessBuilder(program+name, "hello").start();

		BufferedReader stdInput = new BufferedReader(new
		     InputStreamReader(proc.getInputStream()));

		BufferedReader stdError = new BufferedReader(new
		     InputStreamReader(proc.getErrorStream()));

		StringBuffer exeOut = new StringBuffer();

		// read the output from the command
		System.out.println("Here is the standard output of the command:\n");
		String s = null;
		while ((s = stdInput.readLine()) != null) {
		    System.out.println(s);
				exeOut.append(s);
		}

		// read any errors from the attempted command
		System.out.println("Here is the standard error of the command (if any):\n");
		while ((s = stdError.readLine()) != null) {
		    System.out.println(s);
		}
		return exeOut.toString();
	}

}
