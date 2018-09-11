<#import "parts/common.ftl" as c>

<@c.page>
<h5 class="mb-3">User editor</h5>

<form action="/user" method="post">
    <div class="form-group row">
        <label class="col-sm-2 col-form-label">User name:</label>
        <div class="col-sm-5">
            <input type="text" name="userName" class="form-control" value="${user.username}">
        </div>
    </div>
    <div class="form-group row">
        <label class="col-sm-2 col-form-label">User status:</label>
        <div class="col-sm-5">
            <select name="active" class="custom-select">
                <option  value="<#if user.active=true>true<#else>false</#if>" selected hidden>
                    <#if user.active=true>Active<#else>Bahn</#if>
                </option>
                <option value="true">Active</option>
                <option value="false">Bahn</option>
            </select>
        </div>
    </div>
    <div class="form-group row">
        <label class="col-sm-2 col-form-label">User roles:</label>
        <div class="col-sm-5">
           <#list roles as role>
               <div>
                   <label><input type="checkbox" name="${role}" ${user.roles?seq_contains(role)?string("checked", "")}>${role}</label>
               </div>
           </#list>
        </div>
    </div>

    <input type="hidden" value="${user.id}" name="userId">
    <input type="hidden" value="${_csrf.token}" name="_csrf">
    <button class="btn btn-info" type="submit">Save</button>
</form>
</@c.page>