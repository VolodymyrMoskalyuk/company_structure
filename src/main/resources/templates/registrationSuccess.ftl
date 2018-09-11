<#import "parts/common.ftl" as c>
<#import "parts/login.ftl" as l>

<@c.page>
    <#if success??>
        <div class="alert alert-success" role="alert" style="text-align: center; font-size: 2em; margin-top: 12em;">
             <a href="\login">${success?ifExists}</a>
        </div>
    </#if>
</@c.page>