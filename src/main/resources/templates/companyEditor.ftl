<#import "parts/common.ftl" as c>

<@c.page>
<h5 class="mb-3">Company editor</h5>

<form action="/company/${company.id}" method="post">
    <div class="form-group row">
        <label class="col-sm-2 col-form-label">Company name:</label>
        <div class="col-sm-5">
            <input type="text" readonly name="companyName" class="form-control" value="${company.companyName}">
        </div>
    </div>
    <div class="form-group row">
        <label class="col-sm-2 col-form-label">Company earnings:</label>
        <div class="col-sm-5">
            <input type="text" name="earnings" class="form-control" value="${company.earnings}">
        </div>
    </div>
    <div class="form-group row">
        <label class="col-sm-2 col-form-label">Company parent:</label>
        <div class="col-sm-5">
            <input type="text" name="parent" class="form-control ${(parentError??)?string('is-invalid', '')}"
                   value="${company.parent}">
           <#if parentError??>
                <div class="invalid-feedback">
                    ${parentError}
                </div>
           </#if>
        </div>

    </div>

    <input type="hidden" value="${company.id}" name="company.id">
    <input type="hidden" value="${company.childEarnings}" name="childEarnings">
    <input type="hidden" value="${company.totalAmount}" name="totalAmount">
    <input type="hidden" value="${_csrf.token}" name="_csrf">
    <button class="btn btn-info" type="submit">Save</button>
</form>
</@c.page>