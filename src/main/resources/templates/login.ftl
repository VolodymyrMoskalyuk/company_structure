<#import "parts/common.ftl" as c>
<#import "parts/login.ftl" as l>

<@c.page>
<h5 class="mb-3">Login page</h5>
    <#if Session?? && Session.SPRING_SECURITY_LAST_EXCEPTION??>
    <div class="alert alert-danger" role="alert" style="text-align: center">
        ${Session.SPRING_SECURITY_LAST_EXCEPTION.message}
    </div>
    </#if>
    <@l.login "/login" false/>
</@c.page>