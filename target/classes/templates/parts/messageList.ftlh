<#include "security.ftlh">
<#import "pager.ftlh" as p>

<@p.pager url page/>
<div class="card-columns mt-5" id="message-list">

   <#list page.content as message>
       <div class="card mt-3" data-id="${message.id}"  style="width: 18rem;">
                 <#if message.filename??>
                     <img class="card-img-top"  src="/img/${message.filename}" />
                 </#if>

                <div class="m-2">
                    <span>${message.text}</span><br/>
                    <i>${message.tag}</i>
                </div>
                  <div class="card-footer text-muted container">
                        <div class="row">
                            <a class="col align-self-center" href = "/user-messages/${message.author.id}">  ${message.authorName} </a>
                                <a class="col align-self-center" href="/messages/${message.id}/like">
                                     <#if message.meLiked>
                                         <i class="lnr lnr-thumbs-up"></i>
                                     <#else>
                                     <i class="lnr lnr-heart"></i>

                                     </#if>
                                     ${message.likes}
                                </a>
                            <#if message.author.id == currentUserId>
                                 <a class="col" href = "/user-messages/${message.author.id}?message=${message.id}"> Edit</a>
                            </#if>
                        </div>
                  </div>
 </div>
    <#else>
    No message
    </#list>
</div>
<@p.pager url page/>