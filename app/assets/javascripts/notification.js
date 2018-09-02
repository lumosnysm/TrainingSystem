function showNotification(from, align, msg_type, msg) {
  if(msg_type == 'notice') color = 'warning'
  else if(msg_type == 'alert') color = 'danger'
  else color = msg_type
  $.notify({
    icon: 'add_alert',
    message: msg
  }, {
    type: color,
    timer: 3000,
    placement: {
      from: from,
      align: align
    }
  });
}
