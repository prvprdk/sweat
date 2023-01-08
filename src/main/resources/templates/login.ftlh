<#import "parts/common.ftlh" as c>
<#import "parts/login.ftlh" as l>
<@c.page>

<#if Session?? && Session.SPRING_SECURITY_LAST_EXCEPTION??>
       <div class= "alert alert-danger" role="aller" >
            ${Session.SPRING_SECURITY_LAST_EXCEPTION.message}
       </div>
</#if>
<@l.login "/login" false/>

</@c.page>