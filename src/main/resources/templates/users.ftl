<#import "parts/common.ftl" as c>

<@c.page>


<a class="btn btn-info" data-toggle="collapse" href="#collapseSearch" role="button" aria-expanded="false"
   aria-controls="collapseAdd">
    Search User
</a>

<div class="collapse <#if filter!="">show</#if>" id="collapseSearch">
    <div class="form-group mt-3 ">
        <div class="form-row">
            <div class="form-group">
                <form method="get" action="/user" class="form-inline" style="width: 22em">
                    <input type="text" name="filter" value="${filter?ifExists}"
                           class="form-control ml-1 col-sm-6 ${(filterError??)?string('is-invalid', '')}"
                           placeholder="Search by user name">
                    <button type="submit" class="btn btn-info ml-2">Search</button>
                    <#if filterError??>
                    <div class="invalid-feedback ml-1">
                        ${filterError}
                    </div>
                    </#if>
                </form>
            </div>
        </div>
    </div>
</div>

<h5 class="mt-3 mb-3">List of users:</h5>

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