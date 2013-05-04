function afterJanrainLogin(result)
{
  janrain.capture.ui.modal.close();
  
  // create form
  var form  = $('<form accept-charset="UTF-8" action="/users/sign_in" method="post" ></form>')
  
  // create hidden div in form
  var hidden_els = $('<div style="margin:0;padding:0;display:inline"></div>')

  // add utf
  hidden_els.append('<input name="utf8" type="hidden" value="✓">')

  // grab forgery token
  var token_name = $("meta[name='csrf-param']").attr('content')
  var token_val = $("meta[name='csrf-token']").attr('content')
  if(token_name && token_val)
  {
    hidden_els.prepend('<input name="'+token_name +'" type="hidden" value="'+token_val+'">')
  }

  // append hidden els to form
  form.append(hidden_els)

  // add oauth code to form
  form.append('<input id="authorization-code" name="code" type="hidden" value="'+result.authorizationCode+'">')

  form.append('body')
  form.submit()
}

function janrainCaptureWidgetOnLoad() {
  janrain.settings.capture.flowName = 'signIn';
  janrain.settings.language = 'en';
  janrain.capture.ui.start();
  janrain.events.onCaptureLoginSuccess.addHandler(afterJanrainLogin);
  janrain.events.onCaptureRegistrationSuccess.addHandler(afterJanrainLogin);
}