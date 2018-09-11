<#import "parts/common.ftl" as c>

<@c.page>

<h5 class="mb-3">List of users:</h5>

<table class="table table-bordered table-striped " style="text-align: center;">
<thead style="background-color: #a8a8a8">
    <tr>
        <th>Id</th>
        <th>Name</th>
        <th>Role</th>
        <th>Status</th>
        <th>Action</th>
    </tr>
    </thead>
    <tbody>
        <#list users as user>
        <tr>
            <td>${user.id}</td>
            <td>${user.username}</td>
            <td><#list user.roles as role>${role}<#sep>, </#list></td>
            <td><#if user.active=true>Active<#else>Bahn</#if></td>
            <td><a href="/user/${user.id}" style="color: green">Edit</a>
                <a href="/user/delete/${user.id}" class="ml-2" style="color: red">Delete</a></td>
        </tr>
        </#list>
    </tbody>
</table>
</@c.page>