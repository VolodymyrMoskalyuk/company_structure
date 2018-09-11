<#import "parts/common.ftl" as c>

<@c.page>

<a class="btn btn-info" data-toggle="collapse" href="#collapseAdd" role="button" aria-expanded="false"
   aria-controls="collapseAdd">
    Search Company
</a>

<div class="collapse" id="collapseAdd">
    <div class="form-group mt-3 ">
        <div class="form-row">
            <div class="form-group">
                <form method="get" action="/company" class="form-inline" style="width: 22em">
                    <input type="text" name="filter" class="form-control ml-1 col-sm-8" value="${filter?ifExists}"
                           placeholder="Search by company name">
                    <button type="submit" class="btn btn-info ml-2">Search</button>
                </form>
            </div>
        </div>
    </div>
</div>

<table class="table table-bordered table-striped mt-3" style="text-align: center;">
    <thead style="background-color: #a8a8a8; ">
    <tr>
        <th>Id</th>
        <th>Company name</th>
        <th>Own earnings</th>
        <th>Child earnings</th>
        <th>Total earnings</th>
    </tr>
    </thead>
    <tbody>
        <#list companies as company>
        <tr>
            <td>${company.id}</td>
            <td>${company.companyName}</td>
            <td>${company.earnings}</td>
            <td>${company.childEarnings}</td>
            <td>${company.totalAmount}</td>
        </tr>
        <#else>
         No companies
        </#list>
    </tbody>
</table>

</@c.page>