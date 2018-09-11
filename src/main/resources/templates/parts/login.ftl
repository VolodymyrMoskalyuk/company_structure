<#include "security.ftl">
<#macro login path isRegisterForm>
    <form action="${path}" method="post">
        <div class="form-group row">
            <label class="<#if !isRegisterForm>col-sm-2<#else>col-sm-3</#if> col-form-label">User Name:</label>
            <div class="col-sm-6">
                <input type="text" name="username" value="<#if user??>${user.username}</#if>"
                       class="form-control ${(userNameError??)?string('is-invalid', '')}"
                       placeholder="User name"/>
            <#if userNameError??>
                <div class="invalid-feedback">
                    ${userNameError}
                </div>
            </#if>
            </div>
        </div>
          <#if isRegisterForm>
            <div class="form-group row">
                <label class="col-sm-3 col-form-label">Email:</label>
                <div class="col-sm-6">
                    <input type="email" name="email" value="<#if user??>${user.email}</#if>"
                           class="form-control ${(emailError??)?string('is-invalid', '')}"
                           placeholder="email@email.com"/>
             <#if emailError??>
                    <div class="invalid-feedback">
                        ${emailError}
                    </div>
             </#if>
                </div>
            </div>
          </#if>
        <div class="form-group row">
            <label class="<#if !isRegisterForm>col-sm-2<#else>col-sm-3</#if> col-form-label">Password:</label>
            <div class="col-sm-6">
                <input type="password" name="password" class="form-control ${(passwordError??)?string('is-invalid', '')}"
                       placeholder="Password"/>
            <#if passwordError??>
                <div class="invalid-feedback">
                    ${passwordError}
                </div>
            </#if>
            </div>
        </div>
        <#if isRegisterForm>
            <div class="form-group row">
                <label class="col-sm-3 col-form-label">Password confirmation:</label>
                <div class="col-sm-6">
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
        </#if>
        <input type="hidden" name="_csrf" value="${_csrf.token}"/>
        <#if !isRegisterForm><a href="/registration" class="info">Add new user</a></#if>
        <button class="btn btn-info" type="submit">
        <#if isRegisterForm>Create<#else>Sign In </#if>
        </button>
    </form>
</#macro>

<#macro logout>
<form action="/logout" method="post">
    <input type="hidden" name="_csrf" value="${_csrf.token}"/>
    <button class="btn btn-info" type="submit"><#if currentUserId=-1>Log in<#else>Sign Out</#if></button>
</form>
</#macro>