<#import "parts/common.ftl" as c>


<@c.page>
<h5 class="ml-5"><#if user??>${user.getUsername()}<#else>${username}</#if></h5>
    ${message?ifExists}
<form method="post" class="ml-5">
    <div class="form-group row">
        <label class="col-sm-2 col-form-label">Password:</label>
        <div class="col-sm-5">
            <input type="password" name="password" class="form-control ${(passwordError??)?string('is-invalid', '')}"
                   placeholder="Password"/>
            <#if passwordError??>
                <div class="invalid-feedback">
                    ${passwordError}
                </div>
            </#if>
        </div>
    </div>
    <div class="form-group row">
        <label class="col-sm-2 col-form-label">Confirm Password:</label>
        <div class="col-sm-5">
            <input type="password" name="passwordConfirmation"
                   class="form-control ${(passwordConfirmationError??)?string('is-invalid', '')}"
                   placeholder="Retype password"/>
                <#if passwordConfirmationError??>
                    <div class="invalid-feedback">
                        ${passwordConfirmationError}
                    </div>
                </#if>
        </div>
    </div>
    <div class="form-group row">
        <label class="col-sm-2 col-form-label">Email:</label>
        <div class="col-sm-5">
            <input type="email" name="email" value="<#if newEmail??>${newEmail}<#else>${email!''}</#if>"
                   class="form-control" placeholder="email@email.com"/>
        </div>
    </div>

    <input type="hidden" name="_csrf" value="${_csrf.token}"/>
    <button class="btn btn-info" type="submit">Save</button>
</form>
</@c.page>