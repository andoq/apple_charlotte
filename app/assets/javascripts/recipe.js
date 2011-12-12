$(function(){
  $('.search-button').on('click', function(e){
    e.preventDefault();
    $(this).parents('.search-form').submit();
  });
});
