<#macro login path isRegisterForm>
<form action="${path}" method="post">
    <div class="form-group">
        <label  for="exampleInputEmail1" > User Name: </label>
        <input type="text" name="username"
         value="<#if user??> ${user.username} </#if>"
          class="form-control ${(usernameError??)?string('is.invalid','')}"
           placeholder="Enter username" />
            <#if usernameError??>
                       <div clas="invalid-feedback">
                          ${usernameError}
                       </div>
            </#if>
    </div>

    <div class="form-group">
         <label for="exampleInputPassword1"> Password: </label>
            <input class="form-control form-control ${(passwordError??)?string('is.invalid','')}" type="password"
            name="password" placeholder="Enter Password" />
                            <#if passwordError??>
                                       <div clas="invalid-feedback">
                                          ${passwordError}
                                       </div>
                            </#if>
               <#if isRegisterForm>
               <input class="form-control form-control ${(password2Error??)?string('is.invalid', '')}" type="password" name="password2" placeholder="Retype password" />
                        <#if password2Error??>
                                   <div clas="invalid-feedback">
                                      ${password2Error}
                                   </div>
                        </#if>
                </#if>
            <input type="hidden" name="_csrf" value="${_csrf.token}" />
             <div class=" mt-5" > <#if !isRegisterForm > <a class="btn btn-primary" href ="/registration"> add new User </a></#if> </div>
            <button class="btn btn-primary mt-2" type="submit"> <#if isRegisterForm>Create<#else> Sign In</#if></button>
     </div>
</form>
</#macro>
<#macro logout>
    <form action="/logout" method="post">
        <input type="hidden" name="_csrf" value="${_csrf.token}" />
        <button  class="btn btn-primary"  type="submit"> <#if user??>Sign Out <#else> Sign in </#if></button>
    </form>
</#macro>