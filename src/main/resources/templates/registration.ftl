<#import "parts/common.ftl" as c>
<#import "parts/login.ftl" as l>

<@c.page>
<h5 class="mb-3">Add new user</h5>
    <#if message??>
        <div class="alert alert-danger" style="text-align: center" role="alert">
            ${message?ifExists}
        </div>
    </#if>

    <@l.login "/registration" true/>
</@c.page>