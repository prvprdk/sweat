<#include "security.ftlh">
<#import "login.ftlh" as l>
<nav class="navbar navbar-expand-lg bg-light">

    <a class="navbar-brand" href="#">Sweater</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>

            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                      <ul class="navbar-nav mr-auto">
                                <li class="nav-item">
                                  <a class="nav-link" aria-current="page" href="">Home</a>
                                    </li>
                                    <li class="nav-item">
                                      <a class="nav-link" aria-current="page" href="/main">Messages</a>
                                    </li>
                                    <#if isAdmin>
                                    <li class="nav-item">
                                      <a class="nav-link" aria-current="page" href="/user">User List</a>
                                    </li>
                                    </#if>
                                    <#if user??>
                                    <li class="nav-item">
                                      <a class="nav-link" aria-current="page" href="/user-messages/${currentUserId}">My Messages</a>
                                    </li>
                                    </#if>
                      </ul>
                         <div class="navbar-text mr-3"><#if user??>${name}<#else>Please, login</#if></div>
                        <@l.logout />
            </div>
</nav>