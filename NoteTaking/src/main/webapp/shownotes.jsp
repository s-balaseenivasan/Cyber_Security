<%@ page import="jakarta.mail.Session" %>
<%@ page import="com.cyber.notetaking.Model.User" %>
<%@ page import="com.cyber.notetaking.Notes.AddNotes" %>
<%@ page import="java.util.List" %>
<%@ page import="com.cyber.notetaking.Model.Notes" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    User user = (User) request.getSession().getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return; // Ensure no further code is executed
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Show Notes</title>
    <link rel="stylesheet" href="fontawesome/css/all.min.css">
    <link rel="stylesheet" href="css/notes.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</head>
<body>
<nav class="navbar navbar-expand-lg bg-custom nav-custom">
    <div class="container-fluid">
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link" aria-current="page" href="index.jsp"><i class="fa-solid fa-house"></i> Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="addnotes.jsp"><i class="fa-solid fa-plus"></i> Add Note</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="shownotes.jsp"><i class="fa-solid fa-address-book"></i> Show Note</a>
                </li>
            </ul>
            <form class="d-flex">
                <a class="btn btn-light me-2" href="logout"><i class="fa-solid fa-circle-left"></i> Logout</a>
                <a class="btn btn-light" data-bs-toggle="modal" data-bs-target="#profileModal"><i class="fa-solid fa-user"></i> <%=session.getAttribute("fname")%></a>
            </form>
        </div>
    </div>
</nav>

<div class="modal fade" id="profileModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="profileModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="profileModalLabel">Profile</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <table class="table">
                    <tbody>
                    <tr>
                        <th>User Name</th>
                        <td><%=session.getAttribute("fname")%> <%=session.getAttribute("lname")%></td>
                    </tr>
                    <tr>
                        <th>Email</th>
                        <td><%=session.getAttribute("email")%></td>
                    </tr>
                    <tr>
                        <th>Phone</th>
                        <td><%=session.getAttribute("phone")%></td>
                    </tr>
                    </tbody>
                </table>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
<%
    String updateMessage = (String) session.getAttribute("UMsg");
    String errorMessage = (String) session.getAttribute("EMsg");
    session.removeAttribute("UMsg");
    session.removeAttribute("EMsg");
%>
<% if (updateMessage != null) { %>
<div class="alert alert-success" role="alert">
    <%= updateMessage %>
</div>
<% } %>
<% if (errorMessage != null) { %>
<div class="alert alert-danger" role="alert">
    <%= errorMessage %>
</div>
<% } %>


<%
    String umsg = (String) session.getAttribute("UMsg");
    if (umsg != null) {
%>
<div class="alert alert-success" role="alert"><%= umsg %></div>
<%
        session.removeAttribute("UMsg");
    }
    String emsg = (String) session.getAttribute("EMsg");
    if (emsg != null) {
%>
<div class="alert alert-danger" role="alert"><%=emsg%></div>
<%
        session.removeAttribute("EMsg");
    }
%>

<div class="container mt-4">
    <h2 class="text-center">All Notes</h2>
    <div class="row">
        <div class="col-md-12">
            <%
                AddNotes an = new AddNotes();
                List<Notes> notes = an.getData(user.getId());
                if (notes != null && !notes.isEmpty()) {
                    for (Notes n : notes) {
            %>
            <div class="card mt-3">
                <img src="images/notes.png" class="card-img-top mt-2 mx-auto" style="max-width:100px;">
                <div class="card-body p-4">
                    <h5 class="card-title">Title: <%= n.getTitle() %></h5>
                    <p>
                        <b class="text-success">Published By:</b><br>
                        <b class="text-primary"><%= user.getFname() %></b>
                    </p>
                    <p>
                        <b class="text-success">Published Date:</b><br>
                        <b class="text-primary"><%= n.getTimestamp() %></b>
                    </p>
                    <div class="d-flex justify-content-center mt-2">
                        <a href="#" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#noteModal<%=n.getId()%>">Open</a>
                        <a href="delete?noteid=<%=n.getId()%>" class="btn btn-danger ms-2">Delete</a>
                        <a href="editnotes.jsp?noteid=<%=n.getId()%>" class="btn btn-primary ms-2">Edit</a>
                        <%
                            session.setAttribute("notes",n);
                        %>
                    </div>
                </div>
            </div>

            <div class="modal fade" id="noteModal<%=n.getId()%>" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="noteModalLabel<%=n.getId()%>" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="noteModalLabel<%=n.getId()%>"><%=n.getTitle()%></h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <p><%=n.getContent()%></p>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>
            <%
                }
            } else {
            %>
            <p class="text-center">No notes available.</p>
            <%
                }
            %>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>
