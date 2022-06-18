package com.ine.cartografia.GeneraMapa;

import java.io.BufferedReader;
import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.RequestDispatcher;
//import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

@WebServlet(value = "/dce/GenerarMapa")
public class MapaServlet extends HttpServlet {

	public static Logger logger = Logger.getLogger(MapaServlet.class);
	/**
	 * 
	 */
	private static final long serialVersionUID = 7651002631108954297L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		logger.info("doGet(" + request.toString() + ", " + response.toString() + ")");
		Enumeration<String> parameterNames = request.getParameterNames();

		String json=null;
		
		while (parameterNames.hasMoreElements()) {

			String line = parameterNames.nextElement();
			if(line.equalsIgnoreCase("json")) {
				String[] paramValues = request.getParameterValues(line);
				line += " [";
				for (int i = 0; i < paramValues.length; i++) {
					if (i != paramValues.length - 1) {
						line += paramValues[i] + ",";
						json = paramValues[i];
					}
					else {
						line += paramValues[i];
						json = paramValues[i];
					}
				}
				logger.info(line + "]");
				line += " [";
			}else {
				String[] paramValues = request.getParameterValues(line);
				line += " [";
				for (int i = 0; i < paramValues.length; i++) {
					if (i != paramValues.length - 1)
						line += paramValues[i] + ",";
					else 
						line += paramValues[i];
				}
				logger.info(line + "]");
				line += " [";
			}
		}
		
		logger.info("Json: [" + json + "]");
		
		request.getSession().setAttribute("json", json);
			
		logger.info("-------------------------------------------------------");
//		response.setContentType("text/html");
//		PrintWriter out = response.getWriter();
//		out.print("<html><body>");
//		out.print("<h3>Hello Servlet</h3>");
//		out.print("</body></html>");
		String nextJSP = "/map.jsp";
		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(nextJSP);
		dispatcher.forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		logger.info("doPost(" + request.toString() + ", " + response.toString() + ")");
		Enumeration<String> parameterNames = request.getParameterNames();

		String json=null;
		
		while (parameterNames.hasMoreElements()) {

			String line = parameterNames.nextElement();
			if(line.equalsIgnoreCase("json")) {
				String[] paramValues = request.getParameterValues(line);
				line += " [";
				for (int i = 0; i < paramValues.length; i++) {
					if (i != paramValues.length - 1) {
						line += paramValues[i] + ",";
						json = paramValues[i];
					}
					else {
						line += paramValues[i];
						json = paramValues[i];
					}
				}
				logger.info(line + "]");
				line += " [";
			}else {
				String[] paramValues = request.getParameterValues(line);
				line += " [";
				for (int i = 0; i < paramValues.length; i++) {
					if (i != paramValues.length - 1)
						line += paramValues[i] + ",";
					else 
						line += paramValues[i];
				}
				logger.info(line + "]");
				line += " [";
			}
			
		}
		
//		response.setContentType("text/html");
//		PrintWriter out = response.getWriter();
//		out.print("<html><body>");
//		out.print("<h3>Hello Servlet</h3>");
//		out.print("</body></html>");

		StringBuffer jb = new StringBuffer();
		String line = null;
		try {
			BufferedReader reader = request.getReader();
			while ((line = reader.readLine()) != null)
				jb.append(line);
		} catch (Exception e) {
			/* report an error */ }
		
		if(jb.toString().isEmpty()&&json!=null) {
			logger.info("Json: [" + json + "]");
			request.getSession().setAttribute("json", json);
		}else {
			logger.info("Json: [" + jb.toString() + "]");
			request.getSession().setAttribute("json", jb.toString());
		}
		
		
		logger.info("-------------------------------------------------------");
		
		String nextJSP = "/map.jsp";
		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(nextJSP);
		dispatcher.forward(request, response);

	}

}
