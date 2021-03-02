package servlet;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import dao.StaffDAO;
import model.Staff;

@WebServlet("/staff/*")
public class StaffServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public StaffServlet() {
        super();
        
    }
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request,response);
    }
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("application/json");
		response.setCharacterEncoding("utf-8");
		
		String url = request.getRequestURL().toString();
		if (url.endsWith("login")) {
			login(request, response);
		} else {
			logout(request, response);
		}
	}
	private void logout(HttpServletRequest request, HttpServletResponse response) throws IOException {		
		HttpSession session = request.getSession();
		session.removeAttribute("user");
		response.sendRedirect(request.getContextPath()+ "/admin/home.jsp");		
	}
	private void login(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		StaffDAO staffDAO = new StaffDAO();	
		Staff staff = null;
		try {
			staff = staffDAO.login(username, password);
			String staffJson = new Gson().toJson(staff);
			response.getWriter().print(staffJson);
			HttpSession session = request.getSession();
			
			// login success
			if (staff != null && staff.getId() > 0) {
				session.setAttribute("user", staff);
			}					
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		
	}

}
