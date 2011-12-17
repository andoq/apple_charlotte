$(function() {
  $('.form-toggle-link').on('click', function(e){
    e.preventDefault();
    $(this).siblings('.hidden-form').first().toggle();
  });

  $('.hidden-form .cancel').on('click', function(e){
    e.preventDefault();
    $(this).parents('form').hide();
  });
});
