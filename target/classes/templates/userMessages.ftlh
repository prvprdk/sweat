 <#import "parts/common.ftlh" as c>

 <@c.page>

    <h3> ${userChannel.username} </h3>
      <#if !isCurrentUser>
           <#if isSubscriber>
                <a class="btn btn-info" href = "/user/unsubscribe/${userChannel.id}" > Unsubscribe </a>
                <#else>
                <a class="btn btn-info" href = "/user/subscribe/${userChannel.id}" > Subscribe </a>
            </#if>
      </#if>
    <div class="container my-3 mx-3">
            <div class="row">
                    <div class="col">
                            <div class="card">
                                <div class="card-body">
                                     <div class="card-title"> Subscriptions</div>
                                     <div class="card-text">
                                            <a href= "/user/subscriptions/${userChannel.id}/list "> ${subscriptionsCount} </a>
                                     </div>
                                </div>
                            </div>
                    </div>
             </div>
             <div class="row">
                    <div class="col">
                            <div class="card">
                                <div class="card-body">
                                     <div class="card-title"> Subscribers </div>
                                     <div class="card-text">
                                       <a href= "/user/subscribers/${userChannel.id}/list"> ${subscriberCount} </a>
                                     </div>
                                </div>
                            </div>
                    </div>
             </div>
    </div>


        <#if isCurrentUser>
          <#include "parts/messageEdit.ftlh" />
        </#if>
        <#include "parts/messageList.ftlh" />

 </@c.page>