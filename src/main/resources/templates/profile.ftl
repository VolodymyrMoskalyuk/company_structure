<#import "parts/common.ftl" as c>


<@c.page>
<h5 class="ml-5">${username}</h5>
    ${message?ifExists}
<form method="post" class="ml-5">
    <div class="form-group row">
        <label class="col-sm-2 col-form-label">Password:</label>
        <div class="col-sm-5">
            <input type="password" name="password" class="form-control" placeholder="Password" />
        </div>
    </div>
    <div class="form-group row">
        <label class="col-sm-2 col-form-label">Confirm Password:</label>
        <div class="col-sm-5">
            <input type="password" name="confPassword" class="form-control" placeholder="Confirm Password" />
        </div>
    </div>
    <div class="form-group row">
        <label class="col-sm-2 col-form-label">Email:</label>
        <div class="col-sm-5">
            <input type="email" name="email" class="form-control" placeholder="some@some.com" value="${email!''}" />
        </div>
    </div>
    <input type="hidden" name="_csrf" value="${_csrf.token}" />
    <button class="btn btn-info" type="submit">Save</button>
</form>
</@c.page>