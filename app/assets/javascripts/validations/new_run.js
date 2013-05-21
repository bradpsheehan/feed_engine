function errorMessage(message) {
  return "<span class='error'>"+message+"</span>";
}

function hasErrors(){
  $('.error').length > 0
}

function validate(elem, message) {
  $(elem).blur(function(){

    var name_input = $(this);
    var name = name_input.val().trim();

    if(name == ""){
      name_input.parent().addClass("error").removeClass("success")
      .append(errorMessage(message));
    }else {
      name_input.parent().removeClass("error").addClass("success");
      name_input.next().remove();
    }

    updateSubmit();

  });
}

function validateInputs() {
  validate("#run_name", "Group name can't be blank");
  validate("#run_run_date", "Date can't be blank");
  validate("#run_run_start_time", "Start time can't be blank");
  validate("#run_name", "Group name can't be blank");
}

function validateForm(event) {
  validateInputs();

  if(hasErrors()) {
    event.preventDefault();
  }
}

$(document).ready(function() {
  $('form').submit(validateForm(event));

});
