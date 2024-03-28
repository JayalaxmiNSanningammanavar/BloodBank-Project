<%@page import="java.util.Vector"%>
<%@page import="com.apps.Logcreation.Log"%>
<%@page import="com.apps.Database.DatabaseFile"%>
<%@page import="java.sql.*"%>

<%
Log objLog  = objLog = new Log(); 
Vector<Object> rsp = null;
Statement st = null;
ResultSet rs = null;
Connection con = null;
int userId = 0;
                                                          
try
{
     //session
     HttpSession hs = request.getSession(true);
       
    //argument
    String username =  hs.getAttribute("x").toString();
        
    //getting values from design page
    String name = request.getParameter("name");
    String address = request.getParameter("address");
    String phoneno = request.getParameter("phoneno");
  
    if( ((name!=null) && (!name.trim().equals(""))) && ((address!=null) && (!address.trim().equals("")))
            && ((phoneno!=null) && (!phoneno.trim().equals(""))))
    {                
        //jdbc connection
        try
        {      
            String sql = "SELECT AdminId "
                    + "FROM admindetails "
                    + "WHERE Username = '"+username+"' ";

            Log.logger.info("sql:"+sql);	  
            
            //CALLING DATABASE Class           
            rsp = DatabaseFile.getInstance().codeselect(sql);

            st = (Statement) rsp.get(0);
            rs = (ResultSet) rsp.get(1);
            con = (Connection) rsp.get(2);

            while(rs.next())
            {
                userId = rs.getInt(1);
                
                Log.logger.info("userId:"+userId);	                                                                  
            }
              
            if(userId > 0)
            {
                
                String sql1 = "INSERT INTO blood_banks( Blood_bank_name, Blood_bank_address, Blood_bank_ph_no, Created_By, Created_Date, Isdeleted)"
                    + " VALUES('"+name+"', '"+address+"', '"+phoneno+"', '"+userId+"', now() , '0')";
            
                DatabaseFile.getInstance().codeinsert(sql1);

               %>
               <jsp:forward page="adminhome.jsp">
                       <jsp:param name="msg" value="108"></jsp:param>               
                   </jsp:forward>
               <%                
            }                                           
        }
        catch(Exception e)
        {
            e.printStackTrace();
            
            Log.logger.error("Error:", e);
            Log.logger.warn("This is a warning message");
            Log.logger.trace("This message will not be logged since log level is set as DEBUG");
        }
        finally
        {
            try
            {
                if(st != null)
                {
                    st.close(); 
                    st = null;
                }
            }
            catch(Exception e)
            {
                e.printStackTrace();
                
                Log.logger.error("Error:", e);
                Log.logger.warn("This is a warning message");
                Log.logger.trace("This message will not be logged since log level is set as DEBUG");
            }
            
            try
            {
                if(rs != null)
                {
                    rs.close(); 
                    rs = null;
                }
            }
            catch(Exception e)
            {
                e.printStackTrace();
                
                Log.logger.error("Error:", e);
                Log.logger.warn("This is a warning message");
                Log.logger.trace("This message will not be logged since log level is set as DEBUG");
            }
            
            try
            {
                if(con != null)
                {
                    DatabaseFile.cp.surrenderConnection(con);
                    
                    con.close();
                    con = null;
                }
            }
            catch(Exception e)
            {
                e.printStackTrace();
                
                Log.logger.error("Error:", e);
                Log.logger.warn("This is a warning message");
                Log.logger.trace("This message will not be logged since log level is set as DEBUG");
            }
            
            rsp = null;
        }
    }
    else
    {
           %>
           <jsp:forward page="adminhome.jsp">
               <jsp:param name="msg" value="102"></jsp:param>
           </jsp:forward>
           <%
    }
    
}
catch(Exception e)
{
    e.printStackTrace();
        
    Log.logger.error("Error:", e);
    Log.logger.warn("This is a warning message");
    Log.logger.trace("This message will not be logged since log level is set as DEBUG");
}
    
%>