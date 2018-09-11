<#include "security.ftl">
<#import "login.ftl" as l>

<nav class="navbar navbar-expand-lg navbar-light" style="background-color: #49bda2; ">
    <a class="navbar-brand mb-0 h1" href="/" style="font-size: 1.7em">Company Structure</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
            aria-controls="navbarSupportedContent" aria-expanded="true" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarSupportedContent" style="font-size: 1.2em">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item">
                <a class="nav-link" href="/">Home</a>
            </li>
            <#if isAdmin>
            <li class="nav-item">
                <a class="nav-link" href="/company">Company list</a>
            </li>
            </#if>
            <#if isAdmin>
            <li class="nav-item">
                <a class="nav-link" href="/user">User list</a>
            </li>
            </#if>
            <#if user??&&currentUserId!=-1>
            <li class="nav-item">
                <a class="nav-link" href="/user/profile">Profile</a>
            </li>
            </#if>
            <#if user??&&isAdmin=false&&currentUserId!=-1>
            <li class="nav-item">
                <a class="nav-link" href="/company/own_companies">My companies</a>
            </li>
            </#if>
            <li class="nav-item">
                <a class="nav-link" href="/contacts">Contacts</a>
            </li>
        </ul>
        <div class="navbar-text mr-3"><a href="/user/profile" style="text-decoration: none">${name}</a></div>
        <@l.logout/>
    </div>
</nav>