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

import dao.PartDAO;
import model.Part;

@WebServlet("/part/*")
public class PartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    private PartDAO partDAO;
    public PartServlet() {
        super();
        partDAO = new PartDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		String url = request.getRequestURL().toString();		
		String query = request.getQueryString();
		if (url.endsWith("get")) {			
			if (query == null || query.isEmpty()) {
				getAllPart(request, response);
			}
			else if (query.contains("id")) {
				getPartById(request, response);
			} else if (query.contains("name")){				
				getPartByName(request, response);
			}
		} else if (url.endsWith("insert")) {
			insertPart(request, response);
		}
		
	}

	private void getAllPart(HttpServletRequest request, HttpServletResponse response) throws IOException {
		List<Part> listPart = null;
		try {
			listPart = partDAO.getAll();			
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		String result = new Gson().toJson(listPart);
		response.getWriter().print(result);
		
	}

	private void insertPart(HttpServletRequest request, HttpServletResponse response) {
		
	}

	private void getPartByName(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String name = request.getParameter("name");
		List<Part> parts = null;
		try {
			parts = partDAO.getPartByName(name);			
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		String result = new Gson().toJson(parts);
		response.getWriter().print(result);
	}

	private void getPartById(HttpServletRequest request, HttpServletResponse response) throws IOException {
		int id = Integer.parseInt(request.getParameter("id"));
		Part part = null;
		try {
			part = partDAO.get(id);			
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		String result = new Gson().toJson(part);
		response.getWriter().print(result);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}


}
