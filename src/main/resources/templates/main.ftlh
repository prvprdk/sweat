<#import "parts/common.ftlh" as c>

<@c.page>

<div class="container mt-5">
    <#include "parts/messageEdit.ftlh"/>
        <div class="form-row">
        <div class="form-group col-mx-6 mt-4">
               <form  method="get" action="/main" class="form-inline">
                     <input type="text" name="filter" value ="${filter!}" placeholder="search" />
                     <button class="btn btn-primary  ml-2 " type="submit">Search</button>
                </form>
            </div>
        </div>
         <#include "parts/messageList.ftlh" />
</div>



</@c.page>