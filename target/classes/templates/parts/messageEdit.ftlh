
  <a class="btn btn-primary" data-toggle="collapse" href="#collapseExample" role="button" aria-expanded="false" aria-controls="collapseExample">
   Message Edit
  </a>

 <div class="collapse <#if message??>show</#if> mt-2"  id="collapseExample">
        <form method ="post" enctype= "multipart/form-data"  >
            <input type="text" class="${(textError??)?string('is.invalid','')}" value="<#if message??> ${message.text}</#if>" name="text" placeholder="Введите сообщение" />
                    <#if textError??>
                        <div clas="invalid-feedback">
                           ${textError}
                        </div>
                     </#if>
            <input type="text" value="<#if message??>${message.tag}</#if>" name="tag" placeholder="Тэг" />
                    <#if tagError??>
                             <div clas="invalid-feedback">
                                ${usernameError}
                             </div>
                    </#if>
            <input type="file" name="file" />
            <input type="hidden" name="_csrf" value="${_csrf.token}" />
            <input type="hidden" name="id" value="<#if message??> ${message.id}</#if>" />
            <button type = "submit">Save</button>
        </form>
  </div>