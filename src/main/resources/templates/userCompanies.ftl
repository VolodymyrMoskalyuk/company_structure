<#import "parts/common.ftl" as c>

<@c.page>

<a class="btn btn-info" data-toggle="collapse" href="#collapseAdd" role="button" aria-expanded="false"
   aria-controls="collapseAdd">
    Add new Company
</a>

<div class="collapse <#if company??>show</#if>" id="collapseAdd">
    <div class="form-group mt-3">
        <form method="post" action="/company" >
            <div class="form-group col-sm-6">
                <input type="text" class="form-control ${(companyNameError??)?string('is-invalid', '')}"
                      value="<#if company??>${company.companyName}</#if>" name="companyName" placeholder="Enter company name"/>
                 <#if companyNameError??>
                    <div class="invalid-feedback">
                        ${companyNameError}
                    </div>
                 </#if>
            </div>
            <div class="form-group col-sm-6">
                <input type="text" class="form-control ${(earningsError??)?string('is-invalid', '')}"
                       name="earnings" placeholder="Enter earnings">
                <#if earningsError??>
                <div class="invalid-feedback">
                    ${earningsError}
                </div>
                </#if>
            </div>
            <div class="form-group col-sm-6">
                <input type="text" class="form-control" value="<#if company??>${company.parent}</#if>"
                       name="parent" placeholder="Enter parent"/>
            </div>
            <input type="hidden" name="_csrf" value="${_csrf.token}"/>
            <div class="form-group">
                <button type="submit" class="btn btn-info">ADD</button>
            </div>
        </form>
    </div>
</div>

<table class="table table-bordered table-striped mt-3 ">
    <thead style="background-color: #a8a8a8; text-align: center;">
    <tr>
        <th>Id</th>
        <th>Company name</th>
        <th>Own earnings</th>
        <th>Child earnings</th>
        <th>Total earnings</th>
        <th>Parent</th>
        <th>Action</th>
    </tr>
    </thead>
    <tbody>
        <#list companies as company>
        <tr>
            <td style="text-align: center">${company.id}</td>
            <td>${company.companyName}</td>
            <td>${company.earnings}</td>
            <td>${company.childEarnings}</td>
            <td>${company.totalAmount}</td>
            <td>${company.parent}</td>
            <td style="text-align: center">
                <a href="/company/${company.id}" style="color: green">Edit</a>
                <a href="/company/delete/${company.id}" style="color: red" class="ml-3">Delete</a>
            </td>
        </tr>
        <#else>
         No companies
        </#list>
    </tbody>
</table>

</@c.page>