 <#import "parts/common.ftlh" as c>

 <@c.page>
<h3> ${userChannel.username}</h3>
<div> ${type} </div>
    <div>
        <ul class="list-group mt-3">
            <#list users as user>
                <li class="list-group-item mt-3">
                <a href="/user-messages/${user.id}"> ${user.getUsername()} </a>
                </li>
            </#list>
        </ul>
    </div>

</@c.page>