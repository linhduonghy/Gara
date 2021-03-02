package servlet;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import dao.ServiceDAO;
import model.Service;

@WebServlet("/service/*")
public class ServiceServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	private ServiceDAO serviceDAO;
	
    public ServiceServlet() {
        super();       
        serviceDAO = new ServiceDAO();
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		String url = request.getRequestURL().toString();		
		String query = request.getQueryString();
		if (url.endsWith("get")) {			
			if (query == null || query.isEmpty()) {
				getAllService(request, response);
			}
			else if (query.contains("id")) {
				getServiceById(request, response);
			} else if (query.contains("name")){				
				getServiceByName(request, response);
			}
		} else if (url.endsWith("insert")) {
			insertService(request, response);
		}
		
	}

	private void getAllService(HttpServletRequest request, HttpServletResponse response) throws IOException {
		List<Service> listService = null;
		try {
			listService = serviceDAO.getAll();			
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		String result = new Gson().toJson(listService);
		response.getWriter().print(result);
		
	}


	private void insertService(HttpServletRequest request, HttpServletResponse response) {
		
	}


	private void getServiceByName(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String name = request.getParameter("name");
		List<Service> services = null;
		try {
			services = serviceDAO.getServiceByName(name);			
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		String result = new Gson().toJson(services);
		response.getWriter().print(result);
	}


	private void getServiceById(HttpServletRequest request, HttpServletResponse response) throws IOException {
		int id = Integer.parseInt(request.getParameter("id"));
		Service service = null;
		try {
			service = serviceDAO.get(id);			
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		String result = new Gson().toJson(service);
		response.getWriter().print(result);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}

}
