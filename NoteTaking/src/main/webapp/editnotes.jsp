<%@ page import="com.cyber.notetaking.Model.User" %>
<%@ page import="com.cyber.notetaking.Model.Notes" %>
<%@ page import="com.cyber.notetaking.Notes.AddNotes" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Edit Notes</title>
    <link rel="stylesheet" href="fontawesome/css/all.min.css">
    <link rel="stylesheet" href="css/notes.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
</head>
<body>
<%
    User user = (User) request.getSession().getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    Integer noteid = Integer.parseInt(request.getParameter("noteid"));
    AddNotes an = new AddNotes();
    Notes notes = an.getNote(noteid); // Adjusted to handle possible null value
%>
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
            <form class="form-inline my-2 my-lg-0">
                <a class="btn btn-light my-2 my-sm-0 mr-2" href="logout"><i class="fa-solid fa-circle-left"></i> Logout</a>
                <a class="btn btn-light my-2 my-sm-0" data-bs-toggle="modal" data-bs-target="#staticBackdrop"><i class="fa-solid fa-user"></i> <%= session.getAttribute("fname") %></a>
            </form>
        </div>
    </div>
</nav>

<div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="staticBackdropLabel">Profiles</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <table class="table">
                    <tbody>
                    <tr>
                        <th>User Name</th>
                        <td><%= session.getAttribute("fname") %> <%= session.getAttribute("lname") %></td>
                    </tr>
                    <tr>
                        <th>Email</th>
                        <td><%= session.getAttribute("email") %></td>
                    </tr>
                    <tr>
                        <th>Phone</th>
                        <td><%= session.getAttribute("phone") %></td>
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

<form action="update_note" method="post"> <!-- Adjusted form action -->
    <h1 class="text-center">Edit Your Notes</h1>
    <input type="hidden" name="noteid" value="<%= noteid %>">
    <div class="form-group">
        <label for="noteTitle" class="form-label">Notes Title</label>
        <input type="text" class="form-control" id="noteTitle" name="title" placeholder="Title" value="<%= notes != null ? notes.getTitle() : "" %>" required>
    </div>
    <div class="form-group">
        <label for="noteContent" class="form-label">Enter Content</label>
        <textarea class="form-control" id="noteContent" name="content" rows="10" required><%= notes != null ? notes.getContent() : "" %></textarea>
    </div>
    <div class="container text-center">
        <button type="submit" class="btn btn-primary">Update Notes</button>
    </div>
</form>

<%
    String status = request.getParameter("status");
%>
<script type="text/javascript">
    var status = "<%= status != null ? status : "" %>";
    if (status === "failed") {
        swal("Error", "Notes not updated due to an error", "error");
    } else if (status === "success") {
        swal("Success", "Notes updated successfully", "success");
    }
</script>
</body>
</html>
